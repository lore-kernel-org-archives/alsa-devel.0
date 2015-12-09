From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 177/182] ASoC: wm5100: use gpiochip data pointer
Date: Wed,  9 Dec 2015 14:51:29 +0100
Message-ID: <1449669089-7167-1-git-send-email-linus.walleij@linaro.org>
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
 sound/soc/codecs/wm5100.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 171a23ddd15d..512a9d25fe6f 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/pm.h>
 #include <linux/gcd.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>
@@ -2236,14 +2237,9 @@ static irqreturn_t wm5100_edge_irq(int irq, void *data)
 }
 
 #ifdef CONFIG_GPIOLIB
-static inline struct wm5100_priv *gpio_to_wm5100(struct gpio_chip *chip)
-{
-	return container_of(chip, struct wm5100_priv, gpio_chip);
-}
-
 static void wm5100_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
+	struct wm5100_priv *wm5100 = gpiochip_get_data(chip);
 
 	regmap_update_bits(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset,
 			   WM5100_GP1_LVL, !!value << WM5100_GP1_LVL_SHIFT);
@@ -2252,7 +2248,7 @@ static void wm5100_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 static int wm5100_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
-	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
+	struct wm5100_priv *wm5100 = gpiochip_get_data(chip);
 	int val, ret;
 
 	val = (1 << WM5100_GP1_FN_SHIFT) | (!!value << WM5100_GP1_LVL_SHIFT);
@@ -2268,7 +2264,7 @@ static int wm5100_gpio_direction_out(struct gpio_chip *chip,
 
 static int wm5100_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
+	struct wm5100_priv *wm5100 = gpiochip_get_data(chip);
 	unsigned int reg;
 	int ret;
 
@@ -2281,7 +2277,7 @@ static int wm5100_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 static int wm5100_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 {
-	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
+	struct wm5100_priv *wm5100 = gpiochip_get_data(chip);
 
 	return regmap_update_bits(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset,
 				  WM5100_GP1_FN_MASK | WM5100_GP1_DIR,
@@ -2313,7 +2309,7 @@ static void wm5100_init_gpio(struct i2c_client *i2c)
 	else
 		wm5100->gpio_chip.base = -1;
 
-	ret = gpiochip_add(&wm5100->gpio_chip);
+	ret = gpiochip_add_data(&wm5100->gpio_chip, wm5100);
 	if (ret != 0)
 		dev_err(&i2c->dev, "Failed to add GPIOs: %d\n", ret);
 }
-- 
2.4.3

