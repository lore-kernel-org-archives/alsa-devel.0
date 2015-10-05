From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ad193x: add support to ad1934" to the
	asoc tree
Date: Mon, 05 Oct 2015 17:44:37 +0100
Message-ID: <E1Zj8sP-0003Gc-SF@finisterre>
References: <5fa6cd7e991982cea9f52d5ebba7a3aca7350ed7.1443537293.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3656126149D
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 18:45:01 +0200 (CEST)
In-Reply-To: <5fa6cd7e991982cea9f52d5ebba7a3aca7350ed7.1443537293.git.cyrille.pitchen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ad193x: add support to ad1934

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e5224f58e3efd74972f7dcf46264c3ba9aa807ba Mon Sep 17 00:00:00 2001
From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Tue, 29 Sep 2015 16:41:43 +0200
Subject: [PATCH] ASoC: ad193x: add support to ad1934

The AD1934 codec has no ADC feature. Hence it register mapping is slightly
different from the register mapping of other members of the AD193x family.

Some ASoC controls and widgets are related to the DAC feature so are not
relevant in the case of an AD1934 codec.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x-i2c.c |   8 +--
 sound/soc/codecs/ad193x-spi.c |  16 +++++-
 sound/soc/codecs/ad193x.c     | 122 ++++++++++++++++++++++++++++++++----------
 sound/soc/codecs/ad193x.h     |   9 +++-
 4 files changed, 121 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/ad193x-i2c.c b/sound/soc/codecs/ad193x-i2c.c
index df3a1a4..1713136 100644
--- a/sound/soc/codecs/ad193x-i2c.c
+++ b/sound/soc/codecs/ad193x-i2c.c
@@ -15,8 +15,8 @@
 #include "ad193x.h"
 
 static const struct i2c_device_id ad193x_id[] = {
-	{ "ad1936", 0 },
-	{ "ad1937", 0 },
+	{ "ad1936", AD193X },
+	{ "ad1937", AD193X },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad193x_id);
@@ -30,7 +30,9 @@ static int ad193x_i2c_probe(struct i2c_client *client,
 	config.val_bits = 8;
 	config.reg_bits = 8;
 
-	return ad193x_probe(&client->dev, devm_regmap_init_i2c(client, &config));
+	return ad193x_probe(&client->dev,
+			    devm_regmap_init_i2c(client, &config),
+			    (enum ad193x_type)id->driver_data);
 }
 
 static int ad193x_i2c_remove(struct i2c_client *client)
diff --git a/sound/soc/codecs/ad193x-spi.c b/sound/soc/codecs/ad193x-spi.c
index 390cef9..364e8211 100644
--- a/sound/soc/codecs/ad193x-spi.c
+++ b/sound/soc/codecs/ad193x-spi.c
@@ -16,6 +16,7 @@
 
 static int ad193x_spi_probe(struct spi_device *spi)
 {
+	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct regmap_config config;
 
 	config = ad193x_regmap_config;
@@ -24,7 +25,8 @@ static int ad193x_spi_probe(struct spi_device *spi)
 	config.read_flag_mask = 0x09;
 	config.write_flag_mask = 0x08;
 
-	return ad193x_probe(&spi->dev, devm_regmap_init_spi(spi, &config));
+	return ad193x_probe(&spi->dev, devm_regmap_init_spi(spi, &config),
+			    (enum ad193x_type)id->driver_data);
 }
 
 static int ad193x_spi_remove(struct spi_device *spi)
@@ -33,6 +35,17 @@ static int ad193x_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id ad193x_spi_id[] = {
+	{ "ad193x", AD193X },
+	{ "ad1933", AD1933 },
+	{ "ad1934", AD1934 },
+	{ "ad1936", AD193X },
+	{ "ad1937", AD193X },
+	{ "ad1938", AD193X },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad193x_spi_id);
+
 static struct spi_driver ad193x_spi_driver = {
 	.driver = {
 		.name	= "ad193x",
@@ -40,6 +53,7 @@ static struct spi_driver ad193x_spi_driver = {
 	},
 	.probe		= ad193x_spi_probe,
 	.remove		= ad193x_spi_remove,
+	.id_table	= ad193x_spi_id,
 };
 module_spi_driver(ad193x_spi_driver);
 
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 17c9535..76d7966 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -23,6 +23,7 @@
 /* codec private data */
 struct ad193x_priv {
 	struct regmap *regmap;
+	enum ad193x_type type;
 	int sysclk;
 };
 
@@ -47,12 +48,6 @@ static const struct snd_kcontrol_new ad193x_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("DAC4 Volume", AD193X_DAC_L4_VOL,
 			AD193X_DAC_R4_VOL, 0, 0xFF, 1, adau193x_tlv),
 
-	/* ADC switch control */
-	SOC_DOUBLE("ADC1 Switch", AD193X_ADC_CTRL0, AD193X_ADCL1_MUTE,
-		AD193X_ADCR1_MUTE, 1, 1),
-	SOC_DOUBLE("ADC2 Switch", AD193X_ADC_CTRL0, AD193X_ADCL2_MUTE,
-		AD193X_ADCR2_MUTE, 1, 1),
-
 	/* DAC switch control */
 	SOC_DOUBLE("DAC1 Switch", AD193X_DAC_CHNL_MUTE, AD193X_DACL1_MUTE,
 		AD193X_DACR1_MUTE, 1, 1),
@@ -63,26 +58,37 @@ static const struct snd_kcontrol_new ad193x_snd_controls[] = {
 	SOC_DOUBLE("DAC4 Switch", AD193X_DAC_CHNL_MUTE, AD193X_DACL4_MUTE,
 		AD193X_DACR4_MUTE, 1, 1),
 
+	/* DAC de-emphasis */
+	SOC_ENUM("Playback Deemphasis", ad193x_deemp_enum),
+};
+
+static const struct snd_kcontrol_new ad193x_adc_snd_controls[] = {
+	/* ADC switch control */
+	SOC_DOUBLE("ADC1 Switch", AD193X_ADC_CTRL0, AD193X_ADCL1_MUTE,
+		AD193X_ADCR1_MUTE, 1, 1),
+	SOC_DOUBLE("ADC2 Switch", AD193X_ADC_CTRL0, AD193X_ADCL2_MUTE,
+		AD193X_ADCR2_MUTE, 1, 1),
+
 	/* ADC high-pass filter */
 	SOC_SINGLE("ADC High Pass Filter Switch", AD193X_ADC_CTRL0,
 			AD193X_ADC_HIGHPASS_FILTER, 1, 0),
-
-	/* DAC de-emphasis */
-	SOC_ENUM("Playback Deemphasis", ad193x_deemp_enum),
 };
 
 static const struct snd_soc_dapm_widget ad193x_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_PGA("DAC Output", AD193X_DAC_CTRL0, 0, 1, NULL, 0),
-	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_SUPPLY("PLL_PWR", AD193X_PLL_CLK_CTRL0, 0, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD193X_ADC_CTRL0, 0, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("SYSCLK", AD193X_PLL_CLK_CTRL0, 7, 0, NULL, 0),
 	SND_SOC_DAPM_VMID("VMID"),
 	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
 	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
 	SND_SOC_DAPM_OUTPUT("DAC3OUT"),
 	SND_SOC_DAPM_OUTPUT("DAC4OUT"),
+};
+
+static const struct snd_soc_dapm_widget ad193x_adc_widgets[] = {
+	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD193X_ADC_CTRL0, 0, 1, NULL, 0),
 	SND_SOC_DAPM_INPUT("ADC1IN"),
 	SND_SOC_DAPM_INPUT("ADC2IN"),
 };
@@ -91,18 +97,33 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "DAC", NULL, "SYSCLK" },
 	{ "DAC Output", NULL, "DAC" },
 	{ "DAC Output", NULL, "VMID" },
-	{ "ADC", NULL, "SYSCLK" },
-	{ "DAC", NULL, "ADC_PWR" },
-	{ "ADC", NULL, "ADC_PWR" },
 	{ "DAC1OUT", NULL, "DAC Output" },
 	{ "DAC2OUT", NULL, "DAC Output" },
 	{ "DAC3OUT", NULL, "DAC Output" },
 	{ "DAC4OUT", NULL, "DAC Output" },
+	{ "SYSCLK", NULL, "PLL_PWR" },
+};
+
+static const struct snd_soc_dapm_route ad193x_adc_audio_paths[] = {
+	{ "ADC", NULL, "SYSCLK" },
+	{ "ADC", NULL, "ADC_PWR" },
 	{ "ADC", NULL, "ADC1IN" },
 	{ "ADC", NULL, "ADC2IN" },
-	{ "SYSCLK", NULL, "PLL_PWR" },
 };
 
+static inline bool ad193x_has_adc(const struct ad193x_priv *ad193x)
+{
+	switch (ad193x->type) {
+	case AD1933:
+	case AD1934:
+		return false;
+	default:
+		break;
+	}
+
+	return true;
+}
+
 /*
  * DAI ops entries
  */
@@ -147,8 +168,10 @@ static int ad193x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 
 	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL1,
 		AD193X_DAC_CHAN_MASK, channels << AD193X_DAC_CHAN_SHFT);
-	regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
-		AD193X_ADC_CHAN_MASK, channels << AD193X_ADC_CHAN_SHFT);
+	if (ad193x_has_adc(ad193x))
+		regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
+				   AD193X_ADC_CHAN_MASK,
+				   channels << AD193X_ADC_CHAN_SHFT);
 
 	return 0;
 }
@@ -172,7 +195,9 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		adc_serfmt |= AD193X_ADC_SERFMT_AUX;
 		break;
 	default:
-		return -EINVAL;
+		if (ad193x_has_adc(ad193x))
+			return -EINVAL;
+		break;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -217,10 +242,12 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL1,
-		AD193X_ADC_SERFMT_MASK, adc_serfmt);
-	regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
-		AD193X_ADC_FMT_MASK, adc_fmt);
+	if (ad193x_has_adc(ad193x)) {
+		regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL1,
+				   AD193X_ADC_SERFMT_MASK, adc_serfmt);
+		regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
+				   AD193X_ADC_FMT_MASK, adc_fmt);
+	}
 	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL1,
 		AD193X_DAC_FMT_MASK, dac_fmt);
 
@@ -287,8 +314,9 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
 			    AD193X_DAC_WORD_LEN_MASK,
 			    word_len << AD193X_DAC_WORD_LEN_SHFT);
 
-	regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL1,
-			    AD193X_ADC_WORD_LEN_MASK, word_len);
+	if (ad193x_has_adc(ad193x))
+		regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL1,
+				   AD193X_ADC_WORD_LEN_MASK, word_len);
 
 	return 0;
 }
@@ -326,6 +354,8 @@ static struct snd_soc_dai_driver ad193x_dai = {
 static int ad193x_codec_probe(struct snd_soc_codec *codec)
 {
 	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	int num, ret;
 
 	/* default setting for ad193x */
 
@@ -335,14 +365,46 @@ static int ad193x_codec_probe(struct snd_soc_codec *codec)
 	regmap_write(ad193x->regmap, AD193X_DAC_CTRL2, 0x1A);
 	/* dac in tdm mode */
 	regmap_write(ad193x->regmap, AD193X_DAC_CTRL0, 0x40);
-	/* high-pass filter enable */
-	regmap_write(ad193x->regmap, AD193X_ADC_CTRL0, 0x3);
-	/* sata delay=1, adc aux mode */
-	regmap_write(ad193x->regmap, AD193X_ADC_CTRL1, 0x43);
+
+	/* adc only */
+	if (ad193x_has_adc(ad193x)) {
+		/* high-pass filter enable */
+		regmap_write(ad193x->regmap, AD193X_ADC_CTRL0, 0x3);
+		/* sata delay=1, adc aux mode */
+		regmap_write(ad193x->regmap, AD193X_ADC_CTRL1, 0x43);
+	}
+
 	/* pll input: mclki/xi */
 	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL0, 0x99); /* mclk=24.576Mhz: 0x9D; mclk=12.288Mhz: 0x99 */
 	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL1, 0x04);
 
+	/* adc only */
+	if (ad193x_has_adc(ad193x)) {
+		/* add adc controls */
+		num = ARRAY_SIZE(ad193x_adc_snd_controls);
+		ret = snd_soc_add_codec_controls(codec,
+						 ad193x_adc_snd_controls,
+						 num);
+		if (ret)
+			return ret;
+
+		/* add adc widgets */
+		num = ARRAY_SIZE(ad193x_adc_widgets);
+		ret = snd_soc_dapm_new_controls(dapm,
+						ad193x_adc_widgets,
+						num);
+		if (ret)
+			return ret;
+
+		/* add adc routes */
+		num = ARRAY_SIZE(ad193x_adc_audio_paths);
+		ret = snd_soc_dapm_add_routes(dapm,
+					      ad193x_adc_audio_paths,
+					      num);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -367,7 +429,8 @@ const struct regmap_config ad193x_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(ad193x_regmap_config);
 
-int ad193x_probe(struct device *dev, struct regmap *regmap)
+int ad193x_probe(struct device *dev, struct regmap *regmap,
+		 enum ad193x_type type)
 {
 	struct ad193x_priv *ad193x;
 
@@ -379,6 +442,7 @@ int ad193x_probe(struct device *dev, struct regmap *regmap)
 		return -ENOMEM;
 
 	ad193x->regmap = regmap;
+	ad193x->type = type;
 
 	dev_set_drvdata(dev, ad193x);
 
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index ab9a998..8b1e65f 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -13,8 +13,15 @@
 
 struct device;
 
+enum ad193x_type {
+	AD193X,
+	AD1933,
+	AD1934,
+};
+
 extern const struct regmap_config ad193x_regmap_config;
-int ad193x_probe(struct device *dev, struct regmap *regmap);
+int ad193x_probe(struct device *dev, struct regmap *regmap,
+		 enum ad193x_type type);
 
 #define AD193X_PLL_CLK_CTRL0    0x00
 #define AD193X_PLL_POWERDOWN           0x01
-- 
2.5.0
