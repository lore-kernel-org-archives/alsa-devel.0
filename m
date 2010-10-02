From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Put WM8962 GPIO2/3 into GPIO mode when
	configuring platform data too
Date: Fri,  1 Oct 2010 17:51:39 -0700
Message-ID: <1285980699-27382-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B66F244E4
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 02:51:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

GPIO2 and GPIO3 on the WM8962 are MFPs and need to be put into GPIO mode
before the GPIO block can be used to control them. We're already doing
this when used via gpiolib, factor out the code for use when setting static
configurations via platform data as well.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   42 +++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 3a1db4a..6d30f34 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1733,6 +1733,31 @@ static void wm8962_free_beep(struct snd_soc_codec *codec)
 }
 #endif
 
+static void wm8962_set_gpio_mode(struct snd_soc_codec *codec, int gpio)
+{
+	int mask = 0;
+	int val = 0;
+
+	/* Some of the GPIOs are behind MFP configuration and need to
+	 * be put into GPIO mode. */
+	switch (gpio) {
+	case 2:
+		mask = WM8962_CLKOUT2_SEL_MASK;
+		val = 1 << WM8962_CLKOUT2_SEL_SHIFT;
+		break;
+	case 3:
+		mask = WM8962_CLKOUT3_SEL_MASK;
+		val = 1 << WM8962_CLKOUT3_SEL_SHIFT;
+		break;
+	default:
+		break;
+	}
+
+	if (mask)
+		snd_soc_update_bits(codec, WM8962_ANALOGUE_CLOCKING1,
+				    mask, val);
+}
+
 #ifdef CONFIG_GPIOLIB
 static inline struct wm8962_priv *gpio_to_wm8962(struct gpio_chip *chip)
 {
@@ -1743,8 +1768,6 @@ static int wm8962_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
 	struct snd_soc_codec *codec = wm8962->codec;
-	int mask = 0;
-	int val;
 
 	/* The WM8962 GPIOs aren't linearly numbered.  For simplicity
 	 * we export linear numbers and error out if the unsupported
@@ -1752,13 +1775,7 @@ static int wm8962_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 */
 	switch (offset + 1) {
 	case 2:
-		mask = WM8962_CLKOUT2_SEL_MASK;
-		val = 1 << WM8962_CLKOUT2_SEL_SHIFT;
-		break;
 	case 3:
-		mask = WM8962_CLKOUT3_SEL_MASK;
-		val = 1 << WM8962_CLKOUT3_SEL_SHIFT;
-		break;
 	case 5:
 	case 6:
 		break;
@@ -1766,10 +1783,7 @@ static int wm8962_gpio_request(struct gpio_chip *chip, unsigned offset)
 		return -EINVAL;
 	}
 
-	/* Some of the GPIOs are behind MFP configuration */
-	if (mask)
-		snd_soc_update_bits(codec, WM8962_ANALOGUE_CLOCKING1,
-				    mask, val);
+	wm8962_set_gpio_mode(codec, offset + 1);
 
 	return 0;
 }
@@ -1943,9 +1957,11 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	if (pdata) {
 		/* Apply static configuration for GPIOs */
 		for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
-			if (pdata->gpio_init[i])
+			if (pdata->gpio_init[i]) {
+				wm8962_set_gpio_mode(codec, i + 1);
 				snd_soc_write(codec, 0x200 + i,
 					      pdata->gpio_init[i] & 0xffff);
+			}
 
 		/* Put the speakers into mono mode? */
 		if (pdata->spk_mono)
-- 
1.7.1
