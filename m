From: Andreas Ruprecht <rupran@einserver.de>
Subject: [PATCH v2] ASoC: rockchip: i2s: Fix Kconfig for I2S device driver
Date: Fri, 21 Nov 2014 20:50:46 +0100
Message-ID: <1416599446-32310-1-git-send-email-rupran@einserver.de>
References: <20141121185856.GJ3815@sirena.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141121185856.GJ3815@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andreas Ruprecht <rupran@einserver.de>
List-Id: alsa-devel@alsa-project.org

Currently, CONFIG_SND_SOC_ROCKCHIP_I2S could also be selected
without having CONFIG_SND_SOC_ROCKCHIP enabled.

As this makes no sense, a Kconfig dependency is added to
CONFIG_SND_SOC_ROCKCHIP_I2S. This will make the item visible only if
CONFIG_SND_SOC_ROCKCHIP is enabled.

Additionally, as the code connected to CONFIG_SND_SOC_ROCKCHIP_I2S
depends on CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM, the dependency
is moved to reflect this more clearly.

Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
Reported-by: Jim Davis <jim.epost@gmail.com>
---
 sound/soc/rockchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index b1fc0ca..e181826 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -1,7 +1,6 @@
 config SND_SOC_ROCKCHIP
 	tristate "ASoC support for Rockchip"
 	depends on COMPILE_TEST || ARCH_ROCKCHIP
-	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Rockchip SoCs' Audio interfaces. You will also need to
@@ -9,7 +8,8 @@ config SND_SOC_ROCKCHIP
 
 config SND_SOC_ROCKCHIP_I2S
 	tristate "Rockchip I2S Device Driver"
-	depends on CLKDEV_LOOKUP
+	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for I2S driver for
 	  Rockchip I2S device. The device supports upto maximum of
-- 
1.9.1
