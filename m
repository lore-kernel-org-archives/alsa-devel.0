From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/4] ASoC: tlv320aic32x4: DT support
Date: Thu, 16 Jan 2014 16:30:26 +0100
Message-ID: <1389886227-876-4-git-send-email-mpa@pengutronix.de>
References: <1389886227-876-1-git-send-email-mpa@pengutronix.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389886227-876-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add DT support for this codec. The bindings differ a bit from the aic3x
codec bindings, so I created a new binding documentation. The difference
is especially a "ti,ldo-enable" property, which enables the internal
LDOs.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 .../devicetree/bindings/sound/tlv320aic32x4.txt    | 23 +++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.c                   | 30 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
new file mode 100644
index 0000000..5c8fb4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -0,0 +1,23 @@
+Texas Instruments - tlv320aic32x4 Codec module
+
+The tlv320aic32x4 serial control bus communicates through I2C protocols
+
+Required properties:
+ - compatible: Should be "ti,tlv320aic32x4"
+ - reg: I2C slave address
+
+Optional properties:
+ - ti,ldo-enable: Bool, has to be set when the codec is powered only through the
+   LDOIN pin.
+ - gpio-reset - gpio pin number used for codec reset
+
+
+Example:
+
+codec: tlv320aic32x4@18 {
+	compatible = "ti,tlv320aic32x4";
+	reg = <0x18>;
+	clocks = <&clks 201>;
+	clock-names = "mclk";
+	ti,ldo-enable;
+};
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 1c9f1d8..840f529 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/i2c.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
@@ -669,11 +670,27 @@ static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
 	.num_dapm_routes = ARRAY_SIZE(aic32x4_dapm_routes),
 };
 
+static int aic32x4_parse_dt(struct aic32x4_priv *aic32x4,
+		struct device_node *np)
+{
+	aic32x4->swapdacs = false;
+	aic32x4->micpga_routing = 0;
+	aic32x4->rstn_gpio = of_get_named_gpio(np, "gpio-reset", 0);
+
+	if (of_property_read_bool(np, "ti,ldo-enable"))
+		aic32x4->power_cfg = AIC32X4_PWR_AIC32X4_LDO_ENABLE;
+	else
+		aic32x4->power_cfg = 0;
+
+	return 0;
+}
+
 static int aic32x4_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
 	struct aic32x4_pdata *pdata = i2c->dev.platform_data;
 	struct aic32x4_priv *aic32x4;
+	struct device_node *np = i2c->dev.of_node;
 	int ret;
 
 	aic32x4 = devm_kzalloc(&i2c->dev, sizeof(struct aic32x4_priv),
@@ -692,6 +709,12 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->swapdacs = pdata->swapdacs;
 		aic32x4->micpga_routing = pdata->micpga_routing;
 		aic32x4->rstn_gpio = pdata->rstn_gpio;
+	} else if (np) {
+		ret = aic32x4_parse_dt(aic32x4, np);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to parse DT node\n");
+			return ret;
+		}
 	} else {
 		aic32x4->power_cfg = 0;
 		aic32x4->swapdacs = false;
@@ -723,10 +746,17 @@ static const struct i2c_device_id aic32x4_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);
 
+static const struct of_device_id aic32x4_of_id[] = {
+	{ .compatible = "ti,tlv320aic32x4", },
+	{ /* senitel */ }
+};
+MODULE_DEVICE_TABLE(of, aic32x4_of_id);
+
 static struct i2c_driver aic32x4_i2c_driver = {
 	.driver = {
 		.name = "tlv320aic32x4",
 		.owner = THIS_MODULE,
+		.of_match_table = aic32x4_of_id,
 	},
 	.probe =    aic32x4_i2c_probe,
 	.remove =   aic32x4_i2c_remove,
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
