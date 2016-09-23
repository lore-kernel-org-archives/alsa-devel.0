From: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2] ASoC: simple-card: add support for aux devices
Date: Fri, 23 Sep 2016 10:11:12 +0300
Message-ID: <1474614673-12350-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, =?UTF-8?q?Otto=20Kek=C3=A4l=C3=A4inen?= <otto-Gh1NM5ZPXYb1KXRcyAk9cg@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mengdong Lin <mengdong.lin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chris Healy <cphealy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch makes it possible to use simple-card in setups where separate
amplifier chip is connected to codec's output.

Changes from v1:
- moved example usage from commit message to Documentation/, as
  suggested by Kuninori Morimoto,
- fixed typo in example usage.

Signed-off-by: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
---
 .../devicetree/bindings/sound/simple-card.txt      | 37 ++++++++++++++++++++++
 sound/soc/generic/simple-card.c                    | 34 ++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 59d8628..c7a9393 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -22,6 +22,8 @@ Optional properties:
 					  headphones are attached.
 - simple-audio-card,mic-det-gpio	: Reference to GPIO that signals when
 					  a microphone is attached.
+- simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
+					  as amplifiers, to be added to the sound card.
 
 Optional subnodes:
 
@@ -162,3 +164,38 @@ sound {
 		};
 	};
 };
+
+Example 3 - route audio from IMX6 SSI2 through TLV320DAC3100 codec
+through TPA6130A2 amplifier to headphones:
+
+&i2c0 {
+	codec: tlv320dac3100@18 {
+		compatible = "ti,tlv320dac3100";
+		...
+	}
+
+	amp: tpa6130a2@60 {
+		compatible = "ti,tpa6130a2";
+		...
+	}
+}
+
+sound {
+	compatible = "simple-audio-card";
+	...
+	simple-audio-card,widgets =
+		"Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+		"Headphone Jack", "HPLEFT",
+		"Headphone Jack", "HPRIGHT",
+		"LEFTIN", "HPL",
+		"RIGHTIN", "HPR";
+	simple-audio-card,aux-devs = <&amp>;
+	simple-audio-card,cpu {
+		sound-dai = <&ssi2>;
+	};
+	simple-audio-card,codec {
+		sound-dai = <&codec>;
+		clocks = ...
+	};
+};
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
