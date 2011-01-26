From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 4/4] ASoC: Convert bunch of codecs to use
	soc-core interconnect registration
Date: Wed, 26 Jan 2011 13:58:17 +0200
Message-ID: <1296043097-11720-4-git-send-email-jhnikula@gmail.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BE451039F6
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:57:15 +0100 (CET)
Received: by mail-fx0-f51.google.com with SMTP id 5so871208fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 03:57:15 -0800 (PST)
In-Reply-To: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

These codec drivers have only single interconnect map so these can be
switched to use soc-core based interconnect registration.

This simplifies those codecs that check the return value of
snd_soc_dapm_add_routes and adds a failure path to those that don't.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Only twl4030 tested and rest by compilation only.
---
 sound/soc/codecs/88pm860x-codec.c |    3 ++-
 sound/soc/codecs/ad1836.c         |    3 ++-
 sound/soc/codecs/ad193x.c         |    4 +++-
 sound/soc/codecs/ak4535.c         |    3 ++-
 sound/soc/codecs/ak4671.c         |    3 ++-
 sound/soc/codecs/cs42l51.c        |    4 ++--
 sound/soc/codecs/cx20442.c        |    4 ++--
 sound/soc/codecs/jz4740.c         |    5 ++---
 sound/soc/codecs/max98088.c       |    4 ++--
 sound/soc/codecs/sn95031.c        |    6 ++----
 sound/soc/codecs/ssm2602.c        |    3 ++-
 sound/soc/codecs/tlv320aic23.c    |    4 ++--
 sound/soc/codecs/tlv320dac33.c    |    4 ++--
 sound/soc/codecs/twl4030.c        |    3 ++-
 sound/soc/codecs/twl6040.c        |    3 ++-
 sound/soc/codecs/uda1380.c        |    3 ++-
 sound/soc/codecs/wm8350.c         |   15 ++++-----------
 sound/soc/codecs/wm8400.c         |    3 ++-
 sound/soc/codecs/wm8510.c         |    3 ++-
 sound/soc/codecs/wm8523.c         |    3 ++-
 sound/soc/codecs/wm8580.c         |    3 ++-
 sound/soc/codecs/wm8711.c         |    3 ++-
 sound/soc/codecs/wm8728.c         |    3 ++-
 sound/soc/codecs/wm8731.c         |    3 ++-
 sound/soc/codecs/wm8737.c         |    3 ++-
 sound/soc/codecs/wm8741.c         |    3 ++-
 sound/soc/codecs/wm8750.c         |    3 ++-
 sound/soc/codecs/wm8753.c         |    3 ++-
 sound/soc/codecs/wm8770.c         |    6 +++---
 sound/soc/codecs/wm8776.c         |    3 ++-
 sound/soc/codecs/wm8900.c         |    3 ++-
 sound/soc/codecs/wm8903.c         |    3 ++-
 sound/soc/codecs/wm8940.c         |   15 ++++-----------
 sound/soc/codecs/wm8955.c         |    4 ++--
 sound/soc/codecs/wm8961.c         |    3 ++-
 sound/soc/codecs/wm8971.c         |    3 ++-
 sound/soc/codecs/wm8974.c         |    3 ++-
 sound/soc/codecs/wm8978.c         |    4 ++--
 sound/soc/codecs/wm8985.c         |    6 +++---
 sound/soc/codecs/wm8988.c         |    3 ++-
 sound/soc/codecs/wm8990.c         |    4 ++--
 sound/soc/codecs/wm8991.c         |    6 +++---
 sound/soc/codecs/wm8993.c         |    3 ++-
 sound/soc/codecs/wm8995.c         |    6 +++---
 sound/soc/codecs/wm9081.c         |    3 ++-
 sound/soc/codecs/wm9705.c         |    3 ++-
 sound/soc/codecs/wm9712.c         |    3 ++-
 sound/soc/codecs/wm9713.c         |    4 ++--
 48 files changed, 105 insertions(+), 90 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 06b6981..7d6321f 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1382,7 +1382,6 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(pm860x_snd_controls));
 	snd_soc_dapm_new_controls(dapm, pm860x_dapm_widgets,
 				  ARRAY_SIZE(pm860x_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	return 0;
 
 out:
@@ -1410,6 +1409,8 @@ static struct snd_soc_codec_driver soc_codec_dev_pm860x = {
 	.reg_cache_size	= REG_CACHE_SIZE,
 	.reg_word_size	= sizeof(u8),
 	.set_bias_level	= pm860x_set_bias_level,
+	.route		= audio_map,
+	.num_routes	= ARRAY_SIZE(audio_map),
 };
 
 static int __devinit pm860x_codec_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index ab63d52..add2364 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -253,7 +253,6 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(ad1836_snd_controls));
 	snd_soc_dapm_new_controls(dapm, ad1836_dapm_widgets,
 				  ARRAY_SIZE(ad1836_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return ret;
 }
@@ -275,6 +274,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
 	.resume =       ad1836_soc_resume,
 	.reg_cache_size = AD1836_NUM_REGS,
 	.reg_word_size = sizeof(u16),
+	.route		= audio_paths,
+	.num_routes	= ARRAY_SIZE(audio_paths),
 };
 
 static int __devinit ad1836_spi_probe(struct spi_device *spi)
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index da46479..b8d0ea9 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -385,7 +385,6 @@ static int ad193x_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(ad193x_snd_controls));
 	snd_soc_dapm_new_controls(dapm, ad193x_dapm_widgets,
 				  ARRAY_SIZE(ad193x_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return ret;
 }
@@ -395,6 +394,9 @@ static struct snd_soc_codec_driver soc_codec_dev_ad193x = {
 	.reg_cache_default = ad193x_reg,
 	.reg_cache_size = AD193X_NUM_REGS,
 	.reg_word_size = sizeof(u16),
+	.route = audio_paths,
+	.num_routes = ARRAY_SIZE(audio_paths),
+
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 8b38739..7b6219e 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -293,7 +293,6 @@ static int ak4535_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, ak4535_dapm_widgets,
 				  ARRAY_SIZE(ak4535_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -480,6 +479,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
 	.reg_cache_size = ARRAY_SIZE(ak4535_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = ak4535_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 2ec75ab..fee7bdc 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -439,7 +439,6 @@ static int ak4671_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, ak4671_dapm_widgets,
 				  ARRAY_SIZE(ak4671_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -670,6 +669,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
 	.reg_cache_size = AK4671_CACHEREGNUM,
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = ak4671_reg,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 static int __devinit ak4671_i2c_probe(struct i2c_client *client,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 8fb7070..cb1e3fc 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -551,8 +551,6 @@ static int cs42l51_probe(struct snd_soc_codec *codec)
 		ARRAY_SIZE(cs42l51_snd_controls));
 	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_widgets,
 		ARRAY_SIZE(cs42l51_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, cs42l51_routes,
-		ARRAY_SIZE(cs42l51_routes));
 
 	return 0;
 }
@@ -561,6 +559,8 @@ static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
 	.probe =	cs42l51_probe,
 	.reg_cache_size = CS42L51_NUMREGS,
 	.reg_word_size = sizeof(u8),
+	.route = cs42l51_routes,
+	.num_routes = ARRAY_SIZE(cs42l51_routes),
 };
 
 static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 03d1e86..6146717 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -92,8 +92,6 @@ static int cx20442_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, cx20442_dapm_widgets,
 				  ARRAY_SIZE(cx20442_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, cx20442_audio_map,
-				ARRAY_SIZE(cx20442_audio_map));
 
 	return 0;
 }
@@ -374,6 +372,8 @@ static struct snd_soc_codec_driver cx20442_codec_dev = {
 	.reg_word_size = sizeof(u8),
 	.read = cx20442_read_reg_cache,
 	.write = cx20442_write,
+	.route = cx20442_audio_map,
+	.num_routes = ARRAY_SIZE(cx20442_audio_map),
 };
 
 static int cx20442_platform_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index f7cd346..e6fb47e 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -305,9 +305,6 @@ static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
 	snd_soc_dapm_new_controls(dapm, jz4740_codec_dapm_widgets,
 		ARRAY_SIZE(jz4740_codec_dapm_widgets));
 
-	snd_soc_dapm_add_routes(dapm, jz4740_codec_dapm_routes,
-		ARRAY_SIZE(jz4740_codec_dapm_routes));
-
 	snd_soc_dapm_new_widgets(codec);
 
 	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -350,6 +347,8 @@ static struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
 	.reg_cache_default	= jz4740_codec_regs,
 	.reg_word_size = sizeof(u32),
 	.reg_cache_size	= 2,
+	.route = jz4740_codec_dapm_routes,
+	.num_routes = ARRAY_SIZE(jz4740_codec_dapm_routes),
 };
 
 static int __devinit jz4740_codec_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index bd0517c..0b6f4a0 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1233,8 +1233,6 @@ static int max98088_add_widgets(struct snd_soc_codec *codec)
        snd_soc_dapm_new_controls(dapm, max98088_dapm_widgets,
                                  ARRAY_SIZE(max98088_dapm_widgets));
 
-       snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
        snd_soc_add_controls(codec, max98088_snd_controls,
                             ARRAY_SIZE(max98088_snd_controls));
 
@@ -2036,6 +2034,8 @@ static struct snd_soc_codec_driver soc_codec_dev_max98088 = {
        .reg_word_size = sizeof(u8),
        .reg_cache_default = max98088_reg,
        .volatile_register = max98088_volatile_register,
+       .route = audio_map,
+       .num_routes = ARRAY_SIZE(audio_map),
 };
 
 static int max98088_i2c_probe(struct i2c_client *i2c,
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 593632c..0a0d71c 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -427,10 +427,6 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 				ARRAY_SIZE(sn95031_dapm_widgets));
 	if (ret)
 		pr_err("soc_dapm_new_control failed %d", ret);
-	ret = snd_soc_dapm_add_routes(&codec->dapm, sn95031_audio_map,
-				ARRAY_SIZE(sn95031_audio_map));
-	if (ret)
-		pr_err("soc_dapm_add_routes failed %d", ret);
 
 	return ret;
 }
@@ -449,6 +445,8 @@ struct snd_soc_codec_driver sn95031_codec = {
 	.read		= sn95031_read,
 	.write		= sn95031_write,
 	.set_bias_level	= sn95031_set_vaud_bias,
+	.route		= sn95031_audio_map,
+	.num_routes	= ARRAY_SIZE(sn95031_audio_map),
 };
 
 static int __devinit sn95031_device_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 2727bef..586f52c 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -210,7 +210,6 @@ static int ssm2602_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, ssm2602_dapm_widgets,
 				  ARRAY_SIZE(ssm2602_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_conn, ARRAY_SIZE(audio_conn));
 
 	return 0;
 }
@@ -605,6 +604,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.reg_cache_size = sizeof(ssm2602_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = ssm2602_reg,
+	.route = audio_conn,
+	.num_routes = ARRAY_SIZE(audio_conn),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 54a30ef..40be48a 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -394,8 +394,6 @@ static int tlv320aic23_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
 				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
-	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -698,6 +696,8 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
 	.read = tlv320aic23_read_reg_cache,
 	.write = tlv320aic23_write,
 	.set_bias_level = tlv320aic23_set_bias_level,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 71d7be8..75740b3 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -623,8 +623,6 @@ static int dac33_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, dac33_dapm_widgets,
 				  ARRAY_SIZE(dac33_dapm_widgets));
-	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1491,6 +1489,8 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
 	.remove = dac33_soc_remove,
 	.suspend = dac33_soc_suspend,
 	.resume = dac33_soc_resume,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #define DAC33_RATES	(SNDRV_PCM_RATE_44100 | \
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e4d464b..6f30605 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1639,7 +1639,6 @@ static int twl4030_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, twl4030_dapm_widgets,
 				 ARRAY_SIZE(twl4030_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -2293,6 +2292,8 @@ static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.reg_cache_size = sizeof(twl4030_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = twl4030_reg,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 static int __devinit twl4030_codec_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 4bbf1b1..3ff0501 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1225,7 +1225,6 @@ static int twl6040_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, twl6040_dapm_widgets,
 				 ARRAY_SIZE(twl6040_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 	snd_soc_dapm_new_widgets(dapm);
 
 	return 0;
@@ -1747,6 +1746,8 @@ static struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.reg_cache_size = ARRAY_SIZE(twl6040_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = twl6040_reg,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 static int __devinit twl6040_codec_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index c5ca8cf..32f8341 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -416,7 +416,6 @@ static int uda1380_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, uda1380_dapm_widgets,
 				  ARRAY_SIZE(uda1380_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -814,6 +813,8 @@ static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = uda1380_reg,
 	.reg_cache_step = 1,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 6d6dc9e..fcd07fa 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -794,19 +794,10 @@ static int wm8350_add_widgets(struct snd_soc_codec *codec)
 	ret = snd_soc_dapm_new_controls(dapm,
 					wm8350_dapm_widgets,
 					ARRAY_SIZE(wm8350_dapm_widgets));
-	if (ret != 0) {
+	if (ret != 0)
 		dev_err(codec->dev, "dapm control register failed\n");
-		return ret;
-	}
-
-	/* set up audio paths */
-	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-	if (ret != 0) {
-		dev_err(codec->dev, "DAPM route register failed\n");
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int wm8350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
@@ -1697,6 +1688,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 	.read = wm8350_codec_read,
 	.write = wm8350_codec_write,
 	.set_bias_level = wm8350_set_bias_level,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 static int __devinit wm8350_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 3c3bc07..e8fec1a 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -914,7 +914,6 @@ static int wm8400_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8400_dapm_widgets,
 				  ARRAY_SIZE(wm8400_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1453,6 +1452,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 	.read = wm8400_read,
 	.write = wm8400_write,
 	.set_bias_level = wm8400_set_bias_level,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 static int __devinit wm8400_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index db0dced..1bdbc95 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -219,7 +219,6 @@ static int wm8510_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8510_dapm_widgets,
 				  ARRAY_SIZE(wm8510_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -596,6 +595,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8510 = {
 	.reg_cache_size = ARRAY_SIZE(wm8510_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default =wm8510_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 4fd4d8d..0f6766fe 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -112,7 +112,6 @@ static int wm8523_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8523_dapm_widgets,
 				  ARRAY_SIZE(wm8523_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -512,6 +511,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8523 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8523_reg,
 	.volatile_register = wm8523_volatile_register,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 8f6b5ee..ec16d74 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -304,7 +304,6 @@ static int wm8580_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8580_dapm_widgets,
 				  ARRAY_SIZE(wm8580_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -905,6 +904,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
 	.reg_cache_size = ARRAY_SIZE(wm8580_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8580_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 97c3038..fb632c4 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -95,7 +95,6 @@ static int wm8711_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8711_dapm_widgets,
 				  ARRAY_SIZE(wm8711_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -420,6 +419,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8711 = {
 	.reg_cache_size = ARRAY_SIZE(wm8711_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8711_reg,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 736b035..a01a7ca 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -76,7 +76,6 @@ static int wm8728_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8728_dapm_widgets,
 				  ARRAY_SIZE(wm8728_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -275,6 +274,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
 	.reg_cache_size = ARRAY_SIZE(wm8728_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8728_reg_defaults,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 0a67c31..5dfcd05 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -233,7 +233,6 @@ static int wm8731_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8731_dapm_widgets,
 				  ARRAY_SIZE(wm8731_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -636,6 +635,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
 	.reg_cache_size = ARRAY_SIZE(wm8731_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8731_reg,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 30c67d0..a7f9bab 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -272,7 +272,6 @@ static int wm8737_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8737_dapm_widgets,
 				  ARRAY_SIZE(wm8737_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -632,6 +631,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8737 = {
 	.reg_cache_size = WM8737_REGISTER_COUNT - 1, /* Skip reset */
 	.reg_word_size	= sizeof(u16),
 	.reg_cache_default = wm8737_reg,
+	.route		= intercon,
+	.num_routes	= ARRAY_SIZE(intercon),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 25af901..f8dc671 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -97,7 +97,6 @@ static int wm8741_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8741_dapm_widgets,
 				  ARRAY_SIZE(wm8741_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -459,6 +458,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
 	.reg_cache_size = ARRAY_SIZE(wm8741_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8741_reg_defaults,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 38f38fd..55d7c5e 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -401,7 +401,6 @@ static int wm8750_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
 				  ARRAY_SIZE(wm8750_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -749,6 +748,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8750 = {
 	.reg_cache_size = ARRAY_SIZE(wm8750_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8750_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 79b02ae..224bf8e 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -626,7 +626,6 @@ static int wm8753_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8753_dapm_widgets,
 				  ARRAY_SIZE(wm8753_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1542,6 +1541,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
 	.reg_cache_size = ARRAY_SIZE(wm8753_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8753_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 19b92ba..5b4eb96 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -647,8 +647,6 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(wm8770_snd_controls));
 	snd_soc_dapm_new_controls(&codec->dapm, wm8770_dapm_widgets,
 				  ARRAY_SIZE(wm8770_dapm_widgets));
-	snd_soc_dapm_add_routes(&codec->dapm, wm8770_intercon,
-				ARRAY_SIZE(wm8770_intercon));
 	return 0;
 
 err_reg_enable:
@@ -681,7 +679,9 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
 	.set_bias_level = wm8770_set_bias_level,
 	.reg_cache_size = ARRAY_SIZE(wm8770_reg_defs),
 	.reg_word_size = sizeof (u16),
-	.reg_cache_default = wm8770_reg_defs
+	.reg_cache_default = wm8770_reg_defs,
+	.route = wm8770_intercon,
+	.num_routes = ARRAY_SIZE(wm8770_intercon),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 8e7953b..3a0627e 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -429,7 +429,6 @@ static int wm8776_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(wm8776_snd_controls));
 	snd_soc_dapm_new_controls(dapm, wm8776_dapm_widgets,
 				  ARRAY_SIZE(wm8776_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, routes, ARRAY_SIZE(routes));
 
 	return ret;
 }
@@ -450,6 +449,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
 	.reg_cache_size = ARRAY_SIZE(wm8776_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8776_reg,
+	.route = routes,
+	.num_routes = ARRAY_SIZE(routes),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 449ea09..9480a1d 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -613,7 +613,6 @@ static int wm8900_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8900_dapm_widgets,
 				  ARRAY_SIZE(wm8900_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1252,6 +1251,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
 	.reg_cache_size = ARRAY_SIZE(wm8900_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8900_reg_defaults,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 9c4f2c4..0bfa35f 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1011,7 +1011,6 @@ static int wm8903_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8903_dapm_widgets,
 				  ARRAY_SIZE(wm8903_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -1893,6 +1892,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8903_reg_defaults,
 	.volatile_register = wm8903_volatile_register,
+	.route = intercon,
+	.num_routes = ARRAY_SIZE(intercon),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 25580e3..f943561 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -290,18 +290,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int wm8940_add_widgets(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	ret = snd_soc_dapm_new_controls(dapm, wm8940_dapm_widgets,
-					ARRAY_SIZE(wm8940_dapm_widgets));
-	if (ret)
-		goto error_ret;
-	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-	if (ret)
-		goto error_ret;
 
-error_ret:
-	return ret;
+	return snd_soc_dapm_new_controls(dapm, wm8940_dapm_widgets,
+					 ARRAY_SIZE(wm8940_dapm_widgets));
 }
 
 #define wm8940_reset(c) snd_soc_write(c, WM8940_SOFTRESET, 0);
@@ -751,6 +742,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8940 = {
 	.reg_cache_size = ARRAY_SIZE(wm8940_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8940_reg_defaults,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 5e0214d..f87a4dc 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -582,8 +582,6 @@ static int wm8955_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8955_dapm_widgets,
 				  ARRAY_SIZE(wm8955_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, wm8955_intercon,
-				ARRAY_SIZE(wm8955_intercon));
 
 	return 0;
 }
@@ -1000,6 +998,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8955 = {
 	.reg_cache_size = ARRAY_SIZE(wm8955_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8955_reg,
+	.route = wm8955_intercon,
+	.num_routes = ARRAY_SIZE(wm8955_intercon),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index cdee810..7e24610 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1025,7 +1025,6 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 				ARRAY_SIZE(wm8961_snd_controls));
 	snd_soc_dapm_new_controls(dapm, wm8961_dapm_widgets,
 				  ARRAY_SIZE(wm8961_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return 0;
 }
@@ -1078,6 +1077,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8961_reg_defaults,
 	.volatile_register = wm8961_volatile_register,
+	.route = audio_paths,
+	.num_routes = ARRAY_SIZE(audio_paths),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 572bb80..a20f16b 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -336,7 +336,6 @@ static int wm8971_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8971_dapm_widgets,
 				  ARRAY_SIZE(wm8971_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -707,6 +706,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
 	.reg_cache_size = ARRAY_SIZE(wm8971_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8971_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index ca646a8..5aa92d1 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -276,7 +276,6 @@ static int wm8974_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8974_dapm_widgets,
 				  ARRAY_SIZE(wm8974_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -644,6 +643,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 	.reg_cache_size = ARRAY_SIZE(wm8974_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8974_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 30fb48e..eeee090 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -357,8 +357,6 @@ static int wm8978_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8978_dapm_widgets,
 				  ARRAY_SIZE(wm8978_dapm_widgets));
-	/* set up the WM8978 audio map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -999,6 +997,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
 	.reg_cache_size = ARRAY_SIZE(wm8978_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8978_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index bae510a..42843dd 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -536,8 +536,6 @@ static int wm8985_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8985_dapm_widgets,
 				  ARRAY_SIZE(wm8985_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map,
-				ARRAY_SIZE(audio_map));
 	return 0;
 }
 
@@ -1069,7 +1067,9 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
 	.set_bias_level = wm8985_set_bias_level,
 	.reg_cache_size = ARRAY_SIZE(wm8985_reg_defs),
 	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8985_reg_defs
+	.reg_cache_default = wm8985_reg_defs,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index d7170f1..05f709c 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -791,7 +791,6 @@ static int wm8988_probe(struct snd_soc_codec *codec)
 				ARRAY_SIZE(wm8988_snd_controls));
 	snd_soc_dapm_new_controls(dapm, wm8988_dapm_widgets,
 				  ARRAY_SIZE(wm8988_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -811,6 +810,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
 	.reg_cache_size = ARRAY_SIZE(wm8988_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8988_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 100aeee..9b2d0c1 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -917,8 +917,6 @@ static int wm8990_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm8990_dapm_widgets,
 				  ARRAY_SIZE(wm8990_dapm_widgets));
-	/* set up the WM8990 audio map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1392,6 +1390,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
 	.reg_cache_size = ARRAY_SIZE(wm8990_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8990_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 28fdfd6..51d6bb1 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1306,8 +1306,6 @@ static int wm8991_probe(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(&codec->dapm, wm8991_dapm_widgets,
 				  ARRAY_SIZE(wm8991_dapm_widgets));
-	snd_soc_dapm_add_routes(&codec->dapm, audio_map,
-				ARRAY_SIZE(audio_map));
 	return 0;
 }
 
@@ -1358,7 +1356,9 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8991 = {
 	.set_bias_level = wm8991_set_bias_level,
 	.reg_cache_size = WM8991_MAX_REGISTER + 1,
 	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8991_reg_defs
+	.reg_cache_default = wm8991_reg_defs,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 static __devinit int wm8991_i2c_probe(struct i2c_client *i2c,
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 379fa22..d948484 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1514,7 +1514,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 				  ARRAY_SIZE(wm8993_dapm_widgets));
 	wm_hubs_add_analogue_controls(codec);
 
-	snd_soc_dapm_add_routes(dapm, routes, ARRAY_SIZE(routes));
 	wm_hubs_add_analogue_routes(codec, wm8993->pdata.lineout1_diff,
 				    wm8993->pdata.lineout2_diff);
 
@@ -1597,6 +1596,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8993_reg_defaults,
 	.volatile_register = wm8993_volatile,
+	.route = routes,
+	.num_routes = ARRAY_SIZE(routes),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 67eaaec..8aba002 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -1679,8 +1679,6 @@ static int wm8995_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(wm8995_snd_controls));
 	snd_soc_dapm_new_controls(&codec->dapm, wm8995_dapm_widgets,
 				  ARRAY_SIZE(wm8995_dapm_widgets));
-	snd_soc_dapm_add_routes(&codec->dapm, wm8995_intercon,
-				ARRAY_SIZE(wm8995_intercon));
 
 	return 0;
 
@@ -1783,7 +1781,9 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8995 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8995_reg_defs,
 	.volatile_register = wm8995_volatile,
-	.compress_type = SND_SOC_RBTREE_COMPRESSION
+	.compress_type = SND_SOC_RBTREE_COMPRESSION,
+	.route = wm8995_intercon,
+	.num_routes = ARRAY_SIZE(wm8995_intercon),
 };
 
 #if defined(CONFIG_SPI_MASTER)
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 5c224dd..b177c97 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1274,7 +1274,6 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm9081_dapm_widgets,
 				  ARRAY_SIZE(wm9081_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return ret;
 }
@@ -1324,6 +1323,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm9081_reg_defaults,
 	.volatile_register = wm9081_volatile_register,
+	.route = audio_paths,
+	.num_routes = ARRAY_SIZE(audio_paths),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 47b357a..05605a7 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -206,7 +206,6 @@ static int wm9705_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm9705_dapm_widgets,
 					ARRAY_SIZE(wm9705_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -390,6 +389,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9705_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 static __devinit int wm9705_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index bf5d4ef..7ec0a78 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -435,7 +435,6 @@ static int wm9712_add_widgets(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_new_controls(dapm, wm9712_dapm_widgets,
 				  ARRAY_SIZE(wm9712_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -678,6 +677,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9712_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 static __devinit int wm9712_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 38ed985..abbeef0 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -651,8 +651,6 @@ static int wm9713_add_widgets(struct snd_soc_codec *codec)
 	snd_soc_dapm_new_controls(dapm, wm9713_dapm_widgets,
 				  ARRAY_SIZE(wm9713_dapm_widgets));
 
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -1262,6 +1260,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9713_reg,
+	.route = audio_map,
+	.num_routes = ARRAY_SIZE(audio_map),
 };
 
 static __devinit int wm9713_probe(struct platform_device *pdev)
-- 
1.7.2.3
