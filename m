From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 6/7] ASoC: wm8962: remove bitwise operations
	involving GPIO level value
Date: Tue,  2 Jun 2015 02:09:17 +0300
Message-ID: <1433200158-6890-6-git-send-email-vz@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 343722604AC
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 01:09:48 +0200 (CEST)
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
 sound/soc/codecs/wm8962.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c5748fd..ad619e6 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3341,9 +3341,13 @@ static void wm8962_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
 	struct snd_soc_codec *codec = wm8962->codec;
+	unsigned int val = 0;
+
+	if (value)
+		val = 0x1 << WM8962_GP2_LVL_SHIFT;
 
 	snd_soc_update_bits(codec, WM8962_GPIO_BASE + offset,
-			    WM8962_GP2_LVL, !!value << WM8962_GP2_LVL_SHIFT);
+			    WM8962_GP2_LVL, val);
 }
 
 static int wm8962_gpio_direction_out(struct gpio_chip *chip,
@@ -3351,10 +3355,11 @@ static int wm8962_gpio_direction_out(struct gpio_chip *chip,
 {
 	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
 	struct snd_soc_codec *codec = wm8962->codec;
-	int ret, val;
+	unsigned int val = 0x1 << WM8962_GP2_FN_SHIFT;
+	int ret;
 
-	/* Force function 1 (logic output) */
-	val = (1 << WM8962_GP2_FN_SHIFT) | (value << WM8962_GP2_LVL_SHIFT);
+	if (value)
+		val |= 0x1 << WM8962_GP2_LVL_SHIFT;
 
 	ret = snd_soc_update_bits(codec, WM8962_GPIO_BASE + offset,
 				  WM8962_GP2_FN_MASK | WM8962_GP2_LVL, val);
-- 
2.1.4
