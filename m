From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH 2/3] ASoC: tas6424: Add support for the standby pin
Date: Fri, 20 Apr 2018 12:04:43 +0200
Message-ID: <1524218684-19752-3-git-send-email-jjhiblot@ti.com>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: dannenberg@ti.com, afd@ti.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@ti.com>
List-Id: alsa-devel@alsa-project.org

The standby pin can be connected to a GPIO. In that case we have to drive
it to the correct values for the TAS6424 to operate properly.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 .../devicetree/bindings/sound/ti,tas6424.txt       |  1 +
 sound/soc/codecs/tas6424.c                         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
index bf2ff98..82c6d48 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas6424.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -8,6 +8,7 @@ Required properties:
 	- sound-dai-cells: must be equal to 0
 	- disable-auto-diagnostics: disable DC auto diagnostics (faster power
 	  on, but less safe as shortage won't be detected)
+	- standby-gpio: GPIO used to shut the TAS6424 down.
 
 Example:
 
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 5cee400..926259a 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -44,6 +45,7 @@ struct tas6424_data {
 	unsigned int last_fault2;
 	unsigned int last_warn;
 	bool no_auto_diags;
+	struct gpio_desc *standby_gpio;
 };
 
 /*
@@ -632,6 +634,22 @@ static int tas6424_i2c_probe(struct i2c_client *client,
 	tas6424->no_auto_diags = of_property_read_bool(dev->of_node,
 						"disable-auto-diagnostics");
 
+	/*
+	 * Get control of the standby pin and set it LOW to take the codec
+	 * out of the stand-by mode.
+	 * Note: The actual pin polarity is taken care of in the GPIO lib
+	 * according the polarity specified in the DTS.
+	 */
+	tas6424->standby_gpio = devm_gpiod_get_optional(dev, "standby",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(tas6424->standby_gpio)) {
+		if (PTR_ERR(tas6424->standby_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(dev, "failed to get standvby GPIO: %ld\n",
+			PTR_ERR(tas6424->standby_gpio));
+		tas6424->standby_gpio = NULL;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(tas6424->supplies); i++)
 		tas6424->supplies[i].supply = tas6424_supply_names[i];
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(tas6424->supplies),
@@ -691,6 +709,10 @@ static int tas6424_i2c_remove(struct i2c_client *client)
 
 	cancel_delayed_work_sync(&tas6424->fault_check_work);
 
+	/* put the codec in stand-by */
+	if (tas6424->standby_gpio)
+		gpiod_set_value_cansleep(tas6424->standby_gpio, 1);
+
 	ret = regulator_bulk_disable(ARRAY_SIZE(tas6424->supplies),
 				     tas6424->supplies);
 	if (ret < 0) {
-- 
2.7.4
