From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] ASoC: AD193X: Convert to direct regmap API usage
Date: Mon, 28 Nov 2011 17:28:12 +0100
Message-ID: <1322497692-27868-7-git-send-email-lars@metafoo.de>
References: <1322497692-27868-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322497692-27868-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad193x.c |   61 ++++++++++++++++++++++++++------------------
 1 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 7d64f20..c1b7d92 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -106,14 +106,14 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 
 static int ad193x_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(dai->codec);
 
 	if (mute)
-		snd_soc_update_bits(codec, AD193X_DAC_CTRL2,
+		regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL2,
 				    AD193X_DAC_MASTER_MUTE,
 				    AD193X_DAC_MASTER_MUTE);
 	else
-		snd_soc_update_bits(codec, AD193X_DAC_CTRL2,
+		regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL2,
 				    AD193X_DAC_MASTER_MUTE, 0);
 
 	return 0;
@@ -122,7 +122,7 @@ static int ad193x_mute(struct snd_soc_dai *dai, int mute)
 static int ad193x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots, int width)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(dai->codec);
 	unsigned int channels;
 
 	switch (slots) {
@@ -142,10 +142,10 @@ static int ad193x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, AD193X_DAC_CTRL1, AD193X_DAC_CHAN_MASK,
-		channels << AD193X_DAC_CHAN_SHFT);
-	snd_soc_update_bits(codec, AD193X_ADC_CTRL2, AD193X_ADC_CHAN_MASK,
-		channels << AD193X_ADC_CHAN_SHFT);
+	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL1,
+		AD193X_DAC_CHAN_MASK, channels << AD193X_DAC_CHAN_SHFT);
+	regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
+		AD193X_ADC_CHAN_MASK, channels << AD193X_ADC_CHAN_SHFT);
 
 	return 0;
 }
@@ -153,7 +153,7 @@ static int ad193x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec_dai->codec);
 	unsigned int adc_serfmt = 0;
 	unsigned int adc_fmt = 0;
 	unsigned int dac_fmt = 0;
@@ -214,12 +214,12 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, AD193X_ADC_CTRL1, AD193X_ADC_SERFMT_MASK,
-	    adc_serfmt);
-	snd_soc_update_bits(codec, AD193X_ADC_CTRL2, AD193X_ADC_FMT_MASK,
-	    adc_fmt);
-	snd_soc_update_bits(codec, AD193X_DAC_CTRL1, AD193X_DAC_FMT_MASK,
-	    dac_fmt);
+	regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL1,
+		AD193X_ADC_SERFMT_MASK, adc_serfmt);
+	regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
+		AD193X_ADC_FMT_MASK, adc_fmt);
+	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL1,
+		AD193X_DAC_FMT_MASK, dac_fmt);
 
 	return 0;
 }
@@ -279,14 +279,14 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	snd_soc_update_bits(codec, AD193X_PLL_CLK_CTRL0,
+	regmap_update_bits(ad193x->regmap, AD193X_PLL_CLK_CTRL0,
 			    AD193X_PLL_INPUT_MASK, master_rate);
 
-	snd_soc_update_bits(codec, AD193X_DAC_CTRL2,
+	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL2,
 			    AD193X_DAC_WORD_LEN_MASK,
 			    word_len << AD193X_DAC_WORD_LEN_SHFT);
 
-	snd_soc_update_bits(codec, AD193X_ADC_CTRL1,
+	regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL1,
 			    AD193X_ADC_WORD_LEN_MASK, word_len);
 
 	return 0;
@@ -337,18 +337,18 @@ static int ad193x_probe(struct snd_soc_codec *codec)
 	/* default setting for ad193x */
 
 	/* unmute dac channels */
-	snd_soc_write(codec, AD193X_DAC_CHNL_MUTE, 0x0);
+	regmap_write(ad193x->regmap, AD193X_DAC_CHNL_MUTE, 0x0);
 	/* de-emphasis: 48kHz, powedown dac */
-	snd_soc_write(codec, AD193X_DAC_CTRL2, 0x1A);
+	regmap_write(ad193x->regmap, AD193X_DAC_CTRL2, 0x1A);
 	/* powerdown dac, dac in tdm mode */
-	snd_soc_write(codec, AD193X_DAC_CTRL0, 0x41);
+	regmap_write(ad193x->regmap, AD193X_DAC_CTRL0, 0x41);
 	/* high-pass filter enable */
-	snd_soc_write(codec, AD193X_ADC_CTRL0, 0x3);
+	regmap_write(ad193x->regmap, AD193X_ADC_CTRL0, 0x3);
 	/* sata delay=1, adc aux mode */
-	snd_soc_write(codec, AD193X_ADC_CTRL1, 0x43);
+	regmap_write(ad193x->regmap, AD193X_ADC_CTRL1, 0x43);
 	/* pll input: mclki/xi */
-	snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, 0x99); /* mclk=24.576Mhz: 0x9D; mclk=12.288Mhz: 0x99 */
-	snd_soc_write(codec, AD193X_PLL_CLK_CTRL1, 0x04);
+	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL0, 0x99); /* mclk=24.576Mhz: 0x9D; mclk=12.288Mhz: 0x99 */
+	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL1, 0x04);
 
 	return ret;
 }
@@ -363,6 +363,11 @@ static struct snd_soc_codec_driver soc_codec_dev_ad193x = {
 	.num_dapm_routes = ARRAY_SIZE(audio_paths),
 };
 
+static bool adau193x_reg_volatile(struct device *dev, unsigned int reg)
+{
+	return false;
+}
+
 #if defined(CONFIG_SPI_MASTER)
 
 static const struct regmap_config ad193x_spi_regmap_config = {
@@ -370,6 +375,9 @@ static const struct regmap_config ad193x_spi_regmap_config = {
 	.reg_bits = 16,
 	.read_flag_mask = 0x09,
 	.write_flag_mask = 0x08,
+
+	.max_register = AD193X_NUM_REGS - 1,
+	.volatile_reg = adau193x_reg_volatile,
 };
 
 static int __devinit ad193x_spi_probe(struct spi_device *spi)
@@ -429,6 +437,9 @@ static struct spi_driver ad193x_spi_driver = {
 static const struct regmap_config ad193x_i2c_regmap_config = {
 	.val_bits = 8,
 	.reg_bits = 8,
+
+	.max_register = AD193X_NUM_REGS - 1,
+	.volatile_reg = adau193x_reg_volatile,
 };
 
 static const struct i2c_device_id ad193x_id[] = {
-- 
1.7.7.3
