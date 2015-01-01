From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v6 2/3] ASoC: simple-card: Add multi-CODECs in
	DT
Date: Thu, 1 Jan 2015 09:37:25 +0100
Message-ID: <c9527c2b5a6b6dc03901669f5902122df34e9080.1420102454.git.moinejf@free.fr>
References: <cover.1420102454.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EA0726048A
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 10:16:48 +0100 (CET)
In-Reply-To: <cover.1420102454.git.moinejf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch allows to declare many CODECs per DAI link in the device tree.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 .../devicetree/bindings/sound/simple-card.txt      | 19 ++++++++++-
 sound/soc/generic/simple-card.c                    | 39 +++++++++++++---------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c3cba60..6e3a011 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -65,7 +65,8 @@ properties should also be placed in the codec node if needed.
 
 Required CPU/CODEC subnodes properties:
 
-- sound-dai				: phandle and port of CPU/CODEC
+- sound-dai				: phandle and port of CPU
+					  or list of phandle and port of CODECs
 
 Optional CPU/CODEC subnodes properties:
 
@@ -153,3 +154,19 @@ sound {
 		};
 	};
 };
+
+Example 3 - many CODECs
+
+sound {
+	compatible = "simple-audio-card";
+	simple-audio-card,name = "Cubox Simple Audio";
+
+	simple-audio-card,dai-link {		/* S/PDIF - HDMI & S/PDIF */
+		cpu {
+			sound-dai = <&audio1 1>;
+		};
+		codec {
+			sound-dai = <&tda998x 1>, <&spdif_codec>;
+		};
+	};
+};
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 170de17..a765869 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -264,11 +264,12 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
 	struct device_node *cpu = NULL;
 	struct device_node *codec = NULL;
+	struct snd_soc_dai_link_component *component;
 	struct of_phandle_args args;
 	char *name;
 	char prop[128];
 	char *prefix = "";
-	int ret, cpu_args;
+	int ret, cpu_args, i;
 
 	/* For single DAI link & old style of DT node */
 	if (is_top_level_node)
@@ -308,19 +309,13 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	/* Get the node and name of the CODEC */
-	ret = of_parse_phandle_with_args(codec, "sound-dai",
-					 "#sound-dai-cells", 0, &args);
+	/* Get the node and name of the CODECs */
+	ret = snd_soc_of_get_dai_link_codecs(dev, codec, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
-	dai_link->codec_of_node = args.np;
-
-	ret = snd_soc_of_get_dai_name(codec, &dai_link->codec_dai_name);
-	if (ret < 0)
-		goto dai_link_of_err;
 
 	ret = asoc_simple_card_sub_parse_of(codec, &dai_props->codec_dai,
-					    dai_link->codec_of_node);
+					    dai_link->codecs[0].of_node);
 	if (ret < 0)
 		goto dai_link_of_err;
 
@@ -335,10 +330,10 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
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
@@ -349,7 +344,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		dai_props->cpu_dai.fmt,
 		dai_props->cpu_dai.sysclk);
 	dev_dbg(dev, "\tcodec : %s / %04x / %d\n",
-		dai_link->codec_dai_name,
+		dai_link->codecs[0].dai_name,
 		dai_props->codec_dai.fmt,
 		dai_props->codec_dai.sysclk);
 
@@ -365,7 +360,17 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (!cpu_args)
 		dai_link->cpu_dai_name = NULL;
 
+	of_node_put(cpu);
+	of_node_put(codec);
+	return 0;
+
 dai_link_of_err:
+	for (i = 0, component = dai_link->codecs;
+	     i < dai_link->num_codecs;
+	     i++, component++) {
+		of_node_put(component->of_node);
+		component->of_node = NULL;
+	}
 	of_node_put(cpu);
 	of_node_put(codec);
 
@@ -455,13 +460,17 @@ static int asoc_simple_card_unref(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct snd_soc_dai_link *dai_link;
-	int num_links;
+	struct snd_soc_dai_link_component *component;
+	int num_links, i;
 
 	for (num_links = 0, dai_link = card->dai_link;
 	     num_links < card->num_links;
 	     num_links++, dai_link++) {
 		of_node_put(dai_link->cpu_of_node);
-		of_node_put(dai_link->codec_of_node);
+		for (i = 0, component = dai_link->codecs;
+		     i < dai_link->num_codecs;
+		     i++, component++)
+			of_node_put(component->of_node);
 	}
 	return 0;
 }
-- 
2.1.4
