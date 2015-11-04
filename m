From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] ASoC: wm9713: add gpio chip
Date: Wed,  4 Nov 2015 18:12:44 +0100
Message-ID: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

The Wolfson WM9713 provides 8 GPIOs. If the gpiolib is compiled in the
kernel, declare a gpio chip.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/wm9713.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm9713.h |   1 +
 2 files changed, 124 insertions(+)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 79e143625ac3..904fe4fc5bf1 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/gpio/driver.h>
 #include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -33,11 +34,21 @@
 #define WM9713_VENDOR_ID 0x574d4c13
 #define WM9713_VENDOR_ID_MASK 0xffffffff
 
+#define AC97_GPIO_PUSH_PULL	0x58
+
+struct wm9713_gpio_priv {
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio_chip;
+#endif
+	struct snd_soc_codec *codec;
+};
+
 struct wm9713_priv {
 	struct snd_ac97 *ac97;
 	u32 pll_in; /* PLL input frequency */
 	unsigned int hp_mixer[2];
 	struct mutex lock;
+	struct wm9713_gpio_priv *gpio_priv;
 };
 
 #define HPL_MIXER 0
@@ -1202,10 +1213,116 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 	return ret;
 }
 
+#ifdef CONFIG_GPIOLIB
+static inline struct snd_soc_codec *gpio_to_codec(struct gpio_chip *chip)
+{
+	struct wm9713_gpio_priv *gpio_priv =
+		container_of(chip, struct wm9713_gpio_priv, gpio_chip);
+
+	return gpio_priv->codec;
+}
+
+static int wm9713_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	if (offset >= WM9713_NUM_GPIOS)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int wm9713_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
+{
+	struct snd_soc_codec *codec = gpio_to_codec(chip);
+
+	return snd_soc_update_bits(codec, AC97_GPIO_CFG,
+				   1 << (offset + 1), 1 << (offset + 1));
+}
+
+static int wm9713_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct snd_soc_codec *codec = gpio_to_codec(chip);
+	int ret;
+
+	ret = snd_soc_read(codec, AC97_GPIO_STATUS);
+
+	return ret < 0 ? ret : ret & (1 << (offset + 1));
+}
+
+static void wm9713_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct snd_soc_codec *codec = gpio_to_codec(chip);
+
+	snd_soc_update_bits(codec, AC97_GPIO_PUSH_PULL,
+			    1 << offset | (1 << (offset + 8)),
+			    1 << (offset + 8 * !!value));
+}
+
+static int wm9713_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned offset, int value)
+{
+	struct snd_soc_codec *codec = gpio_to_codec(chip);
+
+	wm9713_gpio_set(chip, offset, value);
+
+	return  snd_soc_update_bits(codec, AC97_GPIO_CFG, 1 << (offset + 1), 0);
+}
+
+static struct gpio_chip wm9713_gpio_chip = {
+	.label			= "wm9713",
+	.owner			= THIS_MODULE,
+	.request		= wm9713_gpio_request,
+	.direction_input	= wm9713_gpio_direction_in,
+	.get			= wm9713_gpio_get,
+	.direction_output	= wm9713_gpio_direction_out,
+	.set			= wm9713_gpio_set,
+	.can_sleep		= 1,
+};
+
+static int wm9713_init_gpio(struct snd_soc_codec *codec)
+{
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct wm9713_gpio_priv *gpio_priv;
+	int ret;
+
+	gpio_priv = devm_kzalloc(codec->dev, sizeof(*wm9713->gpio_priv),
+				 GFP_KERNEL);
+	if (!gpio_priv)
+		return -ENOMEM;
+	wm9713->gpio_priv = gpio_priv;
+	gpio_priv->codec = codec;
+	gpio_priv->gpio_chip = wm9713_gpio_chip;
+	gpio_priv->gpio_chip.ngpio = WM9713_NUM_GPIOS;
+	gpio_priv->gpio_chip.dev = codec->dev;
+	gpio_priv->gpio_chip.base = -1;
+
+	ret = gpiochip_add(&gpio_priv->gpio_chip);
+	if (ret != 0)
+		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
+	return ret;
+}
+
+static void wm9713_free_gpio(struct snd_soc_codec *codec)
+{
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+
+	gpiochip_remove(&wm9713->gpio_priv->gpio_chip);
+}
+#else
+static int wm9713_init_gpio(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static void wm9713_free_gpio(struct snd_soc_codec *codec)
+{
+}
+#endif
+
 static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	struct regmap *regmap;
+	int ret;
 
 	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
 		WM9713_VENDOR_ID_MASK);
@@ -1223,6 +1340,11 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	/* unmute the adc - move to kcontrol */
 	snd_soc_update_bits(codec, AC97_CD, 0x7fff, 0x0000);
 
+	ret = wm9713_init_gpio(codec);
+	if (ret) {
+		snd_soc_free_ac97_codec(wm9713->ac97);
+		return ret;
+	}
 	return 0;
 }
 
@@ -1230,6 +1352,7 @@ static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 
+	wm9713_free_gpio(codec);
 	snd_soc_codec_exit_regmap(codec);
 	snd_soc_free_ac97_codec(wm9713->ac97);
 	return 0;
diff --git a/sound/soc/codecs/wm9713.h b/sound/soc/codecs/wm9713.h
index 53df11b1f727..d72f96e653d1 100644
--- a/sound/soc/codecs/wm9713.h
+++ b/sound/soc/codecs/wm9713.h
@@ -45,4 +45,5 @@
 #define WM9713_DAI_AC97_AUX		1
 #define WM9713_DAI_PCM_VOICE	2
 
+#define WM9713_NUM_GPIOS	8
 #endif
-- 
2.1.4
