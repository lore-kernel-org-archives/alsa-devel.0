From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v3 1/3] ASoC: tas6424: Add support for the
	standby pin
Date: Mon, 30 Apr 2018 10:30:16 +0200
Message-ID: <1525077018-15863-2-git-send-email-jjhiblot@ti.com>
References: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 5426C266F0F
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 10:30:35 +0200 (CEST)
In-Reply-To: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, afd@ti.com, Jean-Jacques Hiblot <jjhiblot@ti.com>, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org

The standby pin can be connected to a GPIO. In that case we have to drive
it to the correct values for the TAS6424 to operate properly.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/ti,tas6424.txt       |  1 +
 sound/soc/codecs/tas6424.c                         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
index 1c4ada0..df71e41 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas6424.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -6,6 +6,7 @@ Required properties:
 	- compatible: "ti,tas6424" - TAS6424
 	- reg: I2C slave address
 	- sound-dai-cells: must be equal to 0
+	- standby-gpios: GPIO used to shut the TAS6424 down.
 
 Example:
 
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 4f3a16c..5abb17f 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -43,6 +44,7 @@ struct tas6424_data {
 	unsigned int last_fault1;
 	unsigned int last_fault2;
 	unsigned int last_warn;
+	struct gpio_desc *standby_gpio;
 };
 
 /*
@@ -627,6 +629,22 @@ static int tas6424_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
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
+		dev_info(dev, "failed to get standby GPIO: %ld\n",
+			PTR_ERR(tas6424->standby_gpio));
+		tas6424->standby_gpio = NULL;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(tas6424->supplies); i++)
 		tas6424->supplies[i].supply = tas6424_supply_names[i];
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(tas6424->supplies),
@@ -671,6 +689,10 @@ static int tas6424_i2c_remove(struct i2c_client *client)
 
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
