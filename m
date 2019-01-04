From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: reduce naming prefix" to
	the asoc tree
Date: Fri,  4 Jan 2019 14:01:09 +0000 (GMT)
Message-ID: <20190104140109.B412411270A3@debutante.sirena.org.uk>
References: <87ftut7zc2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B61BA267B94
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 15:01:10 +0100 (CET)
In-Reply-To: <87ftut7zc2.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: reduce naming prefix

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

>From 2d01a84605a55cf07ea9c6886049cc85c5e98454 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:47:34 +0900
Subject: [PATCH] ASoC: simple-card: reduce naming prefix

Current simple-card is using asoc_simple_card_xxx() for
function / data naming. Because of this long prefix, it is easy to be
80 character over.
Let's reduce prefix from asoc_simple_card_xxx() to simple_xxx().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 157 ++++++++++++++++----------------
 1 file changed, 79 insertions(+), 78 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index e796b1516b40..479de236e694 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -15,7 +15,7 @@
 #include <sound/soc-dai.h>
 #include <sound/soc.h>
 
-struct simple_card_data {
+struct simple_priv {
 	struct snd_soc_card snd_card;
 	struct simple_dai_props {
 		struct asoc_simple_dai *cpu_dai;
@@ -49,10 +49,10 @@ struct link_info {
 #define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
 
-static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
+static int simple_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 	int ret;
@@ -68,10 +68,10 @@ static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
+static void simple_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
@@ -80,8 +80,8 @@ static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(dai_props->codec_dai);
 }
 
-static int asoc_simple_set_clk_rate(struct asoc_simple_dai *simple_dai,
-				    unsigned long rate)
+static int simple_set_clk_rate(struct asoc_simple_dai *simple_dai,
+			       unsigned long rate)
 {
 	if (!simple_dai)
 		return 0;
@@ -95,13 +95,13 @@ static int asoc_simple_set_clk_rate(struct asoc_simple_dai *simple_dai,
 	return clk_set_rate(simple_dai->clk, rate);
 }
 
-static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
-				      struct snd_pcm_hw_params *params)
+static int simple_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 	unsigned int mclk, mclk_fs = 0;
@@ -113,11 +113,11 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 	if (mclk_fs) {
 		mclk = params_rate(params) * mclk_fs;
 
-		ret = asoc_simple_set_clk_rate(dai_props->codec_dai, mclk);
+		ret = simple_set_clk_rate(dai_props->codec_dai, mclk);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_set_clk_rate(dai_props->cpu_dai, mclk);
+		ret = simple_set_clk_rate(dai_props->cpu_dai, mclk);
 		if (ret < 0)
 			return ret;
 
@@ -136,15 +136,15 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static const struct snd_soc_ops asoc_simple_card_ops = {
-	.startup = asoc_simple_card_startup,
-	.shutdown = asoc_simple_card_shutdown,
-	.hw_params = asoc_simple_card_hw_params,
+static const struct snd_soc_ops simple_ops = {
+	.startup	= simple_startup,
+	.shutdown	= simple_shutdown,
+	.hw_params	= simple_hw_params,
 };
 
-static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
+static int simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	int ret;
 
@@ -161,10 +161,10 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-					       struct snd_pcm_hw_params *params)
+static int simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				     struct snd_pcm_hw_params *params)
 {
-	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 
 	asoc_simple_card_convert_fixup(&dai_props->adata, params);
@@ -172,9 +172,9 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static void asoc_simple_card_get_conversion(struct device *dev,
-					    struct device_node *np,
-					    struct asoc_simple_card_data *adata)
+static void simple_get_conversion(struct device *dev,
+				  struct device_node *np,
+				  struct asoc_simple_card_data *adata)
 {
 	struct device_node *top = dev->of_node;
 	struct device_node *node = of_get_parent(np);
@@ -187,11 +187,11 @@ static void asoc_simple_card_get_conversion(struct device *dev,
 	of_node_put(node);
 }
 
-static int asoc_simple_card_dai_link_of_dpcm(struct simple_card_data *priv,
-					     struct device_node *np,
-					     struct device_node *codec,
-					     struct link_info *li,
-					     bool is_top)
+static int simple_dai_link_of_dpcm(struct simple_priv *priv,
+				   struct device_node *np,
+				   struct device_node *codec,
+				   struct link_info *li,
+				   bool is_top)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
@@ -264,7 +264,7 @@ static int asoc_simple_card_dai_link_of_dpcm(struct simple_card_data *priv,
 
 		/* BE settings */
 		dai_link->no_pcm		= 1;
-		dai_link->be_hw_params_fixup	= asoc_simple_card_be_hw_params_fixup;
+		dai_link->be_hw_params_fixup	= simple_be_hw_params_fixup;
 
 		dai =
 		dai_props->codec_dai	= &priv->dais[li->dais++];
@@ -295,7 +295,7 @@ static int asoc_simple_card_dai_link_of_dpcm(struct simple_card_data *priv,
 					     "prefix");
 	}
 
-	asoc_simple_card_get_conversion(dev, np, &dai_props->adata);
+	simple_get_conversion(dev, np, &dai_props->adata);
 
 	ret = asoc_simple_card_of_parse_tdm(np, dai);
 	if (ret)
@@ -317,17 +317,17 @@ static int asoc_simple_card_dai_link_of_dpcm(struct simple_card_data *priv,
 
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
-	dai_link->ops			= &asoc_simple_card_ops;
-	dai_link->init			= asoc_simple_card_dai_init;
+	dai_link->ops			= &simple_ops;
+	dai_link->init			= simple_dai_init;
 
 	return 0;
 }
 
-static int asoc_simple_card_dai_link_of(struct simple_card_data *priv,
-					struct device_node *np,
-					struct device_node *codec,
-					struct link_info *li,
-					bool is_top)
+static int simple_dai_link_of(struct simple_priv *priv,
+			      struct device_node *np,
+			      struct device_node *codec,
+			      struct link_info *li,
+			      bool is_top)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
@@ -420,8 +420,8 @@ static int asoc_simple_card_dai_link_of(struct simple_card_data *priv,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	dai_link->ops = &asoc_simple_card_ops;
-	dai_link->init = asoc_simple_card_dai_init;
+	dai_link->ops = &simple_ops;
+	dai_link->init = simple_dai_init;
 
 	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
 
@@ -431,13 +431,13 @@ static int asoc_simple_card_dai_link_of(struct simple_card_data *priv,
 	return ret;
 }
 
-static int asoc_simple_card_for_each_link(struct simple_card_data *priv,
+static int simple_for_each_link(struct simple_priv *priv,
 			struct link_info *li,
-			int (*func_noml)(struct simple_card_data *priv,
+			int (*func_noml)(struct simple_priv *priv,
 					 struct device_node *np,
 					 struct device_node *codec,
 					 struct link_info *li, bool is_top),
-			int (*func_dpcm)(struct simple_card_data *priv,
+			int (*func_dpcm)(struct simple_priv *priv,
 					 struct device_node *np,
 					 struct device_node *codec,
 					 struct link_info *li, bool is_top))
@@ -473,7 +473,7 @@ static int asoc_simple_card_for_each_link(struct simple_card_data *priv,
 		/* get convert-xxx property */
 		memset(&adata, 0, sizeof(adata));
 		for_each_child_of_node(node, np)
-			asoc_simple_card_get_conversion(dev, np, &adata);
+			simple_get_conversion(dev, np, &adata);
 
 		/* loop for all CPU/Codec node */
 		for_each_child_of_node(node, np) {
@@ -499,8 +499,8 @@ static int asoc_simple_card_for_each_link(struct simple_card_data *priv,
 	return 0;
 }
 
-static int asoc_simple_card_parse_aux_devs(struct device_node *node,
-					   struct simple_card_data *priv)
+static int simple_parse_aux_devs(struct device_node *node,
+				 struct simple_priv *priv)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *aux_node;
@@ -530,7 +530,7 @@ static int asoc_simple_card_parse_aux_devs(struct device_node *node,
 	return 0;
 }
 
-static int asoc_simple_card_parse_of(struct simple_card_data *priv)
+static int simple_parse_of(struct simple_priv *priv)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *top = dev->of_node;
@@ -564,9 +564,9 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 		 * To avoid random sub-device numbering,
 		 * detect "dummy-Codec" in last;
 		 */
-		ret = asoc_simple_card_for_each_link(priv, &li,
-						     asoc_simple_card_dai_link_of,
-						     asoc_simple_card_dai_link_of_dpcm);
+		ret = simple_for_each_link(priv, &li,
+					   simple_dai_link_of,
+					   simple_dai_link_of_dpcm);
 		if (ret < 0)
 			return ret;
 	}
@@ -575,15 +575,15 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_parse_aux_devs(top, priv);
+	ret = simple_parse_aux_devs(top, priv);
 
 	return ret;
 }
 
-static int asoc_simple_card_count_noml(struct simple_card_data *priv,
-				       struct device_node *np,
-				       struct device_node *codec,
-				       struct link_info *li, bool is_top)
+static int simple_count_noml(struct simple_priv *priv,
+			     struct device_node *np,
+			     struct device_node *codec,
+			     struct link_info *li, bool is_top)
 {
 	li->dais++; /* CPU or Codec */
 	if (np != codec)
@@ -592,10 +592,10 @@ static int asoc_simple_card_count_noml(struct simple_card_data *priv,
 	return 0;
 }
 
-static int asoc_simple_card_count_dpcm(struct simple_card_data *priv,
-				       struct device_node *np,
-				       struct device_node *codec,
-				       struct link_info *li, bool is_top)
+static int simple_count_dpcm(struct simple_priv *priv,
+			     struct device_node *np,
+			     struct device_node *codec,
+			     struct link_info *li, bool is_top)
 {
 	li->dais++; /* CPU or Codec */
 	li->link++; /* CPU-dummy or dummy-Codec */
@@ -605,8 +605,8 @@ static int asoc_simple_card_count_dpcm(struct simple_card_data *priv,
 	return 0;
 }
 
-static void asoc_simple_card_get_dais_count(struct simple_card_data *priv,
-					    struct link_info *li)
+static void simple_get_dais_count(struct simple_priv *priv,
+				  struct link_info *li)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *top = dev->of_node;
@@ -664,16 +664,17 @@ static void asoc_simple_card_get_dais_count(struct simple_card_data *priv,
 		return;
 	}
 
-	asoc_simple_card_for_each_link(priv, li,
-				       asoc_simple_card_count_noml,
-				       asoc_simple_card_count_dpcm);
+	simple_for_each_link(priv, li,
+			     simple_count_noml,
+			     simple_count_dpcm);
+
 	dev_dbg(dev, "link %d, dais %d, ccnf %d\n",
 		li->link, li->dais, li->conf);
 }
 
-static int asoc_simple_soc_card_probe(struct snd_soc_card *card)
+static int simple_soc_probe(struct snd_soc_card *card)
 {
-	struct simple_card_data *priv = snd_soc_card_get_drvdata(card);
+	struct simple_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, PREFIX);
@@ -687,9 +688,9 @@ static int asoc_simple_soc_card_probe(struct snd_soc_card *card)
 	return 0;
 }
 
-static int asoc_simple_card_probe(struct platform_device *pdev)
+static int simple_probe(struct platform_device *pdev)
 {
-	struct simple_card_data *priv;
+	struct simple_priv *priv;
 	struct snd_soc_dai_link *dai_link;
 	struct simple_dai_props *dai_props;
 	struct asoc_simple_dai *dais;
@@ -708,10 +709,10 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	card = simple_priv_to_card(priv);
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
-	card->probe		= asoc_simple_soc_card_probe;
+	card->probe		= simple_soc_probe;
 
 	memset(&li, 0, sizeof(li));
-	asoc_simple_card_get_dais_count(priv, &li);
+	simple_get_dais_count(priv, &li);
 	if (!li.link || !li.dais)
 		return -EINVAL;
 
@@ -746,7 +747,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	if (np && of_device_is_available(np)) {
 
-		ret = asoc_simple_card_parse_of(priv);
+		ret = simple_parse_of(priv);
 		if (ret < 0) {
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "parse error %d\n", ret);
@@ -789,7 +790,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		dai_link->stream_name	= cinfo->name;
 		dai_link->cpu_dai_name	= cinfo->cpu_dai.name;
 		dai_link->dai_fmt	= cinfo->daifmt;
-		dai_link->init		= asoc_simple_card_dai_init;
+		dai_link->init		= simple_dai_init;
 		memcpy(priv->dai_props->cpu_dai, &cinfo->cpu_dai,
 					sizeof(*priv->dai_props->cpu_dai));
 		memcpy(priv->dai_props->codec_dai, &cinfo->codec_dai,
@@ -809,28 +810,28 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int asoc_simple_card_remove(struct platform_device *pdev)
+static int simple_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
 	return asoc_simple_card_clean_reference(card);
 }
 
-static const struct of_device_id asoc_simple_of_match[] = {
+static const struct of_device_id simple_of_match[] = {
 	{ .compatible = "simple-audio-card", },
 	{ .compatible = "simple-scu-audio-card", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, asoc_simple_of_match);
+MODULE_DEVICE_TABLE(of, simple_of_match);
 
 static struct platform_driver asoc_simple_card = {
 	.driver = {
 		.name = "asoc-simple-card",
 		.pm = &snd_soc_pm_ops,
-		.of_match_table = asoc_simple_of_match,
+		.of_match_table = simple_of_match,
 	},
-	.probe = asoc_simple_card_probe,
-	.remove = asoc_simple_card_remove,
+	.probe = simple_probe,
+	.remove = simple_remove,
 };
 
 module_platform_driver(asoc_simple_card);
-- 
2.20.1
