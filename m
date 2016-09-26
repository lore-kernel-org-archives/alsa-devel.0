From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: simple-card: add support for aux devices" to the asoc tree
Date: Mon, 26 Sep 2016 09:15:34 -0700
Message-ID: <E1boYZ4-0005Mt-7v@finisterre>
References: <1474883811-14344-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474883811-14344-1-git-send-email-nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Healy <cphealy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: add support for aux devices

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 899a247cf6d5bbb9eb799261791441d7d5ea2099 Mon Sep 17 00:00:00 2001
From: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Date: Mon, 26 Sep 2016 12:56:51 +0300
Subject: [PATCH] ASoC: simple-card: add support for aux devices

Add device tree property to define auxiliary devices to be added to
simle-audio-card.

Together with proper audio routing definition, this allows to use
simple-card in setups where separate amplifier chip is connected to
codec's output.

Signed-off-by: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/simple-card.txt      | 37 ++++++++++++++++++++++
 sound/soc/generic/simple-card.c                    | 34 ++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index cf3979eb3578..5ecdde6d9f63 100644
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
index fe0bc5c469e2..f608f8d23f3d 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -318,6 +318,36 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
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
@@ -372,6 +402,10 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	}
 
 	ret = asoc_simple_card_parse_card_name(&priv->snd_card, PREFIX);
+	if (ret < 0)
+		goto card_parse_end;
+
+	ret = asoc_simple_card_parse_aux_devs(node, priv);
 
 card_parse_end:
 	of_node_put(dai_link);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
