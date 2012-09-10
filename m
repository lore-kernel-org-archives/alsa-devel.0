From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8983: Convert to direct regmap API
	usage
Date: Mon, 10 Sep 2012 15:29:22 +0800
Message-ID: <1347262162-5335-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347262162-5335-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFAA2264FBA
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 09:58:34 +0200 (CEST)
In-Reply-To: <1347262162-5335-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8983.c |  151 +++++++++++++++++++++++++--------------------
 1 file changed, 85 insertions(+), 66 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 57c33fc..d8879f2 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -27,61 +28,60 @@
 
 #include "wm8983.h"
 
-static const u16 wm8983_reg_defs[WM8983_MAX_REGISTER + 1] = {
-	[0x00] = 0x0000,     /* R0  - Software Reset */
-	[0x01] = 0x0000,     /* R1  - Power management 1 */
-	[0x02] = 0x0000,     /* R2  - Power management 2 */
-	[0x03] = 0x0000,     /* R3  - Power management 3 */
-	[0x04] = 0x0050,     /* R4  - Audio Interface */
-	[0x05] = 0x0000,     /* R5  - Companding control */
-	[0x06] = 0x0140,     /* R6  - Clock Gen control */
-	[0x07] = 0x0000,     /* R7  - Additional control */
-	[0x08] = 0x0000,     /* R8  - GPIO Control */
-	[0x09] = 0x0000,     /* R9  - Jack Detect Control 1 */
-	[0x0A] = 0x0000,     /* R10 - DAC Control */
-	[0x0B] = 0x00FF,     /* R11 - Left DAC digital Vol */
-	[0x0C] = 0x00FF,     /* R12 - Right DAC digital vol */
-	[0x0D] = 0x0000,     /* R13 - Jack Detect Control 2 */
-	[0x0E] = 0x0100,     /* R14 - ADC Control */
-	[0x0F] = 0x00FF,     /* R15 - Left ADC Digital Vol */
-	[0x10] = 0x00FF,     /* R16 - Right ADC Digital Vol */
-	[0x12] = 0x012C,     /* R18 - EQ1 - low shelf */
-	[0x13] = 0x002C,     /* R19 - EQ2 - peak 1 */
-	[0x14] = 0x002C,     /* R20 - EQ3 - peak 2 */
-	[0x15] = 0x002C,     /* R21 - EQ4 - peak 3 */
-	[0x16] = 0x002C,     /* R22 - EQ5 - high shelf */
-	[0x18] = 0x0032,     /* R24 - DAC Limiter 1 */
-	[0x19] = 0x0000,     /* R25 - DAC Limiter 2 */
-	[0x1B] = 0x0000,     /* R27 - Notch Filter 1 */
-	[0x1C] = 0x0000,     /* R28 - Notch Filter 2 */
-	[0x1D] = 0x0000,     /* R29 - Notch Filter 3 */
-	[0x1E] = 0x0000,     /* R30 - Notch Filter 4 */
-	[0x20] = 0x0038,     /* R32 - ALC control 1 */
-	[0x21] = 0x000B,     /* R33 - ALC control 2 */
-	[0x22] = 0x0032,     /* R34 - ALC control 3 */
-	[0x23] = 0x0000,     /* R35 - Noise Gate */
-	[0x24] = 0x0008,     /* R36 - PLL N */
-	[0x25] = 0x000C,     /* R37 - PLL K 1 */
-	[0x26] = 0x0093,     /* R38 - PLL K 2 */
-	[0x27] = 0x00E9,     /* R39 - PLL K 3 */
-	[0x29] = 0x0000,     /* R41 - 3D control */
-	[0x2A] = 0x0000,     /* R42 - OUT4 to ADC */
-	[0x2B] = 0x0000,     /* R43 - Beep control */
-	[0x2C] = 0x0033,     /* R44 - Input ctrl */
-	[0x2D] = 0x0010,     /* R45 - Left INP PGA gain ctrl */
-	[0x2E] = 0x0010,     /* R46 - Right INP PGA gain ctrl */
-	[0x2F] = 0x0100,     /* R47 - Left ADC BOOST ctrl */
-	[0x30] = 0x0100,     /* R48 - Right ADC BOOST ctrl */
-	[0x31] = 0x0002,     /* R49 - Output ctrl */
-	[0x32] = 0x0001,     /* R50 - Left mixer ctrl */
-	[0x33] = 0x0001,     /* R51 - Right mixer ctrl */
-	[0x34] = 0x0039,     /* R52 - LOUT1 (HP) volume ctrl */
-	[0x35] = 0x0039,     /* R53 - ROUT1 (HP) volume ctrl */
-	[0x36] = 0x0039,     /* R54 - LOUT2 (SPK) volume ctrl */
-	[0x37] = 0x0039,     /* R55 - ROUT2 (SPK) volume ctrl */
-	[0x38] = 0x0001,     /* R56 - OUT3 mixer ctrl */
-	[0x39] = 0x0001,     /* R57 - OUT4 (MONO) mix ctrl */
-	[0x3D] = 0x0000      /* R61 - BIAS CTRL */
+static const struct reg_default wm8983_defaults[] = {
+	{ 0x01, 0x0000 },     /* R1  - Power management 1 */
+	{ 0x02, 0x0000 },     /* R2  - Power management 2 */
+	{ 0x03, 0x0000 },     /* R3  - Power management 3 */
+	{ 0x04, 0x0050 },     /* R4  - Audio Interface */
+	{ 0x05, 0x0000 },     /* R5  - Companding control */
+	{ 0x06, 0x0140 },     /* R6  - Clock Gen control */
+	{ 0x07, 0x0000 },     /* R7  - Additional control */
+	{ 0x08, 0x0000 },     /* R8  - GPIO Control */
+	{ 0x09, 0x0000 },     /* R9  - Jack Detect Control 1 */
+	{ 0x0A, 0x0000 },     /* R10 - DAC Control */
+	{ 0x0B, 0x00FF },     /* R11 - Left DAC digital Vol */
+	{ 0x0C, 0x00FF },     /* R12 - Right DAC digital vol */
+	{ 0x0D, 0x0000 },     /* R13 - Jack Detect Control 2 */
+	{ 0x0E, 0x0100 },     /* R14 - ADC Control */
+	{ 0x0F, 0x00FF },     /* R15 - Left ADC Digital Vol */
+	{ 0x10, 0x00FF },     /* R16 - Right ADC Digital Vol */
+	{ 0x12, 0x012C },     /* R18 - EQ1 - low shelf */
+	{ 0x13, 0x002C },     /* R19 - EQ2 - peak 1 */
+	{ 0x14, 0x002C },     /* R20 - EQ3 - peak 2 */
+	{ 0x15, 0x002C },     /* R21 - EQ4 - peak 3 */
+	{ 0x16, 0x002C },     /* R22 - EQ5 - high shelf */
+	{ 0x18, 0x0032 },     /* R24 - DAC Limiter 1 */
+	{ 0x19, 0x0000 },     /* R25 - DAC Limiter 2 */
+	{ 0x1B, 0x0000 },     /* R27 - Notch Filter 1 */
+	{ 0x1C, 0x0000 },     /* R28 - Notch Filter 2 */
+	{ 0x1D, 0x0000 },     /* R29 - Notch Filter 3 */
+	{ 0x1E, 0x0000 },     /* R30 - Notch Filter 4 */
+	{ 0x20, 0x0038 },     /* R32 - ALC control 1 */
+	{ 0x21, 0x000B },     /* R33 - ALC control 2 */
+	{ 0x22, 0x0032 },     /* R34 - ALC control 3 */
+	{ 0x23, 0x0000 },     /* R35 - Noise Gate */
+	{ 0x24, 0x0008 },     /* R36 - PLL N */
+	{ 0x25, 0x000C },     /* R37 - PLL K 1 */
+	{ 0x26, 0x0093 },     /* R38 - PLL K 2 */
+	{ 0x27, 0x00E9 },     /* R39 - PLL K 3 */
+	{ 0x29, 0x0000 },     /* R41 - 3D control */
+	{ 0x2A, 0x0000 },     /* R42 - OUT4 to ADC */
+	{ 0x2B, 0x0000 },     /* R43 - Beep control */
+	{ 0x2C, 0x0033 },     /* R44 - Input ctrl */
+	{ 0x2D, 0x0010 },     /* R45 - Left INP PGA gain ctrl */
+	{ 0x2E, 0x0010 },     /* R46 - Right INP PGA gain ctrl */
+	{ 0x2F, 0x0100 },     /* R47 - Left ADC BOOST ctrl */
+	{ 0x30, 0x0100 },     /* R48 - Right ADC BOOST ctrl */
+	{ 0x31, 0x0002 },     /* R49 - Output ctrl */
+	{ 0x32, 0x0001 },     /* R50 - Left mixer ctrl */
+	{ 0x33, 0x0001 },     /* R51 - Right mixer ctrl */
+	{ 0x34, 0x0039 },     /* R52 - LOUT1 (HP) volume ctrl */
+	{ 0x35, 0x0039 },     /* R53 - ROUT1 (HP) volume ctrl */
+	{ 0x36, 0x0039 },     /* R54 - LOUT2 (SPK) volume ctrl */
+	{ 0x37, 0x0039 },     /* R55 - ROUT2 (SPK) volume ctrl */
+	{ 0x38, 0x0001 },     /* R56 - OUT3 mixer ctrl */
+	{ 0x39, 0x0001 },     /* R57 - OUT4 (MONO) mix ctrl */
+	{ 0x3D, 0x0000 },      /* R61 - BIAS CTRL */
 };
 
 static const struct wm8983_reg_access {
@@ -159,7 +159,7 @@ static const int vol_update_regs[] = {
 };
 
 struct wm8983_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	u32 sysclk;
 	u32 bclk;
 };
@@ -610,7 +610,7 @@ static int eqmode_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int wm8983_readable(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm8983_readable(struct device *dev, unsigned int reg)
 {
 	if (reg > WM8983_MAX_REGISTER)
 		return 0;
@@ -905,6 +905,7 @@ static int wm8983_set_sysclk(struct snd_soc_dai *dai,
 static int wm8983_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8983_priv *wm8983 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	switch (level) {
@@ -917,7 +918,7 @@ static int wm8983_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			ret = snd_soc_cache_sync(codec);
+			ret = regcache_sync(wm8983->regmap);
 			if (ret < 0) {
 				dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
 				return ret;
@@ -994,10 +995,9 @@ static int wm8983_remove(struct snd_soc_codec *codec)
 static int wm8983_probe(struct snd_soc_codec *codec)
 {
 	int ret;
-	struct wm8983_priv *wm8983 = snd_soc_codec_get_drvdata(codec);
 	int i;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8983->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache i/o: %d\n", ret);
 		return ret;
@@ -1067,16 +1067,23 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8983 = {
 	.suspend = wm8983_suspend,
 	.resume = wm8983_resume,
 	.set_bias_level = wm8983_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8983_reg_defs),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8983_reg_defs,
 	.controls = wm8983_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8983_snd_controls),
 	.dapm_widgets = wm8983_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm8983_dapm_widgets),
 	.dapm_routes = wm8983_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(wm8983_audio_map),
-	.readable_register = wm8983_readable
+};
+
+static const struct regmap_config wm8983_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.reg_defaults = wm8983_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8983_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.readable_reg = wm8983_readable,
 };
 
 #if defined(CONFIG_SPI_MASTER)
@@ -1089,7 +1096,13 @@ static int __devinit wm8983_spi_probe(struct spi_device *spi)
 	if (!wm8983)
 		return -ENOMEM;
 
-	wm8983->control_type = SND_SOC_SPI;
+	wm8983->regmap = devm_regmap_init_spi(spi, &wm8983_regmap);
+	if (IS_ERR(wm8983->regmap)) {
+		ret = PTR_ERR(wm8983->regmap);
+		dev_err(&spi->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
 	spi_set_drvdata(spi, wm8983);
 
 	ret = snd_soc_register_codec(&spi->dev,
@@ -1124,7 +1137,13 @@ static __devinit int wm8983_i2c_probe(struct i2c_client *i2c,
 	if (!wm8983)
 		return -ENOMEM;
 
-	wm8983->control_type = SND_SOC_I2C;
+	wm8983->regmap = devm_regmap_init_i2c(i2c, &wm8983_regmap);
+	if (IS_ERR(wm8983->regmap)) {
+		ret = PTR_ERR(wm8983->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8983);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.10.4
