From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 52/54] sound: soc: wm8903: Be sure to clamp return value
Date: Tue, 22 Dec 2015 15:50:49 +0100
Message-ID: <1450795849-28642-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

As we want gpio_chip .get() calls to be able to return negative
error codes and propagate to drivers, we need to go over all
drivers and make sure their return values are clamped to [0,1].
We do this by using the ret = !!(val) design pattern.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: as mentioned in 00/54: either apply this directly
or ACK it and I will take it into the GPIO tree.
---
 sound/soc/codecs/wm8903.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 2512def0d349..a82b8bc2cfc0 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1804,7 +1804,7 @@ static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 	regmap_read(wm8903->regmap, WM8903_GPIO_CONTROL_1 + offset, &reg);
 
-	return (reg & WM8903_GP1_LVL_MASK) >> WM8903_GP1_LVL_SHIFT;
+	return !!((reg & WM8903_GP1_LVL_MASK) >> WM8903_GP1_LVL_SHIFT);
 }
 
 static int wm8903_gpio_direction_out(struct gpio_chip *chip,
-- 
2.4.3

