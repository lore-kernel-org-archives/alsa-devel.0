From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: use cpu/codec pointer
	on graph_dai_props" to the asoc tree
Date: Tue,  4 Dec 2018 17:27:01 +0000 (GMT)
Message-ID: <20181204172701.0F92A11251E3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AB38267B53
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 18:27:02 +0100 (CET)
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

   ASoC: audio-graph-card: use cpu/codec pointer on graph_dai_props

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

>From 0e3460bceedc98176684602a34659d51cd8bd4ce Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Nov 2018 02:07:48 +0000
Subject: [PATCH] ASoC: audio-graph-card: use cpu/codec pointer on
 graph_dai_props

In  DPCM case, it uses CPU-dummy / dummy-Codec dai links, and
non DPCM case, it uses CPU-Codec dai links.

Now, we want to merge audio-graph-card and audio-graph-scu-card.

These sound cards are using silimar but not same logic on each functions.
Then, of course we want to share same logic.
To compromise, this patch uses cpu/codec pointer on audio-graph-card.
It is same logic with audio-graph-scu-card, thus easy merging.
This is prepare for merging audio card

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 57 +++++++++++++++++-----------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 1b158cc2df88..1da9532ef897 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -23,8 +23,8 @@
 struct graph_card_data {
 	struct snd_soc_card snd_card;
 	struct graph_dai_props {
-		struct asoc_simple_dai cpu_dai;
-		struct asoc_simple_dai codec_dai;
+		struct asoc_simple_dai *cpu_dai;
+		struct asoc_simple_dai *codec_dai;
 		struct snd_soc_dai_link_component codecs; /* single codec */
 		struct snd_soc_dai_link_component platform;
 		unsigned int mclk_fs;
@@ -33,6 +33,7 @@ struct graph_card_data {
 	struct asoc_simple_jack hp_jack;
 	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
+	struct asoc_simple_dai *dais;
 	struct gpio_desc *pa_gpio;
 };
 
@@ -75,13 +76,13 @@ static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 	int ret;
 
-	ret = asoc_simple_card_clk_enable(&dai_props->cpu_dai);
+	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
 	if (ret)
 		return ret;
 
-	ret = asoc_simple_card_clk_enable(&dai_props->codec_dai);
+	ret = asoc_simple_card_clk_enable(dai_props->codec_dai);
 	if (ret)
-		asoc_simple_card_clk_disable(&dai_props->cpu_dai);
+		asoc_simple_card_clk_disable(dai_props->cpu_dai);
 
 	return ret;
 }
@@ -92,9 +93,9 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 
-	asoc_simple_card_clk_disable(&dai_props->cpu_dai);
+	asoc_simple_card_clk_disable(dai_props->cpu_dai);
 
-	asoc_simple_card_clk_disable(&dai_props->codec_dai);
+	asoc_simple_card_clk_disable(dai_props->codec_dai);
 }
 
 static int asoc_graph_card_hw_params(struct snd_pcm_substream *substream,
@@ -139,17 +140,16 @@ static const struct snd_soc_ops asoc_graph_card_ops = {
 static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct graph_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *codec = rtd->codec_dai;
-	struct snd_soc_dai *cpu = rtd->cpu_dai;
-	struct graph_dai_props *dai_props =
-		graph_priv_to_props(priv, rtd->num);
-	int ret;
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	int ret = 0;
 
-	ret = asoc_simple_card_init_dai(codec, &dai_props->codec_dai);
+	ret = asoc_simple_card_init_dai(rtd->codec_dai,
+					dai_props->codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_dai(cpu, &dai_props->cpu_dai);
+	ret = asoc_simple_card_init_dai(rtd->cpu_dai,
+					dai_props->cpu_dai);
 	if (ret < 0)
 		return ret;
 
@@ -158,17 +158,22 @@ static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 					struct graph_card_data *priv,
-					int idx)
+					int *dai_idx, int link_idx)
 {
 	struct device *dev = graph_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, idx);
-	struct graph_dai_props *dai_props = graph_priv_to_props(priv, idx);
-	struct asoc_simple_dai *cpu_dai = &dai_props->cpu_dai;
-	struct asoc_simple_dai *codec_dai = &dai_props->codec_dai;
+	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, link_idx);
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, link_idx);
+	struct asoc_simple_dai *cpu_dai;
+	struct asoc_simple_dai *codec_dai;
 	struct device_node *cpu_ep    = of_get_next_child(cpu_port, NULL);
 	struct device_node *codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 	int ret;
 
+	cpu_dai			=
+	dai_props->cpu_dai	= &priv->dais[(*dai_idx)++];
+	codec_dai		=
+	dai_props->codec_dai	= &priv->dais[(*dai_idx)++];
+
 	ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
 					    NULL, &dai_link->dai_fmt);
 	if (ret < 0)
@@ -231,8 +236,8 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_card *card = graph_priv_to_card(priv);
 	struct device_node *node = dev->of_node;
-	int rc, idx = 0;
-	int ret;
+	int rc, ret;
+	int link_idx, dai_idx;
 
 	ret = asoc_simple_card_of_parse_widgets(card, NULL);
 	if (ret < 0)
@@ -245,8 +250,11 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	/* Factor to mclk, used in hw_params() */
 	of_property_read_u32(node, "mclk-fs", &priv->mclk_fs);
 
+	link_idx = 0;
+	dai_idx = 0;
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
-		ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
+		ret = asoc_graph_card_dai_link_of(it.node, priv,
+						  &dai_idx, link_idx++);
 		if (ret < 0) {
 			of_node_put(it.node);
 
@@ -291,6 +299,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	struct graph_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct graph_dai_props *dai_props;
+	struct asoc_simple_dai *dais;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
 	int num, ret, i;
@@ -306,7 +315,8 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 
 	dai_props = devm_kcalloc(dev, num, sizeof(*dai_props), GFP_KERNEL);
 	dai_link  = devm_kcalloc(dev, num, sizeof(*dai_link), GFP_KERNEL);
-	if (!dai_props || !dai_link)
+	dais      = devm_kcalloc(dev, num * 2, sizeof(*dais), GFP_KERNEL);
+	if (!dai_props || !dai_link || !dais)
 		return -ENOMEM;
 
 	/*
@@ -330,6 +340,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 
 	priv->dai_props			= dai_props;
 	priv->dai_link			= dai_link;
+	priv->dais			= dais;
 
 	/* Init snd_soc_card */
 	card = graph_priv_to_card(priv);
-- 
2.19.0.rc2
