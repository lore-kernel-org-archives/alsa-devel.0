From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 7/7] ASoC: wm8996: remove bitwise operations
	involving GPIO level value
Date: Tue,  2 Jun 2015 02:09:18 +0300
Message-ID: <1433200158-6890-7-git-send-email-vz@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E5442604B5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 01:09:49 +0200 (CEST)
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
 sound/soc/codecs/wm8996.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 3dd063f..0dce3a0 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2147,18 +2147,23 @@ static inline struct wm8996_priv *gpio_to_wm8996(struct gpio_chip *chip)
 static void wm8996_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
+	unsigned int val = 0;
+
+	if (value)
+		val = 0x1 << WM8996_GP1_LVL_SHIFT;
 
 	regmap_update_bits(wm8996->regmap, WM8996_GPIO_1 + offset,
-			   WM8996_GP1_LVL, !!value << WM8996_GP1_LVL_SHIFT);
+			   WM8996_GP1_LVL, val);
 }
 
 static int wm8996_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
 	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
-	int val;
+	unsigned int val = 0x1 << WM8996_GP1_FN_SHIFT;
 
-	val = (1 << WM8996_GP1_FN_SHIFT) | (!!value << WM8996_GP1_LVL_SHIFT);
+	if (value)
+		val |= 0x1 << WM8996_GP1_LVL_SHIFT;
 
 	return regmap_update_bits(wm8996->regmap, WM8996_GPIO_1 + offset,
 				  WM8996_GP1_FN_MASK | WM8996_GP1_DIR |
-- 
2.1.4
