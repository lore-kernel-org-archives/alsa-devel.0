From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 7/7] ASoC: simple-scu-card: care multi DPCM
	codec_conf
Date: Tue, 4 Dec 2018 08:25:02 +0000
Message-ID: <874lbt3dya.wl-kuninori.morimoto.gx@renesas.com>
References: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400110.outbound.protection.outlook.com [40.107.140.110])
 by alsa0.perex.cz (Postfix) with ESMTP id E4B84267B49
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 09:25:04 +0100 (CET)
In-Reply-To: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <630482A77840424E98E1D1D2EF93876B@jpnprd01.prod.outlook.com>
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

Current simple-scu-card didn't care about codec_conf
for multi DPCM case. This patch cares it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-scu-card.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 944a6f4..9d7299d 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -21,17 +21,18 @@
 
 struct simple_card_data {
 	struct snd_soc_card snd_card;
-	struct snd_soc_codec_conf codec_conf;
 	struct simple_dai_props {
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
 
 #define simple_priv_to_card(priv) (&(priv)->snd_card)
@@ -116,7 +117,8 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 					struct device_node *np,
 					struct device_node *codec,
 					struct simple_card_data *priv,
-					int *dai_idx, int link_idx, int is_fe,
+					int *dai_idx, int link_idx,
+					int *conf_idx, int is_fe,
 					bool is_top_level_node)
 {
 	struct device *dev = simple_priv_to_dev(priv);
@@ -165,6 +167,8 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 
 		asoc_simple_card_canonicalize_cpu(dai_link, is_single_links);
 	} else {
+		struct snd_soc_codec_conf *cconf;
+
 		/* FE is dummy */
 		dai_link->cpu_of_node		= NULL;
 		dai_link->cpu_dai_name		= "snd-soc-dummy-dai";
@@ -177,6 +181,9 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 		dai =
 		dai_props->codec_dai	= &priv->dais[(*dai_idx)++];
 
+		cconf =
+		dai_props->codec_conf	= &priv->codec_conf[(*conf_idx)++];
+
 		ret = asoc_simple_card_parse_codec(np, dai_link, DAI, CELL);
 		if (ret < 0)
 			return ret;
@@ -192,14 +199,12 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 			return ret;
 
 		/* check "prefix" from top node */
-		snd_soc_of_parse_audio_prefix(card,
-					      &priv->codec_conf,
+		snd_soc_of_parse_audio_prefix(card, cconf,
 					      dai_link->codecs->of_node,
 					      PREFIX "prefix");
 		/* check "prefix" from each node if top doesn't have */
-		if (!priv->codec_conf.of_node)
-			snd_soc_of_parse_node_prefix(np,
-						     &priv->codec_conf,
+		if (!cconf->of_node)
+			snd_soc_of_parse_node_prefix(np, cconf,
 						     dai_link->codecs->of_node,
 						     "prefix");
 	}
@@ -238,7 +243,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	bool is_fe;
 	int ret, loop;
-	int dai_idx, link_idx;
+	int dai_idx, link_idx, conf_idx;
 
 	if (!top)
 		return -EINVAL;
@@ -256,6 +261,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	loop = 1;
 	link_idx = 0;
 	dai_idx = 0;
+	conf_idx = 0;
 	node = of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
 		node = dev->of_node;
@@ -273,6 +279,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 
 			ret = asoc_simple_card_dai_link_of(node, np, codec, priv,
 							   &dai_idx, link_idx++,
+							   &conf_idx,
 							   is_fe, !loop);
 			if (ret < 0)
 				return ret;
@@ -368,6 +375,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct simple_dai_props *dai_props;
 	struct asoc_simple_dai *dais;
 	struct snd_soc_card *card;
+	struct snd_soc_codec_conf *cconf;
 	struct device *dev = &pdev->dev;
 	int ret, i;
 	int lnum = 0, dnum = 0, cnum = 0;
@@ -384,6 +392,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	dai_props = devm_kcalloc(dev, lnum, sizeof(*dai_props), GFP_KERNEL);
 	dai_link  = devm_kcalloc(dev, lnum, sizeof(*dai_link), GFP_KERNEL);
 	dais      = devm_kcalloc(dev, dnum, sizeof(*dais),      GFP_KERNEL);
+	cconf     = devm_kcalloc(dev, cnum, sizeof(*cconf),     GFP_KERNEL);
 	if (!dai_props || !dai_link || !dais)
 		return -ENOMEM;
 
@@ -402,6 +411,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	priv->dai_props				= dai_props;
 	priv->dai_link				= dai_link;
 	priv->dais				= dais;
+	priv->codec_conf			= cconf;
 
 	/* Init snd_soc_card */
 	card = simple_priv_to_card(priv);
@@ -409,8 +419,8 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
 	card->num_links		= lnum;
-	card->codec_conf	= &priv->codec_conf;
-	card->num_configs	= 1;
+	card->codec_conf	= cconf;
+	card->num_configs	= cnum;
 
 	ret = asoc_simple_card_parse_of(priv);
 	if (ret < 0) {
-- 
2.7.4
