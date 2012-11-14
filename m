From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: ak4104: add reset line property to
	DT bindings
Date: Wed, 14 Nov 2012 18:28:39 +0800
Message-ID: <1352888919-25270-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id CB2D1265261
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 11:28:58 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This device doesn't have a pdata definition for legacy boards, and
unless anyone need to control the reset GPIO, it's not worth adding one.
So this feature is only available to DT users for now.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/sound/ak4104.txt |  5 +++++
 sound/soc/codecs/ak4104.c                          | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ak4104.txt b/Documentation/devicetree/bindings/sound/ak4104.txt
index 1f8e506..b902ee3 100644
--- a/Documentation/devicetree/bindings/sound/ak4104.txt
+++ b/Documentation/devicetree/bindings/sound/ak4104.txt
@@ -8,6 +8,11 @@ Required properties:
 
   - reg : The chip select number on the SPI bus
 
+Optional properties:
+
+  - reset-gpio : a GPIO spec for the reset pin. If specified, it will be
+		 deasserted before communication to the device starts.
+
 Example:
 
 spdif: ak4104@0 {
diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index d4d4858..eec086b 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -15,6 +15,8 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <linux/spi/spi.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <sound/asoundef.h>
 
 /* AK4104 registers addresses */
@@ -204,6 +206,7 @@ static const struct regmap_config ak4104_regmap = {
 
 static int ak4104_spi_probe(struct spi_device *spi)
 {
+	struct device_node *np = spi->dev.of_node;
 	struct ak4104_private *ak4104;
 	unsigned int val;
 	int ret;
@@ -225,6 +228,20 @@ static int ak4104_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	if (np) {
+		enum of_gpio_flags flags;
+		int gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
+
+		if (gpio_is_valid(gpio)) {
+			ret = devm_gpio_request_one(&spi->dev, gpio,
+				     flags & OF_GPIO_ACTIVE_LOW ?
+					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
+				     "ak4104 reset");
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	/* read the 'reserved' register - according to the datasheet, it
 	 * should contain 0x5b. Not a good way to verify the presence of
 	 * the device, but there is no hardware ID register. */
-- 
1.7.11.7
