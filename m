From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: uda134x: Convert to regmap
Date: Mon, 13 Jul 2015 12:26:47 +0200
Message-ID: <1436783208-1529-4-git-send-email-lars@metafoo.de>
References: <1436783208-1529-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-236.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 29E972605CD
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 12:26:58 +0200 (CEST)
In-Reply-To: <1436783208-1529-1-git-send-email-lars@metafoo.de>
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

Use regmap rather then the legacy ASoC IO for the uda134x driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/uda134x.c | 115 ++++++++++++++++++++++++---------------------
 sound/soc/codecs/uda134x.h |   2 -
 2 files changed, 62 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index d47da0e..d25a9f3 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -37,13 +37,27 @@ struct uda134x_priv {
 
 	struct snd_pcm_substream *master_substream;
 	struct snd_pcm_substream *slave_substream;
+
+	struct regmap *regmap;
+	struct uda134x_platform_data *pd;
 };
 
-static const char uda134x_reg[UDA134X_REGS_NUM] = {
-	/* Extended address registers */
-	0x04, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* Status, data regs */
-	0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00,
+static const struct reg_default uda134x_reg_defaults[] = {
+	{ UDA134X_EA000, 0x04 },
+	{ UDA134X_EA001, 0x04 },
+	{ UDA134X_EA010, 0x04 },
+	{ UDA134X_EA011, 0x00 },
+	{ UDA134X_EA100, 0x00 },
+	{ UDA134X_EA101, 0x00 },
+	{ UDA134X_EA110, 0x00 },
+	{ UDA134X_EA111, 0x00 },
+	{ UDA134X_STATUS0, 0x00 },
+	{ UDA134X_STATUS1, 0x03 },
+	{ UDA134X_DATA000, 0x00 },
+	{ UDA134X_DATA001, 0x00 },
+	{ UDA134X_DATA010, 0x00 },
+	{ UDA134X_DATA011, 0x00 },
+	{ UDA134X_DATA1, 0x00 },
 };
 
 /*
@@ -52,47 +66,36 @@ static const char uda134x_reg[UDA134X_REGS_NUM] = {
 static inline unsigned int uda134x_read_reg_cache(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
+	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
+	int ret;
 
-	if (reg >= UDA134X_REGS_NUM)
+	ret = regmap_read(uda134x->regmap, reg, &val);
+	if (ret)
 		return -1;
-	return cache[reg];
+
+	return val;
 }
 
-/*
- * Write the register cache
- */
-static inline void uda134x_write_reg_cache(struct snd_soc_codec *codec,
-	u8 reg, unsigned int value)
+static void uda134x_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int val)
 {
-	u8 *cache = codec->reg_cache;
+	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 
-	if (reg >= UDA134X_REGS_NUM)
-		return;
-	cache[reg] = value;
+	regmap_write(uda134x->regmap, reg, val);
 }
 
 /*
  * Write to the uda134x registers
  *
  */
-static int uda134x_write(struct snd_soc_codec *codec, unsigned int reg,
+static int uda134x_regmap_write(void *context, unsigned int reg,
 	unsigned int value)
 {
+	struct uda134x_platform_data *pd = context;
 	int ret;
 	u8 addr;
 	u8 data = value;
-	struct uda134x_platform_data *pd = codec->control_data;
-
-	pr_debug("%s reg: %02X, value:%02X\n", __func__, reg, value);
-
-	if (reg >= UDA134X_REGS_NUM) {
-		printk(KERN_ERR "%s unknown register: reg: %u",
-		       __func__, reg);
-		return -EINVAL;
-	}
-
-	uda134x_write_reg_cache(codec, reg, value);
 
 	switch (reg) {
 	case UDA134X_STATUS0:
@@ -325,10 +328,8 @@ static int uda134x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
-	struct uda134x_platform_data *pd = codec->control_data;
-	int i;
-	u8 *cache = codec->reg_cache;
-
+	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
+	struct uda134x_platform_data *pd = uda134x->pd;
 	pr_debug("%s bias level %d\n", __func__, level);
 
 	switch (level) {
@@ -338,17 +339,17 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 		/* power on */
 		if (pd->power) {
 			pd->power(1);
-			/* Sync reg_cache with the hardware */
-			for (i = 0; i < ARRAY_SIZE(uda134x_reg); i++)
-				codec->driver->write(codec, i, *cache++);
+			regcache_sync(uda134x->regmap);
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* power off */
-		if (pd->power)
+		if (pd->power) {
 			pd->power(0);
+			regcache_mark_dirty(uda134x->regmap);
+		}
 		break;
 	}
 	return 0;
@@ -479,21 +480,14 @@ static struct snd_soc_dai_driver uda134x_dai = {
 static int uda134x_soc_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct uda134x_platform_data *pd = codec->component.card->dev->platform_data;
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
+	struct uda134x_platform_data *pd = uda134x->pd;
 	const struct snd_soc_dapm_widget *widgets;
 	unsigned num_widgets;
-
 	int ret;
 
 	printk(KERN_INFO "UDA134X SoC Audio Codec\n");
 
-	if (!pd) {
-		printk(KERN_ERR "UDA134X SoC codec: "
-		       "missing L3 bitbang function\n");
-		return -ENODEV;
-	}
-
 	switch (pd->model) {
 	case UDA134X_UDA1340:
 	case UDA134X_UDA1341:
@@ -507,9 +501,6 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-
-	codec->control_data = pd;
-
 	if (pd->power)
 		pd->power(1);
 
@@ -560,11 +551,6 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 	.probe =        uda134x_soc_probe,
-	.reg_cache_size = sizeof(uda134x_reg),
-	.reg_word_size = sizeof(u8),
-	.reg_cache_default = uda134x_reg,
-	.reg_cache_step = 1,
-	.read = uda134x_read_reg_cache,
 	.set_bias_level = uda134x_set_bias_level,
 	.suspend_bias_off = true,
 
@@ -574,16 +560,39 @@ static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 	.num_dapm_routes = ARRAY_SIZE(uda134x_dapm_routes),
 };
 
+static const struct regmap_config uda134x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = UDA134X_DATA1,
+	.reg_defaults = uda134x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(uda134x_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.reg_write = uda134x_regmap_write,
+};
+
 static int uda134x_codec_probe(struct platform_device *pdev)
 {
+	struct uda134x_platform_data *pd = pdev->dev.platform_data;
 	struct uda134x_priv *uda134x;
 
+	if (!pd) {
+		dev_err(&pdev->dev, "Missing L3 bitbang function\n");
+		return -ENODEV;
+	}
+
 	uda134x = devm_kzalloc(&pdev->dev, sizeof(*uda134x), GFP_KERNEL);
 	if (!uda134x)
 		return -ENOMEM;
 
+	uda134x->pd = pd;
 	platform_set_drvdata(pdev, uda134x);
 
+	uda134x->regmap = devm_regmap_init(&pdev->dev, NULL, pd,
+		&uda134x_regmap_config);
+	if (IS_ERR(uda134x->regmap))
+		return PTR_ERR(uda134x->regmap);
+
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_uda134x, &uda134x_dai, 1);
 }
diff --git a/sound/soc/codecs/uda134x.h b/sound/soc/codecs/uda134x.h
index 9faae06..e41ab38 100644
--- a/sound/soc/codecs/uda134x.h
+++ b/sound/soc/codecs/uda134x.h
@@ -26,8 +26,6 @@
 #define UDA134X_DATA011 13
 #define UDA134X_DATA1   14
 
-#define UDA134X_REGS_NUM 15
-
 #define STATUS0_DAIFMT_MASK (~(7<<1))
 #define STATUS0_SYSCLK_MASK (~(3<<4))
 
-- 
2.1.4
