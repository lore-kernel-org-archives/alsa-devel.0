From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 1/6] ASoC: Convert ALC5632 codec to use regmap
	API
Date: Wed, 16 Nov 2011 12:06:58 +0200
Message-ID: <1321438023-29660-2-git-send-email-leon@leon.nu>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E149A24436
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:07:17 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 10so213890eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 02:07:17 -0800 (PST)
In-Reply-To: <1321438023-29660-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |  219 ++++++++++++++++++++++++++++++++------------
 sound/soc/codecs/alc5632.h |    2 +
 2 files changed, 162 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 8df1e22..42feae0 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -22,6 +22,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -34,45 +35,129 @@
 /*
  * ALC5632 register cache
  */
-static const u16 alc5632_reg_defaults[] = {
-	0x59B4, 0x0000, 0x8080, 0x0000, /* 0 */
-	0x8080, 0x0000, 0x8080, 0x0000, /* 4 */
-	0xC800, 0x0000, 0xE808, 0x0000, /* 8 */
-	0x1010, 0x0000, 0x0808, 0x0000, /* 12 */
-	0xEE0F, 0x0000, 0xCBCB, 0x0000, /* 16 */
-	0x7F7F, 0x0000, 0x0000, 0x0000, /* 20 */
-	0xE010, 0x0000, 0x0000, 0x0000, /* 24 */
-	0x8008, 0x0000, 0x0000, 0x0000, /* 28 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 32 */
-	0x00C0, 0x0000, 0xEF00, 0x0000, /* 36 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 40 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 44 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 48 */
-	0x8000, 0x0000, 0x0000, 0x0000, /* 52 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 56 */
-	0x0000, 0x0000, 0x8000, 0x0000, /* 60 */
-	0x0C0A, 0x0000, 0x0000, 0x0000, /* 64 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 68 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 72 */
-	0xBE3E, 0x0000, 0xBE3E, 0x0000, /* 76 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 80 */
-	0x803A, 0x0000, 0x0000, 0x0000, /* 84 */
-	0x0000, 0x0000, 0x0009, 0x0000, /* 88 */
-	0x0000, 0x0000, 0x3000, 0x0000, /* 92 */
-	0x3075, 0x0000, 0x1010, 0x0000, /* 96 */
-	0x3110, 0x0000, 0x0000, 0x0000, /* 100 */
-	0x0553, 0x0000, 0x0000, 0x0000, /* 104 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 108 */
+static struct reg_default  alc5632_reg_defaults[] = {
+	{   0, 0x59B4 },
+	{   1, 0x0000 },
+	{   2, 0x8080 },
+	{   3, 0x0000 },
+	{   4, 0x8080 },
+	{   5, 0x0000 },
+	{   6, 0x8080 },
+	{   7, 0x0000 },
+	{   8, 0xC800 },
+	{   9, 0x0000 },
+	{  10, 0xE808 },
+	{  11, 0x0000 },
+	{  12, 0x1010 },
+	{  13, 0x0000 },
+	{  14, 0x0808 },
+	{  15, 0x0000 },
+	{  16, 0xEE0F },
+	{  17, 0x0000 },
+	{  18, 0xCBCB },
+	{  19, 0x0000 },
+	{  20, 0x7F7F },
+	{  21, 0x0000 },
+	{  22, 0x0000 },
+	{  23, 0x0000 },
+	{  24, 0xE010 },
+	{  25, 0x0000 },
+	{  26, 0x0000 },
+	{  27, 0x0000 },
+	{  28, 0x8008 },
+	{  29, 0x0000 },
+	{  30, 0x0000 },
+	{  31, 0x0000 },
+	{  32, 0x0000 },
+	{  33, 0x0000 },
+	{  34, 0x0000 },
+	{  35, 0x0000 },
+	{  36, 0x00C0 },
+	{  37, 0x0000 },
+	{  38, 0xEF00 },
+	{  39, 0x0000 },
+	{  40, 0x0000 },
+	{  41, 0x0000 },
+	{  42, 0x0000 },
+	{  43, 0x0000 },
+	{  44, 0x0000 },
+	{  45, 0x0000 },
+	{  46, 0x0000 },
+	{  47, 0x0000 },
+	{  48, 0x0000 },
+	{  49, 0x0000 },
+	{  50, 0x0000 },
+	{  51, 0x0000 },
+	{  52, 0x8000 },
+	{  53, 0x0000 },
+	{  54, 0x0000 },
+	{  55, 0x0000 },
+	{  56, 0x0000 },
+	{  57, 0x0000 },
+	{  58, 0x0000 },
+	{  59, 0x0000 },
+	{  60, 0x0000 },
+	{  61, 0x0000 },
+	{  62, 0x8000 },
+	{  63, 0x0000 },
+	{  64, 0x0C0A },
+	{  65, 0x0000 },
+	{  66, 0x0000 },
+	{  67, 0x0000 },
+	{  68, 0x0000 },
+	{  69, 0x0000 },
+	{  70, 0x0000 },
+	{  71, 0x0000 },
+	{  72, 0x0000 },
+	{  73, 0x0000 },
+	{  74, 0x0000 },
+	{  75, 0x0000 },
+	{  76, 0xBE3E },
+	{  77, 0x0000 },
+	{  78, 0xBE3E },
+	{  79, 0x0000 },
+	{  80, 0x0000 },
+	{  81, 0x0000 },
+	{  82, 0x0000 },
+	{  83, 0x0000 },
+	{  84, 0x803A },
+	{  85, 0x0000 },
+	{  86, 0x0000 },
+	{  87, 0x0000 },
+	{  88, 0x0000 },
+	{  89, 0x0000 },
+	{  90, 0x0009 },
+	{  91, 0x0000 },
+	{  92, 0x0000 },
+	{  93, 0x0000 },
+	{  94, 0x3000 },
+	{  95, 0x0000 },
+	{  96, 0x3075 },
+	{  97, 0x0000 },
+	{  98, 0x1010 },
+	{  99, 0x0000 },
+	{ 100, 0x3110 },
+	{ 101, 0x0000 },
+	{ 102, 0x0000 },
+	{ 103, 0x0000 },
+	{ 104, 0x0553 },
+	{ 105, 0x0000 },
+	{ 106, 0x0000 },
+	{ 107, 0x0000 },
+	{ 108, 0x0000 },
+	{ 109, 0x0000 },
+	{ 110, 0x0000 },
+	{ 111, 0x0000 },
 };
 
 /* codec private data */
 struct alc5632_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	u8 id;
 	unsigned int sysclk;
 };
 
-static int alc5632_volatile_register(struct snd_soc_codec *codec,
+static bool alc5632_volatile_register(struct device *dev,
 							unsigned int reg)
 {
 	switch (reg) {
@@ -82,19 +167,18 @@ static int alc5632_volatile_register(struct snd_soc_codec *codec,
 	case ALC5632_OVER_CURR_STATUS:
 	case ALC5632_HID_CTRL_DATA:
 	case ALC5632_EQ_CTRL:
-		return 1;
+		return true;
 
 	default:
 		break;
 	}
 
-	return 0;
+	return false;
 }
 
-static inline int alc5632_reset(struct snd_soc_codec *codec)
+static inline int alc5632_reset(struct regmap *map)
 {
-	snd_soc_write(codec, ALC5632_RESET, 0);
-	return snd_soc_read(codec, ALC5632_RESET);
+	return regmap_write(map, ALC5632_RESET, 0x59B4);
 }
 
 static int amp_mixer_event(struct snd_soc_dapm_widget *w,
@@ -947,17 +1031,10 @@ static int alc5632_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
 
 static int alc5632_resume(struct snd_soc_codec *codec)
 {
-	int ret;
-
-	/* mark cache as needed to sync */
-	codec->cache_sync = 1;
-
-	ret = snd_soc_cache_sync(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
-		return ret;
-	}
+	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
 
+	regcache_sync(alc5632->regmap);
+
 	alc5632_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
@@ -967,14 +1044,14 @@ static int alc5632_probe(struct snd_soc_codec *codec)
 	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, alc5632->control_type);
-	if (ret < 0) {
+	codec->control_data = alc5632->regmap;
+
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
+	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
-	alc5632_reset(codec);
-
 	/* power on device  */
 	alc5632_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -1003,11 +1080,6 @@ static struct snd_soc_codec_driver soc_codec_device_alc5632 = {
 	.suspend = alc5632_suspend,
 	.resume = alc5632_resume,
 	.set_bias_level = alc5632_set_bias_level,
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
-	.reg_cache_default = alc5632_reg_defaults,
-	.reg_cache_size = ARRAY_SIZE(alc5632_reg_defaults),
-	.volatile_register = alc5632_volatile_register,
 	.controls = alc5632_snd_controls,
 	.num_controls = ARRAY_SIZE(alc5632_snd_controls),
 	.dapm_widgets = alc5632_dapm_widgets,
@@ -1016,13 +1088,24 @@ static struct snd_soc_codec_driver soc_codec_device_alc5632 = {
 	.num_dapm_routes = ARRAY_SIZE(alc5632_dapm_routes),
 };
 
+static struct regmap_config alc5632_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = ALC5632_MAX_REGISTER,
+	.reg_defaults = alc5632_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(alc5632_reg_defaults),
+	.volatile_reg = alc5632_volatile_register,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 /*
  * alc5632 2 wire address is determined by A1 pin
  * state during powerup.
  *    low  = 0x1a
  *    high = 0x1b
  */
-static int alc5632_i2c_probe(struct i2c_client *client,
+static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct alc5632_priv *alc5632;
@@ -1069,20 +1152,38 @@ static int alc5632_i2c_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, alc5632);
-	alc5632->control_type = SND_SOC_I2C;
 
+	alc5632->regmap = regmap_init_i2c(client, &alc5632_regmap);
+	if (IS_ERR(alc5632->regmap)) {
+		ret = PTR_ERR(alc5632->regmap);
+		dev_err(&client->dev, "regmap_init() failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = alc5632_reset(alc5632->regmap);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to issue reset\n");
+		regmap_exit(alc5632->regmap);
+		return ret;
+	}
+
 	ret =  snd_soc_register_codec(&client->dev,
 		&soc_codec_device_alc5632, &alc5632_dai, 1);
-	if (ret != 0)
+
+	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register codec: %d\n", ret);
+		regmap_exit(alc5632->regmap);
+		return ret;
+	}
 
 	return ret;
 }
 
 static int alc5632_i2c_remove(struct i2c_client *client)
 {
+	struct alc5632_priv *alc5632 = i2c_get_clientdata(client);
 	snd_soc_unregister_codec(&client->dev);
-
+	regmap_exit(alc5632->regmap);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/alc5632.h b/sound/soc/codecs/alc5632.h
index ff4c0fd..357651e 100644
--- a/sound/soc/codecs/alc5632.h
+++ b/sound/soc/codecs/alc5632.h
@@ -246,4 +246,6 @@
 #define ALC5632_VENDOR_ID1			0x7C
 #define ALC5632_VENDOR_ID2			0x7E
 
+#define ALC5632_MAX_REGISTER        0x7E
+
 #endif
-- 
1.7.3.4
