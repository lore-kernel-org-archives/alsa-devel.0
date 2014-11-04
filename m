From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v3 2/2] ASoC: simple-card: add multi-CODECs in DT
Date: Tue, 4 Nov 2014 11:21:46 +0100
Message-ID: <53ef077d2174f8eb5b861d6cebe7c9e732f06d52.1415096705.git.moinejf@free.fr>
References: <cover.1415096705.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1415096705.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch allows many CODECs per link to be defined in the device tree.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
 .../devicetree/bindings/sound/simple-card.txt      |  28 ++---
 sound/soc/generic/simple-card.c                    | 135 +++++++++++++--------
 2 files changed, 94 insertions(+), 69 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c3cba60..6cb1816 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -65,7 +65,11 @@ properties should also be placed in the codec node if needed.
 
 Required CPU/CODEC subnodes properties:
 
-- sound-dai				: phandle and port of CPU/CODEC
+either
+  - sound-dai				: phandle and port of CPU/CODEC
+or
+  - sound-dais				: list of phandle and port of CODECs
+					  
 
 Optional CPU/CODEC subnodes properties:
 
@@ -119,37 +123,29 @@ sh_fsi2: sh_fsi2@ec230000 {
 	interrupts = <0 146 0x4>;
 };
 
-Example 2 - many DAI links:
+Example 2 - many DAI links and multi-CODECs:
 
 sound {
 	compatible = "simple-audio-card";
 	simple-audio-card,name = "Cubox Audio";
 
-	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
+	simple-audio-card,dai-link@0 {		/* S/PDIF - HDMI & S/PDIF */
 		format = "i2s";
 		cpu {
-			sound-dai = <&audio1 0>;
-		};
-		codec {
-			sound-dai = <&tda998x 0>;
-		};
-	};
-
-	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
-		cpu {
 			sound-dai = <&audio1 1>;
 		};
 		codec {
-			sound-dai = <&tda998x 1>;
+			sound-dais = <&hdmi 0>, <&spdif_codec>;
 		};
 	};
 
-	simple-audio-card,dai-link@2 {		/* S/PDIF - S/PDIF */
+	simple-audio-card,dai-link@1 {		/* I2S - HDMI */
+		format = "i2s";
 		cpu {
-			sound-dai = <&audio1 1>;
+			sound-dai = <&audio1 0>;
 		};
 		codec {
-			sound-dai = <&spdif_codec>;
+			sound-dai = <&hdmi 1>;
 		};
 	};
 };
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index cd49d50..ed3b125 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -172,34 +172,12 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
 			      struct asoc_simple_dai *dai,
-			      struct device_node **p_node,
-			      const char **name,
-			      int *args_count)
+			      const struct device_node *dai_np)
 {
-	struct of_phandle_args args;
 	struct clk *clk;
 	u32 val;
 	int ret;
 
-	/*
-	 * Get node via "sound-dai = <&phandle port>"
-	 * it will be used as xxx_of_node on soc_bind_dai_link()
-	 */
-	ret = of_parse_phandle_with_args(np, "sound-dai",
-					 "#sound-dai-cells", 0, &args);
-	if (ret)
-		return ret;
-
-	*p_node = args.np;
-
-	if (args_count)
-		*args_count = args.args_count;
-
-	/* Get dai->name */
-	ret = snd_soc_of_get_dai_name(np, name);
-	if (ret < 0)
-		return ret;
-
 	/* Parse TDM slot */
 	ret = snd_soc_of_parse_tdm_slot(np, &dai->slots, &dai->slot_width);
 	if (ret)
@@ -222,7 +200,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	} else if (!of_property_read_u32(np, "system-clock-frequency", &val)) {
 		dai->sysclk = val;
 	} else {
-		clk = of_clk_get(args.np, 0);
+		clk = of_clk_get((struct device_node *) dai_np, 0);
 		if (!IS_ERR(clk))
 			dai->sysclk = clk_get_rate(clk);
 	}
@@ -232,7 +210,6 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 
 static int asoc_simple_card_parse_daifmt(struct device_node *node,
 					 struct simple_card_data *priv,
-					 struct device_node *cpu,
 					 struct device_node *codec,
 					 char *prefix, int idx)
 {
@@ -285,62 +262,99 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
-	struct device_node *cpu = NULL;
-	struct device_node *codec = NULL;
+	struct device_node *np = NULL;
+	struct snd_soc_dai_link_component *component;
+	struct of_phandle_args args;
 	char *name;
 	char prop[128];
 	char *prefix = "";
-	int ret, cpu_args;
+	int ret, cpu_args, i, num_codecs;
 
 	/* For single DAI link & old style of DT node */
 	if (is_top_level_node)
 		prefix = "simple-audio-card,";
 
 	snprintf(prop, sizeof(prop), "%scpu", prefix);
-	cpu = of_get_child_by_name(node, prop);
-
-	snprintf(prop, sizeof(prop), "%scodec", prefix);
-	codec = of_get_child_by_name(node, prop);
-
-	if (!cpu || !codec) {
+	np = of_get_child_by_name(node, prop);
+	if (!np) {
 		ret = -EINVAL;
 		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
 		goto dai_link_of_err;
 	}
 
-	ret = asoc_simple_card_parse_daifmt(node, priv,
-					    cpu, codec, prefix, idx);
-	if (ret < 0)
+	/* Get the CPU node and name */
+	ret = of_parse_phandle_with_args(np, "sound-dai",
+					 "#sound-dai-cells", 0, &args);
+	if (ret)
 		goto dai_link_of_err;
+	dai_link->cpu_of_node = args.np;
+	cpu_args = args.args_count;
 
-	ret = asoc_simple_card_sub_parse_of(cpu, &dai_props->cpu_dai,
-					    &dai_link->cpu_of_node,
-					    &dai_link->cpu_dai_name,
-					    &cpu_args);
+	ret = snd_soc_of_get_dai_name(np, &dai_link->cpu_dai_name);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_sub_parse_of(codec, &dai_props->codec_dai,
-					    &dai_link->codec_of_node,
-					    &dai_link->codec_dai_name, NULL);
+	ret = asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai,
+					    dai_link->cpu_of_node);
 	if (ret < 0)
 		goto dai_link_of_err;
+	of_node_put(np);
 
-	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name) {
+	snprintf(prop, sizeof(prop), "%scodec", prefix);
+	np = of_get_child_by_name(node, prop);
+	if (!np) {
 		ret = -EINVAL;
+		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
+		goto dai_link_of_err;
+	}
+
+	/* Get the node and name of the CODEC(s) */
+	name = "sound-dai";
+	num_codecs = of_count_phandle_with_args(np, name,
+						"#sound-dai-cells");
+	if (num_codecs <= 0) {
+		name = "sound-dais";
+		num_codecs = of_count_phandle_with_args(np, name,
+							"#sound-dai-cells");
+		if (num_codecs <= 0) {
+			ret = -EINVAL;
+			dev_err(dev, "No CODEC DAI phandle\n");
+			goto dai_link_of_err;
+		}
+	}
+	component = devm_kzalloc(dev,
+				 sizeof *component * num_codecs,
+				 GFP_KERNEL);
+	if (!component) {
+		ret = -ENOMEM;
 		goto dai_link_of_err;
 	}
+	dai_link->codecs = component;
+	dai_link->num_codecs = num_codecs;
+	ret = snd_soc_of_get_dai_link_codecs(np, name, dai_link);
+	if (ret < 0)
+		goto dai_link_of_err;
+
+	ret = asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai,
+					    dai_link->codecs[0].of_node);
+	if (ret < 0)
+		goto dai_link_of_err;
 
 	/* Simple Card assumes platform == cpu */
 	dai_link->platform_of_node = dai_link->cpu_of_node;
 
+	ret = asoc_simple_card_parse_daifmt(node, priv,
+					    np, prefix, idx);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	/* DAI link name is created from CPU/CODEC dai name */
 	name = devm_kzalloc(dev,
 			    strlen(dai_link->cpu_dai_name)   +
-			    strlen(dai_link->codec_dai_name) + 2,
+			    strlen(dai_link->codecs[0].dai_name) + 2,
 			    GFP_KERNEL);
 	sprintf(name, "%s-%s", dai_link->cpu_dai_name,
-				dai_link->codec_dai_name);
+				dai_link->codecs[0].dai_name);
 	dai_link->name = dai_link->stream_name = name;
 	dai_link->ops = &asoc_simple_card_ops;
 	dai_link->init = asoc_simple_card_dai_init;
@@ -351,7 +365,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		dai_props->cpu_dai.fmt,
 		dai_props->cpu_dai.sysclk);
 	dev_dbg(dev, "\tcodec : %s / %04x / %d\n",
-		dai_link->codec_dai_name,
+		dai_link->codecs[0].dai_name,
 		dai_props->codec_dai.fmt,
 		dai_props->codec_dai.sysclk);
 
@@ -366,11 +380,20 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	 */
 	if (!cpu_args)
 		dai_link->cpu_dai_name = NULL;
+	goto out;
 
 dai_link_of_err:
-	of_node_put(cpu);
-	of_node_put(codec);
+	for (i = 0, component = dai_link->codecs;
+	     i < dai_link->num_codecs;
+	     i++, component++) {
+		if (!component->of_node)
+			break;
+		of_node_put((struct device_node *) component->of_node);
+		component->of_node = NULL;
+	}
 
+out:
+	of_node_put(np);
 	return ret;
 }
 
@@ -457,16 +480,22 @@ static int asoc_simple_card_unref(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct snd_soc_dai_link *dai_link;
+	struct snd_soc_dai_link_component *component;
 	struct device_node *np;
-	int num_links;
+	int num_links, i;
 
 	for (num_links = 0, dai_link = card->dai_link;
 	     num_links < card->num_links;
 	     num_links++, dai_link++) {
 		np = (struct device_node *) dai_link->cpu_of_node;
 		of_node_put(np);
-		np = (struct device_node *) dai_link->codec_of_node;
-		of_node_put(np);
+		for (i = 0, component = dai_link->codecs;
+		     i < dai_link->num_codecs;
+		     i++, component++) {
+			if (!component->of_node)
+				break;
+			of_node_put((struct device_node *) component->of_node);
+		}
 	}
 	return 0;
 }
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
