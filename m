From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ak4641: Convert to direct regmap API
	usage
Date: Fri, 22 Nov 2013 15:15:59 +0000
Message-ID: <1385133359-8934-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 19EA6265011
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 16:16:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

We're trying to remove the ASoC level I/O functions.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4641.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 49cc5f6d6dba..94cbe508dd37 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -30,6 +31,7 @@
 
 /* codec private data */
 struct ak4641_priv {
+	struct regmap *regmap;
 	unsigned int sysclk;
 	int deemph;
 	int playback_fs;
@@ -38,12 +40,12 @@ struct ak4641_priv {
 /*
  * ak4641 register cache
  */
-static const u8 ak4641_reg[AK4641_CACHEREGNUM] = {
-	0x00, 0x80, 0x00, 0x80,
-	0x02, 0x00, 0x11, 0x05,
-	0x00, 0x00, 0x36, 0x10,
-	0x00, 0x00, 0x57, 0x00,
-	0x88, 0x88, 0x08, 0x08
+static const struct reg_default ak4641_reg_defaults[] = {
+	{  0, 0x00 }, {  1, 0x80 }, {  2, 0x00 }, {  3, 0x80 },
+	{  4, 0x02 }, {  5, 0x00 }, {  6, 0x11 }, {  7, 0x05 },
+	{  8, 0x00 }, {  9, 0x00 }, { 10, 0x36 }, { 11, 0x10 },
+	{ 12, 0x00 }, { 13, 0x00 }, { 14, 0x57 }, { 15, 0x00 },
+	{ 16, 0x88 }, { 17, 0x88 }, { 18, 0x08 }, { 19, 0x08 }
 };
 
 static const int deemph_settings[] = {44100, 0, 48000, 32000};
@@ -396,6 +398,7 @@ static int ak4641_mute(struct snd_soc_dai *dai, int mute)
 static int ak4641_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
 	struct ak4641_platform_data *pdata = codec->dev->platform_data;
 	int ret;
 
@@ -417,7 +420,7 @@ static int ak4641_set_bias_level(struct snd_soc_codec *codec,
 				gpio_set_value(pdata->gpio_npdn, 1);
 			mdelay(1);
 
-			ret = snd_soc_cache_sync(codec);
+			ret = regcache_sync(ak4641->regmap);
 			if (ret) {
 				dev_err(codec->dev,
 					"Failed to sync cache: %d\n", ret);
@@ -433,7 +436,7 @@ static int ak4641_set_bias_level(struct snd_soc_codec *codec,
 			gpio_set_value(pdata->gpio_npdn, 0);
 		if (pdata && gpio_is_valid(pdata->gpio_power))
 			gpio_set_value(pdata->gpio_power, 0);
-		codec->cache_sync = 1;
+		regcache_mark_dirty(ak4641->regmap);
 		break;
 	}
 	codec->dapm.bias_level = level;
@@ -518,7 +521,7 @@ static int ak4641_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -550,12 +553,17 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4641 = {
 	.dapm_routes		= ak4641_audio_map,
 	.num_dapm_routes	= ARRAY_SIZE(ak4641_audio_map),
 	.set_bias_level		= ak4641_set_bias_level,
-	.reg_cache_size		= ARRAY_SIZE(ak4641_reg),
-	.reg_word_size		= sizeof(u8),
-	.reg_cache_default	= ak4641_reg,
-	.reg_cache_step		= 1,
 };
 
+static const struct regmap_config ak4641_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK4641_BTIF,
+	.reg_defaults = ak4641_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ak4641_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
 
 static int ak4641_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
@@ -569,6 +577,10 @@ static int ak4641_i2c_probe(struct i2c_client *i2c,
 	if (!ak4641)
 		return -ENOMEM;
 
+	ak4641->regmap = devm_regmap_init_i2c(i2c, &ak4641_regmap);
+	if (IS_ERR(ak4641->regmap))
+		return PTR_ERR(ak4641->regmap);
+
 	if (pdata) {
 		if (gpio_is_valid(pdata->gpio_power)) {
 			ret = gpio_request_one(pdata->gpio_power,
-- 
1.8.4.4
