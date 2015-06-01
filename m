From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 2/7] ASoC: rt5677: clean up gpiolib callbacks
Date: Tue,  2 Jun 2015 02:09:13 +0300
Message-ID: <1433200158-6890-2-git-send-email-vz@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 591A5260425
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 01:09:29 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The main intention of the change is to remove bitwise operations on
GPIO level value as a preceding change before updating gpiolib
callbacks to utilize bool type representing a GPIO level. Usage of
generic over GPIO[1-5] macros allows to remove calculations with magic
numbers.

No functional change.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 31d969a..28908f5a 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4507,16 +4507,23 @@ static inline struct rt5677_priv *gpio_to_rt5677(struct gpio_chip *chip)
 static void rt5677_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	unsigned int val = 0;
 
 	switch (offset) {
 	case RT5677_GPIO1 ... RT5677_GPIO5:
+		if (value)
+			val = RT5677_GPIO_OUT_HI(offset);
+
 		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
-			0x1 << (offset * 3 + 1), !!value << (offset * 3 + 1));
+				   RT5677_GPIO_OUT_MASK(offset), val);
 		break;
 
 	case RT5677_GPIO6:
+		if (value)
+			val = RT5677_GPIO6_OUT_HI;
+
 		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL3,
-			RT5677_GPIO6_OUT_MASK, !!value << RT5677_GPIO6_OUT_SFT);
+				   RT5677_GPIO6_OUT_MASK, val);
 		break;
 
 	default:
@@ -4528,18 +4535,27 @@ static int rt5677_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
 	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	unsigned int val;
 
 	switch (offset) {
 	case RT5677_GPIO1 ... RT5677_GPIO5:
+		val = RT5677_GPIO_DIR_OUT(offset);
+
+		if (value)
+			val |= RT5677_GPIO_OUT_HI(offset);
+
 		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
-			0x3 << (offset * 3 + 1),
-			(0x2 | !!value) << (offset * 3 + 1));
+				   RT5677_GPIO_DIR_OUT_MASK(offset), val);
 		break;
 
 	case RT5677_GPIO6:
+		val = RT5677_GPIO6_DIR_OUT;
+
+		if (value)
+			val |= RT5677_GPIO6_OUT_HI;
+
 		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL3,
-			RT5677_GPIO6_DIR_MASK | RT5677_GPIO6_OUT_MASK,
-			RT5677_GPIO6_DIR_OUT | !!value << RT5677_GPIO6_OUT_SFT);
+			RT5677_GPIO6_DIR_MASK | RT5677_GPIO6_OUT_MASK, val);
 		break;
 
 	default:
@@ -4568,12 +4584,12 @@ static int rt5677_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 	switch (offset) {
 	case RT5677_GPIO1 ... RT5677_GPIO5:
 		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
-			0x1 << (offset * 3 + 2), 0x0);
+				   RT5677_GPIO_DIR_MASK(offset), 0x0);
 		break;
 
 	case RT5677_GPIO6:
 		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL3,
-			RT5677_GPIO6_DIR_MASK, RT5677_GPIO6_DIR_IN);
+				   RT5677_GPIO6_DIR_MASK, RT5677_GPIO6_DIR_IN);
 		break;
 
 	default:
-- 
2.1.4
