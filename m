From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/2] ASoC: cs42l52: Add DeviceTree Support for CS42L52
Date: Wed, 13 Nov 2013 09:44:33 -0600
Message-ID: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds device tree support for the CS42L52 CODEC

v2 changes dt bindings to use '-' instead of '_'.
reset_gpio = reset-gpio. Pdata variables are not changed.

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 sound/soc/codecs/cs42l52.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 8b427c9..ea55ee5 100644
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
@@ -1174,6 +1174,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	struct cs42l52_private *cs42l52;
 	struct cs42l52_platform_data *pdata = dev_get_platdata(&i2c_client->dev);
 	int ret;
+	u32 val32;
 	unsigned int devid = 0;
 	unsigned int reg;
 
@@ -1190,8 +1191,47 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	if (pdata)
+	if (pdata) {
 		cs42l52->pdata = *pdata;
+	} else {
+		pdata = devm_kzalloc(&i2c_client->dev,
+				     sizeof(struct cs42l52_platform_data),
+				GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&i2c_client->dev, "could not allocate pdata\n");
+			return -ENOMEM;
+		}
+		if (i2c_client->dev.of_node) {
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"mica-cfg", &val32) >= 0)
+				pdata->mica_cfg = val32;
+
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"micb-cfg", &val32) >= 0)
+				pdata->micb_cfg = val32;
+
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"mica-sel", &val32) >= 0)
+				pdata->mica_sel = val32;
+
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"micb-sel", &val32) >= 0)
+				pdata->micb_sel = val32;
+
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"micbias-lvl", &val32) >= 0)
+				pdata->micbias_lvl = val32;
+
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"chgfreq", &val32) >= 0)
+				pdata->chgfreq = val32;
+
+			pdata->reset_gpio =
+				of_get_named_gpio(i2c_client->dev.of_node,
+						"reset-gpio", 0);
+		}
+		cs42l52->pdata = *pdata;
+	}
 
 	if (cs42l52->pdata.reset_gpio) {
 		ret = gpio_request_one(cs42l52->pdata.reset_gpio,
@@ -1274,6 +1314,12 @@ static int cs42l52_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id cs42l52_of_match[] = {
+	{ .compatible = "cirrus,cs42l52", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cs42l52_of_match);
+
 static const struct i2c_device_id cs42l52_id[] = {
 	{ "cs42l52", 0 },
 	{ }
@@ -1284,6 +1330,7 @@ static struct i2c_driver cs42l52_i2c_driver = {
 	.driver = {
 		.name = "cs42l52",
 		.owner = THIS_MODULE,
+		.of_match_table = cs42l52_of_match,
 	},
 	.id_table = cs42l52_id,
 	.probe =    cs42l52_i2c_probe,
-- 
1.8.4.rc3


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
