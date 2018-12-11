From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: care multi DPCM
	codec_conf" to the asoc tree
Date: Tue, 11 Dec 2018 20:36:43 +0000 (GMT)
Message-ID: <20181211203643.8B740112540E@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E5D21267BDC
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 21:36:45 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: care multi DPCM codec_conf

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0a26d6df4fd8aa8f4fb444446d162e01c3e349c0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Dec 2018 03:25:37 +0000
Subject: [PATCH] ASoC: simple-scu-card: care multi DPCM codec_conf

Current simple-scu-card didn't care about codec_conf
for multi DPCM case. This patch cares it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 30 +++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 944a6f435f88..9d7299d536a8 100644
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
2.19.0.rc2
