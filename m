From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH v3 1/4] ASoC: WM8903: Expose GPIOs through
	gpiolib
Date: Thu, 20 Jan 2011 13:52:08 -0700
Message-ID: <1295556731-25165-2-git-send-email-swarren@nvidia.com>
References: <1295556731-25165-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D9F3243F0
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 21:52:21 +0100 (CET)
In-Reply-To: <1295556731-25165-1-git-send-email-swarren@nvidia.com>
In-Reply-To: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Also, fix platform_data GPIO handling to have an explicit "don't touch this
pin" option.

Add #defines for the GPIO pin functions.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/wm8903.h    |   20 +++++++-
 sound/soc/codecs/wm8903.c |  126 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/include/sound/wm8903.h b/include/sound/wm8903.h
index b4a0db2..86172cf 100644
--- a/include/sound/wm8903.h
+++ b/include/sound/wm8903.h
@@ -37,6 +37,21 @@
 #define WM8903_MICBIAS_ENA_WIDTH                     1  /* MICBIAS_ENA */
 
 /*
+ * WM8903_GPn_FN values
+ *
+ * See datasheets for list of valid values per pin
+ */
+#define WM8903_GPn_FN_GPIO_OUTPUT                    0
+#define WM8903_GPn_FN_BCLK                           1
+#define WM8903_GPn_FN_IRQ_OUTPT                      2
+#define WM8903_GPn_FN_GPIO_INPUT                     3
+#define WM8903_GPn_FN_MICBIAS_CURRENT_DETECT         4
+#define WM8903_GPn_FN_MICBIAS_SHORT_DETECT           5
+#define WM8903_GPn_FN_DMIC_LR_CLK_OUTPUT             6
+#define WM8903_GPn_FN_FLL_LOCK_OUTPUT                8
+#define WM8903_GPn_FN_FLL_CLOCK_OUTPUT               9
+
+/*
  * R116 (0x74) - GPIO Control 1
  */
 #define WM8903_GP1_FN_MASK                      0x1F00  /* GP1_FN - [12:8] */
@@ -231,6 +246,8 @@
 #define WM8903_GP5_DB_SHIFT                          0  /* GP5_DB */
 #define WM8903_GP5_DB_WIDTH                          1  /* GP5_DB */
 
+#define WM8903_NUM_GPIO 5
+
 struct wm8903_platform_data {
 	bool irq_active_low;   /* Set if IRQ active low, default high */
 
@@ -243,7 +260,8 @@ struct wm8903_platform_data {
 
 	int micdet_delay;      /* Delay after microphone detection (ms) */
 
-	u32 gpio_cfg[5];       /* Default register values for GPIO pin mux */
+	int gpio_base;
+	u32 gpio_cfg[WM8903_NUM_GPIO]; /* Default register values for GPIO pin mux */
 };
 
 #endif
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index a2a446c..9c4f2c4 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2,6 +2,7 @@
  * wm8903.c  --  WM8903 ALSA SoC Audio driver
  *
  * Copyright 2008 Wolfson Microelectronics
+ * Copyright 2011 NVIDIA, Inc.
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
  *
@@ -19,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
@@ -213,6 +215,7 @@ static u16 wm8903_reg_defaults[] = {
 };
 
 struct wm8903_priv {
+	struct snd_soc_codec *codec;
 
 	int sysclk;
 	int irq;
@@ -230,6 +233,10 @@ struct wm8903_priv {
 	int mic_short;
 	int mic_last_report;
 	int mic_delay;
+
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio_chip;
+#endif
 };
 
 static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
@@ -1635,6 +1642,119 @@ static int wm8903_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
+#ifdef CONFIG_GPIOLIB
+static inline struct wm8903_priv *gpio_to_wm8903(struct gpio_chip *chip)
+{
+	return container_of(chip, struct wm8903_priv, gpio_chip);
+}
+
+static int wm8903_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	if (offset >= WM8903_NUM_GPIO)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
+{
+	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	struct snd_soc_codec *codec = wm8903->codec;
+	unsigned int mask, val;
+
+	mask = WM8903_GP1_FN_MASK | WM8903_GP1_DIR_MASK;
+	val = (WM8903_GPn_FN_GPIO_INPUT << WM8903_GP1_FN_SHIFT) |
+		WM8903_GP1_DIR;
+
+	return snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
+				   mask, val);
+}
+
+static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	struct snd_soc_codec *codec = wm8903->codec;
+	int reg;
+
+	reg = snd_soc_read(codec, WM8903_GPIO_CONTROL_1 + offset);
+
+	return (reg & WM8903_GP1_LVL_MASK) >> WM8903_GP1_LVL_SHIFT;
+}
+
+static int wm8903_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned offset, int value)
+{
+	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	struct snd_soc_codec *codec = wm8903->codec;
+	unsigned int mask, val;
+
+	mask = WM8903_GP1_FN_MASK | WM8903_GP1_DIR_MASK | WM8903_GP1_LVL_MASK;
+	val = (WM8903_GPn_FN_GPIO_OUTPUT << WM8903_GP1_FN_SHIFT) |
+		(value << WM8903_GP2_LVL_SHIFT);
+
+	return snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
+				   mask, val);
+}
+
+static void wm8903_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
+	struct snd_soc_codec *codec = wm8903->codec;
+
+	snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
+			    WM8903_GP1_LVL_MASK, value << WM8903_GP1_LVL_SHIFT);
+}
+
+static struct gpio_chip wm8903_template_chip = {
+	.label			= "wm8903",
+	.owner			= THIS_MODULE,
+	.request		= wm8903_gpio_request,
+	.direction_input	= wm8903_gpio_direction_in,
+	.get			= wm8903_gpio_get,
+	.direction_output	= wm8903_gpio_direction_out,
+	.set			= wm8903_gpio_set,
+	.can_sleep		= 1,
+};
+
+static void wm8903_init_gpio(struct snd_soc_codec *codec)
+{
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
+	struct wm8903_platform_data *pdata = dev_get_platdata(codec->dev);
+	int ret;
+
+	wm8903->gpio_chip = wm8903_template_chip;
+	wm8903->gpio_chip.ngpio = WM8903_NUM_GPIO;
+	wm8903->gpio_chip.dev = codec->dev;
+
+	if (pdata && pdata->gpio_base)
+		wm8903->gpio_chip.base = pdata->gpio_base;
+	else
+		wm8903->gpio_chip.base = -1;
+
+	ret = gpiochip_add(&wm8903->gpio_chip);
+	if (ret != 0)
+		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
+}
+
+static void wm8903_free_gpio(struct snd_soc_codec *codec)
+{
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = gpiochip_remove(&wm8903->gpio_chip);
+	if (ret != 0)
+		dev_err(codec->dev, "Failed to remove GPIOs: %d\n", ret);
+}
+#else
+static void wm8903_init_gpio(struct snd_soc_codec *codec)
+{
+}
+
+static void wm8903_free_gpio(struct snd_soc_codec *codec)
+{
+}
+#endif
+
 static int wm8903_probe(struct snd_soc_codec *codec)
 {
 	struct wm8903_platform_data *pdata = dev_get_platdata(codec->dev);
@@ -1643,6 +1763,7 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 	int trigger, irq_pol;
 	u16 val;
 
+	wm8903->codec = codec;
 	init_completion(&wm8903->wseq);
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
@@ -1667,7 +1788,7 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 	/* Set up GPIOs and microphone detection */
 	if (pdata) {
 		for (i = 0; i < ARRAY_SIZE(pdata->gpio_cfg); i++) {
-			if (!pdata->gpio_cfg[i])
+			if (pdata->gpio_cfg[i] == WM8903_GPIO_NO_CONFIG)
 				continue;
 
 			snd_soc_write(codec, WM8903_GPIO_CONTROL_1 + i,
@@ -1749,12 +1870,15 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 				ARRAY_SIZE(wm8903_snd_controls));
 	wm8903_add_widgets(codec);
 
+	wm8903_init_gpio(codec);
+
 	return ret;
 }
 
 /* power down chip */
 static int wm8903_remove(struct snd_soc_codec *codec)
 {
+	wm8903_free_gpio(codec);
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
-- 
1.7.1
