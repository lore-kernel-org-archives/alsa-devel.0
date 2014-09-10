From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC:simple-card: Add multi-CODEC support
Date: Wed, 10 Sep 2014 13:28:07 +0200
Message-ID: <20140910113104.9F30A2651A9@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 08072261A50
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 13:30:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Jyri Sarha <jsarha@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds multi-CODEC support to the simple-card.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 .../devicetree/bindings/sound/simple-card.txt      | 28 +++++++--------
 sound/soc/generic/simple-card.c                    | 41 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c2e9841..c217687 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -37,6 +37,8 @@ Required dai-link subnodes:
 
 - cpu					: CPU   sub-node
 - codec					: CODEC sub-node
+					  In case of multi-CODECs, there may
+					  be many of such sub-nodes.
 
 Optional dai-link subnode properties:
 
@@ -115,37 +117,31 @@ sh_fsi2: sh_fsi2@ec230000 {
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
-		codec {
-			sound-dai = <&tda998x 1>;
+		codec@0 {
+			sound-dai = <&hdmi 0>;
+		};
+		codec@1 {
+			sound-dai = <&spdif_codec>;
 		};
 	};
 
-	simple-audio-card,dai-link@2 {		/* S/PDIF - S/PDIF */
+	simple-audio-card,dai-link@1 {		/* I2S - HDMI */
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
index 4053152..bf0ce08 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -179,11 +179,12 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	struct device_node *np = NULL;
 	struct device_node *bitclkmaster = NULL;
 	struct device_node *framemaster = NULL;
+	struct snd_soc_dai_link_component *component;
 	unsigned int daifmt;
 	char *name;
 	char prop[128];
 	char *prefix = "";
-	int ret, cpu_args;
+	int ret, cpu_args, num_codec_dais;
 
 	/* For single DAI link & old style of DT node */
 	if (is_top_level_node)
@@ -225,7 +226,16 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	}
 
 	of_node_put(np);
+
+	/* count the number of codec DAIs */
 	snprintf(prop, sizeof(prop), "%scodec", prefix);
+	num_codec_dais = 0;
+	for_each_child_of_node(node, np) {
+		if (strcmp(np->name, prop) == 0)
+			num_codec_dais++;
+	}
+
+	/* treat the first DAI */
 	np = of_get_child_by_name(node, prop);
 	if (!np) {
 		ret = -EINVAL;
@@ -307,6 +317,35 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (!cpu_args)
 		dai_link->cpu_dai_name = NULL;
 
+	/* handle multi-codec DAIs */
+	if (num_codec_dais == 1)
+		goto out;
+	dai_link->codecs = component =
+			   devm_kzalloc(dev,
+					sizeof *component * num_codec_dais,
+					GFP_KERNEL);
+	dai_link->num_codecs = num_codec_dais;
+	component->of_node = dai_link->codec_of_node;
+	dai_link->codec_of_node = NULL;
+	component->dai_name = dai_link->codec_dai_name;
+	dai_link->codec_dai_name = NULL;
+	for (;;) {
+		np = of_get_next_child(node, np);
+		if (!np)
+			break;
+		component++;
+		component->of_node = of_parse_phandle(np, "sound-dai", 0);
+		if (!component->of_node) {
+			ret = -ENODEV;
+			dev_err(dev, "Bad sound-dai\n");
+			goto dai_link_of_err;
+		}
+		ret = snd_soc_of_get_dai_name(np, &component->dai_name);
+		if (ret < 0)
+			goto dai_link_of_err;
+	}
+
+out:
 dai_link_of_err:
 	if (np)
 		of_node_put(np);
-- 
2.1.0
