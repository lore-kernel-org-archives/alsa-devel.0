From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3] ASoC: tas5086: add regulator consumer
	support
Date: Thu,  3 Jul 2014 16:56:43 +0200
Message-ID: <1404399403-6316-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
 [74.125.82.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 34E172654C6
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 17:02:12 +0200 (CEST)
Received: by mail-we0-f174.google.com with SMTP id u57so375408wes.33
 for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2014 08:02:12 -0700 (PDT)
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

Also, switch on the power to identify the chip at device probe level,
and switch it off again afterwards. The codec level will take care for
power handling later.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
This has been sitting in my tree since I forgot to resend it in March.

 .../devicetree/bindings/sound/ti,tas5086.txt       |  5 ++
 sound/soc/codecs/tas5086.c                         | 67 +++++++++++++++++++---
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas5086.txt b/Documentation/devicetree/bindings/sound/ti,tas5086.txt
index d2866a0..234dad2 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas5086.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas5086.txt
@@ -31,6 +31,9 @@ Optional properties:
 
 			Most systems should not set any of these properties.
 
+ - avdd-supply:         Power supply for AVDD, providing 3.3V
+ - dvdd-supply:         Power supply for DVDD, providing 3.3V
+
 Examples:
 
 	i2c_bus {
@@ -39,5 +42,7 @@ Examples:
 			reg = <0x1b>;
 			reset-gpio = <&gpio 23 0>;
 			ti,charge-period = <156000>;
+			avdd-supply = <&vdd_3v3_reg>;
+			dvdd-supply = <&vdd_3v3_reg>;
 		};
 	};
diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index d48491a..be7194b 100644
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
 
+static const char * const supply_names[] = {
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
 
@@ -812,6 +824,12 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
 	priv->pwm_start_mid_z = 0;
 	priv->charge_period = 1300000; /* hardware default is 1300 ms */
 
@@ -832,16 +850,22 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 		}
 	}
 
+	tas5086_reset(priv);
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
@@ -852,6 +876,8 @@ static int tas5086_remove(struct snd_soc_codec *codec)
 		/* Set codec to the reset state */
 		gpio_set_value(priv->gpio_nreset, 0);
 
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+
 	return 0;
 };
 
@@ -900,6 +926,16 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
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
@@ -919,21 +955,34 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
 			gpio_nreset = -EINVAL;
 
 	priv->gpio_nreset = gpio_nreset;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
 	tas5086_reset(priv);
 
 	/* The TAS5086 always returns 0x03 in its TAS5086_DEV_ID register */
 	ret = regmap_read(priv->regmap, TAS5086_DEV_ID, &i);
-	if (ret < 0)
-		return ret;
-
-	if (i != 0x3) {
+	if (ret == 0 && i != 0x3) {
 		dev_err(dev,
 			"Failed to identify TAS5086 codec (got %02x)\n", i);
-		return -ENODEV;
+		ret = -ENODEV;
 	}
 
-	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tas5086,
-		&tas5086_dai, 1);
+	/*
+	 * The chip has been identified, so we can turn off the power
+	 * again until the dai link is set up.
+	 */
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+
+	if (ret == 0)
+		ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tas5086,
+					     &tas5086_dai, 1);
+
+	return ret;
 }
 
 static int tas5086_i2c_remove(struct i2c_client *i2c)
-- 
1.9.3
