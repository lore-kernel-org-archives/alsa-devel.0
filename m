From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v6 2/4] ASoC: tlv320aic32x4: Support for
	regulators
Date: Thu, 20 Feb 2014 18:22:59 +0100
Message-ID: <1392916981-9333-3-git-send-email-mpa@pengutronix.de>
References: <1392916981-9333-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id BA5FB265838
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 18:23:41 +0100 (CET)
In-Reply-To: <1392916981-9333-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Support regulators to power up the codec. This patch also enables the
AVDD LDO if no AV regulator was found.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |   8 ++
 sound/soc/codecs/tlv320aic32x4.c                   | 126 ++++++++++++++++++++-
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index 352be7b..5e2741a 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -5,6 +5,14 @@ The tlv320aic32x4 serial control bus communicates through I2C protocols
 Required properties:
  - compatible: Should be "ti,tlv320aic32x4"
  - reg: I2C slave address
+ - supply-*: Required supply regulators are:
+    "iov" - digital IO power supply
+    "ldoin" - LDO power supply
+    "dv" - Digital core power supply
+    "av" - Analog core power supply
+    If you supply ldoin, dv and av are optional. Otherwise they are required
+   See regulator/regulator.txt for more information about the detailed binding
+   format.
 
 Optional properties:
  - reset-gpios: Reset-GPIO phandle with args as described in gpio/gpio.txt
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 643fa53..d69c61f 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -34,6 +34,7 @@
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/regulator/consumer.h>
 
 #include <sound/tlv320aic32x4.h>
 #include <sound/core.h>
@@ -69,6 +70,11 @@ struct aic32x4_priv {
 	bool swapdacs;
 	int rstn_gpio;
 	struct clk *mclk;
+
+	struct regulator *supply_ldo;
+	struct regulator *supply_iov;
+	struct regulator *supply_dv;
+	struct regulator *supply_av;
 };
 
 /* 0dB min, 0.5dB steps */
@@ -695,6 +701,106 @@ static int aic32x4_parse_dt(struct aic32x4_priv *aic32x4,
 	return 0;
 }
 
+static void aic32x4_disable_regulators(struct aic32x4_priv *aic32x4)
+{
+	regulator_disable(aic32x4->supply_iov);
+
+	if (!IS_ERR(aic32x4->supply_ldo))
+		regulator_disable(aic32x4->supply_ldo);
+
+	if (!IS_ERR(aic32x4->supply_dv))
+		regulator_disable(aic32x4->supply_dv);
+
+	if (!IS_ERR(aic32x4->supply_av))
+		regulator_disable(aic32x4->supply_av);
+}
+
+static int aic32x4_setup_regulators(struct device *dev,
+		struct aic32x4_priv *aic32x4)
+{
+	int ret = 0;
+
+	aic32x4->supply_ldo = devm_regulator_get_optional(dev, "ldoin");
+	aic32x4->supply_iov = devm_regulator_get(dev, "iov");
+	aic32x4->supply_dv = devm_regulator_get_optional(dev, "dv");
+	aic32x4->supply_av = devm_regulator_get_optional(dev, "av");
+
+	/* Check if the regulator requirements are fulfilled */
+
+	if (IS_ERR(aic32x4->supply_iov)) {
+		dev_err(dev, "Missing supply 'iov'\n");
+		return PTR_ERR(aic32x4->supply_iov);
+	}
+
+	if (IS_ERR(aic32x4->supply_ldo)) {
+		if (PTR_ERR(aic32x4->supply_ldo) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		if (IS_ERR(aic32x4->supply_dv)) {
+			dev_err(dev, "Missing supply 'dv' or 'ldoin'\n");
+			return PTR_ERR(aic32x4->supply_dv);
+		}
+		if (IS_ERR(aic32x4->supply_av)) {
+			dev_err(dev, "Missing supply 'av' or 'ldoin'\n");
+			return PTR_ERR(aic32x4->supply_av);
+		}
+	} else {
+		if (IS_ERR(aic32x4->supply_dv) &&
+				PTR_ERR(aic32x4->supply_dv) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		if (IS_ERR(aic32x4->supply_av) &&
+				PTR_ERR(aic32x4->supply_av) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
+	ret = regulator_enable(aic32x4->supply_iov);
+	if (ret) {
+		dev_err(dev, "Failed to enable regulator iov\n");
+		return ret;
+	}
+
+	if (!IS_ERR(aic32x4->supply_ldo)) {
+		ret = regulator_enable(aic32x4->supply_ldo);
+		if (ret) {
+			dev_err(dev, "Failed to enable regulator ldo\n");
+			goto error_ldo;
+		}
+	}
+
+	if (!IS_ERR(aic32x4->supply_dv)) {
+		ret = regulator_enable(aic32x4->supply_dv);
+		if (ret) {
+			dev_err(dev, "Failed to enable regulator dv\n");
+			goto error_dv;
+		}
+	}
+
+	if (!IS_ERR(aic32x4->supply_av)) {
+		ret = regulator_enable(aic32x4->supply_av);
+		if (ret) {
+			dev_err(dev, "Failed to enable regulator av\n");
+			goto error_av;
+		}
+	}
+
+	if (!IS_ERR(aic32x4->supply_ldo) && IS_ERR(aic32x4->supply_av))
+		aic32x4->power_cfg |= AIC32X4_PWR_AIC32X4_LDO_ENABLE;
+
+	return 0;
+
+error_av:
+	if (!IS_ERR(aic32x4->supply_dv))
+		regulator_disable(aic32x4->supply_dv);
+
+error_dv:
+	if (!IS_ERR(aic32x4->supply_ldo))
+		regulator_disable(aic32x4->supply_ldo);
+
+error_ldo:
+	regulator_disable(aic32x4->supply_iov);
+	return ret;
+}
+
 static int aic32x4_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -745,13 +851,31 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 			return ret;
 	}
 
+	ret = aic32x4_setup_regulators(&i2c->dev, aic32x4);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to setup regulators\n");
+		return ret;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic32x4, &aic32x4_dai, 1);
-	return ret;
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to register codec\n");
+		aic32x4_disable_regulators(aic32x4);
+		return ret;
+	}
+
+	i2c_set_clientdata(i2c, aic32x4);
+
+	return 0;
 }
 
 static int aic32x4_i2c_remove(struct i2c_client *client)
 {
+	struct aic32x4_priv *aic32x4 = i2c_get_clientdata(client);
+
+	aic32x4_disable_regulators(aic32x4);
+
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
-- 
1.8.5.3
