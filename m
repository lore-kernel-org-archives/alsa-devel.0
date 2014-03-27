From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/3 v2] ASoC: tas5086: add regulator consumer
	support
Date: Thu, 27 Mar 2014 21:42:16 +0100
Message-ID: <1395952936-10670-3-git-send-email-zonque@gmail.com>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C49A26547F
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 21:42:30 +0100 (CET)
Received: by mail-ee0-f42.google.com with SMTP id d17so3371994eek.1
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 13:42:30 -0700 (PDT)
In-Reply-To: <1395952936-10670-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The TAS5086 has two power domains, DVDD and AVDD. Enable them both as
long as the codec is in use.

While at it, move the device identification from the i2c probe to the
codec probe, so we do it after the regulators have been enabled.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 64 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index a895a5e..2ee03b6 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -36,6 +36,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -240,6 +241,10 @@ static int tas5086_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
+static const char const *supply_names[] = {
+	"dvdd", "avdd"
+};
+
 struct tas5086_private {
 	struct regmap	*regmap;
 	unsigned int	mclk, sclk;
@@ -251,6 +256,7 @@ struct tas5086_private {
 	int		rate;
 	/* GPIO driving Reset pin, if any */
 	int		gpio_nreset;
+	struct		regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
 static int tas5086_deemph[] = { 0, 32000, 44100, 48000 };
@@ -773,6 +779,8 @@ static int tas5086_soc_suspend(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+
 	return 0;
 }
 
@@ -781,6 +789,10 @@ static int tas5086_soc_resume(struct snd_soc_codec *codec)
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	if (ret < 0)
+		return ret;
+
 	tas5086_reset(priv);
 	regcache_mark_dirty(priv->regmap);
 
@@ -812,6 +824,25 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	tas5086_reset(priv);
+
+	/* The TAS5086 always returns 0x03 in its TAS5086_DEV_ID register */
+	ret = regmap_read(priv->regmap, TAS5086_DEV_ID, &i);
+	if (ret < 0)
+		goto exit_disable_regulators;
+
+	if (i != 0x3) {
+		dev_err(codec->dev,
+			"Failed to identify TAS5086 codec (got %02x)\n", i);
+		goto exit_disable_regulators;
+	}
+
 	priv->pwm_start_mid_z = 0;
 	priv->charge_period = 1300000; /* hardware default is 1300 ms */
 
@@ -834,14 +865,19 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 
 	ret = tas5086_init(codec->dev, priv);
 	if (ret < 0)
-		return ret;
+		goto exit_disable_regulators;
 
 	/* set master volume to 0 dB */
 	ret = regmap_write(priv->regmap, TAS5086_MASTER_VOL, 0x30);
 	if (ret < 0)
-		return ret;
+		goto exit_disable_regulators;
 
 	return 0;
+
+exit_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+
+	return ret;
 }
 
 static int tas5086_remove(struct snd_soc_codec *codec)
@@ -852,6 +888,8 @@ static int tas5086_remove(struct snd_soc_codec *codec)
 		/* Set codec to the reset state */
 		gpio_set_value(priv->gpio_nreset, 0);
 
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+
 	return 0;
 };
 
@@ -900,6 +938,16 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
 	if (!priv)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		priv->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
+				      priv->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
 	priv->regmap = devm_regmap_init(dev, NULL, i2c, &tas5086_regmap);
 	if (IS_ERR(priv->regmap)) {
 		ret = PTR_ERR(priv->regmap);
@@ -919,18 +967,6 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
 			gpio_nreset = -EINVAL;
 
 	priv->gpio_nreset = gpio_nreset;
-	tas5086_reset(priv);
-
-	/* The TAS5086 always returns 0x03 in its TAS5086_DEV_ID register */
-	ret = regmap_read(priv->regmap, TAS5086_DEV_ID, &i);
-	if (ret < 0)
-		return ret;
-
-	if (i != 0x3) {
-		dev_err(dev,
-			"Failed to identify TAS5086 codec (got %02x)\n", i);
-		return -ENODEV;
-	}
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tas5086,
 		&tas5086_dai, 1);
-- 
1.8.5.3
