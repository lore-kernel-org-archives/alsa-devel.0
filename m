From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 6/6] ASoC: tlv320aic32x4: Support for
	regulators
Date: Mon, 27 Jan 2014 13:03:10 +0100
Message-ID: <1390824190-18376-7-git-send-email-mpa@pengutronix.de>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7242B265020
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 13:03:59 +0100 (CET)
In-Reply-To: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
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
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  6 +++
 sound/soc/codecs/tlv320aic32x4.c                   | 52 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index 352be7b..d09b065 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -10,6 +10,12 @@ Optional properties:
  - reset-gpios: Reset-GPIO phandle with args as described in gpio/gpio.txt
  - clocks/clock-names: Clock named 'mclk' for the master clock of the codec.
    See clock/clock-bindings.txt for information about the detailed format.
+ - supply-*: Optional supply regulators for the codec. Possible regulators are
+    "ldoin" - LDO power supply
+    "iov" - digital IO power supply
+    "dv" - Digital core power supply
+    "av" - Analog core power supply
+   See regulator/regulator.txt for more information.
 
 
 Example:
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 4f7830d..49b5293 100644
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
@@ -699,6 +705,46 @@ static int aic32x4_parse_dt(struct aic32x4_priv *aic32x4,
 	return 0;
 }
 
+static int aic32x4_i2c_setup_regulators(struct device *dev,
+		struct aic32x4_priv *aic32x4)
+{
+	int ret;
+
+	aic32x4->supply_ldo = devm_regulator_get_optional(dev, "ldoin");
+	aic32x4->supply_iov = devm_regulator_get_optional(dev, "iov");
+	aic32x4->supply_dv = devm_regulator_get_optional(dev, "dv");
+	aic32x4->supply_av = devm_regulator_get_optional(dev, "av");
+
+	if (!IS_ERR(aic32x4->supply_ldo)) {
+		ret = regulator_enable(aic32x4->supply_ldo);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR(aic32x4->supply_iov)) {
+		ret = regulator_enable(aic32x4->supply_iov);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR(aic32x4->supply_dv)) {
+		ret = regulator_enable(aic32x4->supply_dv);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR(aic32x4->supply_av)) {
+		ret = regulator_enable(aic32x4->supply_av);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR(aic32x4->supply_ldo) && IS_ERR(aic32x4->supply_av))
+		aic32x4->power_cfg |= AIC32X4_PWR_AIC32X4_LDO_ENABLE;
+
+	return 0;
+}
+
 static int aic32x4_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -736,6 +782,12 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->rstn_gpio = -1;
 	}
 
+	ret = aic32x4_i2c_setup_regulators(&i2c->dev, aic32x4);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to setup regulators\n");
+		return ret;
+	}
+
 	aic32x4->mclk = devm_clk_get(&i2c->dev, "mclk");
 	if (IS_ERR(aic32x4->mclk))
 		dev_info(&i2c->dev, "No mclk found, continuing without clock\n");
-- 
1.8.5.2
