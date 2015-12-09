From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 180/182] ASoC: wm8996: use gpiochip data pointer
Date: Wed,  9 Dec 2015 14:51:54 +0100
Message-ID: <1449669114-7317-1-git-send-email-linus.walleij@linaro.org>
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
 sound/soc/codecs/wm8996.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 8d7d6c01a2f7..f9656df9dccc 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/gcd.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -2139,14 +2140,9 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 }
 
 #ifdef CONFIG_GPIOLIB
-static inline struct wm8996_priv *gpio_to_wm8996(struct gpio_chip *chip)
-{
-	return container_of(chip, struct wm8996_priv, gpio_chip);
-}
-
 static void wm8996_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
+	struct wm8996_priv *wm8996 = gpiochip_get_data(chip);
 
 	regmap_update_bits(wm8996->regmap, WM8996_GPIO_1 + offset,
 			   WM8996_GP1_LVL, !!value << WM8996_GP1_LVL_SHIFT);
@@ -2155,7 +2151,7 @@ static void wm8996_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 static int wm8996_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
-	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
+	struct wm8996_priv *wm8996 = gpiochip_get_data(chip);
 	int val;
 
 	val = (1 << WM8996_GP1_FN_SHIFT) | (!!value << WM8996_GP1_LVL_SHIFT);
@@ -2167,7 +2163,7 @@ static int wm8996_gpio_direction_out(struct gpio_chip *chip,
 
 static int wm8996_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
+	struct wm8996_priv *wm8996 = gpiochip_get_data(chip);
 	unsigned int reg;
 	int ret;
 
@@ -2180,7 +2176,7 @@ static int wm8996_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 static int wm8996_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 {
-	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
+	struct wm8996_priv *wm8996 = gpiochip_get_data(chip);
 
 	return regmap_update_bits(wm8996->regmap, WM8996_GPIO_1 + offset,
 				  WM8996_GP1_FN_MASK | WM8996_GP1_DIR,
@@ -2211,7 +2207,7 @@ static void wm8996_init_gpio(struct wm8996_priv *wm8996)
 	else
 		wm8996->gpio_chip.base = -1;
 
-	ret = gpiochip_add(&wm8996->gpio_chip);
+	ret = gpiochip_add_data(&wm8996->gpio_chip, wm8996);
 	if (ret != 0)
 		dev_err(wm8996->dev, "Failed to add GPIOs: %d\n", ret);
 }
-- 
2.4.3

