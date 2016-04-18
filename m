From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH v2 2/3] ASoC: simple-card: Add support call the codec jack detection after parse dts
Date: Mon, 18 Apr 2016 19:20:02 +0800
Message-ID: <1460978403-4754-3-git-send-email-zhengxing@rock-chips.com>
References: <1460978403-4754-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460978403-4754-1-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, Adam.Thomson@diasemi.com, sugar.zhang@rock-chips.com, jay.xu@rock-chips.com, broonie@kernel.org, dianders@chromium.org, Xing Zheng <zhengxing@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, Mengdong Lin <mengdong.lin@linux.intel.com>, Jun Nie <jun.nie@linaro.org>, Jyri Sarha <jsarha@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In most cases, many codecs already supports jack detection, previouslly,
we need to create a customized machine driver every time.

Hence, the simple-card need to support use them dynamically via parse dts
file for better flexibility.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v1: None

 .../devicetree/bindings/sound/simple-card.txt      |   17 +++
 sound/soc/generic/simple-card.c                    |  126 +++++++++++++++++++-
 2 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index cf3979e..d25c8eb 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -22,6 +22,23 @@ Optional properties:
 					  headphones are attached.
 - simple-audio-card,mic-det-gpio	: Reference to GPIO that signals when
 					  a microphone is attached.
+- simple-audio-card,codec-jack		: A list of the codec supports jack detection.
+					  The jack types which are supported refer to include/sound/jack.h.
+					  All of the jack types:
+						"JACK_HEADPHONE",
+						"JACK_MICROPHONE",
+						"JACK_HEADSET",
+						"JACK_LINEOUT",
+						"JACK_MECHANICAL",
+						"JACK_VIDEOOUT",
+						"JACK_AVOUT",
+						"JACK_LINEIN",
+						"JACK_BTN_0",
+						"JACK_BTN_1",
+						"JACK_BTN_2",
+						"JACK_BTN_3",
+						"JACK_BTN_4",
+						"JACK_BTN_5".
 
 Optional subnodes:
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2389ab4..bc61022 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -33,12 +33,35 @@ struct simple_card_data {
 	int gpio_hp_det_invert;
 	int gpio_mic_det;
 	int gpio_mic_det_invert;
+	struct simple_codecs_jack {
+		int jack_det;
+		int jack_types;
+		struct snd_soc_jack codec_jack;
+	} *codec_det_jack;
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
 #define simple_priv_to_dev(priv) ((priv)->snd_card.dev)
 #define simple_priv_to_link(priv, i) ((priv)->snd_card.dai_link + i)
 #define simple_priv_to_props(priv, i) ((priv)->dai_props + i)
+#define simple_priv_to_codecdetjack(priv, i) ((priv)->codec_det_jack + i)
+
+static const char * const jack_types_list[] = {
+	"JACK_HEADPHONE",
+	"JACK_MICROPHONE",
+	"JACK_HEADSET",
+	"JACK_LINEOUT",
+	"JACK_MECHANICAL",
+	"JACK_VIDEOOUT",
+	"JACK_AVOUT",
+	"JACK_LINEIN",
+	"JACK_BTN_0",
+	"JACK_BTN_1",
+	"JACK_BTN_2",
+	"JACK_BTN_3",
+	"JACK_BTN_4",
+	"JACK_BTN_5",
+};
 
 static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 {
@@ -136,6 +159,8 @@ static struct snd_soc_jack_gpio simple_card_mic_jack_gpio = {
 	.debounce_time = 150,
 };
 
+static struct snd_soc_jack simple_card_codecs_jack;
+
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set)
 {
@@ -173,9 +198,12 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai *codec = rtd->codec_dai;
 	struct snd_soc_dai *cpu = rtd->cpu_dai;
 	struct simple_dai_props *dai_props;
+	struct simple_codecs_jack *codec_det_jack;
 	int ret;
 
 	dai_props = &priv->dai_props[rtd->num];
+	codec_det_jack = &priv->codec_det_jack[rtd->num];
+
 	ret = __asoc_simple_card_dai_init(codec, &dai_props->codec_dai);
 	if (ret < 0)
 		return ret;
@@ -208,6 +236,80 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_jack_add_gpios(&simple_card_mic_jack, 1,
 				       &simple_card_mic_jack_gpio);
 	}
+
+	if (codec_det_jack->jack_det) {
+		ret = snd_soc_card_jack_new(rtd->card, "Simple-card Codec Jack",
+					    codec_det_jack->jack_types,
+					    &simple_card_codecs_jack, NULL, 0);
+		if (ret) {
+			dev_err(rtd->card->dev, "New Simple-card Codec Jack failed! (%d)\n", ret);
+			return ret;
+		}
+
+		snd_soc_jack_codec_detect(rtd->codec, &simple_card_codecs_jack);
+	}
+
+	return 0;
+}
+
+static int asoc_simple_card_parse_jack(struct device_node *np, int *jack_types)
+{
+	const char *propname = "simple-audio-card,codec-jack";
+	const char *jack_name;
+	int num_jacks, i, j, ret;
+
+	/* init with invalid, don't need to de-init if get count strings failed. */
+	*jack_types = -1;
+
+	num_jacks = of_property_count_strings(np, propname);
+	if (num_jacks < 0) {
+		pr_err("simple-card: Property '%s' number is invalid\n", propname);
+		return -EINVAL;
+	}
+
+	/* init and clean value */
+	*jack_types = 0;
+
+	for (i = 0; i < num_jacks; i++) {
+		ret = of_property_read_string_index(np, propname, i, &jack_name);
+		if (ret) {
+			pr_err("simple-card: Property '%s' index %d read error: %d\n",
+				propname, i, ret);
+			return -EINVAL;
+		}
+
+		for (j = 0; j < ARRAY_SIZE(jack_types_list); j++) {
+			if (!strcmp(jack_name, "JACK_HEADPHONE"))
+				*jack_types |= SND_JACK_HEADPHONE;
+			else if (!strcmp(jack_name, "JACK_MICROPHONE"))
+				*jack_types |= SND_JACK_MICROPHONE;
+			else if (!strcmp(jack_name, "JACK_HEADSET"))
+				*jack_types |= SND_JACK_HEADSET;
+			else if (!strcmp(jack_name, "JACK_LINEOUT"))
+				*jack_types |= SND_JACK_LINEOUT;
+			else if (!strcmp(jack_name, "JACK_MECHANICAL"))
+				*jack_types |= SND_JACK_MECHANICAL;
+			else if (!strcmp(jack_name, "JACK_VIDEOOUT"))
+				*jack_types |= SND_JACK_VIDEOOUT;
+			else if (!strcmp(jack_name, "JACK_AVOUT"))
+				*jack_types |= SND_JACK_AVOUT;
+			else if (!strcmp(jack_name, "JACK_LINEIN"))
+				*jack_types |= SND_JACK_LINEIN;
+			else if (!strcmp(jack_name, "JACK_BTN_0"))
+				*jack_types |= SND_JACK_BTN_0;
+			else if (!strcmp(jack_name, "JACK_BTN_1"))
+				*jack_types |= SND_JACK_BTN_1;
+			else if (!strcmp(jack_name, "JACK_BTN_2"))
+				*jack_types |= SND_JACK_BTN_2;
+			else if (!strcmp(jack_name, "JACK_BTN_3"))
+				*jack_types |= SND_JACK_BTN_3;
+			else if (!strcmp(jack_name, "JACK_BTN_4"))
+				*jack_types |= SND_JACK_BTN_4;
+			else if (!strcmp(jack_name, "JACK_BTN_5"))
+				*jack_types |= SND_JACK_BTN_5;
+		}
+	}
+
 	return 0;
 }
 
@@ -216,7 +318,8 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			      struct asoc_simple_dai *dai,
 			      struct device_node **p_node,
 			      const char **name,
-			      int *args_count)
+			      int *args_count,
+			      struct simple_codecs_jack *codec_det_jack)
 {
 	struct of_phandle_args args;
 	struct clk *clk;
@@ -272,6 +375,13 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			dai->sysclk = clk_get_rate(clk);
 	}
 
+	if (codec_det_jack) {
+		codec_det_jack->jack_det = of_property_read_bool(np,
+						"simple-audio-card,codec-jack");
+		if (codec_det_jack->jack_det)
+			asoc_simple_card_parse_jack(np, &codec_det_jack->jack_types);
+	}
+
 	return 0;
 }
 
@@ -325,6 +435,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
+	struct simple_codecs_jack *codec_det_jack = simple_priv_to_codecdetjack(priv, idx);
 	struct device_node *cpu = NULL;
 	struct device_node *plat = NULL;
 	struct device_node *codec = NULL;
@@ -364,13 +475,15 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	ret = asoc_simple_card_sub_parse_of(cpu, &dai_props->cpu_dai,
 					    &dai_link->cpu_of_node,
 					    &dai_link->cpu_dai_name,
-					    &cpu_args);
+					    &cpu_args, NULL);
 	if (ret < 0)
 		goto dai_link_of_err;
 
 	ret = asoc_simple_card_sub_parse_of(codec, &dai_props->codec_dai,
 					    &dai_link->codec_of_node,
-					    &dai_link->codec_dai_name, NULL);
+					    &dai_link->codec_dai_name, NULL,
+					    codec_det_jack);
+
 	if (ret < 0)
 		goto dai_link_of_err;
 
@@ -565,6 +678,13 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	if (!priv->dai_props)
 		return -ENOMEM;
 
+	/* Get room for the other properties */
+	priv->codec_det_jack = devm_kzalloc(dev,
+			sizeof(*priv->codec_det_jack) * num_links,
+			GFP_KERNEL);
+	if (!priv->codec_det_jack)
+		return -ENOMEM;
+
 	if (np && of_device_is_available(np)) {
 
 		ret = asoc_simple_card_parse_of(np, priv);
-- 
1.7.9.5
