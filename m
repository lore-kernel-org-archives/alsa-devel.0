From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: wm8523: Convert to direct regmap API
	usage
Date: Mon, 10 Sep 2012 17:08:01 +0800
Message-ID: <1347268082-14993-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347268082-14993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 397BE26506D
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 11:27:54 +0200 (CEST)
In-Reply-To: <1347268082-14993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8523.c |   69 +++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index c4c64e2..d7d5fe6 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
@@ -39,33 +40,31 @@ static const char *wm8523_supply_names[WM8523_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8523_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8523_NUM_SUPPLIES];
 	unsigned int sysclk;
 	unsigned int rate_constraint_list[WM8523_NUM_RATES];
 	struct snd_pcm_hw_constraint_list rate_constraint;
 };
 
-static const u16 wm8523_reg[WM8523_REGISTER_COUNT] = {
-	0x8523,     /* R0 - DEVICE_ID */
-	0x0001,     /* R1 - REVISION */
-	0x0000,     /* R2 - PSCTRL1 */
-	0x1812,     /* R3 - AIF_CTRL1 */
-	0x0000,     /* R4 - AIF_CTRL2 */
-	0x0001,     /* R5 - DAC_CTRL3 */
-	0x0190,     /* R6 - DAC_GAINL */
-	0x0190,     /* R7 - DAC_GAINR */
-	0x0000,     /* R8 - ZERO_DETECT */
+static const struct reg_default wm8523_reg_defaults[] = {
+	{ 2, 0x0000 },     /* R2 - PSCTRL1 */
+	{ 3, 0x1812 },     /* R3 - AIF_CTRL1 */
+	{ 4, 0x0000 },     /* R4 - AIF_CTRL2 */
+	{ 5, 0x0001 },     /* R5 - DAC_CTRL3 */
+	{ 6, 0x0190 },     /* R6 - DAC_GAINL */
+	{ 7, 0x0190 },     /* R7 - DAC_GAINR */
+	{ 8, 0x0000 },     /* R8 - ZERO_DETECT */
 };
 
-static int wm8523_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm8523_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM8523_DEVICE_ID:
 	case WM8523_REVISION:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -301,8 +300,7 @@ static int wm8523_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
 	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
-	u16 *reg_cache = codec->reg_cache;
-	int ret, i;
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -325,16 +323,13 @@ static int wm8523_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			}
 
+			/* Sync back default/cached values */
+			regcache_sync(wm8523->regmap);
+
 			/* Initial power up */
 			snd_soc_update_bits(codec, WM8523_PSCTRL1,
 					    WM8523_SYS_ENA_MASK, 1);
 
-			/* Sync back default/cached values */
-			for (i = WM8523_AIF_CTRL1;
-			     i < WM8523_MAX_REGISTER; i++)
-				snd_soc_write(codec, i, reg_cache[i]);
-
-
 			msleep(100);
 		}
 
@@ -408,7 +403,7 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 	wm8523->rate_constraint.count =
 		ARRAY_SIZE(wm8523->rate_constraint_list);
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8523->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -426,7 +421,7 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 		dev_err(codec->dev, "Failed to read ID register\n");
 		goto err_enable;
 	}
-	if (ret != wm8523_reg[WM8523_DEVICE_ID]) {
+	if (ret != 0x8523) {
 		dev_err(codec->dev, "Device is not a WM8523, ID is %x\n", ret);
 		ret = -EINVAL;
 		goto err_enable;
@@ -467,8 +462,6 @@ err_get:
 
 static int wm8523_remove(struct snd_soc_codec *codec)
 {
-	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
-
 	wm8523_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
@@ -479,10 +472,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8523 = {
 	.suspend =	wm8523_suspend,
 	.resume =	wm8523_resume,
 	.set_bias_level = wm8523_set_bias_level,
-	.reg_cache_size = WM8523_REGISTER_COUNT,
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8523_reg,
-	.volatile_register = wm8523_volatile_register,
 
 	.controls = wm8523_controls,
 	.num_controls = ARRAY_SIZE(wm8523_controls),
@@ -497,6 +486,18 @@ static const struct of_device_id wm8523_of_match[] = {
 	{ },
 };
 
+static const struct regmap_config wm8523_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = WM8523_ZERO_DETECT,
+
+	.reg_defaults = wm8523_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8523_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = wm8523_volatile_register,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
@@ -509,6 +510,13 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 	if (wm8523 == NULL)
 		return -ENOMEM;
 
+	wm8523->regmap = devm_regmap_init_i2c(i2c, &wm8523_regmap);
+	if (IS_ERR(wm8523->regmap)) {
+		ret = PTR_ERR(wm8523->regmap);
+		dev_err(&i2c->dev, "Failed to create regmap: %d\n", ret);
+		return ret;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(wm8523->supplies); i++)
 		wm8523->supplies[i].supply = wm8523_supply_names[i];
 
@@ -520,7 +528,6 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 	}
 
 	i2c_set_clientdata(i2c, wm8523);
-	wm8523->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8523, &wm8523_dai, 1);
-- 
1.7.10.4
