#!/usr/bin/env bash
#

# Replace panel config
if [[ "${language}" = "ja" ]]; then
    remove "/etc/skel/.config/lxpanel/LXDE/panels/panel"
    mv "/etc/skel/.config/lxpanel/LXDE/panels/panel-jp" "/etc/skel/.config/lxpanel/LXDE/panels/panel"

    remove "/home/${username}/.config/lxpanel/LXDE/panels/panel"
    mv "/home/${username}/.config/lxpanel/LXDE/panels/panel-jp" "/home/${username}/.config/lxpanel/LXDE/panels/panel"
else
    remove "/etc/skel/.config/lxpanel/LXDE/panels/panel-jp"
    remove "/home/${username}/.config/lxpanel/LXDE/panels/panel-jp"
fi


# Enable LightDM to auto login
if [[ "${boot_splash}" =  true ]]; then
    systemctl enable lightdm-plymouth.service
else
    systemctl enable lightdm.service
fi


# Replace logout banner
remove "/usr/share/lxde/images/logout-banner.png"
ln -s "/usr/share/lxde/images/alterlinux.png" "/usr/share/lxde/images/logout-banner.png"
chmod 644 "/usr/share/lxde/images/logout-banner.png"


# Replace wallpaper.
if [[ -f "/usr/share/lxde/wallpapers/lxde_blue.jpg" ]]; then
    remove "/usr/share/lxde/wallpapers/lxde_blue.jpg"
    ln -s "/usr/share/backgrounds/xinux.png" "/usr/share/lxde/wallpapers/lxde_blue.jpg"
fi
[[ -f "/usr/share/backgrounds/xinux.png" ]] && chmod 644 "/usr/share/backgrounds/xinux.png"


# Replace auto login user
sed -i "s|%USERNAME%|${username}|g" "/etc/lightdm/lightdm.conf.d/02-autologin.conf"
