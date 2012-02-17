From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: ak4535: Convert to direct regmap API
	usage
Date: Thu, 16 Feb 2012 23:04:15 -0800
Message-ID: <1329462255-11374-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329462255-11374-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6835F103AD6
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 08:04:22 +0100 (CET)
In-Reply-To: <1329462255-11374-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I suspect the timer register may also be volatile.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4535.c |   66 +++++++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/ak4535.h |    2 -
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index e13303a..838ae8b 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -29,20 +30,41 @@
 
 /* codec private data */
 struct ak4535_priv {
+	struct regmap *regmap;
 	unsigned int sysclk;
-	enum snd_soc_control_type control_type;
 };
 
 /*
  * ak4535 register cache
  */
-static const u8 ak4535_reg[AK4535_CACHEREGNUM] = {
-	0x00, 0x80, 0x00, 0x03,
-	0x02, 0x00, 0x11, 0x01,
-	0x00, 0x40, 0x36, 0x10,
-	0x00, 0x00, 0x57, 0x00,
+static const struct reg_default ak4535_reg_defaults[] = {
+	{ 0, 0x00 },
+	{ 1, 0x80 },
+	{ 2, 0x00 },
+	{ 3, 0x03 },
+	{ 4, 0x02 },
+	{ 5, 0x00 },
+	{ 6, 0x11 },
+	{ 7, 0x01 },
+	{ 8, 0x00 },
+	{ 9, 0x40 },
+	{ 10, 0x36 },
+	{ 11, 0x10 },
+	{ 12, 0x00 },
+	{ 13, 0x00 },
+	{ 14, 0x57 },
 };
 
+static bool ak4535_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AK4535_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const char *ak4535_mono_gain[] = {"+6dB", "-17dB"};
 static const char *ak4535_mono_out[] = {"(L + R)/2", "Hi-Z"};
 static const char *ak4535_hp_out[] = {"Stereo", "Mono"};
@@ -370,7 +392,8 @@ static int ak4535_probe(struct snd_soc_codec *codec)
 	struct ak4535_priv *ak4535 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, ak4535->control_type);
+	codec->control_data = ak4535->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -390,15 +413,24 @@ static int ak4535_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static const struct regmap_config ak4535_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK4535_STATUS,
+	.volatile_reg = ak4535_volatile,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = ak4535_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ak4535_reg_defaults),
+};
+
 static struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
 	.probe =	ak4535_probe,
 	.remove =	ak4535_remove,
 	.suspend =	ak4535_suspend,
 	.resume =	ak4535_resume,
 	.set_bias_level = ak4535_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(ak4535_reg),
-	.reg_word_size = sizeof(u8),
-	.reg_cache_default = ak4535_reg,
 	.dapm_widgets = ak4535_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(ak4535_dapm_widgets),
 	.dapm_routes = ak4535_audio_map,
@@ -416,17 +448,29 @@ static __devinit int ak4535_i2c_probe(struct i2c_client *i2c,
 	if (ak4535 == NULL)
 		return -ENOMEM;
 
+	ak4535->regmap = regmap_init_i2c(i2c, &ak4535_regmap);
+	if (IS_ERR(ak4535->regmap)) {
+		ret = PTR_ERR(ak4535->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, ak4535);
-	ak4535->control_type = SND_SOC_I2C;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_ak4535, &ak4535_dai, 1);
+	if (ret != 0)
+		regmap_exit(ak4535->regmap);
+
 	return ret;
 }
 
 static __devexit int ak4535_i2c_remove(struct i2c_client *client)
 {
+	struct ak4535_priv *ak4535 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
+	regmap_exit(ak4535->regmap);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/ak4535.h b/sound/soc/codecs/ak4535.h
index 0431e5f..402de1d 100644
--- a/sound/soc/codecs/ak4535.h
+++ b/sound/soc/codecs/ak4535.h
@@ -34,6 +34,4 @@
 #define AK4535_VOL		0xe
 #define AK4535_STATUS		0xf
 
-#define AK4535_CACHEREGNUM 	0x10
-
 #endif
-- 
1.7.9.rc1
