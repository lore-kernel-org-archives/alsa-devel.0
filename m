From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 6/6] ASoC: tlv320aic3x: Convert to direct
	regmap API usage
Date: Tue, 24 Sep 2013 00:12:48 +0100
Message-ID: <1379977968-25982-6-git-send-email-broonie@kernel.org>
References: <1379977968-25982-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F41126163C
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 01:13:05 +0200 (CEST)
In-Reply-To: <1379977968-25982-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This is slightly more complex than a standard regmap conversion due to
the moderately detailed cache control and the open coding of a register
patch for the class D speaker on the TLV320AIC3007.

Although the device supports paging this is not currently implemented as
the additional pages are only used during the application of the patch
for the TLV320AIC3007.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic3x.c | 151 ++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 78 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 83e7d85..892c108 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -72,9 +72,9 @@ struct aic3x_disable_nb {
 /* codec private data */
 struct aic3x_priv {
 	struct snd_soc_codec *codec;
+	struct regmap *regmap;
 	struct regulator_bulk_data supplies[AIC3X_NUM_SUPPLIES];
 	struct aic3x_disable_nb disable_nb[AIC3X_NUM_SUPPLIES];
-	enum snd_soc_control_type control_type;
 	struct aic3x_setup_data *setup;
 	unsigned int sysclk;
 	struct list_head list;
@@ -90,35 +90,45 @@ struct aic3x_priv {
 	enum aic3x_micbias_voltage micbias_vg;
 };
 
-static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
-	0x00, 0x00, 0x00, 0x10,	/* 0 */
-	0x04, 0x00, 0x00, 0x00,	/* 4 */
-	0x00, 0x00, 0x00, 0x01,	/* 8 */
-	0x00, 0x00, 0x00, 0x80,	/* 12 */
-	0x80, 0xff, 0xff, 0x78,	/* 16 */
-	0x78, 0x78, 0x78, 0x78,	/* 20 */
-	0x78, 0x00, 0x00, 0xfe,	/* 24 */
-	0x00, 0x00, 0xfe, 0x00,	/* 28 */
-	0x18, 0x18, 0x00, 0x00,	/* 32 */
-	0x00, 0x00, 0x00, 0x00,	/* 36 */
-	0x00, 0x00, 0x00, 0x80,	/* 40 */
-	0x80, 0x00, 0x00, 0x00,	/* 44 */
-	0x00, 0x00, 0x00, 0x04,	/* 48 */
-	0x00, 0x00, 0x00, 0x00,	/* 52 */
-	0x00, 0x00, 0x04, 0x00,	/* 56 */
-	0x00, 0x00, 0x00, 0x00,	/* 60 */
-	0x00, 0x04, 0x00, 0x00,	/* 64 */
-	0x00, 0x00, 0x00, 0x00,	/* 68 */
-	0x04, 0x00, 0x00, 0x00,	/* 72 */
-	0x00, 0x00, 0x00, 0x00,	/* 76 */
-	0x00, 0x00, 0x00, 0x00,	/* 80 */
-	0x00, 0x00, 0x00, 0x00,	/* 84 */
-	0x00, 0x00, 0x00, 0x00,	/* 88 */
-	0x00, 0x00, 0x00, 0x00,	/* 92 */
-	0x00, 0x00, 0x00, 0x00,	/* 96 */
-	0x00, 0x00, 0x02, 0x00,	/* 100 */
-	0x00, 0x00, 0x00, 0x00,	/* 104 */
-	0x00, 0x00,            	/* 108 */
+static const struct reg_default aic3x_reg[] = {
+	{   0, 0x00 }, {   1, 0x00 }, {   2, 0x00 }, {   3, 0x10 },
+	{   4, 0x04 }, {   5, 0x00 }, {   6, 0x00 }, {   7, 0x00 },
+	{   8, 0x00 }, {   9, 0x00 }, {  10, 0x00 }, {  11, 0x01 },
+	{  12, 0x00 }, {  13, 0x00 }, {  14, 0x00 }, {  15, 0x80 },
+	{  16, 0x80 }, {  17, 0xff }, {  18, 0xff }, {  19, 0x78 },
+	{  20, 0x78 }, {  21, 0x78 }, {  22, 0x78 }, {  23, 0x78 },
+	{  24, 0x78 }, {  25, 0x00 }, {  26, 0x00 }, {  27, 0xfe },
+	{  28, 0x00 }, {  29, 0x00 }, {  30, 0xfe }, {  31, 0x00 },
+	{  32, 0x18 }, {  33, 0x18 }, {  34, 0x00 }, {  35, 0x00 },
+	{  36, 0x00 }, {  37, 0x00 }, {  38, 0x00 }, {  39, 0x00 },
+	{  40, 0x00 }, {  41, 0x00 }, {  42, 0x00 }, {  43, 0x80 },
+	{  44, 0x80 }, {  45, 0x00 }, {  46, 0x00 }, {  47, 0x00 },
+	{  48, 0x00 }, {  49, 0x00 }, {  50, 0x00 }, {  51, 0x04 },
+	{  52, 0x00 }, {  53, 0x00 }, {  54, 0x00 }, {  55, 0x00 },
+	{  56, 0x00 }, {  57, 0x00 }, {  58, 0x04 }, {  59, 0x00 },
+	{  60, 0x00 }, {  61, 0x00 }, {  62, 0x00 }, {  63, 0x00 },
+	{  64, 0x00 }, {  65, 0x04 }, {  66, 0x00 }, {  67, 0x00 },
+	{  68, 0x00 }, {  69, 0x00 }, {  70, 0x00 }, {  71, 0x00 },
+	{  72, 0x04 }, {  73, 0x00 }, {  74, 0x00 }, {  75, 0x00 },
+	{  76, 0x00 }, {  77, 0x00 }, {  78, 0x00 }, {  79, 0x00 },
+	{  80, 0x00 }, {  81, 0x00 }, {  82, 0x00 }, {  83, 0x00 },
+	{  84, 0x00 }, {  85, 0x00 }, {  86, 0x00 }, {  87, 0x00 },
+	{  88, 0x00 }, {  89, 0x00 }, {  90, 0x00 }, {  91, 0x00 },
+	{  92, 0x00 }, {  93, 0x00 }, {  94, 0x00 }, {  95, 0x00 },
+	{  96, 0x00 }, {  97, 0x00 }, {  98, 0x00 }, {  99, 0x00 },
+	{ 100, 0x00 }, { 101, 0x00 }, { 102, 0x02 }, { 103, 0x00 },
+	{ 104, 0x00 }, { 105, 0x00 }, { 106, 0x00 }, { 107, 0x00 },
+	{ 108, 0x00 }, { 109, 0x00 },
+};
+
+static const struct regmap_config aic3x_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = DAC_ICC_ADJ,
+	.reg_defaults = aic3x_reg,
+	.num_reg_defaults = ARRAY_SIZE(aic3x_reg),
+	.cache_type = REGCACHE_RBTREE,
 };
 
 #define SOC_DAPM_SINGLE_AIC3X(xname, reg, shift, mask, invert) \
@@ -1066,30 +1076,6 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int aic3x_init_3007(struct snd_soc_codec *codec)
-{
-	unsigned int tmp1, tmp2;
-
-	/*
-	 * There is no need to cache writes to undocumented page 0xD but
-	 * respective page 0 register cache entries must be preserved
-	 */
-	tmp1 = snd_soc_read(codec, 0xD);
-	tmp2 = snd_soc_read(codec, 0x8);
-	/* Class-D speaker driver init; datasheet p. 46 */
-	snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x0D);
-	snd_soc_write(codec, 0xD, 0x0D);
-	snd_soc_write(codec, 0x8, 0x5C);
-	snd_soc_write(codec, 0x8, 0x5D);
-	snd_soc_write(codec, 0x8, 0x5C);
-	snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x00);
-
-	snd_soc_write(codec, 0xD, tmp1);
-	snd_soc_write(codec, 0x8, tmp2);
-
-	return 0;
-}
-
 static int aic3x_regulator_event(struct notifier_block *nb,
 				 unsigned long event, void *data)
 {
@@ -1104,7 +1090,7 @@ static int aic3x_regulator_event(struct notifier_block *nb,
 		 */
 		if (gpio_is_valid(aic3x->gpio_reset))
 			gpio_set_value(aic3x->gpio_reset, 0);
-		aic3x->codec->cache_sync = 1;
+		regcache_mark_dirty(aic3x->regmap);
 	}
 
 	return 0;
@@ -1113,8 +1099,7 @@ static int aic3x_regulator_event(struct notifier_block *nb,
 static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
-	u8 *cache = codec->reg_cache;
+	int ret;
 
 	if (power) {
 		ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
@@ -1122,12 +1107,6 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 		if (ret)
 			goto out;
 		aic3x->power = 1;
-		/*
-		 * Reset release and cache sync is necessary only if some
-		 * supply was off or if there were cached writes
-		 */
-		if (!codec->cache_sync)
-			goto out;
 
 		if (gpio_is_valid(aic3x->gpio_reset)) {
 			udelay(1);
@@ -1135,12 +1114,8 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 		}
 
 		/* Sync reg_cache with the hardware */
-		codec->cache_only = 0;
-		for (i = AIC3X_SAMPLE_RATE_SEL_REG; i < ARRAY_SIZE(aic3x_reg); i++)
-			snd_soc_write(codec, i, cache[i]);
-		if (aic3x->model == AIC3X_MODEL_3007)
-			aic3x_init_3007(codec);
-		codec->cache_sync = 0;
+		regcache_cache_only(aic3x->regmap, false);
+		regcache_sync(aic3x->regmap);
 	} else {
 		/*
 		 * Do soft reset to this codec instance in order to clear
@@ -1148,10 +1123,10 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 		 * remain on
 		 */
 		snd_soc_write(codec, AIC3X_RESET, SOFT_RESET);
-		codec->cache_sync = 1;
+		regcache_mark_dirty(aic3x->regmap);
 		aic3x->power = 0;
 		/* HW writes are needless when bias is off */
-		codec->cache_only = 1;
+		regcache_cache_only(aic3x->regmap, true);
 		ret = regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies),
 					     aic3x->supplies);
 	}
@@ -1306,7 +1281,6 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	snd_soc_write(codec, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
 
 	if (aic3x->model == AIC3X_MODEL_3007) {
-		aic3x_init_3007(codec);
 		snd_soc_write(codec, CLASSD_CTRL, 0);
 	}
 
@@ -1334,7 +1308,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 	INIT_LIST_HEAD(&aic3x->list);
 	aic3x->codec = codec;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, aic3x->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -1353,7 +1327,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	codec->cache_only = 1;
+	regcache_mark_dirty(aic3x->regmap);
 	aic3x_init(codec);
 
 	if (aic3x->setup) {
@@ -1414,9 +1388,6 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
 	.set_bias_level = aic3x_set_bias_level,
 	.idle_bias_off = true,
-	.reg_cache_size = ARRAY_SIZE(aic3x_reg),
-	.reg_word_size = sizeof(u8),
-	.reg_cache_default = aic3x_reg,
 	.probe = aic3x_probe,
 	.remove = aic3x_remove,
 	.suspend = aic3x_suspend,
@@ -1443,6 +1414,16 @@ static const struct i2c_device_id aic3x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
 
+static const struct reg_default aic3007_class_d[] = {
+	/* Class-D speaker driver init; datasheet p. 46 */
+	{ AIC3X_PAGE_SELECT, 0x0D },
+	{ 0xD, 0x0D },
+	{ 0x8, 0x5C },
+	{ 0x8, 0x5D },
+	{ 0x8, 0x5C },
+	{ AIC3X_PAGE_SELECT, 0x00 },
+};
+
 /*
  * If the i2c layer weren't so broken, we could pass this kind of data
  * around
@@ -1463,7 +1444,13 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	}
 
-	aic3x->control_type = SND_SOC_I2C;
+	aic3x->regmap = devm_regmap_init_i2c(i2c, &aic3x_regmap);
+	if (IS_ERR(aic3x->regmap)) {
+		ret = PTR_ERR(aic3x->regmap);
+		return ret;
+	}
+
+	regcache_cache_only(aic3x->regmap, true);
 
 	i2c_set_clientdata(i2c, aic3x);
 	if (pdata) {
@@ -1533,6 +1520,14 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		goto err_gpio;
 	}
 
+	if (aic3x->model == AIC3X_MODEL_3007) {
+		ret = regmap_register_patch(aic3x->regmap, aic3007_class_d,
+					    ARRAY_SIZE(aic3007_class_d));
+		if (ret != 0)
+			dev_err(&i2c->dev, "Failed to init class D: %d\n",
+				ret);
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic3x, &aic3x_dai, 1);
 	return ret;
-- 
1.8.4.rc3
