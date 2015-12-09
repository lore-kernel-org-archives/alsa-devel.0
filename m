From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 178/182] ASoC: wm8903: use gpiochip data pointer
Date: Wed,  9 Dec 2015 14:51:37 +0100
Message-ID: <1449669097-7214-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This makes the driver use the data pointer added to the gpio_chip
to store a pointer to the state container instead of relying on
container_of().

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Liam/Mark: please ACK this so I can merge it into the GPIO tree.
---
 sound/soc/codecs/wm8903.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 2512def0d349..d1315ce5f0a9 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -20,7 +20,7 @@
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -1766,11 +1766,6 @@ static int wm8903_resume(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_GPIOLIB
-static inline struct wm8903_priv *gpio_to_wm8903(struct gpio_chip *chip)
-{
-	return container_of(chip, struct wm8903_priv, gpio_chip);
-}
-
 static int wm8903_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	if (offset >= WM8903_NUM_GPIO)
@@ -1781,7 +1776,7 @@ static int wm8903_gpio_request(struct gpio_chip *chip, unsigned offset)
 
 static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 {
-	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	struct wm8903_priv *wm8903 = gpiochip_get_data(chip);
 	unsigned int mask, val;
 	int ret;
 
@@ -1799,7 +1794,7 @@ static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 
 static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	struct wm8903_priv *wm8903 = gpiochip_get_data(chip);
 	unsigned int reg;
 
 	regmap_read(wm8903->regmap, WM8903_GPIO_CONTROL_1 + offset, &reg);
@@ -1810,7 +1805,7 @@ static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
 static int wm8903_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
-	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	struct wm8903_priv *wm8903 = gpiochip_get_data(chip);
 	unsigned int mask, val;
 	int ret;
 
@@ -1828,7 +1823,7 @@ static int wm8903_gpio_direction_out(struct gpio_chip *chip,
 
 static void wm8903_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	struct wm8903_priv *wm8903 = gpiochip_get_data(chip);
 
 	regmap_update_bits(wm8903->regmap, WM8903_GPIO_CONTROL_1 + offset,
 			   WM8903_GP1_LVL_MASK,
@@ -1860,7 +1855,7 @@ static void wm8903_init_gpio(struct wm8903_priv *wm8903)
 	else
 		wm8903->gpio_chip.base = -1;
 
-	ret = gpiochip_add(&wm8903->gpio_chip);
+	ret = gpiochip_add_data(&wm8903->gpio_chip, wm8903);
 	if (ret != 0)
 		dev_err(wm8903->dev, "Failed to add GPIOs: %d\n", ret);
 }
-- 
2.4.3

