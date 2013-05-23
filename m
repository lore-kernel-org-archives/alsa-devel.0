From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] ASoC: codecs: adau1701: add DT bindings
Date: Thu, 23 May 2013 15:46:05 +0200
Message-ID: <1369316765-3843-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CE73261A2A
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 15:45:50 +0200 (CEST)
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
Cc: broonie@kernel.org, lars@metafoo.de, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Apart from pure matching, the bindings also support setting the the
reset gpio line.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
Lars,

thanks for the quick review. Here's v2 of that patch.


 .../devicetree/bindings/sound/adi,adau1701.txt     | 23 ++++++++++++++
 sound/soc/codecs/adau1701.c                        | 35 +++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1701.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
new file mode 100644
index 0000000..3afeda7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
@@ -0,0 +1,23 @@
+Analog Devices ADAU1701
+
+Required properties:
+
+ - compatible:		Should contain "adi,adau1701"
+ - reg:			The i2c address. Value depends on the state of ADDR0
+			and ADDR1, as wired in hardware.
+
+Optional properties:
+
+ - reset-gpio: 		A GPIO spec to define which pin is connected to the
+			chip's !RESET pin. If specified, the driver will
+			assert a hardware reset at probe time.
+
+Examples:
+
+	i2c_bus {
+		adau1701@34 {
+			compatible = "adi,adau1701";
+			reg = <0x34>;
+			reset-gpio = <&gpio 23 0>;
+		};
+	};
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 95e1677..3fc1763 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -13,6 +13,9 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -452,6 +455,14 @@ static struct snd_soc_dai_driver adau1701_dai = {
 	.symmetric_rates = 1,
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id adau1701_dt_ids[] = {
+	{ .compatible = "adi,adau1701", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adau1701_dt_ids);
+#endif
+
 static int adau1701_probe(struct snd_soc_codec *codec)
 {
 	int ret;
@@ -494,12 +505,33 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
 	struct adau1701 *adau1701;
+	struct device *dev = &client->dev;
+	int gpio_nreset = -EINVAL;
 	int ret;
 
-	adau1701 = devm_kzalloc(&client->dev, sizeof(*adau1701), GFP_KERNEL);
+	adau1701 = devm_kzalloc(dev, sizeof(*adau1701), GFP_KERNEL);
 	if (!adau1701)
 		return -ENOMEM;
 
+	if (dev->of_node) {
+		gpio_nreset = of_get_named_gpio(dev->of_node, "reset-gpio", 0);
+		if (gpio_nreset < 0 && gpio_nreset != -ENOENT)
+			return gpio_nreset;
+	}
+
+	if (gpio_is_valid(gpio_nreset)) {
+		ret = devm_gpio_request_one(dev, gpio_nreset, GPIOF_OUT_INIT_LOW,
+					    "ADAU1701 Reset");
+		if (ret < 0)
+			return ret;
+
+		/* minimum reset time is 20ns */
+		udelay(1);
+		gpio_set_value(gpio_nreset, 1);
+		/* power-up time may be as long as 85ms */
+		mdelay(85);
+	}
+
 	i2c_set_clientdata(client, adau1701);
 	ret = snd_soc_register_codec(&client->dev, &adau1701_codec_drv,
 			&adau1701_dai, 1);
@@ -522,6 +554,7 @@ static struct i2c_driver adau1701_i2c_driver = {
 	.driver = {
 		.name	= "adau1701",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(adau1701_dt_ids),
 	},
 	.probe		= adau1701_i2c_probe,
 	.remove		= adau1701_i2c_remove,
-- 
1.8.1.4
