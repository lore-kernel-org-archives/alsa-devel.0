From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: Add a configuration option for
	LDO2_POW pin
Date: Thu, 11 Sep 2014 08:08:38 -0700
Message-ID: <1410448118-39936-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f73.google.com (mail-pa0-f73.google.com
 [209.85.220.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C582656BA
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 17:08:57 +0200 (CEST)
Received: by mail-pa0-f73.google.com with SMTP id kx10so1413019pab.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 08:08:56 -0700 (PDT)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, Anatol Pomozov <anatol@google.com>, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Anatol Pomozov <anatol@google.com>

Some boards have this pin tied to board and do not require any configuration,
some other boards allow to enable chip using GPIO.

Add an option that tells which GPIO is used to power up the codec.

Signed-off-by: Anatol Pomozov <anatol@google.com>
---
 Documentation/devicetree/bindings/sound/rt5677.txt | 41 +++++++++++++++++++++
 sound/soc/codecs/rt5677.c                          | 42 ++++++++++++++++++++++
 sound/soc/codecs/rt5677.h                          |  2 ++
 3 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5677.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
new file mode 100644
index 0000000..572a42c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -0,0 +1,41 @@
+RT5677 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5677".
+
+- reg : The I2C address of the device.
+
+- interrupts : The CODEC's interrupt output.
+
+Optional properties:
+
+- realtek,pow-ldo2-gpio : The GPIO that controls the CODEC's POW_LDO2 pin.
+
+Pins on the device (for linking into audio routes):
+
+  * IN1P
+  * IN1N
+  * IN2P
+  * IN2N
+  * MICBIAS1
+  * DMIC1
+  * DMIC2
+  * DMIC3
+  * DMIC4
+  * LOUT1
+  * LOUT2
+  * LOUT3
+
+Example:
+
+rt5677 {
+	compatible = "realtek,rt5677";
+	reg = <0x1c>;
+	interrupt-parent = <&gpio>;
+	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+	realtek,pow-ldo2-gpio =
+		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+};
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 40a49ef..cf41e89 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
@@ -3365,6 +3366,24 @@ static const struct i2c_device_id rt5677_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
 
+static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
+{
+	rt5677->pow_ldo2 = of_get_named_gpio(np,
+					"realtek,pow-ldo2-gpio", 0);
+
+	/*
+	 * POW_LDO2 is optional (it may be statically tied on the board).
+	 * -ENOENT means that the property doesn't exist, i.e. there is no
+	 * GPIO, so is not an error. Any other error code means the property
+	 * exists, but could not be parsed.
+	 */
+	if (!gpio_is_valid(rt5677->pow_ldo2) &&
+			(rt5677->pow_ldo2 != -ENOENT))
+		return rt5677->pow_ldo2;
+
+	return 0;
+}
+
 static int rt5677_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -3383,6 +3402,29 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt5677->pdata = *pdata;
 
+	if (i2c->dev.of_node) {
+		ret = rt5677_parse_dt(rt5677, i2c->dev.of_node);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to parse device tree: %d\n",
+				ret);
+			return ret;
+		}
+	} else {
+		rt5677->pow_ldo2 = -EINVAL;
+	}
+
+	if (gpio_is_valid(rt5677->pow_ldo2)) {
+		ret = devm_gpio_request_one(&i2c->dev, rt5677->pow_ldo2,
+					    GPIOF_OUT_INIT_HIGH,
+					    "RT5677 POW_LDO2");
+		if (ret < 0) {
+			dev_err(&i2c->dev, "Failed to request POW_LDO2 %d: %d\n",
+				rt5677->pow_ldo2, ret);
+			return ret;
+		}
+		msleep(10);
+	}
+
 	rt5677->regmap = devm_regmap_init_i2c(i2c, &rt5677_regmap);
 	if (IS_ERR(rt5677->regmap)) {
 		ret = PTR_ERR(rt5677->regmap);
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 8791ab9..3c1b4dc 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1441,6 +1441,8 @@ struct rt5677_priv {
 	int pll_src;
 	int pll_in;
 	int pll_out;
+
+	int pow_ldo2; /* POW_LDO2 pin */
 };
 
 #endif /* __RT5677_H__ */
-- 
2.1.0.rc2.206.gedb03e5
