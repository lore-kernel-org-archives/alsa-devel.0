From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2] ASoC: rt5640: add device tree support
Date: Wed, 12 Jun 2013 11:34:30 -0600
Message-ID: <1371058470-25100-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2596E26512D
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 19:40:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Modify the RT5640 driver to parse platform data from device tree. Write
a DT binding document to describe those properties.

Slight re-ordering of rt5640_i2c_probe() to better fit the DT parsing.

Since ldo1_en is optional, guard usage of it with gpio_is_valid(), rather
than open-coding an if (gpio) check.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Treat ldo1_en==0 in pdata as an invalid (unspecified) GPIO.
---
 Documentation/devicetree/bindings/sound/rt5640.txt | 30 ++++++++++++++
 sound/soc/codecs/rt5640.c                          | 48 +++++++++++++++++++---
 2 files changed, 72 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5640.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
new file mode 100644
index 0000000..005bcb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5640.txt
@@ -0,0 +1,30 @@
+RT5640 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5640".
+
+- reg : The I2C address of the device.
+
+- interrupts : The CODEC's interrupt output.
+
+Optional properties:
+
+- realtek,in1-differential
+- realtek,in2-differential
+  Boolean. Indicate MIC1/2 input are differential, rather than single-ended.
+
+- realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
+
+Example:
+
+rt5640 {
+	compatible = "realtek,rt5640";
+	reg = <0x1c>;
+	interrupt-parent = <&gpio>;
+	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+	realtek,ldo1-en-gpios =
+		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+};
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 288c17c..8761552 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <sound/core.h>
@@ -1998,6 +1999,28 @@ static const struct i2c_device_id rt5640_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
 
+static int rt5640_parse_dt(struct rt5640_priv *rt5640, struct device_node *np)
+{
+	rt5640->pdata.in1_diff = of_property_read_bool(np,
+					"realtek,in1-differential");
+	rt5640->pdata.in2_diff = of_property_read_bool(np,
+					"realtek,in2-differential");
+
+	rt5640->pdata.ldo1_en = of_get_named_gpio(np,
+					"realtek,ldo1-en-gpios", 0);
+	/*
+	 * LDO1_EN is optional (it may be statically tied on the board).
+	 * -ENOENT means that the property doesn't exist, i.e. there is no
+	 * GPIO, so is not an error. Any other error code means the property
+	 * exists, but could not be parsed.
+	 */
+	if (!gpio_is_valid(rt5640->pdata.ldo1_en) &&
+			(rt5640->pdata.ldo1_en != -ENOENT))
+		return rt5640->pdata.ldo1_en;
+
+	return 0;
+}
+
 static int rt5640_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -2011,6 +2034,24 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 				GFP_KERNEL);
 	if (NULL == rt5640)
 		return -ENOMEM;
+	i2c_set_clientdata(i2c, rt5640);
+
+	if (pdata) {
+		rt5640->pdata = *pdata;
+		/*
+		 * Translate zero'd out (default) pdata value to an invalid
+		 * GPIO ID. This makes the pdata and DT paths consistent in
+		 * terms of the value left in this field when no GPIO is
+		 * specified, but means we can't actually use GPIO 0.
+		 */
+		if (!rt5640->pdata.ldo1_en)
+			rt5640->pdata.ldo1_en = -EINVAL;
+	} else if (i2c->dev.of_node) {
+		ret = rt5640_parse_dt(rt5640, i2c->dev.of_node);
+		if (ret)
+			return ret;
+	} else
+		rt5640->pdata.ldo1_en = -EINVAL;
 
 	rt5640->regmap = devm_regmap_init_i2c(i2c, &rt5640_regmap);
 	if (IS_ERR(rt5640->regmap)) {
@@ -2020,12 +2061,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (pdata)
-		rt5640->pdata = *pdata;
-
-	i2c_set_clientdata(i2c, rt5640);
-
-	if (rt5640->pdata.ldo1_en) {
+	if (gpio_is_valid(rt5640->pdata.ldo1_en)) {
 		ret = devm_gpio_request_one(&i2c->dev, rt5640->pdata.ldo1_en,
 					    GPIOF_OUT_INIT_HIGH,
 					    "RT5640 LDO1_EN");
-- 
1.8.1.5
