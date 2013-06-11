From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] ASoC: rt5640: add device tree support
Date: Tue, 11 Jun 2013 14:40:40 -0600
Message-ID: <1370983240-4976-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, flove-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Modify the RT5640 driver to parse platform data from device tree. Write
a DT binding document to describe those properties.

Slight re-ordering of rt5640_i2c_probe() to better fit the DT parsing.

Since ldo1_en is optional, guard usage of it with gpio_is_valid(), rather
than open-coding an if (gpio) check.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Mark, If the underlying rt5640 driver is reposted, this might need a new
version to rebase it, but otherwise I believe should be complete.

Bard, FYI you can find this patch and the DT changes for Dalmore at:
git://nv-tegra.nvidia.com/user/swarren/linux-2.6 linux-next_common

 Documentation/devicetree/bindings/sound/rt5640.txt | 30 ++++++++++++++++
 sound/soc/codecs/rt5640.c                          | 40 ++++++++++++++++++----
 2 files changed, 64 insertions(+), 6 deletions(-)
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
index 288c17c..f7e73d2 100644
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
@@ -2011,6 +2034,16 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 				GFP_KERNEL);
 	if (NULL == rt5640)
 		return -ENOMEM;
+	i2c_set_clientdata(i2c, rt5640);
+
+	if (pdata)
+		rt5640->pdata = *pdata;
+	else if (i2c->dev.of_node) {
+		ret = rt5640_parse_dt(rt5640, i2c->dev.of_node);
+		if (ret)
+			return ret;
+	} else
+		rt5640->pdata.ldo1_en = -1;
 
 	rt5640->regmap = devm_regmap_init_i2c(i2c, &rt5640_regmap);
 	if (IS_ERR(rt5640->regmap)) {
@@ -2020,12 +2053,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
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
