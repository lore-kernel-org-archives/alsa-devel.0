From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ASoC: simple-card: add support for aux devices
Date: Thu, 22 Sep 2016 23:50:44 +0300
Message-ID: <1474577444-7598-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?UTF-8?q?Otto=20Kek=C3=A4l=C3=A4inen?= <otto@seravo.fi>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mengdong Lin <mengdong.lin@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
List-Id: alsa-devel@alsa-project.org

This patch makes it possible to use simple-card in setups where separate
amplifier chip is connected to codec's output.

Example usage:

	codec: tlv320dac3100@18 {
		compatible = "ti,tlv320dac3100";
		...
	}

	amp: tpa6130a2@60 {
		compatible = "ti,tpa6130a2";
		...
	}

	sound {
		compatible = "simple-audio-card";
		...
		simple-audio-card,widgets =
			"Headphone", "Headphone Jack";
		simple-audio-card,routing =
			"Headphone Jack", "HPLEFT",
			"Headphone Jack", "HPRIGHT",
			"LEFTIN", "HPL",
			"RIGHTIN", "HPR";
		simple-audio-card,aux-devs = <&amp>;
		simple-audio-card,cpu {
			sound-dai = <&ssi2>;
		};
		simple-audio-card,codec {
			sound-dai = <&codec1>;
			clocks = ...
		};

This describes audio path from IMX6 SSI2 through TLV320DAC3100 codec
through TPA6130A2 amplifier to headphones.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 .../devicetree/bindings/sound/simple-card.txt      |  2 ++
 sound/soc/generic/simple-card.c                    | 34 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 59d8628..5579f40 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -22,6 +22,8 @@ Optional properties:
 					  headphones are attached.
 - simple-audio-card,mic-det-gpio	: Reference to GPIO that signals when
 					  a microphone is attached.
+- simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
+					  as amplifiers, to be added to the sound card.
 
 Optional subnodes:
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 43295f0..f989f34 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -417,6 +417,36 @@ dai_link_of_err:
 	return ret;
 }
 
+static int asoc_simple_card_parse_aux_devs(struct device_node *node,
+					   struct simple_card_data *priv)
+{
+	struct device *dev = simple_priv_to_dev(priv);
+	struct device_node *aux_node;
+	int i, n, len;
+
+	if (!of_find_property(node, PREFIX "aux-devs", &len))
+		return 0;		/* Ok to have no aux-devs */
+
+	n = len / sizeof(__be32);
+	if (n <= 0)
+		return -EINVAL;
+
+	priv->snd_card.aux_dev = devm_kzalloc(dev,
+			n * sizeof(*priv->snd_card.aux_dev), GFP_KERNEL);
+	if (!priv->snd_card.aux_dev)
+		return -ENOMEM;
+
+	for (i = 0; i < n; i++) {
+		aux_node = of_parse_phandle(node, PREFIX "aux-devs", i);
+		if (!aux_node)
+			return -EINVAL;
+		priv->snd_card.aux_dev[i].codec_of_node = aux_node;
+	}
+
+	priv->snd_card.num_aux_devs = n;
+	return 0;
+}
+
 static int asoc_simple_card_parse_of(struct device_node *node,
 				     struct simple_card_data *priv)
 {
@@ -474,6 +504,10 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	if (ret)
 		return ret;
 
+	ret = asoc_simple_card_parse_aux_devs(node, priv);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.1.4
