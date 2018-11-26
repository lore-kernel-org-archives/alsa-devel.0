From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 3/4] ASoC: audio-graph-scu-card: care multi
	DPCM codec_conf
Date: Mon, 26 Nov 2018 04:59:25 +0000
Message-ID: <877eh030jo.wl-kuninori.morimoto.gx@renesas.com>
References: <87bm6c30kz.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400097.outbound.protection.outlook.com [40.107.140.97])
 by alsa0.perex.cz (Postfix) with ESMTP id 51D92267A90
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 05:59:27 +0100 (CET)
In-Reply-To: <87bm6c30kz.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <86762036419A8441B9FE76AB97223CD6@jpnprd01.prod.outlook.com>
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

Current audio-graph-scu-card didn't care about codec_conf
for multi DPCM case. This patch cares it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-scu-card.c | 40 +++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 4212b38..cc976f6 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -24,17 +24,18 @@
 
 struct graph_card_data {
 	struct snd_soc_card snd_card;
-	struct snd_soc_codec_conf codec_conf;
 	struct graph_dai_props {
 		struct asoc_simple_dai *cpu_dai;
 		struct asoc_simple_dai *codec_dai;
 		struct snd_soc_dai_link_component codecs;
 		struct snd_soc_dai_link_component platform;
 		struct asoc_simple_card_data adata;
+		struct snd_soc_codec_conf *codec_conf;
 	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dais;
 	struct asoc_simple_card_data adata;
+	struct snd_soc_codec_conf *codec_conf;
 };
 
 #define graph_priv_to_card(priv) (&(priv)->snd_card)
@@ -114,7 +115,8 @@ static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
 				       struct device_node *codec_ep,
 				       struct graph_card_data *priv,
-				       int *dai_idx, int link_idx, int is_fe)
+				       int *dai_idx, int link_idx,
+				       int *conf_idx, int is_fe)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, link_idx);
@@ -159,6 +161,8 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
 		asoc_simple_card_canonicalize_cpu(dai_link,
 			of_graph_get_endpoint_count(dai_link->cpu_of_node) == 1);
 	} else {
+		struct snd_soc_codec_conf *cconf;
+
 		/* FE is dummy */
 		dai_link->cpu_of_node		= NULL;
 		dai_link->cpu_dai_name		= "snd-soc-dummy-dai";
@@ -171,6 +175,9 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
 		dai =
 		dai_props->codec_dai	= &priv->dais[(*dai_idx)++];
 
+		cconf =
+		dai_props->codec_conf	= &priv->codec_conf[(*conf_idx)++];
+
 		ret = asoc_simple_card_parse_graph_codec(ep, dai_link);
 		if (ret < 0)
 			return ret;
@@ -186,14 +193,12 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
 			return ret;
 
 		/* check "prefix" from top node */
-		snd_soc_of_parse_audio_prefix(card,
-					      &priv->codec_conf,
+		snd_soc_of_parse_audio_prefix(card, cconf,
 					      dai_link->codecs->of_node,
 					      "prefix");
 		/* check "prefix" from each node if top doesn't have */
-		if (!priv->codec_conf.of_node)
-			snd_soc_of_parse_node_prefix(node,
-						     &priv->codec_conf,
+		if (!cconf->of_node)
+			snd_soc_of_parse_node_prefix(node, cconf,
 						     dai_link->codecs->of_node,
 						     PREFIX "prefix");
 	}
@@ -232,7 +237,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	struct device_node *codec_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old;
-	int dai_idx, link_idx, ret;
+	int dai_idx, link_idx, conf_idx, ret;
 	int rc, codec;
 
 	if (!node)
@@ -256,6 +261,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 	link_idx = 0;
 	dai_idx = 0;
+	conf_idx = 0;
 	codec_port_old = NULL;
 	for (codec = 0; codec < 2; codec++) {
 		/*
@@ -284,7 +290,8 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 			ret = asoc_graph_card_dai_link_of(cpu_ep, codec_ep,
 							  priv, &dai_idx,
-							  link_idx++, !codec);
+							  link_idx++, &conf_idx,
+							  !codec);
 			if (ret < 0)
 				goto parse_of_err;
 		}
@@ -294,6 +301,14 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	if (ret)
 		goto parse_of_err;
 
+	if ((card->num_links   != link_idx) ||
+	    (card->num_configs != conf_idx)) {
+		dev_err(dev, "dai_link or codec_config wrong (%d/%d, %d/%d)\n",
+			card->num_links, link_idx, card->num_configs, conf_idx);
+		ret = -EINVAL;
+		goto parse_of_err;
+	}
+
 	ret = 0;
 
 parse_of_err:
@@ -373,6 +388,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	struct asoc_simple_dai *dais;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
+	struct snd_soc_codec_conf *cconf;
 	int lnum = 0, dnum = 0, cnum = 0;
 	int ret, i;
 
@@ -388,6 +404,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	dai_props = devm_kcalloc(dev, lnum, sizeof(*dai_props), GFP_KERNEL);
 	dai_link  = devm_kcalloc(dev, lnum, sizeof(*dai_link),  GFP_KERNEL);
 	dais      = devm_kcalloc(dev, dnum, sizeof(*dais),      GFP_KERNEL);
+	cconf     = devm_kcalloc(dev, cnum, sizeof(*cconf),     GFP_KERNEL);
 	if (!dai_props || !dai_link || !dais)
 		return -ENOMEM;
 
@@ -406,6 +423,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	priv->dai_props			= dai_props;
 	priv->dai_link			= dai_link;
 	priv->dais			= dais;
+	priv->codec_conf		= cconf;
 
 	/* Init snd_soc_card */
 	card = graph_priv_to_card(priv);
@@ -413,8 +431,8 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
 	card->num_links		= lnum;
-	card->codec_conf	= &priv->codec_conf;
-	card->num_configs	= 1;
+	card->codec_conf	= cconf;
+	card->num_configs	= cnum;
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-- 
2.7.4
