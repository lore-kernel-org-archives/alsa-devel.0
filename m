From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 53/54] sound: soc: ac97: Be sure to clamp return value
Date: Tue, 22 Dec 2015 15:51:39 +0100
Message-ID: <1450795899-28693-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

As we want gpio_chip .get() calls to be able to return negative
error codes and propagate to drivers, we need to go over all
drivers and make sure their return values are clamped to [0,1].
We do this by using the ret = !!(val) design pattern.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: as mentioned in 00/54: either apply this directly
or ACK it and I will take it into the GPIO tree.
---
 sound/soc/soc-ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index a2012652f212..7e0acd83b0e6 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -92,7 +92,7 @@ static int snd_soc_ac97_gpio_get(struct gpio_chip *chip, unsigned offset)
 	dev_dbg(codec->dev, "get gpio %d : %d\n", offset,
 		ret < 0 ? ret : ret & (1 << offset));
 
-	return ret < 0 ? ret : ret & (1 << offset);
+	return ret < 0 ? ret : !!(ret & (1 << offset));
 }
 
 static void snd_soc_ac97_gpio_set(struct gpio_chip *chip, unsigned offset,
-- 
2.4.3

