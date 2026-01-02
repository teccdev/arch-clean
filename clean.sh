#!/usr/bin/env bash

echo -n "Clean up packages? [y/n] "
read -r clean_pkgs

echo -n "Aggressive mode? [y/n] "
read -r clean_aggressive

if [[ $clean_pkgs =~ ^[Yy]$ ]]; then
	echo "Cleaning..."

	# Delete paru cache
	if [[ $clean_aggressive =~ ^[Yy]$ ]]; then
		paru -Scc --noconfirm &>/dev/null
	else
		paru -Sc --noconfirm &>/dev/null
	fi

	# Remove orphaned packages
	paru -Rns $(paru -Qtdq) --noconfirm &>/dev/null

	echo "Done cleaning packages"
else
	echo "Skipping package cleanup."
fi

echo -n "Delete cache? [y/n] "
read -r clean_cache

if [[ $clean_cache =~ ^[Yy]$ ]]; then
	rm -rf ~/.cache/*
	echo "Done cleaning cache"
else
	echo "Skipping cache cleanup."
fi

echo -n "Remove temporary files? [y/n] "
read -r clean_temp
if [[ $clean_temp =~ ^[Yy]$ ]]; then
	rm -rf /tmp/* 2>/dev/null
	echo "Temporary files cleared"
else
	echo "Skipping temporary files cleanup."
fi

echo -e "\nAll cleanup complete!"
exit 0
