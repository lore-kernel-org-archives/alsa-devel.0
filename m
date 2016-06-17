From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC fix up SND_SOC_WM8985 dependency
Date: Fri, 17 Jun 2016 12:12:00 +0200
Message-ID: <20160617101230.2052826-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I just added an I2C dependency to the wm8985 driver to work around
a build failure, but it turns out that was premature: we actually
need to depend on SND_SOC_I2C_AND_SPI, as the driver can work with either
of the two, and we only need to prevent a configuration that has
I2C=m and SND_SOC_WM8985=y.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 05252513fbb9 ("ASoC: wm8985: add i2c dependency")
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d0e8150c7170..60f8f13f0d34 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -994,7 +994,7 @@ config SND_SOC_WM8983
 
 config SND_SOC_WM8985
 	tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
-	depends on I2C
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8988
 	tristate
-- 
2.9.0
