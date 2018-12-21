From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: reduce naming prefix"
	to the asoc tree
Date: Fri, 21 Dec 2018 18:15:13 +0000 (GMT)
Message-ID: <20181221181513.A92A31121B93@debutante.sirena.org.uk>
References: <87o99h7zdq.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D0EC267AD6
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 19:15:14 +0100 (CET)
In-Reply-To: <87o99h7zdq.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-card: reduce naming prefix

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

>From ca36a7bdfb5fef3aebfb017d8a3c0f4fb825ba47 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:46:33 +0900
Subject: [PATCH] ASoC: audio-graph-card: reduce naming prefix

Current audio-graph-card is using asoc_graph_card_xxx() for
function / data naming. Because of this long prefix, it is easy to be
80 character over.
Let's reduce prefix from asoc_graph_card_xxx() to graph_xxx().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 164 +++++++++++++--------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 1152de37110e..3ec96cdc683b 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -20,7 +20,7 @@
 #include <linux/string.h>
 #include <sound/simple_card_utils.h>
 
-struct graph_card_data {
+struct graph_priv {
 	struct snd_soc_card snd_card;
 	struct graph_dai_props {
 		struct asoc_simple_dai *cpu_dai;
@@ -53,12 +53,12 @@ struct link_info {
 
 #define PREFIX	"audio-graph-card,"
 
-static int asoc_graph_card_outdrv_event(struct snd_soc_dapm_widget *w,
-					struct snd_kcontrol *kcontrol,
-					int event)
+static int graph_outdrv_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol,
+			      int event)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct graph_card_data *priv = snd_soc_card_get_drvdata(dapm->card);
+	struct graph_priv *priv = snd_soc_card_get_drvdata(dapm->card);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -74,16 +74,16 @@ static int asoc_graph_card_outdrv_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget asoc_graph_card_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget graph_dapm_widgets[] = {
 	SND_SOC_DAPM_OUT_DRV_E("Amplifier", SND_SOC_NOPM,
-			       0, 0, NULL, 0, asoc_graph_card_outdrv_event,
+			       0, 0, NULL, 0, graph_outdrv_event,
 			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 };
 
-static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
+static int graph_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 	int ret;
 
@@ -98,10 +98,10 @@ static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
+static void graph_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 
 	asoc_simple_card_clk_disable(dai_props->cpu_dai);
@@ -109,13 +109,13 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(dai_props->codec_dai);
 }
 
-static int asoc_graph_card_hw_params(struct snd_pcm_substream *substream,
-				     struct snd_pcm_hw_params *params)
+static int graph_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 	unsigned int mclk, mclk_fs = 0;
 	int ret = 0;
@@ -140,15 +140,15 @@ static int asoc_graph_card_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static const struct snd_soc_ops asoc_graph_card_ops = {
-	.startup = asoc_graph_card_startup,
-	.shutdown = asoc_graph_card_shutdown,
-	.hw_params = asoc_graph_card_hw_params,
+static const struct snd_soc_ops graph_ops = {
+	.startup	= graph_startup,
+	.shutdown	= graph_shutdown,
+	.hw_params	= graph_hw_params,
 };
 
-static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
+static int graph_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct graph_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 	int ret = 0;
 
@@ -165,10 +165,10 @@ static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-					      struct snd_pcm_hw_params *params)
+static int graph_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				    struct snd_pcm_hw_params *params)
 {
-	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct graph_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 
 	asoc_simple_card_convert_fixup(&dai_props->adata, params);
@@ -176,9 +176,9 @@ static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static void asoc_graph_card_get_conversion(struct device *dev,
-					   struct device_node *ep,
-					   struct asoc_simple_card_data *adata)
+static void graph_get_conversion(struct device *dev,
+				 struct device_node *ep,
+				 struct asoc_simple_card_data *adata)
 {
 	struct device_node *top = dev->of_node;
 	struct device_node *port = of_get_parent(ep);
@@ -192,11 +192,11 @@ static void asoc_graph_card_get_conversion(struct device *dev,
 	asoc_simple_card_parse_convert(dev, ep,    NULL,   adata);
 }
 
-static int asoc_graph_card_dai_link_of_dpcm(struct graph_card_data *priv,
-					    struct device_node *cpu_ep,
-					    struct device_node *codec_ep,
-					    struct link_info *li,
-					    int dup_codec)
+static int graph_dai_link_of_dpcm(struct graph_priv *priv,
+				  struct device_node *cpu_ep,
+				  struct device_node *codec_ep,
+				  struct link_info *li,
+				  int dup_codec)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, li->link);
@@ -227,7 +227,7 @@ static int asoc_graph_card_dai_link_of_dpcm(struct graph_card_data *priv,
 	of_property_read_u32(port,  "mclk-fs", &dai_props->mclk_fs);
 	of_property_read_u32(ep,    "mclk-fs", &dai_props->mclk_fs);
 
-	asoc_graph_card_get_conversion(dev, ep, &dai_props->adata);
+	graph_get_conversion(dev, ep, &dai_props->adata);
 
 	of_node_put(ports);
 	of_node_put(port);
@@ -274,7 +274,7 @@ static int asoc_graph_card_dai_link_of_dpcm(struct graph_card_data *priv,
 
 		/* BE settings */
 		dai_link->no_pcm		= 1;
-		dai_link->be_hw_params_fixup	= asoc_graph_card_be_hw_params_fixup;
+		dai_link->be_hw_params_fixup	= graph_be_hw_params_fixup;
 
 		dai =
 		dai_props->codec_dai	= &priv->dais[li->dais++];
@@ -322,24 +322,24 @@ static int asoc_graph_card_dai_link_of_dpcm(struct graph_card_data *priv,
 
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
-	dai_link->ops			= &asoc_graph_card_ops;
-	dai_link->init			= asoc_graph_card_dai_init;
+	dai_link->ops			= &graph_ops;
+	dai_link->init			= graph_dai_init;
 
 	return 0;
 }
 
-static int asoc_graph_card_dai_link_of(struct graph_card_data *priv,
-					struct device_node *cpu_ep,
-					struct device_node *codec_ep,
-					struct link_info *li)
+static int graph_dai_link_of(struct graph_priv *priv,
+			     struct device_node *cpu_ep,
+			     struct device_node *codec_ep,
+			     struct link_info *li)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, li->link);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, li->link);
 	struct device_node *top = dev->of_node;
 	struct device_node *cpu_port;
-	struct device_node *codec_port;
 	struct device_node *cpu_ports;
+	struct device_node *codec_port;
 	struct device_node *codec_ports;
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
@@ -416,8 +416,8 @@ static int asoc_graph_card_dai_link_of(struct graph_card_data *priv,
 	if (ret < 0)
 		return ret;
 
-	dai_link->ops = &asoc_graph_card_ops;
-	dai_link->init = asoc_graph_card_dai_init;
+	dai_link->ops = &graph_ops;
+	dai_link->init = graph_dai_init;
 
 	asoc_simple_card_canonicalize_cpu(dai_link,
 		of_graph_get_endpoint_count(dai_link->cpu_of_node) == 1);
@@ -425,13 +425,13 @@ static int asoc_graph_card_dai_link_of(struct graph_card_data *priv,
 	return 0;
 }
 
-static int asoc_graph_card_for_each_link(struct graph_card_data *priv,
+static int graph_for_each_link(struct graph_priv *priv,
 			struct link_info *li,
-			int (*func_noml)(struct graph_card_data *priv,
+			int (*func_noml)(struct graph_priv *priv,
 					 struct device_node *cpu_ep,
 					 struct device_node *codec_ep,
 					 struct link_info *li),
-			int (*func_dpcm)(struct graph_card_data *priv,
+			int (*func_dpcm)(struct graph_priv *priv,
 					 struct device_node *cpu_ep,
 					 struct device_node *codec_ep,
 					 struct link_info *li, int dup_codec))
@@ -467,8 +467,8 @@ static int asoc_graph_card_for_each_link(struct graph_card_data *priv,
 
 			/* get convert-xxx property */
 			memset(&adata, 0, sizeof(adata));
-			asoc_graph_card_get_conversion(dev, codec_ep, &adata);
-			asoc_graph_card_get_conversion(dev, cpu_ep,   &adata);
+			graph_get_conversion(dev, codec_ep, &adata);
+			graph_get_conversion(dev, cpu_ep,   &adata);
 
 			/*
 			 * It is DPCM
@@ -493,7 +493,7 @@ static int asoc_graph_card_for_each_link(struct graph_card_data *priv,
 	return 0;
 }
 
-static int asoc_graph_card_parse_of(struct graph_card_data *priv)
+static int graph_parse_of(struct graph_priv *priv)
 {
 	struct snd_soc_card *card = graph_priv_to_card(priv);
 	struct link_info li;
@@ -521,9 +521,9 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 		 * To avoid random sub-device numbering,
 		 * detect "dummy-Codec" in last;
 		 */
-		ret = asoc_graph_card_for_each_link(priv, &li,
-						    asoc_graph_card_dai_link_of,
-						    asoc_graph_card_dai_link_of_dpcm);
+		ret = graph_for_each_link(priv, &li,
+					  graph_dai_link_of,
+					  graph_dai_link_of_dpcm);
 		if (ret < 0)
 			return ret;
 	}
@@ -531,10 +531,10 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	return asoc_simple_card_parse_card_name(card, NULL);
 }
 
-static int asoc_graph_card_count_noml(struct graph_card_data *priv,
-				      struct device_node *cpu_ep,
-				      struct device_node *codec_ep,
-				      struct link_info *li)
+static int graph_count_noml(struct graph_priv *priv,
+			    struct device_node *cpu_ep,
+			    struct device_node *codec_ep,
+			    struct link_info *li)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 
@@ -546,11 +546,11 @@ static int asoc_graph_card_count_noml(struct graph_card_data *priv,
 	return 0;
 }
 
-static int asoc_graph_card_count_dpcm(struct graph_card_data *priv,
-				      struct device_node *cpu_ep,
-				      struct device_node *codec_ep,
-				      struct link_info *li,
-				      int dup_codec)
+static int graph_count_dpcm(struct graph_priv *priv,
+			    struct device_node *cpu_ep,
+			    struct device_node *codec_ep,
+			    struct link_info *li,
+			    int dup_codec)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 
@@ -568,8 +568,8 @@ static int asoc_graph_card_count_dpcm(struct graph_card_data *priv,
 	return 0;
 }
 
-static void asoc_graph_get_dais_count(struct graph_card_data *priv,
-				      struct link_info *li)
+static void graph_get_dais_count(struct graph_priv *priv,
+				 struct link_info *li)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 
@@ -619,16 +619,16 @@ static void asoc_graph_get_dais_count(struct graph_card_data *priv,
 	 *	=> 4 DAIs  = 2xCPU + 2xCodec
 	 *	=> 1 ccnf  = 1xdummy-Codec
 	 */
-	asoc_graph_card_for_each_link(priv, li,
-				      asoc_graph_card_count_noml,
-				      asoc_graph_card_count_dpcm);
+	graph_for_each_link(priv, li,
+			    graph_count_noml,
+			    graph_count_dpcm);
 	dev_dbg(dev, "link %d, dais %d, ccnf %d\n",
 		li->link, li->dais, li->conf);
 }
 
-static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
+static int graph_card_probe(struct snd_soc_card *card)
 {
-	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
+	struct graph_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
@@ -642,9 +642,9 @@ static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
 	return 0;
 }
 
-static int asoc_graph_card_probe(struct platform_device *pdev)
+static int graph_probe(struct platform_device *pdev)
 {
-	struct graph_card_data *priv;
+	struct graph_priv *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct graph_dai_props *dai_props;
 	struct asoc_simple_dai *dais;
@@ -662,12 +662,12 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card = graph_priv_to_card(priv);
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
-	card->dapm_widgets	= asoc_graph_card_dapm_widgets;
-	card->num_dapm_widgets	= ARRAY_SIZE(asoc_graph_card_dapm_widgets);
-	card->probe		= asoc_graph_soc_card_probe;
+	card->dapm_widgets	= graph_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(graph_dapm_widgets);
+	card->probe		= graph_card_probe;
 
 	memset(&li, 0, sizeof(li));
-	asoc_graph_get_dais_count(priv, &li);
+	graph_get_dais_count(priv, &li);
 	if (!li.link || !li.dais)
 		return -EINVAL;
 
@@ -707,7 +707,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->codec_conf	= cconf;
 	card->num_configs	= li.conf;
 
-	ret = asoc_graph_card_parse_of(priv);
+	ret = graph_parse_of(priv);
 	if (ret < 0) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "parse error %d\n", ret);
@@ -727,30 +727,30 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int asoc_graph_card_remove(struct platform_device *pdev)
+static int graph_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
 	return asoc_simple_card_clean_reference(card);
 }
 
-static const struct of_device_id asoc_graph_of_match[] = {
+static const struct of_device_id graph_of_match[] = {
 	{ .compatible = "audio-graph-card", },
 	{ .compatible = "audio-graph-scu-card", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, asoc_graph_of_match);
+MODULE_DEVICE_TABLE(of, graph_of_match);
 
-static struct platform_driver asoc_graph_card = {
+static struct platform_driver graph_card = {
 	.driver = {
 		.name = "asoc-audio-graph-card",
 		.pm = &snd_soc_pm_ops,
-		.of_match_table = asoc_graph_of_match,
+		.of_match_table = graph_of_match,
 	},
-	.probe = asoc_graph_card_probe,
-	.remove = asoc_graph_card_remove,
+	.probe = graph_probe,
+	.remove = graph_remove,
 };
-module_platform_driver(asoc_graph_card);
+module_platform_driver(graph_card);
 
 MODULE_ALIAS("platform:asoc-audio-graph-card");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1
