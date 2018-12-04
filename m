From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 6/7] ASoC: simple-scu-card: use cpu/codec
 pointer on graph_dai_props
Date: Tue, 4 Dec 2018 08:21:15 +0000
Message-ID: <875zw93e4l.wl-kuninori.morimoto.gx@renesas.com>
References: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410122.outbound.protection.outlook.com [40.107.141.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CDEA267B67
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 09:21:17 +0100 (CET)
In-Reply-To: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <E460E855A294B543934F672A5C20ABAC@jpnprd01.prod.outlook.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

In  DPCM case, it uses CPU-dummy / dummy-Codec dai links, and
non DPCM case, it uses CPU-Codec dai links.

Now, we want to merge simple-card and simple-scu-card.

These sound cards are using silimar but not same logic on each functions.
Then, of course we want to share same logic.
To compromise, this patch uses cpu/codec pointer on simple-scu-card.
It is same logic with simple-card, thus easy merging.
This is prepare for merging simple card

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-scu-card.c | 77 +++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 3c4e289..944a6f4 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -23,12 +23,14 @@ struct simple_card_data {
 	struct snd_soc_card snd_card;
 	struct snd_soc_codec_conf codec_conf;
 	struct simple_dai_props {
-		struct asoc_simple_dai dai;
+		struct asoc_simple_dai *cpu_dai;
+		struct asoc_simple_dai *codec_dai;
 		struct snd_soc_dai_link_component codecs;
 		struct snd_soc_dai_link_component platform;
 		struct asoc_simple_card_data adata;
 	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
+	struct asoc_simple_dai *dais;
 	struct asoc_simple_card_data adata;
 };
 
@@ -47,8 +49,17 @@ static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
+	int ret;
+
+	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
+	if (ret)
+		return ret;
+
+	ret = asoc_simple_card_clk_enable(dai_props->codec_dai);
+	if (ret)
+		asoc_simple_card_clk_disable(dai_props->cpu_dai);
 
-	return asoc_simple_card_clk_enable(&dai_props->dai);
+	return ret;
 }
 
 static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
@@ -58,7 +69,9 @@ static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
-	asoc_simple_card_clk_disable(&dai_props->dai);
+	asoc_simple_card_clk_disable(dai_props->cpu_dai);
+
+	asoc_simple_card_clk_disable(dai_props->codec_dai);
 }
 
 static const struct snd_soc_ops asoc_simple_card_ops = {
@@ -68,19 +81,21 @@ static const struct snd_soc_ops asoc_simple_card_ops = {
 
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *dai;
-	struct snd_soc_dai_link *dai_link;
-	struct simple_dai_props *dai_props;
-	int num = rtd->num;
+	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
+	int ret;
 
-	dai_link	= simple_priv_to_link(priv, num);
-	dai_props	= simple_priv_to_props(priv, num);
-	dai		= dai_link->dynamic ?
-				rtd->cpu_dai :
-				rtd->codec_dai;
+	ret = asoc_simple_card_init_dai(rtd->codec_dai,
+					dai_props->codec_dai);
+	if (ret < 0)
+		return ret;
 
-	return asoc_simple_card_init_dai(dai, &dai_props->dai);
+	ret = asoc_simple_card_init_dai(rtd->cpu_dai,
+					dai_props->cpu_dai);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -101,13 +116,14 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 					struct device_node *np,
 					struct device_node *codec,
 					struct simple_card_data *priv,
-					int idx, bool is_fe,
+					int *dai_idx, int link_idx, int is_fe,
 					bool is_top_level_node)
 {
 	struct device *dev = simple_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
+	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, link_idx);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, link_idx);
 	struct snd_soc_card *card = simple_priv_to_card(priv);
+	struct asoc_simple_dai *dai;
 	char *prefix = "";
 	int ret;
 
@@ -129,12 +145,15 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 		dai_link->dynamic		= 1;
 		dai_link->dpcm_merged_format	= 1;
 
+		dai =
+		dai_props->cpu_dai	= &priv->dais[(*dai_idx)++];
+
 		ret = asoc_simple_card_parse_cpu(np, dai_link, DAI, CELL,
 						 &is_single_links);
 		if (ret)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_cpu(dev, np, dai_link, &dai_props->dai);
+		ret = asoc_simple_card_parse_clk_cpu(dev, np, dai_link, dai);
 		if (ret < 0)
 			return ret;
 
@@ -155,11 +174,14 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 		dai_link->no_pcm		= 1;
 		dai_link->be_hw_params_fixup	= asoc_simple_card_be_hw_params_fixup;
 
+		dai =
+		dai_props->codec_dai	= &priv->dais[(*dai_idx)++];
+
 		ret = asoc_simple_card_parse_codec(np, dai_link, DAI, CELL);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_codec(dev, np, dai_link, &dai_props->dai);
+		ret = asoc_simple_card_parse_clk_codec(dev, np, dai_link, dai);
 		if (ret < 0)
 			return ret;
 
@@ -184,7 +206,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 
 	asoc_simple_card_parse_convert(dev, link, prefix, &dai_props->adata);
 
-	ret = asoc_simple_card_of_parse_tdm(np, &dai_props->dai);
+	ret = asoc_simple_card_of_parse_tdm(np, dai);
 	if (ret)
 		return ret;
 
@@ -215,7 +237,8 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	struct device_node *codec;
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	bool is_fe;
-	int ret, i, loop;
+	int ret, loop;
+	int dai_idx, link_idx;
 
 	if (!top)
 		return -EINVAL;
@@ -231,7 +254,8 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	asoc_simple_card_parse_convert(dev, top, PREFIX, &priv->adata);
 
 	loop = 1;
-	i = 0;
+	link_idx = 0;
+	dai_idx = 0;
 	node = of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
 		node = dev->of_node;
@@ -248,10 +272,10 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 			is_fe = (np != codec);
 
 			ret = asoc_simple_card_dai_link_of(node, np, codec, priv,
-							   i, is_fe, !loop);
+							   &dai_idx, link_idx++,
+							   is_fe, !loop);
 			if (ret < 0)
 				return ret;
-			i++;
 		}
 		node = of_get_next_child(top, node);
 	} while (loop && node);
@@ -342,6 +366,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct simple_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct simple_dai_props *dai_props;
+	struct asoc_simple_dai *dais;
 	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
 	int ret, i;
@@ -358,7 +383,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	dai_props = devm_kcalloc(dev, lnum, sizeof(*dai_props), GFP_KERNEL);
 	dai_link  = devm_kcalloc(dev, lnum, sizeof(*dai_link), GFP_KERNEL);
-	if (!dai_props || !dai_link)
+	dais      = devm_kcalloc(dev, dnum, sizeof(*dais),      GFP_KERNEL);
+	if (!dai_props || !dai_link || !dais)
 		return -ENOMEM;
 
 	/*
@@ -375,6 +401,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	priv->dai_props				= dai_props;
 	priv->dai_link				= dai_link;
+	priv->dais				= dais;
 
 	/* Init snd_soc_card */
 	card = simple_priv_to_card(priv);
-- 
2.7.4
