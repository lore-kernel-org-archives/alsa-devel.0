From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 181/182] ASoC: ac97: use gpiochip data pointer
Date: Wed,  9 Dec 2015 14:52:01 +0100
Message-ID: <1449669121-7366-1-git-send-email-linus.walleij@linaro.org>
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
 sound/soc/soc-ac97.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index a2012652f212..eaec7177eab2 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -59,8 +59,7 @@ static void soc_ac97_device_release(struct device *dev)
 #ifdef CONFIG_GPIOLIB
 static inline struct snd_soc_codec *gpio_to_codec(struct gpio_chip *chip)
 {
-	struct snd_ac97_gpio_priv *gpio_priv =
-		container_of(chip, struct snd_ac97_gpio_priv, gpio_chip);
+	struct snd_ac97_gpio_priv *gpio_priv = gpiochip_get_data(chip);
 
 	return gpio_priv->codec;
 }
@@ -98,8 +97,7 @@ static int snd_soc_ac97_gpio_get(struct gpio_chip *chip, unsigned offset)
 static void snd_soc_ac97_gpio_set(struct gpio_chip *chip, unsigned offset,
 				  int value)
 {
-	struct snd_ac97_gpio_priv *gpio_priv =
-		container_of(chip, struct snd_ac97_gpio_priv, gpio_chip);
+	struct snd_ac97_gpio_priv *gpio_priv = gpiochip_get_data(chip);
 	struct snd_soc_codec *codec = gpio_to_codec(chip);
 
 	gpio_priv->gpios_set &= ~(1 << offset);
@@ -145,7 +143,7 @@ static int snd_soc_ac97_init_gpio(struct snd_ac97 *ac97,
 	gpio_priv->gpio_chip.parent = codec->dev;
 	gpio_priv->gpio_chip.base = -1;
 
-	ret = gpiochip_add(&gpio_priv->gpio_chip);
+	ret = gpiochip_add_data(&gpio_priv->gpio_chip, gpio_priv);
 	if (ret != 0)
 		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
 	return ret;
-- 
2.4.3

