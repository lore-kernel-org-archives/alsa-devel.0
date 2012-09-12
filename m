From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8580: Convert to direct regmap API
	usage
Date: Wed, 12 Sep 2012 12:05:31 +0800
Message-ID: <1347422732-5162-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 257812615F0
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 06:05:40 +0200 (CEST)
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
 sound/soc/codecs/wm8580.c |  104 +++++++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index cc198df..2a07c70 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -1,7 +1,7 @@
 /*
  * wm8580.c  --  WM8580 ALSA Soc Audio driver
  *
- * Copyright 2008-11 Wolfson Microelectronics PLC.
+ * Copyright 2008-12 Wolfson Microelectronics PLC.
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
@@ -157,21 +158,60 @@
  * We can't read the WM8580 register space when we
  * are using 2 wire for device control, so we cache them instead.
  */
-static const u16 wm8580_reg[] = {
-	0x0121, 0x017e, 0x007d, 0x0014, /*R3*/
-	0x0121, 0x017e, 0x007d, 0x0194, /*R7*/
-	0x0010, 0x0002, 0x0002, 0x00c2, /*R11*/
-	0x0182, 0x0082, 0x000a, 0x0024, /*R15*/
-	0x0009, 0x0000, 0x00ff, 0x0000, /*R19*/
-	0x00ff, 0x00ff, 0x00ff, 0x00ff, /*R23*/
-	0x00ff, 0x00ff, 0x00ff, 0x00ff, /*R27*/
-	0x01f0, 0x0040, 0x0000, 0x0000, /*R31(0x1F)*/
-	0x0000, 0x0000, 0x0031, 0x000b, /*R35*/
-	0x0039, 0x0000, 0x0010, 0x0032, /*R39*/
-	0x0054, 0x0076, 0x0098, 0x0000, /*R43(0x2B)*/
-	0x0000, 0x0000, 0x0000, 0x0000, /*R47*/
-	0x0000, 0x0000, 0x005e, 0x003e, /*R51(0x33)*/
-	0x0000, 0x0000 /*R53*/
+static const struct reg_default wm8580_reg_defaults[] = {
+	{  0, 0x0121 },
+	{  1, 0x017e },
+	{  2, 0x007d },
+	{  3, 0x0014 },
+	{  4, 0x0121 },
+	{  5, 0x017e },
+	{  6, 0x007d },
+	{  7, 0x0194 },
+	{  8, 0x0010 },
+	{  9, 0x0002 },
+	{ 10, 0x0002 },
+	{ 11, 0x00c2 },
+	{ 12, 0x0182 },
+	{ 13, 0x0082 },
+	{ 14, 0x000a },
+	{ 15, 0x0024 },
+	{ 16, 0x0009 },
+	{ 17, 0x0000 },
+	{ 18, 0x00ff },
+	{ 19, 0x0000 },
+	{ 20, 0x00ff },
+	{ 21, 0x00ff },
+	{ 22, 0x00ff },
+	{ 23, 0x00ff },
+	{ 24, 0x00ff },
+	{ 25, 0x00ff },
+	{ 26, 0x00ff },
+	{ 27, 0x00ff },
+	{ 28, 0x01f0 },
+	{ 29, 0x0040 },
+	{ 30, 0x0000 },
+	{ 31, 0x0000 },
+	{ 32, 0x0000 },
+	{ 33, 0x0000 },
+	{ 34, 0x0031 },
+	{ 35, 0x000b },
+	{ 36, 0x0039 },
+	{ 37, 0x0000 },
+	{ 38, 0x0010 },
+	{ 39, 0x0032 },
+	{ 40, 0x0054 },
+	{ 41, 0x0076 },
+	{ 42, 0x0098 },
+	{ 43, 0x0000 },
+	{ 44, 0x0000 },
+	{ 45, 0x0000 },
+	{ 46, 0x0000 },
+	{ 47, 0x0000 },
+	{ 48, 0x0000 },
+	{ 49, 0x0000 },
+	{ 50, 0x005e },
+	{ 51, 0x003e },
+	{ 52, 0x0000 },
 };
 
 struct pll_state {
@@ -188,7 +228,7 @@ static const char *wm8580_supply_names[WM8580_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8580_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8580_NUM_SUPPLIES];
 	struct pll_state a;
 	struct pll_state b;
@@ -203,14 +243,16 @@ static int wm8580_out_vu(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	u16 *reg_cache = codec->reg_cache;
+	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	int ret;
 
-	/* Clear the register cache so we write without VU set */
-	reg_cache[reg] = 0;
-	reg_cache[reg2] = 0;
+	/* Clear the register cache VU so we write without VU set */
+	regcache_cache_only(wm8580->regmap, true);
+	regmap_update_bits(wm8580->regmap, reg, 0x100, 0x000);
+	regmap_update_bits(wm8580->regmap, reg2, 0x100, 0x000);
+	regcache_cache_only(wm8580->regmap, false);
 
 	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 	if (ret < 0)
@@ -817,7 +859,7 @@ static int wm8580_probe(struct snd_soc_codec *codec)
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0,i;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8580->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -875,9 +917,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
 	.probe =	wm8580_probe,
 	.remove =	wm8580_remove,
 	.set_bias_level = wm8580_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8580_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8580_reg,
 
 	.controls = wm8580_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8580_snd_controls),
@@ -892,6 +931,16 @@ static const struct of_device_id wm8580_of_match[] = {
 	{ },
 };
 
+static const struct regmap_config wm8580_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8580_MAX_REGISTER,
+
+	.reg_defaults = wm8580_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8580_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int wm8580_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
@@ -904,8 +953,11 @@ static int wm8580_i2c_probe(struct i2c_client *i2c,
 	if (wm8580 == NULL)
 		return -ENOMEM;
 
+	wm8580->regmap = devm_regmap_init_i2c(i2c, &wm8580_regmap);
+	if (IS_ERR(wm8580->regmap))
+		return PTR_ERR(wm8580->regmap);
+
 	i2c_set_clientdata(i2c, wm8580);
-	wm8580->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8580, wm8580_dai, ARRAY_SIZE(wm8580_dai));
-- 
1.7.10.4
