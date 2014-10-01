From: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Date: Wed,  1 Oct 2014 14:25:20 -0700
Message-ID: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Allow Headphone and Microphone jack detect gpios to be specified in
device tree.  This will allow a few systems including rk3288_max98090
to use simple-card instead of having their own board file.

Signed-off-by: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 .../devicetree/bindings/sound/simple-card.txt      |  4 ++
 sound/soc/generic/simple-card.c                    | 73 ++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c2e9841..72d94b7 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -17,6 +17,10 @@ Optional properties:
 					  source.
 - simple-audio-card,mclk-fs             : Multiplication factor between stream rate and codec
   					  mclk.
+- simple-audio-card,hp_det_gpio		: Reference to GPIO that signals when
+					  headphones are attached.
+- simple-audio-card,mic_det_gpio	: Reference to GPIO that signals when
+					  a microphone is attached.
 
 Optional subnodes:
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 709ce67..fcb431f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -10,10 +10,13 @@
  */
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <sound/jack.h>
 #include <sound/simple_card.h>
 #include <sound/soc-dai.h>
 #include <sound/soc.h>
@@ -25,6 +28,8 @@ struct simple_card_data {
 		struct asoc_simple_dai codec_dai;
 	} *dai_props;
 	unsigned int mclk_fs;
+	int gpio_hp_det;
+	int gpio_mic_det;
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
@@ -54,6 +59,32 @@ static struct snd_soc_ops asoc_simple_card_ops = {
 	.hw_params = asoc_simple_card_hw_params,
 };
 
+static struct snd_soc_jack simple_card_hp_jack;
+static struct snd_soc_jack_pin simple_card_hp_jack_pins[] = {
+	{
+		.pin = "Headphones",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+static struct snd_soc_jack_gpio simple_card_hp_jack_gpio = {
+	.name = "Headphone detection",
+	.report = SND_JACK_HEADPHONE,
+	.debounce_time = 150,
+};
+
+static struct snd_soc_jack simple_card_mic_jack;
+static struct snd_soc_jack_pin simple_card_mic_jack_pins[] = {
+	{
+		.pin = "Mic Jack",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+static struct snd_soc_jack_gpio simple_card_mic_jack_gpio = {
+	.name = "Mic detection",
+	.report = SND_JACK_MICROPHONE,
+	.debounce_time = 150,
+};
+
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set)
 {
@@ -109,6 +140,28 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
+	if (gpio_is_valid(priv->gpio_hp_det)) {
+		snd_soc_jack_new(codec->codec, "Headphones", SND_JACK_HEADPHONE,
+				 &simple_card_hp_jack);
+		snd_soc_jack_add_pins(&simple_card_hp_jack,
+				      ARRAY_SIZE(simple_card_hp_jack_pins),
+				      simple_card_hp_jack_pins);
+
+		simple_card_hp_jack_gpio.gpio = priv->gpio_hp_det;
+		snd_soc_jack_add_gpios(&simple_card_hp_jack, 1,
+				       &simple_card_hp_jack_gpio);
+	}
+
+	if (gpio_is_valid(priv->gpio_mic_det)) {
+		snd_soc_jack_new(codec->codec, "Mic Jack", SND_JACK_MICROPHONE,
+				 &simple_card_mic_jack);
+		snd_soc_jack_add_pins(&simple_card_mic_jack,
+				      ARRAY_SIZE(simple_card_mic_jack_pins),
+				      simple_card_mic_jack_pins);
+		simple_card_mic_jack_gpio.gpio = priv->gpio_mic_det;
+		snd_soc_jack_add_gpios(&simple_card_mic_jack, 1,
+				       &simple_card_mic_jack_gpio);
+	}
 	return 0;
 }
 
@@ -383,6 +436,16 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			return ret;
 	}
 
+	priv->gpio_hp_det = of_get_named_gpio(node,
+				"simple-audio-card,hp-det-gpio", 0);
+	if (priv->gpio_hp_det == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	priv->gpio_mic_det = of_get_named_gpio(node,
+				"simple-audio-card,mic-det-gpio", 0);
+	if (priv->gpio_mic_det == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	if (!priv->snd_card.name)
 		priv->snd_card.name = priv->snd_card.dai_link->name;
 
@@ -502,6 +565,16 @@ err:
 
 static int asoc_simple_card_remove(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct simple_card_data *priv = snd_soc_card_get_drvdata(card);
+
+	if (gpio_is_valid(priv->gpio_hp_det))
+		snd_soc_jack_free_gpios(&simple_card_hp_jack, 1,
+					&simple_card_hp_jack_gpio);
+	if (gpio_is_valid(priv->gpio_mic_det))
+		snd_soc_jack_free_gpios(&simple_card_mic_jack, 1,
+					&simple_card_mic_jack_gpio);
+
 	return asoc_simple_card_unref(pdev);
 }
 
-- 
2.1.0.rc2.206.gedb03e5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
