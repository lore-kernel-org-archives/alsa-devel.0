From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add support for WM8962 GPIO outputs
Date: Thu, 30 Sep 2010 19:27:21 -0700
Message-ID: <1285900041-19393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F6401039A7
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 04:27:07 +0200 (CEST)
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

The WM8962 features five GPIOs, add support for controlling their output
state via gpiolib.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm8962.h    |    1 +
 sound/soc/codecs/wm8962.c |  119 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8962.h |    1 +
 3 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/include/sound/wm8962.h b/include/sound/wm8962.h
index 9722aac..2b5306c 100644
--- a/include/sound/wm8962.h
+++ b/include/sound/wm8962.h
@@ -15,6 +15,7 @@
 #define WM8962_GPIO_SET 0x10000
 
 struct wm8962_pdata {
+	int gpio_base;
 	u32 gpio_init[WM8962_MAX_GPIO];
 
 	/* Setup for microphone detection, raw value to be written to
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 38cbf85..eb66c66 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/gcd.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
@@ -70,6 +71,10 @@ struct wm8962_priv {
 	struct work_struct beep_work;
 	int beep_rate;
 #endif
+
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio_chip;
+#endif
 };
 
 /* We can't use the same notifier block for more than one supply and
@@ -1646,6 +1651,118 @@ static void wm8962_free_beep(struct snd_soc_codec *codec)
 }
 #endif
 
+#ifdef CONFIG_GPIOLIB
+static inline struct wm8962_priv *gpio_to_wm8962(struct gpio_chip *chip)
+{
+	return container_of(chip, struct wm8962_priv, gpio_chip);
+}
+
+static int wm8962_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
+	struct snd_soc_codec *codec = wm8962->codec;
+	int mask = 0;
+	int val;
+
+	/* The WM8962 GPIOs aren't linearly numbered.  For simplicity
+	 * we export linear numbers and error out if the unsupported
+	 * ones are requsted.
+	 */
+	switch (offset + 1) {
+	case 2:
+		mask = WM8962_CLKOUT2_SEL_MASK;
+		val = 1 << WM8962_CLKOUT2_SEL_SHIFT;
+		break;
+	case 3:
+		mask = WM8962_CLKOUT3_SEL_MASK;
+		val = 1 << WM8962_CLKOUT3_SEL_SHIFT;
+		break;
+	case 5:
+	case 6:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Some of the GPIOs are behind MFP configuration */
+	if (mask)
+		snd_soc_update_bits(codec, WM8962_ANALOGUE_CLOCKING1,
+				    mask, val);
+
+	return 0;
+}
+
+static void wm8962_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
+	struct snd_soc_codec *codec = wm8962->codec;
+
+	snd_soc_update_bits(codec, WM8962_GPIO_BASE + offset,
+			    WM8962_GP2_LVL, value << WM8962_GP2_LVL_SHIFT);
+}
+
+static int wm8962_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned offset, int value)
+{
+	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
+	struct snd_soc_codec *codec = wm8962->codec;
+	int val;
+
+	/* Force function 1 (logic output) */
+	val = (1 << WM8962_GP2_FN_SHIFT) | (value << WM8962_GP2_LVL_SHIFT);
+
+	return snd_soc_update_bits(codec, WM8962_GPIO_BASE + offset,
+				   WM8962_GP2_FN_MASK | WM8962_GP2_LVL, val);
+}
+
+static struct gpio_chip wm8962_template_chip = {
+	.label			= "wm8962",
+	.owner			= THIS_MODULE,
+	.request		= wm8962_gpio_request,
+	.direction_output	= wm8962_gpio_direction_out,
+	.set			= wm8962_gpio_set,
+	.can_sleep		= 1,
+};
+
+static void wm8962_init_gpio(struct snd_soc_codec *codec)
+{
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	int ret;
+
+	wm8962->gpio_chip = wm8962_template_chip;
+	wm8962->gpio_chip.ngpio = WM8962_MAX_GPIO;
+	wm8962->gpio_chip.dev = codec->dev;
+
+	if (pdata && pdata->gpio_base)
+		wm8962->gpio_chip.base = pdata->gpio_base;
+	else
+		wm8962->gpio_chip.base = -1;
+
+	ret = gpiochip_add(&wm8962->gpio_chip);
+	if (ret != 0)
+		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
+}
+
+static void wm8962_free_gpio(struct snd_soc_codec *codec)
+{
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = gpiochip_remove(&wm8962->gpio_chip);
+	if (ret != 0)
+		dev_err(codec->dev, "Failed to remove GPIOs: %d\n", ret);
+}
+#else
+static void wm8962_init_gpio(struct snd_soc_codec *codec)
+{
+}
+
+static void wm8962_free_gpio(struct snd_soc_codec *codec)
+{
+}
+#endif
+
 static int wm8962_probe(struct snd_soc_codec *codec)
 {
 	int ret;
@@ -1778,6 +1895,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	wm8962_add_widgets(codec);
 
 	wm8962_init_beep(codec);
+	wm8962_init_gpio(codec);
 
 	if (i2c->irq) {
 		if (pdata && pdata->irq_active_low) {
@@ -1828,6 +1946,7 @@ static int wm8962_remove(struct snd_soc_codec *codec)
 	if (i2c->irq)
 		free_irq(i2c->irq, codec);
 
+	wm8962_free_gpio(codec);
 	wm8962_free_beep(codec);
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
 		regulator_unregister_notifier(wm8962->supplies[i].consumer,
diff --git a/sound/soc/codecs/wm8962.h b/sound/soc/codecs/wm8962.h
index 6145399..fce1199 100644
--- a/sound/soc/codecs/wm8962.h
+++ b/sound/soc/codecs/wm8962.h
@@ -181,6 +181,7 @@
 #define WM8962_EQ39                             0x175
 #define WM8962_EQ40                             0x176
 #define WM8962_EQ41                             0x177
+#define WM8962_GPIO_BASE			0x200
 #define WM8962_GPIO_2                           0x201
 #define WM8962_GPIO_3                           0x202
 #define WM8962_GPIO_5                           0x204
-- 
1.7.1
