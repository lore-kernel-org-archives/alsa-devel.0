From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 176/182] ASoC: rt5677: use gpiochip data pointer
Date: Wed,  9 Dec 2015 14:51:19 +0100
Message-ID: <1449669079-7119-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This makes the driver use the data pointer added to the gpio_chip
to store a pointer to the state container instead of relying on
container_of().

Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Liam/Mark: please ACK this so I can merge it into the GPIO tree.
---
 sound/soc/codecs/rt5677.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 1f590b5a6718..89dda8962c7c 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4500,14 +4500,9 @@ static int rt5677_set_bias_level(struct snd_soc_codec *codec,
 }
 
 #ifdef CONFIG_GPIOLIB
-static inline struct rt5677_priv *gpio_to_rt5677(struct gpio_chip *chip)
-{
-	return container_of(chip, struct rt5677_priv, gpio_chip);
-}
-
 static void rt5677_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	struct rt5677_priv *rt5677 = gpiochip_get_data(chip);
 
 	switch (offset) {
 	case RT5677_GPIO1 ... RT5677_GPIO5:
@@ -4528,7 +4523,7 @@ static void rt5677_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 static int rt5677_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
-	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	struct rt5677_priv *rt5677 = gpiochip_get_data(chip);
 
 	switch (offset) {
 	case RT5677_GPIO1 ... RT5677_GPIO5:
@@ -4552,7 +4547,7 @@ static int rt5677_gpio_direction_out(struct gpio_chip *chip,
 
 static int rt5677_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	struct rt5677_priv *rt5677 = gpiochip_get_data(chip);
 	int value, ret;
 
 	ret = regmap_read(rt5677->regmap, RT5677_GPIO_ST, &value);
@@ -4564,7 +4559,7 @@ static int rt5677_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 static int rt5677_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 {
-	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	struct rt5677_priv *rt5677 = gpiochip_get_data(chip);
 
 	switch (offset) {
 	case RT5677_GPIO1 ... RT5677_GPIO5:
@@ -4618,7 +4613,7 @@ static void rt5677_gpio_config(struct rt5677_priv *rt5677, unsigned offset,
 
 static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	struct rt5677_priv *rt5677 = gpiochip_get_data(chip);
 	struct regmap_irq_chip_data *data = rt5677->irq_data;
 	int irq;
 
@@ -4677,7 +4672,7 @@ static void rt5677_init_gpio(struct i2c_client *i2c)
 	rt5677->gpio_chip.parent = &i2c->dev;
 	rt5677->gpio_chip.base = -1;
 
-	ret = gpiochip_add(&rt5677->gpio_chip);
+	ret = gpiochip_add_data(&rt5677->gpio_chip, rt5677);
 	if (ret != 0)
 		dev_err(&i2c->dev, "Failed to add GPIOs: %d\n", ret);
 }
-- 
2.4.3

