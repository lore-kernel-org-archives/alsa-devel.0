From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: wm8770: Convert to direct regmap API
	usage
Date: Wed, 10 Oct 2012 20:43:36 +0900
Message-ID: <1349869419-10357-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34EAC2616DA
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 09:16:55 +0200 (CEST)
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
 sound/soc/codecs/wm8770.c |  100 +++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index c7c0034..21ec563 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -17,6 +17,7 @@
 #include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -35,19 +36,52 @@ static const char *wm8770_supply_names[WM8770_NUM_SUPPLIES] = {
 	"DVDD"
 };
 
-static const u16 wm8770_reg_defs[WM8770_CACHEREGNUM] = {
-	0x7f, 0x7f, 0x7f, 0x7f,
-	0x7f, 0x7f, 0x7f, 0x7f,
-	0x7f, 0xff, 0xff, 0xff,
-	0xff, 0xff, 0xff, 0xff,
-	0xff, 0xff, 0, 0x90, 0,
-	0, 0x22, 0x22, 0x3e,
-	0xc, 0xc, 0x100, 0x189,
-	0x189, 0x8770
+static const struct reg_default wm8770_reg_defaults[] = {
+	{  0, 0x7f },
+	{  1, 0x7f },
+	{  2, 0x7f },
+	{  3, 0x7f },
+	{  4, 0x7f },
+	{  5, 0x7f },
+	{  6, 0x7f },
+	{  7, 0x7f },
+	{  8, 0x7f },
+	{  9, 0xff },
+	{ 10, 0xff },
+	{ 11, 0xff },
+	{ 12, 0xff },
+	{ 13, 0xff },
+	{ 14, 0xff },
+	{ 15, 0xff },
+	{ 16, 0xff },
+	{ 17, 0xff },
+	{ 18, 0    },
+	{ 19, 0x90 },
+	{ 20, 0    },
+	{ 21, 0    },
+	{ 22, 0x22 },
+	{ 23, 0x22 },
+	{ 24, 0x3e },
+	{ 25, 0xc  },
+	{ 26, 0xc  },
+	{ 27, 0x100 },
+	{ 28, 0x189 },
+	{ 29, 0x189 },
+	{ 30, 0x8770 },
 };
 
+static bool wm8770_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8770_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 struct wm8770_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8770_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8770_NUM_SUPPLIES];
 	struct snd_soc_codec *codec;
@@ -71,7 +105,7 @@ static int wm8770_regulator_event_##n(struct notifier_block *nb, \
 	struct wm8770_priv *wm8770 = container_of(nb, struct wm8770_priv, \
 				     disable_nb[n]); \
 	if (event & REGULATOR_EVENT_DISABLE) { \
-		wm8770->codec->cache_sync = 1; \
+		regcache_mark_dirty(wm8770->regmap);	\
 	} \
 	return 0; \
 }
@@ -466,24 +500,6 @@ static int wm8770_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static void wm8770_sync_cache(struct snd_soc_codec *codec)
-{
-	int i;
-	u16 *cache;
-
-	if (!codec->cache_sync)
-		return;
-
-	codec->cache_only = 0;
-	cache = codec->reg_cache;
-	for (i = 0; i < codec->driver->reg_cache_size; i++) {
-		if (i == WM8770_RESET || cache[i] == wm8770_reg_defs[i])
-			continue;
-		snd_soc_write(codec, i, cache[i]);
-	}
-	codec->cache_sync = 0;
-}
-
 static int wm8770_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -507,7 +523,9 @@ static int wm8770_set_bias_level(struct snd_soc_codec *codec,
 					ret);
 				return ret;
 			}
-			wm8770_sync_cache(codec);
+
+			regcache_sync(wm8770->regmap);
+
 			/* global powerup */
 			snd_soc_write(codec, WM8770_PWDNCTRL, 0);
 		}
@@ -580,7 +598,7 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 	wm8770 = snd_soc_codec_get_drvdata(codec);
 	wm8770->codec = codec;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8770->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -678,9 +696,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
 	.resume = wm8770_resume,
 	.set_bias_level = wm8770_set_bias_level,
 	.idle_bias_off = true,
-	.reg_cache_size = ARRAY_SIZE(wm8770_reg_defs),
-	.reg_word_size = sizeof (u16),
-	.reg_cache_default = wm8770_reg_defs
 };
 
 static const struct of_device_id wm8770_of_match[] = {
@@ -689,6 +704,18 @@ static const struct of_device_id wm8770_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8770_of_match);
 
+static const struct regmap_config wm8770_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8770_RESET,
+
+	.reg_defaults = wm8770_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8770_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = wm8770_volatile_reg,
+};
+
 static int __devinit wm8770_spi_probe(struct spi_device *spi)
 {
 	struct wm8770_priv *wm8770;
@@ -699,7 +726,10 @@ static int __devinit wm8770_spi_probe(struct spi_device *spi)
 	if (!wm8770)
 		return -ENOMEM;
 
-	wm8770->control_type = SND_SOC_SPI;
+	wm8770->regmap = devm_regmap_init_spi(spi, &wm8770_regmap);
+	if (IS_ERR(wm8770->regmap))
+		return PTR_ERR(wm8770->regmap);
+
 	spi_set_drvdata(spi, wm8770);
 
 	ret = snd_soc_register_codec(&spi->dev,
-- 
1.7.10.4
