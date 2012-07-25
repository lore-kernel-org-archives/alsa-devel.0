From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 2/2] ALSA: ASoC: Add reset-gpio DT property
	to cs4270 driver
Date: Wed, 25 Jul 2012 15:28:35 +0200
Message-ID: <1343222915-26108-2-git-send-email-zonque@gmail.com>
References: <1343222915-26108-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id CB521265333
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 15:28:39 +0200 (CEST)
In-Reply-To: <1343222915-26108-1-git-send-email-zonque@gmail.com>
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
Cc: Timur Tabi <timur@freescale.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

In the process of moving over from static board files to the device
tree, reset pins of peripheral reset pins should be handled by their
corresponding drivers.

Add a reset-gpio DT property to the cs4270 driver, and de-assert it
before probing the chip. The logic could be augmented some day to
re-assert it when codec is put to suspend.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Timur Tabi <timur@freescale.com>
---
 v2: cleanups as requested by Timur
 v3: return error code in case devm_gpio_request_one() fails

 Documentation/devicetree/bindings/sound/cs4270.txt |    5 +++++
 sound/soc/codecs/cs4270.c                          |   17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs4270.txt b/Documentation/devicetree/bindings/sound/cs4270.txt
index 7f0bfd8..6b222f9 100644
--- a/Documentation/devicetree/bindings/sound/cs4270.txt
+++ b/Documentation/devicetree/bindings/sound/cs4270.txt
@@ -8,6 +8,11 @@ Required properties:
 
   - reg : the I2C address of the device for I2C
 
+Optional properties:
+
+  - reset-gpio : a GPIO spec for the reset pin. If specified, it will be
+		 deasserted before communication to the codec starts.
+
 Example:
 
 codec: cs4270@48 {
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 4b71b01..fd11bb6 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 /*
  * The codec isn't really big-endian or little-endian, since the I2S
@@ -660,9 +661,25 @@ MODULE_DEVICE_TABLE(of, cs4270_of_match);
 static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	const struct i2c_device_id *id)
 {
+	struct device_node *np = i2c_client->dev.of_node;
 	struct cs4270_private *cs4270;
 	int ret;
 
+	/* See if we have a way to bring the codec out of reset */
+	if (np) {
+		enum of_gpio_flags flags;
+		int gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
+
+		if (gpio_is_valid(gpio)) {
+			ret = devm_gpio_request_one(&i2c_client->dev, gpio,
+				     flags & OF_GPIO_ACTIVE_LOW ?
+					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
+				     "cs4270 reset");
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	/* Verify that we have a CS4270 */
 
 	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
-- 
1.7.10.4
