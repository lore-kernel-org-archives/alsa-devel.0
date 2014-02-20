From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: alc5623: Convert to direct regmap
	API usage
Date: Thu, 20 Feb 2014 09:11:09 +0900
Message-ID: <1392855070-27700-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BB16826531C
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 01:11:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Convert to directly use the regmap API, allowing us to eliminate the last
user of the ASoC level I/O implementations (there are still open coded
I/O implementations in drivers), avoiding duplicating code in regmap.

We no longer cache the entire CODEC register map on probe since the more
advanced cache infrastructure in regmap is able to fill the cache on
demand.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/alc5623.c | 87 ++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index d303628..36cf7e8 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -38,26 +39,13 @@ MODULE_PARM_DESC(caps_charge, "ALC5623 cap charge time (msecs)");
 
 /* codec private data */
 struct alc5623_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	u8 id;
 	unsigned int sysclk;
-	u16 reg_cache[ALC5623_VENDOR_ID2+2];
 	unsigned int add_ctrl;
 	unsigned int jack_det_ctrl;
 };
 
-static void alc5623_fill_cache(struct snd_soc_codec *codec)
-{
-	int i, step = codec->driver->reg_cache_step;
-	u16 *cache = codec->reg_cache;
-
-	/* not really efficient ... */
-	codec->cache_bypass = 1;
-	for (i = 0 ; i < codec->driver->reg_cache_size ; i += step)
-		cache[i] = snd_soc_read(codec, i);
-	codec->cache_bypass = 0;
-}
-
 static inline int alc5623_reset(struct snd_soc_codec *codec)
 {
 	return snd_soc_write(codec, ALC5623_RESET, 0);
@@ -869,18 +857,28 @@ static struct snd_soc_dai_driver alc5623_dai = {
 
 static int alc5623_suspend(struct snd_soc_codec *codec)
 {
+	struct alc5623_priv *alc5623 = snd_soc_codec_get_drvdata(codec);
+
 	alc5623_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_cache_only(alc5623->regmap, true);
+
 	return 0;
 }
 
 static int alc5623_resume(struct snd_soc_codec *codec)
 {
-	int i, step = codec->driver->reg_cache_step;
-	u16 *cache = codec->reg_cache;
+	struct alc5623_priv *alc5623 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	/* Sync reg_cache with the hardware */
-	for (i = 2 ; i < codec->driver->reg_cache_size ; i += step)
-		snd_soc_write(codec, i, cache[i]);
+	regcache_cache_only(alc5623->regmap, false);
+	ret = regcache_sync(alc5623->regmap);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to sync register cache: %d\n",
+			ret);
+		regcache_cache_only(alc5623->regmap, true);
+		return ret;
+	}
 
 	alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -900,14 +898,14 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, alc5623->control_type);
+	codec->control_data = alc5623->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
 	alc5623_reset(codec);
-	alc5623_fill_cache(codec);
 
 	/* power on device */
 	alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -980,9 +978,15 @@ static struct snd_soc_codec_driver soc_codec_device_alc5623 = {
 	.suspend = alc5623_suspend,
 	.resume = alc5623_resume,
 	.set_bias_level = alc5623_set_bias_level,
-	.reg_cache_size = ALC5623_VENDOR_ID2+2,
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
+};
+
+static const struct regmap_config alc5623_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.reg_stride = 2,
+
+	.max_register = ALC5623_VENDOR_ID2,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 /*
@@ -996,19 +1000,32 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 {
 	struct alc5623_platform_data *pdata;
 	struct alc5623_priv *alc5623;
-	int ret, vid1, vid2;
+	unsigned int vid1, vid2;
+	int ret;
 
-	vid1 = i2c_smbus_read_word_data(client, ALC5623_VENDOR_ID1);
-	if (vid1 < 0) {
-		dev_err(&client->dev, "failed to read I2C\n");
-		return -EIO;
+	alc5623 = devm_kzalloc(&client->dev, sizeof(struct alc5623_priv),
+			       GFP_KERNEL);
+	if (alc5623 == NULL)
+		return -ENOMEM;
+
+	alc5623->regmap = devm_regmap_init_i2c(client, &alc5623_regmap);
+	if (IS_ERR(alc5623->regmap)) {
+		ret = PTR_ERR(alc5623->regmap);
+		dev_err(&client->dev, "Failed to initialise I/O: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(alc5623->regmap, ALC5623_VENDOR_ID1, &vid1);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to read vendor ID1: %d\n", ret);
+		return ret;
 	}
 	vid1 = ((vid1 & 0xff) << 8) | (vid1 >> 8);
 
-	vid2 = i2c_smbus_read_byte_data(client, ALC5623_VENDOR_ID2);
-	if (vid2 < 0) {
-		dev_err(&client->dev, "failed to read I2C\n");
-		return -EIO;
+	ret = regmap_read(alc5623->regmap, ALC5623_VENDOR_ID2, &vid2);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to read vendor ID2: %d\n", ret);
+		return ret;
 	}
 
 	if ((vid1 != 0x10ec) || (vid2 != id->driver_data)) {
@@ -1021,11 +1038,6 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 
 	dev_dbg(&client->dev, "Found codec id : alc56%02x\n", vid2);
 
-	alc5623 = devm_kzalloc(&client->dev, sizeof(struct alc5623_priv),
-			       GFP_KERNEL);
-	if (alc5623 == NULL)
-		return -ENOMEM;
-
 	pdata = client->dev.platform_data;
 	if (pdata) {
 		alc5623->add_ctrl = pdata->add_ctrl;
@@ -1048,7 +1060,6 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, alc5623);
-	alc5623->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&client->dev,
 		&soc_codec_device_alc5623, &alc5623_dai, 1);
-- 
1.9.0.rc3
