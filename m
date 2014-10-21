From: Jianqun <jay.xu@rock-chips.com>
Subject: [PATCH] ASoC: rockchip-i2s: add rockchip-max98090 driver support
Date: Tue, 21 Oct 2014 19:31:50 +0800
Message-ID: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: huangtao@rock-chips.com, cf@rock-chips.com, Jianqun <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch is to add support for rockchip board with max98090 codec.
It also needs sound node in dt file.

Tested on rockchip board based on rk3288.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 78fc159..482cbba 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -9,3 +9,16 @@ config SND_SOC_ROCKCHIP
 
 config SND_SOC_ROCKCHIP_I2S
 	tristate
+	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	help
+	  Say Y or M if you want to add support for I2S driver for Rockchip
+	  I2S device.
+
+config SND_SOC_ROCKCHIP_MAX98090
+	tristate "ASoC support Rockchip board with max98090"
+	depends on I2C && GPIOLIB
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_MAX98090
+	help
+	  Say Y or M here if you want to add support for Rockchio board using
+	  a max98090 codec.
-- 
1.9.1
