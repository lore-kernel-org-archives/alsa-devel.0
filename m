From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/4] ASoC: tlv320aic3x: Add runtime regulator
	control to aic3x_set_bias_level
Date: Fri, 10 Sep 2010 14:23:30 +0300
Message-ID: <1284117812-8618-2-git-send-email-jhnikula@gmail.com>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 15E69103982
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:22:48 +0200 (CEST)
Received: by eye27 with SMTP id 27so543647eye.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 04:22:47 -0700 (PDT)
In-Reply-To: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
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
 sound/soc/codecs/tlv320aic3x.c |   66 +++++++++++++++++++++++++++++++--------
 1 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 94dc707..c549b0f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -64,6 +64,7 @@ static const char *aic3x_supply_names[AIC3X_NUM_SUPPLIES] = {
 /* codec private data */
 struct aic3x_priv {
 	struct regulator_bulk_data supplies[AIC3X_NUM_SUPPLIES];
+	int power;
 	enum snd_soc_control_type control_type;
 	struct aic3x_setup_data *setup;
 	void *control_data;
@@ -141,6 +142,7 @@ static inline void aic3x_write_reg_cache(struct snd_soc_codec *codec,
 static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 		       unsigned int value)
 {
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	u8 data[2];
 
 	/* data is
@@ -151,7 +153,8 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = value & 0xff;
 
 	aic3x_write_reg_cache(codec, data[0], data[1]);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
+	if (!aic3x->power ||
+	    codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
 	else
 		return -EIO;
@@ -163,11 +166,17 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
 		      u8 *value)
 {
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	*value = reg & 0xff;
 
-	value[0] = i2c_smbus_read_byte_data(codec->control_data, value[0]);
+	if (aic3x->power) {
+		value[0] = i2c_smbus_read_byte_data(codec->control_data,
+						    value[0]);
+		aic3x_write_reg_cache(codec, reg, *value);
+	} else {
+		value[0] = aic3x_read_reg_cache(codec, reg);
+	}
 
-	aic3x_write_reg_cache(codec, reg, *value);
 	return 0;
 }
 
@@ -1059,6 +1068,41 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int aic3x_set_power(struct snd_soc_codec *codec, int power)
+{
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	int i, ret;
+	u8 data[2];
+	u8 *cache = codec->reg_cache;
+
+	if (power) {
+		ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
+					    aic3x->supplies);
+		if (ret)
+			goto out;
+		if (aic3x->gpio_reset >= 0) {
+			udelay(1);
+			gpio_set_value(aic3x->gpio_reset, 1);
+		}
+		aic3x->power = 1;
+
+		/* Sync reg_cache with the hardware */
+		for (i = 0; i < ARRAY_SIZE(aic3x_reg); i++) {
+			data[0] = i;
+			data[1] = cache[i];
+			codec->hw_write(codec->control_data, data, 2);
+		}
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
@@ -1078,6 +1122,8 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		if (!aic3x->power)
+			aic3x_set_power(codec, 1);
 		if (codec->bias_level == SND_SOC_BIAS_PREPARE &&
 		    aic3x->master) {
 			/* disable pll */
@@ -1087,6 +1133,8 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
+		if (aic3x->power)
+			aic3x_set_power(codec, 0);
 		break;
 	}
 	codec->bias_level = level;
@@ -1186,17 +1234,6 @@ static int aic3x_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
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
@@ -1415,6 +1452,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		udelay(1);
 		gpio_set_value(aic3x->gpio_reset, 1);
 	}
+	aic3x->power = 1;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic3x, &aic3x_dai, 1);
-- 
1.7.1
