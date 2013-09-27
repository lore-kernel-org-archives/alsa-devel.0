From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: adav80x: Convert to direct regmap usage
Date: Fri, 27 Sep 2013 15:18:25 +0200
Message-ID: <1380287905-20520-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 646272656FE
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 15:16:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adav80x.c | 147 +++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 15b012d0..14a7c16 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -115,22 +115,34 @@
 
 #define ADAV80X_PLL_OUTE_SYSCLKPD(x)		BIT(2 - (x))
 
-static u8 adav80x_default_regs[] = {
-	0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x02, 0x01, 0x80, 0x26, 0x00, 0x00,
-	0x02, 0x40, 0x20, 0x00, 0x09, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x04, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0xd1, 0x92, 0xb1, 0x37,
-	0x48, 0xd2, 0xfb, 0xca, 0xd2, 0x15, 0xe8, 0x29, 0xb9, 0x6a, 0xda, 0x2b,
-	0xb7, 0xc0, 0x11, 0x65, 0x5c, 0xf6, 0xff, 0x8d, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa5, 0x00, 0x00,
-	0x00, 0xe8, 0x46, 0xe1, 0x5b, 0xd3, 0x43, 0x77, 0x93, 0xa7, 0x44, 0xee,
-	0x32, 0x12, 0xc0, 0x11, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x3f, 0x3f,
-	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x1d, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x52, 0x00,
+static struct reg_default adav80x_reg_defaults[] = {
+	{ ADAV80X_PLAYBACK_CTRL,	0x01 },
+	{ ADAV80X_AUX_IN_CTRL,		0x01 },
+	{ ADAV80X_REC_CTRL,		0x02 },
+	{ ADAV80X_AUX_OUT_CTRL,		0x01 },
+	{ ADAV80X_DPATH_CTRL1,		0xc0 },
+	{ ADAV80X_DPATH_CTRL2,		0x11 },
+	{ ADAV80X_DAC_CTRL1,		0x00 },
+	{ ADAV80X_DAC_CTRL2,		0x00 },
+	{ ADAV80X_DAC_CTRL3,		0x00 },
+	{ ADAV80X_DAC_L_VOL,		0xff },
+	{ ADAV80X_DAC_R_VOL,		0xff },
+	{ ADAV80X_PGA_L_VOL,		0x00 },
+	{ ADAV80X_PGA_R_VOL,		0x00 },
+	{ ADAV80X_ADC_CTRL1,		0x00 },
+	{ ADAV80X_ADC_CTRL2,		0x00 },
+	{ ADAV80X_ADC_L_VOL,		0xff },
+	{ ADAV80X_ADC_R_VOL,		0xff },
+	{ ADAV80X_PLL_CTRL1,		0x00 },
+	{ ADAV80X_PLL_CTRL2,		0x00 },
+	{ ADAV80X_ICLK_CTRL1,		0x00 },
+	{ ADAV80X_ICLK_CTRL2,		0x00 },
+	{ ADAV80X_PLL_CLK_SRC,		0x00 },
+	{ ADAV80X_PLL_OUTE,		0x00 },
 };
 
 struct adav80x {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 
 	enum adav80x_clk_src clk_src;
 	unsigned int sysclk;
@@ -298,7 +310,7 @@ static int adav80x_set_deemph(struct snd_soc_codec *codec)
 		val = ADAV80X_DAC_CTRL2_DEEMPH_NONE;
 	}
 
-	return snd_soc_update_bits(codec, ADAV80X_DAC_CTRL2,
+	return regmap_update_bits(adav80x->regmap, ADAV80X_DAC_CTRL2,
 		ADAV80X_DAC_CTRL2_DEEMPH_MASK, val);
 }
 
@@ -394,10 +406,11 @@ static int adav80x_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, adav80x_port_ctrl_regs[dai->id][0],
+	regmap_update_bits(adav80x->regmap, adav80x_port_ctrl_regs[dai->id][0],
 		ADAV80X_CAPTURE_MODE_MASK | ADAV80X_CAPTURE_MODE_MASTER,
 		capture);
-	snd_soc_write(codec, adav80x_port_ctrl_regs[dai->id][1], playback);
+	regmap_write(adav80x->regmap, adav80x_port_ctrl_regs[dai->id][1],
+		playback);
 
 	adav80x->dai_fmt[dai->id] = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
@@ -407,6 +420,7 @@ static int adav80x_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int adav80x_set_adc_clock(struct snd_soc_codec *codec,
 		unsigned int sample_rate)
 {
+	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
 
 	if (sample_rate <= 48000)
@@ -414,7 +428,7 @@ static int adav80x_set_adc_clock(struct snd_soc_codec *codec,
 	else
 		val = ADAV80X_ADC_CTRL1_MODULATOR_64FS;
 
-	snd_soc_update_bits(codec, ADAV80X_ADC_CTRL1,
+	regmap_update_bits(adav80x->regmap, ADAV80X_ADC_CTRL1,
 		ADAV80X_ADC_CTRL1_MODULATOR_MASK, val);
 
 	return 0;
@@ -423,6 +437,7 @@ static int adav80x_set_adc_clock(struct snd_soc_codec *codec,
 static int adav80x_set_dac_clock(struct snd_soc_codec *codec,
 		unsigned int sample_rate)
 {
+	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
 
 	if (sample_rate <= 48000)
@@ -430,7 +445,7 @@ static int adav80x_set_dac_clock(struct snd_soc_codec *codec,
 	else
 		val = ADAV80X_DAC_CTRL2_DIV2 | ADAV80X_DAC_CTRL2_INTERPOL_128FS;
 
-	snd_soc_update_bits(codec, ADAV80X_DAC_CTRL2,
+	regmap_update_bits(adav80x->regmap, ADAV80X_DAC_CTRL2,
 		ADAV80X_DAC_CTRL2_DIV_MASK | ADAV80X_DAC_CTRL2_INTERPOL_MASK,
 		val);
 
@@ -440,6 +455,7 @@ static int adav80x_set_dac_clock(struct snd_soc_codec *codec,
 static int adav80x_set_capture_pcm_format(struct snd_soc_codec *codec,
 		struct snd_soc_dai *dai, snd_pcm_format_t format)
 {
+	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
 
 	switch (format) {
@@ -459,7 +475,7 @@ static int adav80x_set_capture_pcm_format(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, adav80x_port_ctrl_regs[dai->id][0],
+	regmap_update_bits(adav80x->regmap, adav80x_port_ctrl_regs[dai->id][0],
 		ADAV80X_CAPTURE_WORD_LEN_MASK, val);
 
 	return 0;
@@ -491,7 +507,7 @@ static int adav80x_set_playback_pcm_format(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, adav80x_port_ctrl_regs[dai->id][1],
+	regmap_update_bits(adav80x->regmap, adav80x_port_ctrl_regs[dai->id][1],
 		ADAV80X_PLAYBACK_MODE_MASK, val);
 
 	return 0;
@@ -554,8 +570,10 @@ static int adav80x_set_sysclk(struct snd_soc_codec *codec,
 					ADAV80X_ICLK_CTRL1_ICLK2_SRC(clk_id);
 			iclk_ctrl2 = ADAV80X_ICLK_CTRL2_ICLK1_SRC(clk_id);
 
-			snd_soc_write(codec, ADAV80X_ICLK_CTRL1, iclk_ctrl1);
-			snd_soc_write(codec, ADAV80X_ICLK_CTRL2, iclk_ctrl2);
+			regmap_write(adav80x->regmap, ADAV80X_ICLK_CTRL1,
+				iclk_ctrl1);
+			regmap_write(adav80x->regmap, ADAV80X_ICLK_CTRL2,
+				iclk_ctrl2);
 
 			snd_soc_dapm_sync(&codec->dapm);
 		}
@@ -575,10 +593,12 @@ static int adav80x_set_sysclk(struct snd_soc_codec *codec,
 		mask = ADAV80X_PLL_OUTE_SYSCLKPD(clk_id);
 
 		if (freq == 0) {
-			snd_soc_update_bits(codec, ADAV80X_PLL_OUTE, mask, mask);
+			regmap_update_bits(adav80x->regmap, ADAV80X_PLL_OUTE,
+				mask, mask);
 			adav80x->sysclk_pd[clk_id] = true;
 		} else {
-			snd_soc_update_bits(codec, ADAV80X_PLL_OUTE, mask, 0);
+			regmap_update_bits(adav80x->regmap, ADAV80X_PLL_OUTE,
+				mask, 0);
 			adav80x->sysclk_pd[clk_id] = false;
 		}
 
@@ -650,9 +670,9 @@ static int adav80x_set_pll(struct snd_soc_codec *codec, int pll_id,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, ADAV80X_PLL_CTRL1, ADAV80X_PLL_CTRL1_PLLDIV,
-		pll_ctrl1);
-	snd_soc_update_bits(codec, ADAV80X_PLL_CTRL2,
+	regmap_update_bits(adav80x->regmap, ADAV80X_PLL_CTRL1,
+			ADAV80X_PLL_CTRL1_PLLDIV, pll_ctrl1);
+	regmap_update_bits(adav80x->regmap, ADAV80X_PLL_CTRL2,
 			ADAV80X_PLL_CTRL2_PLL_MASK(pll_id), pll_ctrl2);
 
 	if (source != adav80x->pll_src) {
@@ -661,7 +681,7 @@ static int adav80x_set_pll(struct snd_soc_codec *codec, int pll_id,
 		else
 			pll_src = ADAV80X_PLL_CLK_SRC_PLL_XIN(pll_id);
 
-		snd_soc_update_bits(codec, ADAV80X_PLL_CLK_SRC,
+		regmap_update_bits(adav80x->regmap, ADAV80X_PLL_CLK_SRC,
 				ADAV80X_PLL_CLK_SRC_PLL_MASK(pll_id), pll_src);
 
 		adav80x->pll_src = source;
@@ -675,6 +695,7 @@ static int adav80x_set_pll(struct snd_soc_codec *codec, int pll_id,
 static int adav80x_set_bias_level(struct snd_soc_codec *codec,
 		enum snd_soc_bias_level level)
 {
+	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	unsigned int mask = ADAV80X_DAC_CTRL1_PD;
 
 	switch (level) {
@@ -683,10 +704,12 @@ static int adav80x_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		snd_soc_update_bits(codec, ADAV80X_DAC_CTRL1, mask, 0x00);
+		regmap_update_bits(adav80x->regmap, ADAV80X_DAC_CTRL1, mask,
+			0x00);
 		break;
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, ADAV80X_DAC_CTRL1, mask, mask);
+		regmap_update_bits(adav80x->regmap, ADAV80X_DAC_CTRL1, mask,
+			mask);
 		break;
 	}
 
@@ -780,7 +803,7 @@ static int adav80x_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, adav80x->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
 	if (ret) {
 		dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -791,23 +814,31 @@ static int adav80x_probe(struct snd_soc_codec *codec)
 	snd_soc_dapm_force_enable_pin(&codec->dapm, "PLL2");
 
 	/* Power down S/PDIF receiver, since it is currently not supported */
-	snd_soc_write(codec, ADAV80X_PLL_OUTE, 0x20);
+	regmap_write(adav80x->regmap, ADAV80X_PLL_OUTE, 0x20);
 	/* Disable DAC zero flag */
-	snd_soc_write(codec, ADAV80X_DAC_CTRL3, 0x6);
+	regmap_write(adav80x->regmap, ADAV80X_DAC_CTRL3, 0x6);
 
 	return adav80x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 }
 
 static int adav80x_suspend(struct snd_soc_codec *codec)
 {
-	return adav80x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = adav80x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_cache_only(adav80x->regmap, true);
+
+	return ret;
 }
 
 static int adav80x_resume(struct snd_soc_codec *codec)
 {
+	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
+
+	regcache_cache_only(adav80x->regmap, false);
 	adav80x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	codec->cache_sync = 1;
-	snd_soc_cache_sync(codec);
+	regcache_sync(adav80x->regmap);
 
 	return 0;
 }
@@ -827,10 +858,6 @@ static struct snd_soc_codec_driver adav80x_codec_driver = {
 	.set_pll = adav80x_set_pll,
 	.set_sysclk = adav80x_set_sysclk,
 
-	.reg_word_size = sizeof(u8),
-	.reg_cache_size = ARRAY_SIZE(adav80x_default_regs),
-	.reg_cache_default = adav80x_default_regs,
-
 	.controls = adav80x_controls,
 	.num_controls = ARRAY_SIZE(adav80x_controls),
 	.dapm_widgets = adav80x_dapm_widgets,
@@ -839,18 +866,21 @@ static struct snd_soc_codec_driver adav80x_codec_driver = {
 	.num_dapm_routes = ARRAY_SIZE(adav80x_dapm_routes),
 };
 
-static int adav80x_bus_probe(struct device *dev,
-			     enum snd_soc_control_type control_type)
+static int adav80x_bus_probe(struct device *dev, struct regmap *regmap)
 {
 	struct adav80x *adav80x;
 	int ret;
 
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	adav80x = kzalloc(sizeof(*adav80x), GFP_KERNEL);
 	if (!adav80x)
 		return -ENOMEM;
 
+
 	dev_set_drvdata(dev, adav80x);
-	adav80x->control_type = control_type;
+	adav80x->regmap = regmap;
 
 	ret = snd_soc_register_codec(dev, &adav80x_codec_driver,
 		adav80x_dais, ARRAY_SIZE(adav80x_dais));
@@ -868,6 +898,19 @@ static int adav80x_bus_remove(struct device *dev)
 }
 
 #if defined(CONFIG_SPI_MASTER)
+static const struct regmap_config adav80x_spi_regmap_config = {
+	.val_bits = 8,
+	.pad_bits = 1,
+	.reg_bits = 7,
+	.read_flag_mask = 0x01,
+
+	.max_register = ADAV80X_PLL_OUTE,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = adav80x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(adav80x_reg_defaults),
+};
+
 static const struct spi_device_id adav80x_spi_id[] = {
 	{ "adav801", 0 },
 	{ }
@@ -876,7 +919,8 @@ MODULE_DEVICE_TABLE(spi, adav80x_spi_id);
 
 static int adav80x_spi_probe(struct spi_device *spi)
 {
-	return adav80x_bus_probe(&spi->dev, SND_SOC_SPI);
+	return adav80x_bus_probe(&spi->dev,
+		devm_regmap_init_spi(spi, &adav80x_spi_regmap_config));
 }
 
 static int adav80x_spi_remove(struct spi_device *spi)
@@ -896,6 +940,18 @@ static struct spi_driver adav80x_spi_driver = {
 #endif
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static const struct regmap_config adav80x_i2c_regmap_config = {
+	.val_bits = 8,
+	.pad_bits = 1,
+	.reg_bits = 7,
+
+	.max_register = ADAV80X_PLL_OUTE,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = adav80x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(adav80x_reg_defaults),
+};
+
 static const struct i2c_device_id adav80x_i2c_id[] = {
 	{ "adav803", 0 },
 	{ }
@@ -905,7 +961,8 @@ MODULE_DEVICE_TABLE(i2c, adav80x_i2c_id);
 static int adav80x_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
-	return adav80x_bus_probe(&client->dev, SND_SOC_I2C);
+	return adav80x_bus_probe(&client->dev,
+		devm_regmap_init_i2c(client, &adav80x_i2c_regmap_config));
 }
 
 static int adav80x_i2c_remove(struct i2c_client *client)
-- 
1.8.0
