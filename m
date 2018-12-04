From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: use cpu/codec
	pointer on graph_dai_props" to the asoc tree
Date: Tue,  4 Dec 2018 17:27:04 +0000 (GMT)
Message-ID: <20181204172704.A626A11251E3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7130E267B5C
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 18:27:05 +0100 (CET)
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

   ASoC: audio-graph-scu-card: use cpu/codec pointer on graph_dai_props

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

>From a1af9858edae12eca8f77b152d17ee049835e57d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Nov 2018 02:07:15 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: use cpu/codec pointer on
 graph_dai_props

In  DPCM case, it uses CPU-dummy / dummy-Codec dai links, and
non DPCM case, it uses CPU-Codec dai links.

Now, we want to merge audio-graph-card and audio-graph-scu-card.

These sound cards are using silimar but not same logic on each functions.
Then, of course we want to share same logic.
To compromise, this patch uses cpu/codec pointer on audio-graph-scu-card.
It is same logic with audio-graph-card, thus easy merging.
This is prepare for merging audio card

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 72 ++++++++++++++++--------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index a0a28671948a..ed128d430060 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -26,12 +26,14 @@ struct graph_card_data {
 	struct snd_soc_card snd_card;
 	struct snd_soc_codec_conf codec_conf;
 	struct graph_dai_props {
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
 
@@ -47,8 +49,17 @@ static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	int ret = 0;
 
-	return asoc_simple_card_clk_enable(&dai_props->dai);
+	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
+	if (ret)
+		return ret;
+
+	ret = asoc_simple_card_clk_enable(dai_props->codec_dai);
+	if (ret)
+		asoc_simple_card_clk_disable(dai_props->cpu_dai);
+
+	return ret;
 }
 
 static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
@@ -57,7 +68,9 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 
-	asoc_simple_card_clk_disable(&dai_props->dai);
+	asoc_simple_card_clk_disable(dai_props->cpu_dai);
+
+	asoc_simple_card_clk_disable(dai_props->codec_dai);
 }
 
 static const struct snd_soc_ops asoc_graph_card_ops = {
@@ -68,18 +81,20 @@ static const struct snd_soc_ops asoc_graph_card_ops = {
 static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct graph_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *dai;
-	struct snd_soc_dai_link *dai_link;
-	struct graph_dai_props *dai_props;
-	int num = rtd->num;
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	int ret = 0;
 
-	dai_link	= graph_priv_to_link(priv, num);
-	dai_props	= graph_priv_to_props(priv, num);
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
 
 static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -99,14 +114,15 @@ static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
 				       struct device_node *codec_ep,
 				       struct graph_card_data *priv,
-				       int idx, int is_fe)
+				       int *dai_idx, int link_idx, int is_fe)
 {
 	struct device *dev = graph_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, idx);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, idx);
+	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, link_idx);
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, link_idx);
 	struct snd_soc_card *card = graph_priv_to_card(priv);
 	struct device_node *ep = is_fe ? cpu_ep : codec_ep;
 	struct device_node *node = of_graph_get_port_parent(ep);
+	struct asoc_simple_dai *dai;
 	int ret;
 
 	if (is_fe) {
@@ -122,11 +138,14 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
 		dai_link->dynamic		= 1;
 		dai_link->dpcm_merged_format	= 1;
 
+		dai =
+		dai_props->cpu_dai	= &priv->dais[(*dai_idx)++];
+
 		ret = asoc_simple_card_parse_graph_cpu(ep, dai_link);
 		if (ret)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_cpu(dev, ep, dai_link, &dai_props->dai);
+		ret = asoc_simple_card_parse_clk_cpu(dev, ep, dai_link, dai);
 		if (ret < 0)
 			return ret;
 
@@ -149,11 +168,14 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
 		dai_link->no_pcm		= 1;
 		dai_link->be_hw_params_fixup	= asoc_graph_card_be_hw_params_fixup;
 
+		dai =
+		dai_props->codec_dai	= &priv->dais[(*dai_idx)++];
+
 		ret = asoc_simple_card_parse_graph_codec(ep, dai_link);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_codec(dev, ep, dai_link, &dai_props->dai);
+		ret = asoc_simple_card_parse_clk_codec(dev, ep, dai_link, dai);
 		if (ret < 0)
 			return ret;
 
@@ -178,7 +200,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_ep,
 
 	asoc_simple_card_parse_convert(dev, node, PREFIX, &dai_props->adata);
 
-	ret = asoc_simple_card_of_parse_tdm(ep, &dai_props->dai);
+	ret = asoc_simple_card_of_parse_tdm(ep, dai);
 	if (ret)
 		return ret;
 
@@ -210,7 +232,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	struct device_node *codec_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old;
-	int dai_idx, ret;
+	int dai_idx, link_idx, ret;
 	int rc, codec;
 
 	if (!node)
@@ -232,6 +254,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	 * see asoc_graph_get_dais_count
 	 */
 
+	link_idx = 0;
 	dai_idx = 0;
 	codec_port_old = NULL;
 	for (codec = 0; codec < 2; codec++) {
@@ -260,8 +283,8 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 			}
 
 			ret = asoc_graph_card_dai_link_of(cpu_ep, codec_ep,
-							  priv, dai_idx++,
-							  !codec);
+							  priv, &dai_idx,
+							  link_idx++, !codec);
 			if (ret < 0)
 				goto parse_of_err;
 		}
@@ -364,6 +387,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	struct graph_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct graph_dai_props *dai_props;
+	struct asoc_simple_dai *dais;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
 	int lnum = 0, dnum = 0, cnum = 0;
@@ -380,7 +404,8 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 
 	dai_props = devm_kcalloc(dev, lnum, sizeof(*dai_props), GFP_KERNEL);
 	dai_link  = devm_kcalloc(dev, lnum, sizeof(*dai_link),  GFP_KERNEL);
-	if (!dai_props || !dai_link)
+	dais      = devm_kcalloc(dev, dnum, sizeof(*dais),      GFP_KERNEL);
+	if (!dai_props || !dai_link || !dais)
 		return -ENOMEM;
 
 	/*
@@ -397,6 +422,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 
 	priv->dai_props			= dai_props;
 	priv->dai_link			= dai_link;
+	priv->dais			= dais;
 
 	/* Init snd_soc_card */
 	card = graph_priv_to_card(priv);
-- 
2.19.0.rc2
