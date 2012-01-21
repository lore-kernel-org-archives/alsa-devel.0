From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: wm8985: Convert to direct regmap API
	usage
Date: Sat, 21 Jan 2012 15:45:27 +0000
Message-ID: <1327160727-1546-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9021910389C
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2012 16:45:33 +0100 (CET)
In-Reply-To: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8985.c |  253 +++++++++++++++++++++++++++++++--------------
 1 files changed, 177 insertions(+), 76 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index bbe19b2..14f6663 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
@@ -39,73 +40,127 @@ static const char *wm8985_supply_names[WM8985_NUM_SUPPLIES] = {
 	"AVDD2"
 };
 
-static const u16 wm8985_reg_defs[] = {
-	0x0000,     /* R0  - Software Reset */
-	0x0000,     /* R1  - Power management 1 */
-	0x0000,     /* R2  - Power management 2 */
-	0x0000,     /* R3  - Power management 3 */
-	0x0050,     /* R4  - Audio Interface */
-	0x0000,     /* R5  - Companding control */
-	0x0140,     /* R6  - Clock Gen control */
-	0x0000,     /* R7  - Additional control */
-	0x0000,     /* R8  - GPIO Control */
-	0x0000,     /* R9  - Jack Detect Control 1 */
-	0x0000,     /* R10 - DAC Control */
-	0x00FF,     /* R11 - Left DAC digital Vol */
-	0x00FF,     /* R12 - Right DAC digital vol */
-	0x0000,     /* R13 - Jack Detect Control 2 */
-	0x0100,     /* R14 - ADC Control */
-	0x00FF,     /* R15 - Left ADC Digital Vol */
-	0x00FF,     /* R16 - Right ADC Digital Vol */
-	0x0000,     /* R17 */
-	0x012C,     /* R18 - EQ1 - low shelf */
-	0x002C,     /* R19 - EQ2 - peak 1 */
-	0x002C,     /* R20 - EQ3 - peak 2 */
-	0x002C,     /* R21 - EQ4 - peak 3 */
-	0x002C,     /* R22 - EQ5 - high shelf */
-	0x0000,     /* R23 */
-	0x0032,     /* R24 - DAC Limiter 1 */
-	0x0000,     /* R25 - DAC Limiter 2 */
-	0x0000,     /* R26 */
-	0x0000,     /* R27 - Notch Filter 1 */
-	0x0000,     /* R28 - Notch Filter 2 */
-	0x0000,     /* R29 - Notch Filter 3 */
-	0x0000,     /* R30 - Notch Filter 4 */
-	0x0000,     /* R31 */
-	0x0038,     /* R32 - ALC control 1 */
-	0x000B,     /* R33 - ALC control 2 */
-	0x0032,     /* R34 - ALC control 3 */
-	0x0000,     /* R35 - Noise Gate */
-	0x0008,     /* R36 - PLL N */
-	0x000C,     /* R37 - PLL K 1 */
-	0x0093,     /* R38 - PLL K 2 */
-	0x00E9,     /* R39 - PLL K 3 */
-	0x0000,     /* R40 */
-	0x0000,     /* R41 - 3D control */
-	0x0000,     /* R42 - OUT4 to ADC */
-	0x0000,     /* R43 - Beep control */
-	0x0033,     /* R44 - Input ctrl */
-	0x0010,     /* R45 - Left INP PGA gain ctrl */
-	0x0010,     /* R46 - Right INP PGA gain ctrl */
-	0x0100,     /* R47 - Left ADC BOOST ctrl */
-	0x0100,     /* R48 - Right ADC BOOST ctrl */
-	0x0002,     /* R49 - Output ctrl */
-	0x0001,     /* R50 - Left mixer ctrl */
-	0x0001,     /* R51 - Right mixer ctrl */
-	0x0039,     /* R52 - LOUT1 (HP) volume ctrl */
-	0x0039,     /* R53 - ROUT1 (HP) volume ctrl */
-	0x0039,     /* R54 - LOUT2 (SPK) volume ctrl */
-	0x0039,     /* R55 - ROUT2 (SPK) volume ctrl */
-	0x0001,     /* R56 - OUT3 mixer ctrl */
-	0x0001,     /* R57 - OUT4 (MONO) mix ctrl */
-	0x0001,     /* R58 */
-	0x0000,     /* R59 */
-	0x0004,     /* R60 - OUTPUT ctrl */
-	0x0000,     /* R61 - BIAS CTRL */
-	0x0180,     /* R62 */
-	0x0000      /* R63 */
+static const struct reg_default wm8985_reg_defaults[] = {
+	{ 1,  0x0000 },     /* R1  - Power management 1 */
+	{ 2,  0x0000 },     /* R2  - Power management 2 */
+	{ 3,  0x0000 },     /* R3  - Power management 3 */
+	{ 4,  0x0050 },     /* R4  - Audio Interface */
+	{ 5,  0x0000 },     /* R5  - Companding control */
+	{ 6,  0x0140 },     /* R6  - Clock Gen control */
+	{ 7,  0x0000 },     /* R7  - Additional control */
+	{ 8,  0x0000 },     /* R8  - GPIO Control */
+	{ 9,  0x0000 },     /* R9  - Jack Detect Control 1 */
+	{ 10, 0x0000 },     /* R10 - DAC Control */
+	{ 11, 0x00FF },     /* R11 - Left DAC digital Vol */
+	{ 12, 0x00FF },     /* R12 - Right DAC digital vol */
+	{ 13, 0x0000 },     /* R13 - Jack Detect Control 2 */
+	{ 14, 0x0100 },     /* R14 - ADC Control */
+	{ 15, 0x00FF },     /* R15 - Left ADC Digital Vol */
+	{ 16, 0x00FF },     /* R16 - Right ADC Digital Vol */
+	{ 18, 0x012C },     /* R18 - EQ1 - low shelf */
+	{ 19, 0x002C },     /* R19 - EQ2 - peak 1 */
+	{ 20, 0x002C },     /* R20 - EQ3 - peak 2 */
+	{ 21, 0x002C },     /* R21 - EQ4 - peak 3 */
+	{ 22, 0x002C },     /* R22 - EQ5 - high shelf */
+	{ 24, 0x0032 },     /* R24 - DAC Limiter 1 */
+	{ 25, 0x0000 },     /* R25 - DAC Limiter 2 */
+	{ 27, 0x0000 },     /* R27 - Notch Filter 1 */
+	{ 28, 0x0000 },     /* R28 - Notch Filter 2 */
+	{ 29, 0x0000 },     /* R29 - Notch Filter 3 */
+	{ 30, 0x0000 },     /* R30 - Notch Filter 4 */
+	{ 32, 0x0038 },     /* R32 - ALC control 1 */
+	{ 33, 0x000B },     /* R33 - ALC control 2 */
+	{ 34, 0x0032 },     /* R34 - ALC control 3 */
+	{ 35, 0x0000 },     /* R35 - Noise Gate */
+	{ 36, 0x0008 },     /* R36 - PLL N */
+	{ 37, 0x000C },     /* R37 - PLL K 1 */
+	{ 38, 0x0093 },     /* R38 - PLL K 2 */
+	{ 39, 0x00E9 },     /* R39 - PLL K 3 */
+	{ 41, 0x0000 },     /* R41 - 3D control */
+	{ 42, 0x0000 },     /* R42 - OUT4 to ADC */
+	{ 43, 0x0000 },     /* R43 - Beep control */
+	{ 44, 0x0033 },     /* R44 - Input ctrl */
+	{ 45, 0x0010 },     /* R45 - Left INP PGA gain ctrl */
+	{ 46, 0x0010 },     /* R46 - Right INP PGA gain ctrl */
+	{ 47, 0x0100 },     /* R47 - Left ADC BOOST ctrl */
+	{ 48, 0x0100 },     /* R48 - Right ADC BOOST ctrl */
+	{ 49, 0x0002 },     /* R49 - Output ctrl */
+	{ 50, 0x0001 },     /* R50 - Left mixer ctrl */
+	{ 51, 0x0001 },     /* R51 - Right mixer ctrl */
+	{ 52, 0x0039 },     /* R52 - LOUT1 (HP) volume ctrl */
+	{ 53, 0x0039 },     /* R53 - ROUT1 (HP) volume ctrl */
+	{ 54, 0x0039 },     /* R54 - LOUT2 (SPK) volume ctrl */
+	{ 55, 0x0039 },     /* R55 - ROUT2 (SPK) volume ctrl */
+	{ 56, 0x0001 },     /* R56 - OUT3 mixer ctrl */
+	{ 57, 0x0001 },     /* R57 - OUT4 (MONO) mix ctrl */
+	{ 60, 0x0004 },     /* R60 - OUTPUT ctrl */
+	{ 61, 0x0000 },     /* R61 - BIAS CTRL */
 };
 
+static bool wm8985_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8985_SOFTWARE_RESET:
+	case WM8985_POWER_MANAGEMENT_1:
+	case WM8985_POWER_MANAGEMENT_2:
+	case WM8985_POWER_MANAGEMENT_3:
+	case WM8985_AUDIO_INTERFACE:
+	case WM8985_COMPANDING_CONTROL:
+	case WM8985_CLOCK_GEN_CONTROL:
+	case WM8985_ADDITIONAL_CONTROL:
+	case WM8985_GPIO_CONTROL:
+	case WM8985_JACK_DETECT_CONTROL_1:
+	case WM8985_DAC_CONTROL:
+	case WM8985_LEFT_DAC_DIGITAL_VOL:
+	case WM8985_RIGHT_DAC_DIGITAL_VOL:
+	case WM8985_JACK_DETECT_CONTROL_2:
+	case WM8985_ADC_CONTROL:
+	case WM8985_LEFT_ADC_DIGITAL_VOL:
+	case WM8985_RIGHT_ADC_DIGITAL_VOL:
+	case WM8985_EQ1_LOW_SHELF:
+	case WM8985_EQ2_PEAK_1:
+	case WM8985_EQ3_PEAK_2:
+	case WM8985_EQ4_PEAK_3:
+	case WM8985_EQ5_HIGH_SHELF:
+	case WM8985_DAC_LIMITER_1:
+	case WM8985_DAC_LIMITER_2:
+	case WM8985_NOTCH_FILTER_1:
+	case WM8985_NOTCH_FILTER_2:
+	case WM8985_NOTCH_FILTER_3:
+	case WM8985_NOTCH_FILTER_4:
+	case WM8985_ALC_CONTROL_1:
+	case WM8985_ALC_CONTROL_2:
+	case WM8985_ALC_CONTROL_3:
+	case WM8985_NOISE_GATE:
+	case WM8985_PLL_N:
+	case WM8985_PLL_K_1:
+	case WM8985_PLL_K_2:
+	case WM8985_PLL_K_3:
+	case WM8985_3D_CONTROL:
+	case WM8985_OUT4_TO_ADC:
+	case WM8985_BEEP_CONTROL:
+	case WM8985_INPUT_CTRL:
+	case WM8985_LEFT_INP_PGA_GAIN_CTRL:
+	case WM8985_RIGHT_INP_PGA_GAIN_CTRL:
+	case WM8985_LEFT_ADC_BOOST_CTRL:
+	case WM8985_RIGHT_ADC_BOOST_CTRL:
+	case WM8985_OUTPUT_CTRL0:
+	case WM8985_LEFT_MIXER_CTRL:
+	case WM8985_RIGHT_MIXER_CTRL:
+	case WM8985_LOUT1_HP_VOLUME_CTRL:
+	case WM8985_ROUT1_HP_VOLUME_CTRL:
+	case WM8985_LOUT2_SPK_VOLUME_CTRL:
+	case WM8985_ROUT2_SPK_VOLUME_CTRL:
+	case WM8985_OUT3_MIXER_CTRL:
+	case WM8985_OUT4_MONO_MIX_CTRL:
+	case WM8985_OUTPUT_CTRL1:
+	case WM8985_BIAS_CTRL:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * latch bit 8 of these registers to ensure instant
  * volume updates
@@ -124,7 +179,7 @@ static const int volume_update_regs[] = {
 };
 
 struct wm8985_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8985_NUM_SUPPLIES];
 	unsigned int sysclk;
 	unsigned int bclk;
@@ -860,7 +915,7 @@ static int wm8985_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			}
 
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8985->regmap);
 
 			/* enable anti-pop features */
 			snd_soc_update_bits(codec, WM8985_OUT4_TO_ADC,
@@ -903,7 +958,7 @@ static int wm8985_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8985_POWER_MANAGEMENT_2, 0);
 		snd_soc_write(codec, WM8985_POWER_MANAGEMENT_3, 0);
 
-		codec->cache_sync = 1;
+		regcache_mark_dirty(wm8985->regmap);
 
 		regulator_bulk_disable(ARRAY_SIZE(wm8985->supplies),
 				       wm8985->supplies);
@@ -948,8 +1003,9 @@ static int wm8985_probe(struct snd_soc_codec *codec)
 	int ret;
 
 	wm8985 = snd_soc_codec_get_drvdata(codec);
+	codec->control_data = wm8985->regmap;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8985->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache i/o: %d\n", ret);
 		return ret;
@@ -1037,14 +1093,23 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
 	.controls = wm8985_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8985_snd_controls),
 	.dapm_widgets = wm8985_dapm_widgets,
-	.reg_cache_size = ARRAY_SIZE(wm8985_reg_defs),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8985_reg_defs
 	.num_dapm_widgets = ARRAY_SIZE(wm8985_dapm_widgets),
 	.dapm_routes = wm8985_dapm_routes,
 	.num_dapm_routes = ARRAY_SIZE(wm8985_dapm_routes),
 };
 
+static const struct regmap_config wm8985_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.max_register = WM8985_MAX_REGISTER,
+	.writeable_reg = wm8985_writeable,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wm8985_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8985_reg_defaults),
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8985_spi_probe(struct spi_device *spi)
 {
@@ -1055,17 +1120,35 @@ static int __devinit wm8985_spi_probe(struct spi_device *spi)
 	if (!wm8985)
 		return -ENOMEM;
 
-	wm8985->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8985);
 
+	wm8985->regmap = regmap_init_spi(spi, &wm8985_regmap);
+	if (IS_ERR(wm8985->regmap)) {
+		ret = PTR_ERR(wm8985->regmap);
+		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto err;
+	}
+
 	ret = snd_soc_register_codec(&spi->dev,
 				     &soc_codec_dev_wm8985, &wm8985_dai, 1);
+	if (ret != 0)
+		goto err;
+
+	return 0;
+
+err:
+	regmap_exit(wm8985->regmap);
 	return ret;
 }
 
 static int __devexit wm8985_spi_remove(struct spi_device *spi)
 {
+	struct wm8985_priv *wm8985 = spi_get_drvdata(spi);
+
 	snd_soc_unregister_codec(&spi->dev);
+	regmap_exit(wm8985->regmap);
+
 	return 0;
 }
 
@@ -1090,17 +1173,35 @@ static __devinit int wm8985_i2c_probe(struct i2c_client *i2c,
 	if (!wm8985)
 		return -ENOMEM;
 
-	wm8985->control_type = SND_SOC_I2C;
 	i2c_set_clientdata(i2c, wm8985);
 
+	wm8985->regmap = regmap_init_i2c(i2c, &wm8985_regmap);
+	if (IS_ERR(wm8985->regmap)) {
+		ret = PTR_ERR(wm8985->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto err;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8985, &wm8985_dai, 1);
+	if (ret != 0)
+		goto err;
+
+	return 0;
+
+err:
+	regmap_exit(wm8985->regmap);
 	return ret;
 }
 
-static __devexit int wm8985_i2c_remove(struct i2c_client *client)
+static __devexit int wm8985_i2c_remove(struct i2c_client *i2c)
 {
-	snd_soc_unregister_codec(&client->dev);
+	struct wm8985_priv *wm8985 = i2c_get_clientdata(i2c);
+
+	snd_soc_unregister_codec(&i2c->dev);
+	regmap_exit(wm8985->regmap);
+
 	return 0;
 }
 
-- 
1.7.7.3
