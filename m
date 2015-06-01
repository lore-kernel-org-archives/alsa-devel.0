From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 5/7] ASoC: wm5100: remove bitwise operations
	involving GPIO level value
Date: Tue,  2 Jun 2015 02:09:16 +0300
Message-ID: <1433200158-6890-5-git-send-email-vz@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE7D2604A9
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 01:09:47 +0200 (CEST)
In-Reply-To: <1433200031-6748-1-git-send-email-vz@mleia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The main intention of the change is to remove bitwise operations on
GPIO level value as a preceding change before updating gpiolib
callbacks to utilize bool type to represent GPIO level.

No functional change.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: patches@opensource.wolfsonmicro.com
---
 sound/soc/codecs/wm5100.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 4c10cd8..fae9d13 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2244,26 +2244,27 @@ static inline struct wm5100_priv *gpio_to_wm5100(struct gpio_chip *chip)
 static void wm5100_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
+	unsigned int val = 0;
+
+	if (value)
+		val = 0x1 << WM5100_GP1_LVL_SHIFT;
 
 	regmap_update_bits(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset,
-			   WM5100_GP1_LVL, !!value << WM5100_GP1_LVL_SHIFT);
+			   WM5100_GP1_LVL, val);
 }
 
 static int wm5100_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
 	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
-	int val, ret;
+	unsigned int val = 0x1 << WM5100_GP1_FN_SHIFT;
 
-	val = (1 << WM5100_GP1_FN_SHIFT) | (!!value << WM5100_GP1_LVL_SHIFT);
+	if (value)
+		val |= 0x1 << WM5100_GP1_LVL_SHIFT;
 
-	ret = regmap_update_bits(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset,
-				 WM5100_GP1_FN_MASK | WM5100_GP1_DIR |
-				 WM5100_GP1_LVL, val);
-	if (ret < 0)
-		return ret;
-	else
-		return 0;
+	return regmap_update_bits(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset,
+				  WM5100_GP1_FN_MASK | WM5100_GP1_DIR |
+				  WM5100_GP1_LVL, val);
 }
 
 static int wm5100_gpio_get(struct gpio_chip *chip, unsigned offset)
-- 
2.1.4
