From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8737: Convert to direct regmap API
	usage
Date: Wed, 12 Sep 2012 12:59:10 +0800
Message-ID: <1347425950-17097-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347425950-17097-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED3FD261662
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 06:59:22 +0200 (CEST)
In-Reply-To: <1347425950-17097-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8737.c |   75 ++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 3bf5bc7..5c9634f 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
@@ -40,29 +41,39 @@ static const char *wm8737_supply_names[WM8737_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8737_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8737_NUM_SUPPLIES];
 	unsigned int mclk;
 };
 
-static const u16 wm8737_reg[WM8737_REGISTER_COUNT] = {
-	0x00C3,     /* R0  - Left PGA volume */
-	0x00C3,     /* R1  - Right PGA volume */
-	0x0007,     /* R2  - AUDIO path L */
-	0x0007,     /* R3  - AUDIO path R */
-	0x0000,     /* R4  - 3D Enhance */
-	0x0000,     /* R5  - ADC Control */
-	0x0000,     /* R6  - Power Management */
-	0x000A,     /* R7  - Audio Format */
-	0x0000,     /* R8  - Clocking */
-	0x000F,     /* R9  - MIC Preamp Control */
-	0x0003,     /* R10 - Misc Bias Control */
-	0x0000,     /* R11 - Noise Gate */
-	0x007C,     /* R12 - ALC1 */
-	0x0000,     /* R13 - ALC2 */
-	0x0032,     /* R14 - ALC3 */
+static const struct reg_default wm8737_reg_defaults[] = {
+	{  0, 0x00C3 },     /* R0  - Left PGA volume */
+	{  1, 0x00C3 },     /* R1  - Right PGA volume */
+	{  2, 0x0007 },     /* R2  - AUDIO path L */
+	{  3, 0x0007 },     /* R3  - AUDIO path R */
+	{  4, 0x0000 },     /* R4  - 3D Enhance */
+	{  5, 0x0000 },     /* R5  - ADC Control */
+	{  6, 0x0000 },     /* R6  - Power Management */
+	{  7, 0x000A },     /* R7  - Audio Format */
+	{  8, 0x0000 },     /* R8  - Clocking */
+	{  9, 0x000F },     /* R9  - MIC Preamp Control */
+	{ 10, 0x0003 },     /* R10 - Misc Bias Control */
+	{ 11, 0x0000 },     /* R11 - Noise Gate */
+	{ 12, 0x007C },     /* R12 - ALC1 */
+	{ 13, 0x0000 },     /* R13 - ALC2 */
+	{ 14, 0x0032 },     /* R14 - ALC3 */
 };
 
+static bool wm8737_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8737_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int wm8737_reset(struct snd_soc_codec *codec)
 {
 	return snd_soc_write(codec, WM8737_RESET, 0);
@@ -479,7 +490,7 @@ static int wm8737_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			}
 
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8737->regmap);
 
 			/* Fast VMID ramp at 2*2.5k */
 			snd_soc_update_bits(codec, WM8737_MISC_BIAS_CONTROL,
@@ -559,7 +570,7 @@ static int wm8737_probe(struct snd_soc_codec *codec)
 	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8737->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -612,10 +623,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8737 = {
 	.suspend	= wm8737_suspend,
 	.resume		= wm8737_resume,
 	.set_bias_level = wm8737_set_bias_level,
-
-	.reg_cache_size = WM8737_REGISTER_COUNT - 1, /* Skip reset */
-	.reg_word_size	= sizeof(u16),
-	.reg_cache_default = wm8737_reg,
 };
 
 static const struct of_device_id wm8737_of_match[] = {
@@ -625,6 +632,18 @@ static const struct of_device_id wm8737_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, wm8737_of_match);
 
+static const struct regmap_config wm8737_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8737_MAX_REGISTER,
+
+	.reg_defaults = wm8737_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8737_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = wm8737_volatile,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8737_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
@@ -647,8 +666,11 @@ static __devinit int wm8737_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	wm8737->regmap = devm_regmap_init_i2c(i2c, &wm8737_regmap);
+	if (IS_ERR(wm8737->regmap))
+		return PTR_ERR(wm8737->regmap);
+
 	i2c_set_clientdata(i2c, wm8737);
-	wm8737->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 				      &soc_codec_dev_wm8737, &wm8737_dai, 1);
@@ -703,7 +725,10 @@ static int __devinit wm8737_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	wm8737->control_type = SND_SOC_SPI;
+	wm8737->regmap = devm_regmap_init_spi(spi, &wm8737_regmap);
+	if (IS_ERR(wm8737->regmap))
+		return PTR_ERR(wm8737->regmap);
+
 	spi_set_drvdata(spi, wm8737);
 
 	ret = snd_soc_register_codec(&spi->dev,
-- 
1.7.10.4
