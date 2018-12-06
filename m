From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/2] ASoC: codecs: ak4104: move to GPIO
	consumer API
Date: Thu,  6 Dec 2018 13:24:57 +0100
Message-ID: <20181206122457.28269-2-daniel@zonque.org>
References: <20181206122457.28269-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 13BD1267C7A
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 13:25:06 +0100 (CET)
In-Reply-To: <20181206122457.28269-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Get the reset GPIO through the GPIO consumer API. This allows specifying the
DT property as "reset-gpios" without breaking existing DT users.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/ak4104.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 32bc545c19cf..6dec8a65eafc 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -268,8 +268,8 @@ static const struct regmap_config ak4104_regmap = {
 
 static int ak4104_spi_probe(struct spi_device *spi)
 {
-	struct device_node *np = spi->dev.of_node;
 	struct ak4104_private *ak4104;
+	struct gpio_desc *reset_gpiod;
 	unsigned int val;
 	int ret;
 
@@ -297,19 +297,11 @@ static int ak4104_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	if (np) {
-		enum of_gpio_flags flags;
-		int gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
-
-		if (gpio_is_valid(gpio)) {
-			ret = devm_gpio_request_one(&spi->dev, gpio,
-				     flags & OF_GPIO_ACTIVE_LOW ?
-					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-				     "ak4104 reset");
-			if (ret < 0)
-				return ret;
-		}
-	}
+	reset_gpiod = devm_gpiod_get_optional(&spi->dev, "reset",
+					      GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpiod) &&
+	    PTR_ERR(reset_gpiod) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	/* read the 'reserved' register - according to the datasheet, it
 	 * should contain 0x5b. Not a good way to verify the presence of
-- 
2.19.2
