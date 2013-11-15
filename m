From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 1/2] ASoC: Add devicetree support for CS42L52
Date: Fri, 15 Nov 2013 09:35:33 -0600
Message-ID: <1384529734-9415-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds device tree support for the CS42L52 Codec

v3 Adds better descriptors for platform data.
Change mic differential setting to boolean
Change chgfreq to chgfreq-divisor
Add vendor cirrus to of properties

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 sound/soc/codecs/cs42l52.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index e68450e..ed3c20f 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -17,7 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -1193,6 +1193,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	int ret;
 	unsigned int devid = 0;
 	unsigned int reg;
+	u32 val32;
 
 	cs42l52 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l52_private),
 			       GFP_KERNEL);
@@ -1206,9 +1207,39 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
 		return ret;
 	}
-
-	if (pdata)
+	if (pdata) {
+		cs42l52->pdata = *pdata;
+	} else {
+		pdata = devm_kzalloc(&i2c_client->dev,
+				     sizeof(struct cs42l52_platform_data),
+				GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&i2c_client->dev, "could not allocate pdata\n");
+			return -ENOMEM;
+		}
+		if (i2c_client->dev.of_node) {
+			if (of_property_read_bool(i2c_client->dev.of_node,
+				"cirrus,mica-differential-cfg"))
+				pdata->mica_diff_cfg = true;
+
+			if (of_property_read_bool(i2c_client->dev.of_node,
+				"cirrus,micb-differential-cfg"))
+				pdata->micb_diff_cfg = true;
+
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"cirrus,micbias-lvl", &val32) >= 0)
+				pdata->micbias_lvl = val32;
+
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"cirrus,chgfreq-divisor", &val32) >= 0)
+				pdata->chgfreq_divisor = val32;
+
+			pdata->reset_gpio =
+				of_get_named_gpio(i2c_client->dev.of_node,
+						"cirrus,reset-gpio", 0);
+		}
 		cs42l52->pdata = *pdata;
+	}
 
 	if (cs42l52->pdata.reset_gpio) {
 		ret = gpio_request_one(cs42l52->pdata.reset_gpio,
@@ -1280,6 +1311,13 @@ static int cs42l52_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id cs42l52_of_match[] = {
+	{ .compatible = "cirrus,cs42l52", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cs42l52_of_match);
+
+
 static const struct i2c_device_id cs42l52_id[] = {
 	{ "cs42l52", 0 },
 	{ }
@@ -1290,6 +1328,7 @@ static struct i2c_driver cs42l52_i2c_driver = {
 	.driver = {
 		.name = "cs42l52",
 		.owner = THIS_MODULE,
+		.of_match_table = cs42l52_of_match,
 	},
 	.id_table = cs42l52_id,
 	.probe =    cs42l52_i2c_probe,
-- 
1.8.4.3


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
