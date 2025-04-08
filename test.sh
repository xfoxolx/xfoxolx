#!/bin/sh

# 设置 pacman 配置文件路径
PACMAN_CONF="/etc/pacman.conf"

# 检查 archlinuxcn 源是否已经存在
if ! grep -q "\[archlinuxcn\]" "$PACMAN_CONF"; then
    echo "添加 archlinuxcn 源到 $PACMAN_CONF..."

    # 将 archlinuxcn 源添加到 pacman 配置文件中
    {
        echo -e "\n# Archlinuxcn Source"
        echo -e "\n[archlinuxcn]"
        echo "Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch"
        echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch"
        echo "Server = https://mirrors.hit.edu.cn/archlinuxcn/\$arch"
        echo "Server = https://repo.huaweicloud.com/archlinuxcn/\$arch"
    } | sudo tee -a "$PACMAN_CONF" > /dev/null
else
    echo "archlinuxcn 源已存在于 $PACMAN_CONF 中，跳过添加。"
fi

# 导入并签名 archlinuxcn 的 GPG 密钥
echo "导入并签名 archlinuxcn 公钥..."
sudo pacman-key --lsign-key "farseerfc@archlinux.org"

# 更新 archlinuxcn 的密钥环
echo "更新 archlinuxcn 的密钥环..."
sudo pacman -Sy archlinuxcn-keyring

# 安装 yay
echo "安装 yay..."
sudo pacman -S yay --noconfirm

echo "脚本执行完成！"
