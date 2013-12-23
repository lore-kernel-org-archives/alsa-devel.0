From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: Add DAPM routes parse from device tree
Date: Mon, 23 Dec 2013 12:57:01 +0800
Message-ID: <1387774621-23968-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: rob@landley.net, kuninori.morimoto.gx@renesas.com, fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Parses a simple DAPM route table from device tree.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 13 +++++++++++--
 sound/soc/generic/simple-card.c                         | 11 +++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 769a346..2ee80c76 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -9,8 +9,13 @@ Required properties:
 Optional properties:
 
 - simple-audio-card,format		: CPU/CODEC common audio format.
-					"i2s", "right_j", "left_j" , "dsp_a"
-					"dsp_b", "ac97", "pdm", "msb", "lsb"
+					  "i2s", "right_j", "left_j" , "dsp_a"
+					  "dsp_b", "ac97", "pdm", "msb", "lsb"
+- simple-audio-routing			: A list of the connections between audio components.
+					  Each entry is a pair of strings, the first being the
+					  connection's sink, the second being the connection's
+					  source.
+
 Required subnodes:
 
 - simple-audio-card,cpu			: CPU   sub-node
@@ -38,6 +43,10 @@ Example:
 sound {
 	compatible = "simple-audio-card";
 	simple-audio-card,format = "left_j";
+	simple-audio-routing =
+		"MIC_IN", "Mic Jack",
+		"Headphone Jack", "HP_OUT",
+		"Ext Spk", "LINE_OUT";
 
 	simple-audio-card,cpu {
 		sound-dai = <&sh_fsi2 0>;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 1d87db8..643c9ed 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -116,12 +116,18 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 {
 	struct device_node *np;
 	char *name;
-	int ret = 0;
+	int ret;
 
 	/* get CPU/CODEC common format via simple-audio-card,format */
 	info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
+	/* DAPM routes */
+	ret = snd_soc_of_parse_audio_routing(&info->snd_card,
+					"simple-audio-routing");
+	if (ret)
+		return ret;
+
 	/* CPU sub-node */
 	ret = -EINVAL;
 	np = of_get_child_by_name(node, "simple-audio-card,cpu");
@@ -185,6 +191,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		cinfo = devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
 		if (cinfo) {
 			int ret;
+			cinfo->snd_card.dev = &pdev->dev;
 			ret = asoc_simple_card_parse_of(np, cinfo, dev,
 							&of_cpu,
 							&of_codec,
@@ -196,6 +203,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 			}
 		}
 	} else {
+		cinfo->snd_card.dev = &pdev->dev;
 		cinfo = pdev->dev.platform_data;
 	}
 
@@ -235,7 +243,6 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	cinfo->snd_card.owner		= THIS_MODULE;
 	cinfo->snd_card.dai_link	= &cinfo->snd_link;
 	cinfo->snd_card.num_links	= 1;
-	cinfo->snd_card.dev		= &pdev->dev;
 
 	return devm_snd_soc_register_card(&pdev->dev, &cinfo->snd_card);
 }
-- 
1.8.4


