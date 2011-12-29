From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: Convert wm8978 to direct regmap API
	usage
Date: Thu, 29 Dec 2011 11:49:14 +0000
Message-ID: <1325159355-31686-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC2BD103A01
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 12:49:26 +0100 (CET)
In-Reply-To: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Helps push the register cache code down out of ASoC and improves resume
times by using the more efficient regmap cache sync code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |  116 ++++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/wm8978.h |    2 +
 2 files changed, 96 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 0ab339c..5ff8734d 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -29,27 +30,74 @@
 
 #include "wm8978.h"
 
-/* wm8978 register cache. Note that register 0 is not included in the cache. */
-static const u16 wm8978_reg[WM8978_CACHEREGNUM] = {
-	0x0000, 0x0000, 0x0000, 0x0000,	/* 0x00...0x03 */
-	0x0050, 0x0000, 0x0140, 0x0000,	/* 0x04...0x07 */
-	0x0000, 0x0000, 0x0000, 0x00ff,	/* 0x08...0x0b */
-	0x00ff, 0x0000, 0x0100, 0x00ff,	/* 0x0c...0x0f */
-	0x00ff, 0x0000, 0x012c, 0x002c,	/* 0x10...0x13 */
-	0x002c, 0x002c, 0x002c, 0x0000,	/* 0x14...0x17 */
-	0x0032, 0x0000, 0x0000, 0x0000,	/* 0x18...0x1b */
-	0x0000, 0x0000, 0x0000, 0x0000,	/* 0x1c...0x1f */
-	0x0038, 0x000b, 0x0032, 0x0000,	/* 0x20...0x23 */
-	0x0008, 0x000c, 0x0093, 0x00e9,	/* 0x24...0x27 */
-	0x0000, 0x0000, 0x0000, 0x0000,	/* 0x28...0x2b */
-	0x0033, 0x0010, 0x0010, 0x0100,	/* 0x2c...0x2f */
-	0x0100, 0x0002, 0x0001, 0x0001,	/* 0x30...0x33 */
-	0x0039, 0x0039, 0x0039, 0x0039,	/* 0x34...0x37 */
-	0x0001,	0x0001,			/* 0x38...0x3b */
+static const struct reg_default wm8978_reg_defaults[] = {
+	{ 1, 0x0000 },
+	{ 2, 0x0000 },
+	{ 3, 0x0000 },
+	{ 4, 0x0050 },
+	{ 5, 0x0000 },
+	{ 6, 0x0140 },
+	{ 7, 0x0000 },
+	{ 8, 0x0000 },
+	{ 9, 0x0000 },
+	{ 10, 0x0000 },
+	{ 11, 0x00ff },
+	{ 12, 0x00ff },
+	{ 13, 0x0000 },
+	{ 14, 0x0100 },
+	{ 15, 0x00ff },
+	{ 16, 0x00ff },
+	{ 17, 0x0000 },
+	{ 18, 0x012c },
+	{ 19, 0x002c },
+	{ 20, 0x002c },
+	{ 21, 0x002c },
+	{ 22, 0x002c },
+	{ 23, 0x0000 },
+	{ 24, 0x0032 },
+	{ 25, 0x0000 },
+	{ 26, 0x0000 },
+	{ 27, 0x0000 },
+	{ 28, 0x0000 },
+	{ 29, 0x0000 },
+	{ 30, 0x0000 },
+	{ 31, 0x0000 },
+	{ 32, 0x0038 },
+	{ 33, 0x000b },
+	{ 34, 0x0032 },
+	{ 35, 0x0000 },
+	{ 36, 0x0008 },
+	{ 37, 0x000c },
+	{ 38, 0x0093 },
+	{ 39, 0x00e9 },
+	{ 40, 0x0000 },
+	{ 41, 0x0000 },
+	{ 42, 0x0000 },
+	{ 43, 0x0000 },
+	{ 44, 0x0033 },
+	{ 45, 0x0010 },
+	{ 46, 0x0010 },
+	{ 47, 0x0100 },
+	{ 48, 0x0100 },
+	{ 49, 0x0002 },
+	{ 50, 0x0001 },
+	{ 51, 0x0001 },
+	{ 52, 0x0039 },
+	{ 53, 0x0039 },
+	{ 54, 0x0039 },
+	{ 55, 0x0039 },
+	{ 56, 0x0001 },
+	{ 57, 0x0001 },
 };
 
+static bool wm8978_volatile(struct device *dev, unsigned int reg)
+{
+	return reg == WM8978_RESET;
+}
+
 /* codec private data */
 struct wm8978_priv {
+	struct regmap *regmap;
 	unsigned int f_pllout;
 	unsigned int f_mclk;
 	unsigned int f_256fs;
@@ -881,10 +929,14 @@ static struct snd_soc_dai_driver wm8978_dai = {
 
 static int wm8978_suspend(struct snd_soc_codec *codec)
 {
+	struct wm8978_priv *wm8978 = snd_soc_codec_get_drvdata(codec);
+
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	/* Also switch PLL off */
 	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, 0);
 
+	regcache_mark_dirty(wm8978->regmap);
+
 	return 0;
 }
 
@@ -893,7 +945,7 @@ static int wm8978_resume(struct snd_soc_codec *codec)
 	struct wm8978_priv *wm8978 = snd_soc_codec_get_drvdata(codec);
 
 	/* Sync reg_cache with the hardware */
-	snd_soc_cache_sync(codec);
+	regcache_sync(wm8978->regmap);
 
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -933,7 +985,8 @@ static int wm8978_probe(struct snd_soc_codec *codec)
 	 * default hardware setting
 	 */
 	wm8978->sysclk = WM8978_PLL;
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
+	codec->control_data = wm8978->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -972,9 +1025,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
 	.suspend =	wm8978_suspend,
 	.resume =	wm8978_resume,
 	.set_bias_level = wm8978_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8978_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8978_reg,
 
 	.controls = wm8978_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8978_snd_controls),
@@ -984,6 +1034,18 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8978_dapm_routes),
 };
 
+static const struct regmap_config wm8978_regmap_config = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.max_register = WM8978_MAX_REGISTER,
+	.volatile_reg = wm8978_volatile,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wm8978_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8978_reg_defaults),
+};
+
 static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
@@ -995,6 +1057,13 @@ static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 	if (wm8978 == NULL)
 		return -ENOMEM;
 
+	wm8978->regmap = regmap_init_i2c(i2c, &wm8978_regmap_config);
+	if (IS_ERR(wm8978->regmap)) {
+		ret = PTR_ERR(wm8978->regmap);
+		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8978);
 
 	ret = snd_soc_register_codec(&i2c->dev,
@@ -1005,7 +1074,10 @@ static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 
 static __devexit int wm8978_i2c_remove(struct i2c_client *client)
 {
+	struct wm8978_priv *wm8978 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
+	regmap_exit(wm8978->regmap);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8978.h b/sound/soc/codecs/wm8978.h
index c75525b..6ae4349 100644
--- a/sound/soc/codecs/wm8978.h
+++ b/sound/soc/codecs/wm8978.h
@@ -67,6 +67,8 @@
 #define WM8978_OUT3_MIXER_CONTROL		0x38
 #define WM8978_OUT4_MIXER_CONTROL		0x39
 
+#define WM8978_MAX_REGISTER			0x39
+
 #define WM8978_CACHEREGNUM			58
 
 /* Clock divider Id's */
-- 
1.7.7.3
