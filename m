From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH v2 3/3] ASoC: cs42l73: Add Device Tree support
	for CS42L73
Date: Fri, 18 Oct 2013 14:30:01 -0500
Message-ID: <1382124601-3317-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CFEE261AD8
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 21:27:58 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for device tree for the CS42L73 CODEC

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 .../devicetree/bindings/sound/cs42l73.txt          | 22 ++++++++++++++++
 sound/soc/codecs/cs42l73.c                         | 29 ++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l73.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l73.txt b/Documentation/devicetree/bindings/sound/cs42l73.txt
new file mode 100644
index 0000000..80ae910
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l73.txt
@@ -0,0 +1,22 @@
+CS42L73 audio CODEC
+
+Required properties:
+
+  - compatible : "cirrus,cs42l73"
+
+  - reg : the I2C address of the device for I2C
+
+Optional properties:
+
+  - reset_gpio : a GPIO spec for the reset pin.
+  - chgfreq    : Charge Pump Frequency values 0x00-0x0F
+
+
+Example:
+
+codec: cs42l73@4a {
+	compatible = "cirrus,cs42l73";
+	reg = <0x4a>;
+	reset_gpio = <&gpio 10 0>;
+	chgfreq = <0x05>;
+};
\ No newline at end of file
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 89efc3c..549d5d6 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -17,7 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -1416,6 +1416,7 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	int ret;
 	unsigned int devid = 0;
 	unsigned int reg;
+	u32 val32;
 
 	cs42l73 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l73_private),
 			       GFP_KERNEL);
@@ -1431,8 +1432,25 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	if (pdata)
+	if (pdata) {
 		cs42l73->pdata = *pdata;
+	} else {
+		pdata = devm_kzalloc(&i2c_client->dev,
+				     sizeof(struct cs42l73_platform_data),
+				GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&i2c_client->dev, "could not allocate pdata\n");
+			return -ENOMEM;
+		}
+		if (i2c_client->dev.of_node) {
+			if (of_property_read_u32(i2c_client->dev.of_node,
+				"chgfreq", &val32) >= 0)
+				pdata->chgfreq = val32;
+		}
+		pdata->reset_gpio = of_get_named_gpio(i2c_client->dev.of_node,
+						"reset-gpio", 0);
+		cs42l73->pdata = *pdata;
+	}
 
 	i2c_set_clientdata(i2c_client, cs42l73);
 
@@ -1493,6 +1511,12 @@ static int cs42l73_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id cs42l73_of_match[] = {
+	{ .compatible = "cirrus,cs42l73", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cs42l73_of_match);
+
 static const struct i2c_device_id cs42l73_id[] = {
 	{"cs42l73", 0},
 	{}
@@ -1504,6 +1528,7 @@ static struct i2c_driver cs42l73_i2c_driver = {
 	.driver = {
 		   .name = "cs42l73",
 		   .owner = THIS_MODULE,
+		   .of_match_table = cs42l73_of_match,
 		   },
 	.id_table = cs42l73_id,
 	.probe = cs42l73_i2c_probe,
-- 
1.8.4.rc3
