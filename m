From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 4/7] ASoC: wm8903: simplify gpiolib callbacks
Date: Tue,  2 Jun 2015 02:09:15 +0300
Message-ID: <1433200158-6890-4-git-send-email-vz@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 597FB260436
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 01:09:46 +0200 (CEST)
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

The change cleans up gpiolib callbacks, and the main intention is to
remove bitwise operations on GPIO level value as a preceding change to
switch gpiolib callbacks to utilize bool type to represent GPIO level.

No functional change.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: patches@opensource.wolfsonmicro.com
---
 sound/soc/codecs/wm8903.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 93f1ce0..efac26b 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1783,18 +1783,13 @@ static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 {
 	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
 	unsigned int mask, val;
-	int ret;
 
 	mask = WM8903_GPn_FN_MASK | WM8903_GPn_DIR_MASK;
 	val = (WM8903_GPn_FN_GPIO_INPUT << WM8903_GPn_FN_SHIFT) |
 		WM8903_GPn_DIR;
 
-	ret = regmap_update_bits(wm8903->regmap,
-				 WM8903_GPIO_CONTROL_1 + offset, mask, val);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return regmap_update_bits(wm8903->regmap,
+				  WM8903_GPIO_CONTROL_1 + offset, mask, val);
 }
 
 static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -1812,27 +1807,26 @@ static int wm8903_gpio_direction_out(struct gpio_chip *chip,
 {
 	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
 	unsigned int mask, val;
-	int ret;
 
 	mask = WM8903_GPn_FN_MASK | WM8903_GPn_DIR_MASK | WM8903_GPn_LVL_MASK;
-	val = (WM8903_GPn_FN_GPIO_OUTPUT << WM8903_GPn_FN_SHIFT) |
-		(value << WM8903_GPn_LVL_SHIFT);
+	val = WM8903_GPn_FN_GPIO_OUTPUT << WM8903_GPn_FN_SHIFT;
+	if (value)
+		val |= 0x1 << WM8903_GPn_LVL_SHIFT;
 
-	ret = regmap_update_bits(wm8903->regmap,
-				 WM8903_GPIO_CONTROL_1 + offset, mask, val);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return regmap_update_bits(wm8903->regmap,
+				  WM8903_GPIO_CONTROL_1 + offset, mask, val);
 }
 
 static void wm8903_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	unsigned int val = 0;
+
+	if (value)
+		val = 0x1 << WM8903_GPn_LVL_SHIFT;
 
 	regmap_update_bits(wm8903->regmap, WM8903_GPIO_CONTROL_1 + offset,
-			   WM8903_GPn_LVL_MASK,
-			   !!value << WM8903_GPn_LVL_SHIFT);
+			   WM8903_GPn_LVL_MASK, val);
 }
 
 static struct gpio_chip wm8903_template_chip = {
-- 
2.1.4
