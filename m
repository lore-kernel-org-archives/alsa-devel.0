From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ad1836: Convert to direct regmap usage.
Date: Thu, 13 Sep 2012 12:04:51 +0200
Message-ID: <1347530691-14141-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id B8B2226257D
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 12:04:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad1836.c |   76 +++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index ae1eb51..dce6ebe 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -19,6 +19,8 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/spi/spi.h>
+#include <linux/regmap.h>
+
 #include "ad1836.h"
 
 enum ad1836_type {
@@ -30,6 +32,7 @@ enum ad1836_type {
 /* codec private data */
 struct ad1836_priv {
 	enum ad1836_type type;
+	struct regmap *regmap;
 };
 
 /*
@@ -161,8 +164,8 @@ static int ad1836_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
 {
+	struct ad1836_priv *ad1836 = snd_soc_codec_get_drvdata(dai->codec);
 	int word_len = 0;
-	struct snd_soc_codec *codec = dai->codec;
 
 	/* bit size */
 	switch (params_format(params)) {
@@ -178,10 +181,12 @@ static int ad1836_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	snd_soc_update_bits(codec, AD1836_DAC_CTRL1, AD1836_DAC_WORD_LEN_MASK,
+	regmap_update_bits(ad1836->regmap, AD1836_DAC_CTRL1,
+		AD1836_DAC_WORD_LEN_MASK,
 		word_len << AD1836_DAC_WORD_LEN_OFFSET);
 
-	snd_soc_update_bits(codec, AD1836_ADC_CTRL2, AD1836_ADC_WORD_LEN_MASK,
+	regmap_update_bits(ad1836->regmap, AD1836_ADC_CTRL2,
+		AD1836_ADC_WORD_LEN_MASK,
 		word_len << AD1836_ADC_WORD_OFFSET);
 
 	return 0;
@@ -223,15 +228,17 @@ static struct snd_soc_dai_driver ad183x_dais[] = {
 #ifdef CONFIG_PM
 static int ad1836_suspend(struct snd_soc_codec *codec)
 {
+	struct ad1836_priv *ad1836 = snd_soc_codec_get_drvdata(codec);
 	/* reset clock control mode */
-	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+	return regmap_update_bits(ad1836->regmap, AD1836_ADC_CTRL2,
 		AD1836_ADC_SERFMT_MASK, 0);
 }
 
 static int ad1836_resume(struct snd_soc_codec *codec)
 {
+	struct ad1836_priv *ad1836 = snd_soc_codec_get_drvdata(codec);
 	/* restore clock control mode */
-	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+	return regmap_update_bits(ad1836->regmap, AD1836_ADC_CTRL2,
 		AD1836_ADC_SERFMT_MASK, AD1836_ADC_AUX);
 }
 #else
@@ -250,37 +257,30 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 	num_dacs = ad183x_dais[ad1836->type].playback.channels_max / 2;
 	num_adcs = ad183x_dais[ad1836->type].capture.channels_max / 2;
 
-	ret = snd_soc_codec_set_cache_io(codec, 4, 12, SND_SOC_SPI);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to set cache I/O: %d\n",
-				ret);
-		return ret;
-	}
-
 	/* default setting for ad1836 */
 	/* de-emphasis: 48kHz, power-on dac */
-	snd_soc_write(codec, AD1836_DAC_CTRL1, 0x300);
+	regmap_write(ad1836->regmap, AD1836_DAC_CTRL1, 0x300);
 	/* unmute dac channels */
-	snd_soc_write(codec, AD1836_DAC_CTRL2, 0x0);
+	regmap_write(ad1836->regmap, AD1836_DAC_CTRL2, 0x0);
 	/* high-pass filter enable, power-on adc */
-	snd_soc_write(codec, AD1836_ADC_CTRL1, 0x100);
+	regmap_write(ad1836->regmap, AD1836_ADC_CTRL1, 0x100);
 	/* unmute adc channles, adc aux mode */
-	snd_soc_write(codec, AD1836_ADC_CTRL2, 0x180);
+	regmap_write(ad1836->regmap, AD1836_ADC_CTRL2, 0x180);
 	/* volume */
 	for (i = 1; i <= num_dacs; ++i) {
-		snd_soc_write(codec, AD1836_DAC_L_VOL(i), 0x3FF);
-		snd_soc_write(codec, AD1836_DAC_R_VOL(i), 0x3FF);
+		regmap_write(ad1836->regmap, AD1836_DAC_L_VOL(i), 0x3FF);
+		regmap_write(ad1836->regmap, AD1836_DAC_R_VOL(i), 0x3FF);
 	}
 
 	if (ad1836->type == AD1836) {
 		/* left/right diff:PGA/MUX */
-		snd_soc_write(codec, AD1836_ADC_CTRL3, 0x3A);
+		regmap_write(ad1836->regmap, AD1836_ADC_CTRL3, 0x3A);
 		ret = snd_soc_add_codec_controls(codec, ad1836_controls,
 				ARRAY_SIZE(ad1836_controls));
 		if (ret)
 			return ret;
 	} else {
-		snd_soc_write(codec, AD1836_ADC_CTRL3, 0x00);
+		regmap_write(ad1836->regmap, AD1836_ADC_CTRL3, 0x00);
 	}
 
 	ret = snd_soc_add_codec_controls(codec, ad183x_dac_controls, num_dacs * 2);
@@ -313,8 +313,9 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 /* power down chip */
 static int ad1836_remove(struct snd_soc_codec *codec)
 {
+	struct ad1836_priv *ad1836 = snd_soc_codec_get_drvdata(codec);
 	/* reset clock control mode */
-	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+	return regmap_update_bits(ad1836->regmap, AD1836_ADC_CTRL2,
 		AD1836_ADC_SERFMT_MASK, 0);
 }
 
@@ -323,8 +324,6 @@ static struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
 	.remove = ad1836_remove,
 	.suspend = ad1836_suspend,
 	.resume = ad1836_resume,
-	.reg_cache_size = AD1836_NUM_REGS,
-	.reg_word_size = sizeof(u16),
 
 	.controls = ad183x_controls,
 	.num_controls = ARRAY_SIZE(ad183x_controls),
@@ -334,6 +333,33 @@ static struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
 	.num_dapm_routes = ARRAY_SIZE(ad183x_dapm_routes),
 };
 
+static const struct reg_default ad1836_reg_defaults[] = {
+	{ AD1836_DAC_CTRL1, 0x0000 },
+	{ AD1836_DAC_CTRL2, 0x0000 },
+	{ AD1836_DAC_L_VOL(0), 0x0000 },
+	{ AD1836_DAC_R_VOL(0), 0x0000 },
+	{ AD1836_DAC_L_VOL(1), 0x0000 },
+	{ AD1836_DAC_R_VOL(1), 0x0000 },
+	{ AD1836_DAC_L_VOL(2), 0x0000 },
+	{ AD1836_DAC_R_VOL(2), 0x0000 },
+	{ AD1836_DAC_L_VOL(3), 0x0000 },
+	{ AD1836_DAC_R_VOL(3), 0x0000 },
+	{ AD1836_ADC_CTRL1, 0x0000 },
+	{ AD1836_ADC_CTRL2, 0x0000 },
+	{ AD1836_ADC_CTRL3, 0x0000 },
+};
+
+static const struct regmap_config ad1836_regmap_config = {
+	.val_bits = 12,
+	.reg_bits = 4,
+	.read_flag_mask = 0x08,
+
+	.max_register = AD1836_ADC_CTRL3,
+	.reg_defaults = ad1836_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ad1836_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static int __devinit ad1836_spi_probe(struct spi_device *spi)
 {
 	struct ad1836_priv *ad1836;
@@ -344,6 +370,10 @@ static int __devinit ad1836_spi_probe(struct spi_device *spi)
 	if (ad1836 == NULL)
 		return -ENOMEM;
 
+	ad1836->regmap = devm_regmap_init_spi(spi, &ad1836_regmap_config);
+	if (IS_ERR(ad1836->regmap))
+		return PTR_ERR(ad1836->regmap);
+
 	ad1836->type = spi_get_device_id(spi)->driver_data;
 
 	spi_set_drvdata(spi, ad1836);
-- 
1.7.10.4
