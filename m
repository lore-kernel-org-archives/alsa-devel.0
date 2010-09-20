From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 2/4] ASoC: tlv320aic3x: Add runtime regulator
	control to aic3x_set_bias_level
Date: Mon, 20 Sep 2010 10:39:12 +0300
Message-ID: <1284968354-12536-3-git-send-email-jhnikula@gmail.com>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 025B2103835
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 09:39:22 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so1641974ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 00:39:22 -0700 (PDT)
In-Reply-To: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
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

Now all the regulators are disabled when entering into SND_SOC_BIAS_OFF
and enabled when coming back to SND_SOC_BIAS_STANDBY state. Currently this
runtime control happens only with suspend/resume as this patch does not
change the default idle behavior.

This patch manages all the regulators and reset since it seems that register
sync is needed even if only analog supplies AVDD and DRVDD are disabled.
This was noted when the system was running with idle behavior changed and
IOVDD and DVDD were on.

It is not known are all the registers needed to sync or only some subset of
them. Therefore patch plays safe and does always full shutdown/power-up.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   83 +++++++++++++++++++++++++++++++---------
 1 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index c60ead9..5f8a7c4 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -70,6 +70,7 @@ struct aic3x_priv {
 	unsigned int sysclk;
 	int master;
 	int gpio_reset;
+	int power;
 #define AIC3X_MODEL_3X 0
 #define AIC3X_MODEL_33 1
 #define AIC3X_MODEL_3007 2
@@ -1028,6 +1029,64 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int aic3x_init_3007(struct snd_soc_codec *codec)
+{
+	u8 tmp1, tmp2, *cache = codec->reg_cache;
+
+	/*
+	 * There is no need to cache writes to undocumented page 0xD but
+	 * respective page 0 register cache entries must be preserved
+	 */
+	tmp1 = cache[0xD];
+	tmp2 = cache[0x8];
+	/* Class-D speaker driver init; datasheet p. 46 */
+	snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x0D);
+	snd_soc_write(codec, 0xD, 0x0D);
+	snd_soc_write(codec, 0x8, 0x5C);
+	snd_soc_write(codec, 0x8, 0x5D);
+	snd_soc_write(codec, 0x8, 0x5C);
+	snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x00);
+	cache[0xD] = tmp1;
+	cache[0x8] = tmp2;
+
+	return 0;
+}
+
+static int aic3x_set_power(struct snd_soc_codec *codec, int power)
+{
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	int i, ret;
+	u8 *cache = codec->reg_cache;
+
+	if (power) {
+		ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
+					    aic3x->supplies);
+		if (ret)
+			goto out;
+		aic3x->power = 1;
+		if (aic3x->gpio_reset >= 0) {
+			udelay(1);
+			gpio_set_value(aic3x->gpio_reset, 1);
+		}
+
+		/* Sync reg_cache with the hardware */
+		codec->cache_only = 0;
+		for (i = 0; i < ARRAY_SIZE(aic3x_reg); i++)
+			snd_soc_write(codec, i, cache[i]);
+		if (aic3x->model == AIC3X_MODEL_3007)
+			aic3x_init_3007(codec);
+		codec->cache_sync = 0;
+	} else {
+		aic3x->power = 0;
+		if (aic3x->gpio_reset >= 0)
+			gpio_set_value(aic3x->gpio_reset, 0);
+		ret = regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies),
+					     aic3x->supplies);
+	}
+out:
+	return ret;
+}
+
 static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 				enum snd_soc_bias_level level)
 {
@@ -1047,6 +1106,8 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		if (!aic3x->power)
+			aic3x_set_power(codec, 1);
 		if (codec->bias_level == SND_SOC_BIAS_PREPARE &&
 		    aic3x->master) {
 			/* disable pll */
@@ -1056,6 +1117,8 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
+		if (aic3x->power)
+			aic3x_set_power(codec, 0);
 		break;
 	}
 	codec->bias_level = level;
@@ -1155,17 +1218,6 @@ static int aic3x_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int aic3x_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u8 data[2];
-	u8 *cache = codec->reg_cache;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(aic3x_reg); i++) {
-		data[0] = i;
-		data[1] = cache[i];
-		codec->hw_write(codec->control_data, data, 2);
-	}
-
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -1247,13 +1299,7 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	snd_soc_write(codec, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
 
 	if (aic3x->model == AIC3X_MODEL_3007) {
-		/* Class-D speaker driver init; datasheet p. 46 */
-		snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x0D);
-		snd_soc_write(codec, 0xD, 0x0D);
-		snd_soc_write(codec, 0x8, 0x5C);
-		snd_soc_write(codec, 0x8, 0x5D);
-		snd_soc_write(codec, 0x8, 0x5C);
-		snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x00);
+		aic3x_init_3007(codec);
 		snd_soc_write(codec, CLASSD_CTRL, 0);
 	}
 
@@ -1299,6 +1345,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
 		goto err_enable;
 	}
+	aic3x->power = 1;
 
 	if (aic3x->gpio_reset >= 0) {
 		udelay(1);
-- 
1.7.1
