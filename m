From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 179/182] ASoC: wm8962: use gpiochip data pointer
Date: Wed,  9 Dec 2015 14:51:47 +0100
Message-ID: <1449669107-7264-1-git-send-email-linus.walleij@linaro.org>
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
 sound/soc/codecs/wm8962.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b563d6746ac4..1577d2e62e76 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -18,7 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/gcd.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/pm_runtime.h>
@@ -3308,14 +3308,9 @@ static void wm8962_set_gpio_mode(struct wm8962_priv *wm8962, int gpio)
 }
 
 #ifdef CONFIG_GPIOLIB
-static inline struct wm8962_priv *gpio_to_wm8962(struct gpio_chip *chip)
-{
-	return container_of(chip, struct wm8962_priv, gpio_chip);
-}
-
 static int wm8962_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
-	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
+	struct wm8962_priv *wm8962 = gpiochip_get_data(chip);
 
 	/* The WM8962 GPIOs aren't linearly numbered.  For simplicity
 	 * we export linear numbers and error out if the unsupported
@@ -3338,7 +3333,7 @@ static int wm8962_gpio_request(struct gpio_chip *chip, unsigned offset)
 
 static void wm8962_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
+	struct wm8962_priv *wm8962 = gpiochip_get_data(chip);
 	struct snd_soc_codec *codec = wm8962->codec;
 
 	snd_soc_update_bits(codec, WM8962_GPIO_BASE + offset,
@@ -3348,7 +3343,7 @@ static void wm8962_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 static int wm8962_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
-	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
+	struct wm8962_priv *wm8962 = gpiochip_get_data(chip);
 	struct snd_soc_codec *codec = wm8962->codec;
 	int ret, val;
 
@@ -3387,7 +3382,7 @@ static void wm8962_init_gpio(struct snd_soc_codec *codec)
 	else
 		wm8962->gpio_chip.base = -1;
 
-	ret = gpiochip_add(&wm8962->gpio_chip);
+	ret = gpiochip_add_data(&wm8962->gpio_chip, wm8962);
 	if (ret != 0)
 		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
 }
-- 
2.4.3

