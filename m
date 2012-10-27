From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: jz4740-codec: Use regmap
Date: Sat, 27 Oct 2012 17:15:08 +0200
Message-ID: <1351350908-4262-3-git-send-email-lars@metafoo.de>
References: <1351350908-4262-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-149.synserver.de (smtp-out-149.synserver.de
 [212.40.185.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 02CCA26520C
 for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2012 17:14:49 +0200 (CEST)
In-Reply-To: <1351350908-4262-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use regmap-mmio instead of open-coding caching and register accessors.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/Kconfig  |    1 +
 sound/soc/codecs/jz4740.c |   86 +++++++++++++++++++++-----------------------
 2 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ac59fe1..2643593 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -237,6 +237,7 @@ config SND_SOC_CX20442
 	tristate
 
 config SND_SOC_JZ4740_CODEC
+	select REGMAP_MMIO
 	tristate
 
 config SND_SOC_L3
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 1661202..9ad1da3 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
 
 #include <linux/delay.h>
 
@@ -27,7 +28,7 @@
 #include <sound/tlv.h>
 
 #define JZ4740_REG_CODEC_1 0x0
-#define JZ4740_REG_CODEC_2 0x1
+#define JZ4740_REG_CODEC_2 0x4
 
 #define JZ4740_CODEC_1_LINE_ENABLE BIT(29)
 #define JZ4740_CODEC_1_MIC_ENABLE BIT(28)
@@ -68,33 +69,15 @@
 #define JZ4740_CODEC_2_MIC_BOOST_GAIN_OFFSET	 4
 #define JZ4740_CODEC_2_HEADPHONE_VOLUME_OFFSET	 0
 
-static const uint32_t jz4740_codec_regs[] = {
-	0x021b2302, 0x00170803,
+static const struct reg_default jz4740_codec_reg_defaults[] = {
+	{ JZ4740_REG_CODEC_1, 0x021b2302 },
+	{ JZ4740_REG_CODEC_2, 0x00170803 },
 };
 
 struct jz4740_codec {
-	void __iomem *base;
+	struct regmap *regmap;
 };
 
-static unsigned int jz4740_codec_read(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(codec);
-	return readl(jz4740_codec->base + (reg << 2));
-}
-
-static int jz4740_codec_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int val)
-{
-	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(codec);
-	u32 *cache = codec->reg_cache;
-
-	cache[reg] = val;
-	writel(val, jz4740_codec->base + (reg << 2));
-
-	return 0;
-}
-
 static const unsigned int jz4740_mic_tlv[] = {
 	TLV_DB_RANGE_HEAD(2),
 	0, 2, TLV_DB_SCALE_ITEM(0, 600, 0),
@@ -175,8 +158,8 @@ static const struct snd_soc_dapm_route jz4740_codec_dapm_routes[] = {
 static int jz4740_codec_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
+	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(dai->codec);
 	uint32_t val;
-	struct snd_soc_codec *codec = dai->codec;
 
 	switch (params_rate(params)) {
 	case 8000:
@@ -212,7 +195,7 @@ static int jz4740_codec_hw_params(struct snd_pcm_substream *substream,
 
 	val <<= JZ4740_CODEC_2_SAMPLE_RATE_OFFSET;
 
-	snd_soc_update_bits(codec, JZ4740_REG_CODEC_2,
+	regmap_update_bits(jz4740_codec->regmap, JZ4740_REG_CODEC_2,
 				JZ4740_CODEC_2_SAMPLE_RATE_MASK, val);
 
 	return 0;
@@ -242,25 +225,23 @@ static struct snd_soc_dai_driver jz4740_codec_dai = {
 	.symmetric_rates = 1,
 };
 
-static void jz4740_codec_wakeup(struct snd_soc_codec *codec)
+static void jz4740_codec_wakeup(struct regmap *regmap)
 {
-	int i;
-	uint32_t *cache = codec->reg_cache;
-
-	snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
+	regmap_update_bits(regmap, JZ4740_REG_CODEC_1,
 		JZ4740_CODEC_1_RESET, JZ4740_CODEC_1_RESET);
 	udelay(2);
 
-	snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
+	regmap_update_bits(regmap, JZ4740_REG_CODEC_1,
 		JZ4740_CODEC_1_SUSPEND | JZ4740_CODEC_1_RESET, 0);
 
-	for (i = 0; i < ARRAY_SIZE(jz4740_codec_regs); ++i)
-		jz4740_codec_write(codec, i, cache[i]);
+	regcache_sync(regmap);
 }
 
 static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(codec);
+	struct regmap *regmap = jz4740_codec->regmap;
 	unsigned int mask;
 	unsigned int value;
 
@@ -273,12 +254,12 @@ static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 				JZ4740_CODEC_1_HEADPHONE_POWERDOWN_M;
 		value = 0;
 
-		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1, mask, value);
+		regmap_update_bits(regmap, JZ4740_REG_CODEC_1, mask, value);
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* The only way to clear the suspend flag is to reset the codec */
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
-			jz4740_codec_wakeup(codec);
+			jz4740_codec_wakeup(regmap);
 
 		mask = JZ4740_CODEC_1_VREF_DISABLE |
 			JZ4740_CODEC_1_VREF_AMP_DISABLE |
@@ -287,13 +268,14 @@ static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 			JZ4740_CODEC_1_VREF_AMP_DISABLE |
 			JZ4740_CODEC_1_HEADPHONE_POWERDOWN_M;
 
-		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1, mask, value);
+		regmap_update_bits(regmap, JZ4740_REG_CODEC_1, mask, value);
 		break;
 	case SND_SOC_BIAS_OFF:
 		mask = JZ4740_CODEC_1_SUSPEND;
 		value = JZ4740_CODEC_1_SUSPEND;
 
-		snd_soc_update_bits(codec, JZ4740_REG_CODEC_1, mask, value);
+		regmap_update_bits(regmap, JZ4740_REG_CODEC_1, mask, value);
+		regcache_mark_dirty(regmap);
 		break;
 	default:
 		break;
@@ -306,7 +288,9 @@ static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 
 static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
 {
-	snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
+	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(codec);
+
+	regmap_update_bits(jz4740_codec->regmap, JZ4740_REG_CODEC_1,
 			JZ4740_CODEC_1_SW2_ENABLE, JZ4740_CODEC_1_SW2_ENABLE);
 
 	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -343,12 +327,7 @@ static struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
 	.remove = jz4740_codec_dev_remove,
 	.suspend = jz4740_codec_suspend,
 	.resume = jz4740_codec_resume,
-	.read = jz4740_codec_read,
-	.write = jz4740_codec_write,
 	.set_bias_level = jz4740_codec_set_bias_level,
-	.reg_cache_default	= jz4740_codec_regs,
-	.reg_word_size = sizeof(u32),
-	.reg_cache_size	= 2,
 
 	.controls = jz4740_codec_controls,
 	.num_controls = ARRAY_SIZE(jz4740_codec_controls),
@@ -358,11 +337,23 @@ static struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
 	.num_dapm_routes = ARRAY_SIZE(jz4740_codec_dapm_routes),
 };
 
+static const struct regmap_config jz4740_codec_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = JZ4740_REG_CODEC_2,
+
+	.reg_defaults = jz4740_codec_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(jz4740_codec_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static int __devinit jz4740_codec_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_codec *jz4740_codec;
 	struct resource *mem;
+	void __iomem *base;
 
 	jz4740_codec = devm_kzalloc(&pdev->dev, sizeof(*jz4740_codec),
 				    GFP_KERNEL);
@@ -370,10 +361,15 @@ static int __devinit jz4740_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	jz4740_codec->base = devm_request_and_ioremap(&pdev->dev, mem);
-	if (!jz4740_codec->base)
+	base = devm_request_and_ioremap(&pdev->dev, mem);
+	if (!base)
 		return -EBUSY;
 
+	jz4740_codec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					    &jz4740_codec_regmap_config);
+	if (IS_ERR(jz4740_codec->regmap))
+		return PTR_ERR(jz4740_codec->regmap);
+
 	platform_set_drvdata(pdev, jz4740_codec);
 
 	ret = snd_soc_register_codec(&pdev->dev,
-- 
1.7.2.5
