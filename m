From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: add link_info" to the asoc
	tree
Date: Fri,  4 Jan 2019 17:09:17 +0000 (GMT)
Message-ID: <20190104170917.A7C9E11270A3@debutante.sirena.org.uk>
References: <87k1k57zd6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D259F267D1C
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:09:23 +0100 (CET)
In-Reply-To: <87k1k57zd6.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: add link_info

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

>From 17029e494edc68337c9b99665e8f9b478f1d4ec5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:46:53 +0900
Subject: [PATCH] ASoC: simple-card: add link_info

Current simple-card is parsing DAI link for both "normal sound" and
"DPCM sound". On this driver, it needs to count and parse
DAIs/Links/Codec Conf from each links.
Then, counting/parsing link loop are very similar, but using different
implementation. Because of this background, the link loop code is very
mysterious. Mystery code will be trouble in the future.

To preparing cleanup code, this patch adds link_info which handles
number of DAIs/Links/Codec Conf, and CPU/Codec turn.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 94 ++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index b15651409c7f..3820ad719059 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -33,6 +33,13 @@ struct simple_card_data {
 	struct snd_soc_codec_conf *codec_conf;
 };
 
+struct link_info {
+	int dais; /* number of dai  */
+	int link; /* number of link */
+	int conf; /* number of codec_conf */
+	int cpu;  /* turn for CPU / Codec */
+};
+
 #define simple_priv_to_card(priv) (&(priv)->snd_card)
 #define simple_priv_to_props(priv, i) ((priv)->dai_props + (i))
 #define simple_priv_to_dev(priv) (simple_priv_to_card(priv)->dev)
@@ -185,25 +192,27 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 					     struct device_node *np,
 					     struct device_node *codec,
 					     struct simple_card_data *priv,
-					     int *dai_idx, int link_idx,
-					     int *conf_idx, int is_fe,
+					     struct link_info *li,
 					     bool is_top_level_node)
 {
 	struct device *dev = simple_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, link_idx);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, link_idx);
+	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, li->link);
 	struct asoc_simple_dai *dai;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
-
 	char prop[128];
 	char *prefix = "";
 	int ret;
 
+	dev_dbg(dev, "link_of DPCM (%pOF)\n", np);
+
+	li->link++;
+
 	/* For single DAI link & old style of DT node */
 	if (is_top_level_node)
 		prefix = PREFIX;
 
-	if (is_fe) {
+	if (np != codec) {
 		int is_single_links = 0;
 
 		/* BE is dummy */
@@ -216,7 +225,7 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 		dai_link->dpcm_merged_format	= 1;
 
 		dai =
-		dai_props->cpu_dai	= &priv->dais[(*dai_idx)++];
+		dai_props->cpu_dai	= &priv->dais[li->dais++];
 
 		ret = asoc_simple_card_parse_cpu(np, dai_link, DAI, CELL,
 						 &is_single_links);
@@ -247,10 +256,10 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 		dai_link->be_hw_params_fixup	= asoc_simple_card_be_hw_params_fixup;
 
 		dai =
-		dai_props->codec_dai	= &priv->dais[(*dai_idx)++];
+		dai_props->codec_dai	= &priv->dais[li->dais++];
 
 		cconf =
-		dai_props->codec_conf	= &priv->codec_conf[(*conf_idx)++];
+		dai_props->codec_conf	= &priv->codec_conf[li->conf++];
 
 		ret = asoc_simple_card_parse_codec(np, dai_link, DAI, CELL);
 		if (ret < 0)
@@ -306,12 +315,12 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 static int asoc_simple_card_dai_link_of(struct device_node *top,
 					struct device_node *node,
 					struct simple_card_data *priv,
-					int *dai_idx, int link_idx,
+					struct link_info *li,
 					bool is_top_level_node)
 {
 	struct device *dev = simple_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, link_idx);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, link_idx);
+	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, li->link);
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
 	struct device_node *cpu = NULL;
@@ -321,6 +330,10 @@ static int asoc_simple_card_dai_link_of(struct device_node *top,
 	char *prefix = "";
 	int ret, single_cpu;
 
+	li->link++;
+
+	dev_dbg(dev, "link_of (%pOF)\n", node);
+
 	/* For single DAI link & old style of DT node */
 	if (is_top_level_node)
 		prefix = PREFIX;
@@ -347,9 +360,9 @@ static int asoc_simple_card_dai_link_of(struct device_node *top,
 	}
 
 	cpu_dai			=
-	dai_props->cpu_dai	= &priv->dais[(*dai_idx)++];
+	dai_props->cpu_dai	= &priv->dais[li->dais++];
 	codec_dai		=
-	dai_props->codec_dai	= &priv->dais[(*dai_idx)++];
+	dai_props->codec_dai	= &priv->dais[li->dais++];
 
 	ret = asoc_simple_card_parse_daifmt(dev, node, codec,
 					    prefix, &dai_link->dai_fmt);
@@ -454,9 +467,8 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	struct device_node *np;
 	struct device_node *codec;
 	struct asoc_simple_card_data adata;
-	bool is_fe;
+	struct link_info li;
 	int ret, loop;
-	int dai_idx, link_idx, conf_idx;
 
 	if (!top)
 		return -EINVAL;
@@ -470,10 +482,8 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 		return ret;
 
 	/* Single/Muti DAI link(s) & New style of DT node */
+	memset(&li, 0, sizeof(li));
 	loop		= 1;
-	link_idx	= 0;
-	dai_idx		= 0;
-	conf_idx	= 0;
 	node = of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
 		node = dev->of_node;
@@ -495,19 +505,16 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 				if (!codec)
 					return -ENODEV;
 
-				is_fe = (np != codec);
-
 				ret = asoc_simple_card_dai_link_of_dpcm(
 						top, node, np, codec, priv,
-						&dai_idx, link_idx++, &conf_idx,
-						is_fe, !loop);
+						&li, !loop);
 				if (ret < 0)
 					return ret;
 			}
 		} else {
 			ret = asoc_simple_card_dai_link_of(
 						top, node, priv,
-						&dai_idx, link_idx++, !loop);
+						&li, !loop);
 			if (ret < 0)
 				return ret;
 		}
@@ -525,9 +532,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 }
 
 static void asoc_simple_card_get_dais_count(struct device *dev,
-					    int *link_num,
-					    int *dais_num,
-					    int *ccnf_num)
+					    struct link_info *li)
 {
 	struct device_node *top = dev->of_node;
 	struct device_node *node;
@@ -583,9 +588,9 @@ static void asoc_simple_card_get_dais_count(struct device *dev,
 	 *	=> 1 ccnf  = 1xdummy-Codec
 	 */
 	if (!top) {
-		(*link_num) = 1;
-		(*dais_num) = 2;
-		(*ccnf_num) = 0;
+		li->link = 1;
+		li->dais = 2;
+		li->conf = 0;
 		return;
 	}
 
@@ -602,13 +607,13 @@ static void asoc_simple_card_get_dais_count(struct device *dev,
 			asoc_simple_card_get_conversion(dev, np, &adata);
 
 		num = of_get_child_count(node);
-		(*dais_num) += num;
+		li->dais += num;
 		if (num > 2 ||
 		    adata.convert_rate || adata.convert_channels) {
-			(*link_num) += num;
-			(*ccnf_num)++;
+			li->link += num;
+			li->conf++;
 		} else {
-			(*link_num)++;
+			li->link++;
 		}
 		node = of_get_next_child(top, node);
 	} while (loop && node);
@@ -640,7 +645,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct snd_soc_card *card;
 	struct snd_soc_codec_conf *cconf;
-	int lnum = 0, dnum = 0, cnum = 0;
+	struct link_info li;
 	int ret, i;
 
 	/* Allocate the private data and the DAI link array */
@@ -648,14 +653,15 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	asoc_simple_card_get_dais_count(dev, &lnum, &dnum, &cnum);
-	if (!lnum || !dnum)
+	memset(&li, 0, sizeof(li));
+	asoc_simple_card_get_dais_count(dev, &li);
+	if (!li.link || !li.dais)
 		return -EINVAL;
 
-	dai_props = devm_kcalloc(dev, lnum, sizeof(*dai_props), GFP_KERNEL);
-	dai_link  = devm_kcalloc(dev, lnum, sizeof(*dai_link),  GFP_KERNEL);
-	dais      = devm_kcalloc(dev, dnum, sizeof(*dais),      GFP_KERNEL);
-	cconf     = devm_kcalloc(dev, cnum, sizeof(*cconf),     GFP_KERNEL);
+	dai_props = devm_kcalloc(dev, li.link, sizeof(*dai_props), GFP_KERNEL);
+	dai_link  = devm_kcalloc(dev, li.link, sizeof(*dai_link),  GFP_KERNEL);
+	dais      = devm_kcalloc(dev, li.dais, sizeof(*dais),      GFP_KERNEL);
+	cconf     = devm_kcalloc(dev, li.conf, sizeof(*cconf),     GFP_KERNEL);
 	if (!dai_props || !dai_link || !dais)
 		return -ENOMEM;
 
@@ -665,7 +671,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	 * see
 	 *	soc-core.c :: snd_soc_init_multicodec()
 	 */
-	for (i = 0; i < lnum; i++) {
+	for (i = 0; i < li.link; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
 		dai_link[i].platform	= &dai_props[i].platform;
@@ -681,9 +687,9 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
-	card->num_links		= lnum;
+	card->num_links		= li.link;
 	card->codec_conf	= cconf;
-	card->num_configs	= cnum;
+	card->num_configs	= li.conf;
 	card->probe		= asoc_simple_soc_card_probe;
 
 	if (np && of_device_is_available(np)) {
-- 
2.20.1
