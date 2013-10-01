From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/3] ASoC: tas5086: move initialization code to
	own functions
Date: Tue,  1 Oct 2013 14:48:25 +0200
Message-ID: <1380631706-19365-2-git-send-email-zonque@gmail.com>
References: <1380631706-19365-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0620A264F13
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 14:48:33 +0200 (CEST)
In-Reply-To: <1380631706-19365-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, s.neumann@raumfeld.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

We'll need to call code to initialize and reset the codec again at
resume time, so factor it out first.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 128 +++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 31b5868..3a88c68 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -458,6 +458,75 @@ static int tas5086_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 	return regmap_write(priv->regmap, TAS5086_SOFT_MUTE, val);
 }
 
+static void tas5086_reset(struct tas5086_private *priv)
+{
+	if (gpio_is_valid(priv->gpio_nreset)) {
+		/* Reset codec - minimum assertion time is 400ns */
+		gpio_direction_output(priv->gpio_nreset, 0);
+		udelay(1);
+		gpio_set_value(priv->gpio_nreset, 1);
+
+		/* Codec needs ~15ms to wake up */
+		msleep(15);
+	}
+}
+
+/* charge period values in microseconds */
+static const int tas5086_charge_period[] = {
+	  13000,  16900,   23400,   31200,   41600,   54600,   72800,   96200,
+	 130000, 156000,  234000,  312000,  416000,  546000,  728000,  962000,
+	1300000, 169000, 2340000, 3120000, 4160000, 5460000, 7280000, 9620000,
+};
+
+static int tas5086_init(struct device *dev, struct tas5086_private *priv)
+{
+	int ret, i;
+
+	/*
+	 * If any of the channels is configured to start in Mid-Z mode,
+	 * configure 'part 1' of the PWM starts to use Mid-Z, and tell
+	 * all configured mid-z channels to start start under 'part 1'.
+	 */
+	if (priv->pwm_start_mid_z)
+		regmap_write(priv->regmap, TAS5086_PWM_START,
+			     TAS5086_PWM_START_MIDZ_FOR_START_1 |
+				priv->pwm_start_mid_z);
+
+	/* lookup and set split-capacitor charge period */
+	if (priv->charge_period == 0) {
+		regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE, 0);
+	} else {
+		i = index_in_array(tas5086_charge_period,
+				   ARRAY_SIZE(tas5086_charge_period),
+				   priv->charge_period);
+		if (i >= 0)
+			regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE,
+				     i + 0x08);
+		else
+			dev_warn(dev,
+				 "Invalid split-cap charge period of %d ns.\n",
+				 priv->charge_period);
+	}
+
+	/* enable factory trim */
+	ret = regmap_write(priv->regmap, TAS5086_OSC_TRIM, 0x00);
+	if (ret < 0)
+		return ret;
+
+	/* start all channels */
+	ret = regmap_write(priv->regmap, TAS5086_SYS_CONTROL_2, 0x20);
+	if (ret < 0)
+		return ret;
+
+	/* mute all channels for now */
+	ret = regmap_write(priv->regmap, TAS5086_SOFT_MUTE,
+			   TAS5086_SOFT_MUTE_ALL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /* TAS5086 controls */
 static const DECLARE_TLV_DB_SCALE(tas5086_dac_tlv, -10350, 50, 1);
 
@@ -712,13 +781,6 @@ static const struct of_device_id tas5086_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, tas5086_dt_ids);
 #endif
 
-/* charge period values in microseconds */
-static const int tas5086_charge_period[] = {
-	  13000,  16900,   23400,   31200,   41600,   54600,   72800,   96200,
-	 130000, 156000,  234000,  312000,  416000,  546000,  728000,  962000,
-	1300000, 169000, 2340000, 3120000, 4160000, 5460000, 7280000, 9620000,
-};
-
 static int tas5086_probe(struct snd_soc_codec *codec)
 {
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
@@ -729,6 +791,7 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 
 	if (of_match_device(of_match_ptr(tas5086_dt_ids), codec->dev)) {
 		struct device_node *of_node = codec->dev->of_node;
+
 		of_property_read_u32(of_node, "ti,charge-period",
 				     &priv->charge_period);
 
@@ -743,39 +806,7 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	/*
-	 * If any of the channels is configured to start in Mid-Z mode,
-	 * configure 'part 1' of the PWM starts to use Mid-Z, and tell
-	 * all configured mid-z channels to start start under 'part 1'.
-	 */
-	if (priv->pwm_start_mid_z)
-		regmap_write(priv->regmap, TAS5086_PWM_START,
-			     TAS5086_PWM_START_MIDZ_FOR_START_1 |
-				priv->pwm_start_mid_z);
-
-	/* lookup and set split-capacitor charge period */
-	if (priv->charge_period == 0) {
-		regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE, 0);
-	} else {
-		i = index_in_array(tas5086_charge_period,
-				   ARRAY_SIZE(tas5086_charge_period),
-				   priv->charge_period);
-		if (i >= 0)
-			regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE,
-				     i + 0x08);
-		else
-			dev_warn(codec->dev,
-				 "Invalid split-cap charge period of %d ns.\n",
-				 priv->charge_period);
-	}
-
-	/* enable factory trim */
-	ret = regmap_write(priv->regmap, TAS5086_OSC_TRIM, 0x00);
-	if (ret < 0)
-		return ret;
-
-	/* start all channels */
-	ret = regmap_write(priv->regmap, TAS5086_SYS_CONTROL_2, 0x20);
+	ret = tas5086_init(codec->dev, priv);
 	if (ret < 0)
 		return ret;
 
@@ -784,12 +815,6 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	/* mute all channels for now */
-	ret = regmap_write(priv->regmap, TAS5086_SOFT_MUTE,
-			   TAS5086_SOFT_MUTE_ALL);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -866,17 +891,8 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
 		if (devm_gpio_request(dev, gpio_nreset, "TAS5086 Reset"))
 			gpio_nreset = -EINVAL;
 
-	if (gpio_is_valid(gpio_nreset)) {
-		/* Reset codec - minimum assertion time is 400ns */
-		gpio_direction_output(gpio_nreset, 0);
-		udelay(1);
-		gpio_set_value(gpio_nreset, 1);
-
-		/* Codec needs ~15ms to wake up */
-		msleep(15);
-	}
-
 	priv->gpio_nreset = gpio_nreset;
+	tas5086_reset(priv);
 
 	/* The TAS5086 always returns 0x03 in its TAS5086_DEV_ID register */
 	ret = regmap_read(priv->regmap, TAS5086_DEV_ID, &i);
-- 
1.8.3.1
