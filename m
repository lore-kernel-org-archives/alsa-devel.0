From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/2] ASoC: codecs: cs4270: move to GPIO
	consumer API
Date: Thu,  6 Dec 2018 13:24:26 +0100
Message-ID: <20181206122426.28194-2-daniel@zonque.org>
References: <20181206122426.28194-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E7CF267C67
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 13:24:40 +0100 (CET)
In-Reply-To: <20181206122426.28194-1-daniel@zonque.org>
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
 sound/soc/codecs/cs4270.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 3c266eeb89bf..33d74f163bd7 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -29,8 +29,8 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 
 /*
  * The codec isn't really big-endian or little-endian, since the I2S
@@ -658,8 +658,8 @@ static const struct regmap_config cs4270_regmap = {
 static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	const struct i2c_device_id *id)
 {
-	struct device_node *np = i2c_client->dev.of_node;
 	struct cs4270_private *cs4270;
+	struct gpio_desc *reset_gpiod;
 	unsigned int val;
 	int ret, i;
 
@@ -678,20 +678,11 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	if (ret < 0)
 		return ret;
 
-	/* See if we have a way to bring the codec out of reset */
-	if (np) {
-		enum of_gpio_flags flags;
-		int gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
-
-		if (gpio_is_valid(gpio)) {
-			ret = devm_gpio_request_one(&i2c_client->dev, gpio,
-				     flags & OF_GPIO_ACTIVE_LOW ?
-					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-				     "cs4270 reset");
-			if (ret < 0)
-				return ret;
-		}
-	}
+	reset_gpiod = devm_gpiod_get_optional(&i2c_client->dev, "reset",
+					      GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpiod) &&
+	    PTR_ERR(reset_gpiod) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	cs4270->regmap = devm_regmap_init_i2c(i2c_client, &cs4270_regmap);
 	if (IS_ERR(cs4270->regmap))
-- 
2.19.2
