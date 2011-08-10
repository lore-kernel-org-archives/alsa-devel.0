From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: soc-io: Add CONFIG_REGMAP_I2C/CONFIG_REGMAP_SPI
 guards for regmap_init_i2c/regmap_init_spi
Date: Wed, 10 Aug 2011 16:24:12 +0800
Message-ID: <1312964652.11589.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In the case of "make da8xx_omapl_defconfig;make", the SPI support is disabled.
Thus calling regmap_init_spi in soc-io.c has below build error.

ERROR: "regmap_init_spi" [sound/soc/snd-soc-core.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

This patch fixes the build error by adding CONFIG_REGMAP_I2C/CONFIG_REGMAP_SPI
guards for regmap_init_i2c/regmap_init_spi.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/soc-io.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index e471ed6..be5aac3 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -122,15 +122,19 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	config.val_bits = data_bits;
 
 	switch (control) {
+#ifdef CONFIG_REGMAP_I2C
 	case SND_SOC_I2C:
 		codec->control_data = regmap_init_i2c(to_i2c_client(codec->dev),
 						      &config);
 		break;
+#endif
 
+#ifdef CONFIG_REGMAP_SPI
 	case SND_SOC_SPI:
 		codec->control_data = regmap_init_spi(to_spi_device(codec->dev),
 						      &config);
 		break;
+#endif
 
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
-- 
1.7.4.1
