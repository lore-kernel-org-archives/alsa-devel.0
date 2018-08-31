From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: use
	simple_dai_props" to the asoc tree
Date: Fri, 31 Aug 2018 16:36:13 +0100 (BST)
Message-ID: <20180831153613.CBB1711226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DDC4267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:36:14 +0200 (CEST)
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

   ASoC: audio-graph-scu-card: use simple_dai_props

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

>From 1340739d4de4d9d99f1134180f95b42cc4eda438 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:09:20 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: use simple_dai_props

audi-graph-card and audio-graph-scu-card are very similar driver,
but using different feature. Thus we are keeping synchronization
on these 2 drivers style, because it is easy to confirm / check.

Current big difference between these 2 drivers are "dai_props" on
graph_card_data (= priv).
It will be difficult to keep synchronize if we will add new feature
on audio-graph-scu-card. Thus, this patch synchronize it.

[audio-graph]
struct graph_card_data {
	...
	struct graph_dai_props {
		...
	} *dai_props;
	...
};

[audio-graph-scu]
struct graph_card_data {
	...
	struct asoc_simple_dai *dai_props;
	...
};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 26 +++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 92882e392d6c..043938fece42 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -25,7 +25,9 @@
 struct graph_card_data {
 	struct snd_soc_card snd_card;
 	struct snd_soc_codec_conf codec_conf;
-	struct asoc_simple_dai *dai_props;
+	struct graph_dai_props {
+		struct asoc_simple_dai dai;
+	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_card_data adata;
 };
@@ -39,18 +41,18 @@ static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct asoc_simple_dai *dai_props = graph_priv_to_props(priv, rtd->num);
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 
-	return asoc_simple_card_clk_enable(dai_props);
+	return asoc_simple_card_clk_enable(&dai_props->dai);
 }
 
 static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct asoc_simple_dai *dai_props = graph_priv_to_props(priv, rtd->num);
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 
-	asoc_simple_card_clk_disable(dai_props);
+	asoc_simple_card_clk_disable(&dai_props->dai);
 }
 
 static const struct snd_soc_ops asoc_graph_card_ops = {
@@ -63,7 +65,7 @@ static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct graph_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai;
 	struct snd_soc_dai_link *dai_link;
-	struct asoc_simple_dai *dai_props;
+	struct graph_dai_props *dai_props;
 	int num = rtd->num;
 
 	dai_link	= graph_priv_to_link(priv, num);
@@ -72,7 +74,7 @@ static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 				rtd->cpu_dai :
 				rtd->codec_dai;
 
-	return asoc_simple_card_init_dai(dai, dai_props);
+	return asoc_simple_card_init_dai(dai, &dai_props->dai);
 }
 
 static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -92,7 +94,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, idx);
-	struct asoc_simple_dai *dai_props = graph_priv_to_props(priv, idx);
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, idx);
 	struct snd_soc_card *card = graph_priv_to_card(priv);
 	int ret;
 
@@ -110,7 +112,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 		if (ret)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_cpu(dev, ep, dai_link, dai_props);
+		ret = asoc_simple_card_parse_clk_cpu(dev, ep, dai_link, &dai_props->dai);
 		if (ret < 0)
 			return ret;
 
@@ -137,7 +139,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_codec(dev, ep, dai_link, dai_props);
+		ret = asoc_simple_card_parse_clk_codec(dev, ep, dai_link, &dai_props->dai);
 		if (ret < 0)
 			return ret;
 
@@ -153,7 +155,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 					      "prefix");
 	}
 
-	ret = asoc_simple_card_of_parse_tdm(ep, dai_props);
+	ret = asoc_simple_card_of_parse_tdm(ep, &dai_props->dai);
 	if (ret)
 		return ret;
 
@@ -331,7 +333,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 {
 	struct graph_card_data *priv;
 	struct snd_soc_dai_link *dai_link;
-	struct asoc_simple_dai *dai_props;
+	struct graph_dai_props *dai_props;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
 	int num, ret;
-- 
2.19.0.rc1
