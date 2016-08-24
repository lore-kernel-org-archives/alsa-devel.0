From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: rename rsrc-card to
	simple-scu-card phase1" to the asoc tree
Date: Wed, 24 Aug 2016 12:20:26 +0100
Message-ID: <E1bcWEM-000079-2z@debutante>
References: <87bn0ki8d0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4258726721C
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 13:20:35 +0200 (CEST)
In-Reply-To: <87bn0ki8d0.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: rename rsrc-card to simple-scu-card phase1

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 53e682b60019d501e00cfeb701f99ca027470e36 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Aug 2016 01:34:17 +0000
Subject: [PATCH] ASoC: rsrc-card: rename rsrc-card to simple-scu-card phase1

rsrc-card which is using DPCM feature was created for Renesas sound.
But not only Renesas, but many SoC can use this driver, because
it is based on simple-card driver.
To use it as more open driver, rsrc-card will be renamed to
simple-scu-card. In order to easy patch review, as 1st step,
this patch renames "rsrc" function prefix to "asoc_simple".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 108 +++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index ce9f91143f1f..a0d0f3679eeb 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -1,5 +1,5 @@
 /*
- * Renesas Sampling Rate Convert Sound Card for DPCM
+ * ASoC simple SCU sound card support
  *
  * Copyright (C) 2015 Renesas Solutions Corp.
  * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
@@ -22,21 +22,21 @@
 #include <sound/soc-dai.h>
 #include <sound/simple_card_utils.h>
 
-struct rsrc_card_of_data {
+struct asoc_simple_card_of_data {
 	const char *prefix;
 	const struct snd_soc_dapm_route *routes;
 	int num_routes;
 };
 
-static const struct of_device_id rsrc_card_of_match[] = {
+static const struct of_device_id asoc_simple_card_of_match[] = {
 	{ .compatible = "renesas,rsrc-card", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, rsrc_card_of_match);
+MODULE_DEVICE_TABLE(of, asoc_simple_card_of_match);
 
 #define IDX_CPU		0
 #define IDX_CODEC	1
-struct rsrc_card_priv {
+struct asoc_simple_card_priv {
 	struct snd_soc_card snd_card;
 	struct snd_soc_codec_conf codec_conf;
 	struct asoc_simple_dai *dai_props;
@@ -45,48 +45,48 @@ struct rsrc_card_priv {
 	u32 convert_channels;
 };
 
-#define rsrc_priv_to_dev(priv) ((priv)->snd_card.dev)
-#define rsrc_priv_to_link(priv, i) ((priv)->snd_card.dai_link + (i))
-#define rsrc_priv_to_props(priv, i) ((priv)->dai_props + (i))
+#define simple_priv_to_dev(priv) ((priv)->snd_card.dev)
+#define simple_priv_to_link(priv, i) ((priv)->snd_card.dai_link + (i))
+#define simple_priv_to_props(priv, i) ((priv)->dai_props + (i))
 
 #define DAI	"sound-dai"
 #define CELL	"#sound-dai-cells"
 
-static int rsrc_card_startup(struct snd_pcm_substream *substream)
+static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct rsrc_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct asoc_simple_dai *dai_props =
-		rsrc_priv_to_props(priv, rtd->num);
+		simple_priv_to_props(priv, rtd->num);
 
 	return clk_prepare_enable(dai_props->clk);
 }
 
-static void rsrc_card_shutdown(struct snd_pcm_substream *substream)
+static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct rsrc_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct asoc_simple_dai *dai_props =
-		rsrc_priv_to_props(priv, rtd->num);
+		simple_priv_to_props(priv, rtd->num);
 
 	clk_disable_unprepare(dai_props->clk);
 }
 
-static struct snd_soc_ops rsrc_card_ops = {
-	.startup = rsrc_card_startup,
-	.shutdown = rsrc_card_shutdown,
+static struct snd_soc_ops asoc_simple_card_ops = {
+	.startup = asoc_simple_card_startup,
+	.shutdown = asoc_simple_card_shutdown,
 };
 
-static int rsrc_card_dai_init(struct snd_soc_pcm_runtime *rtd)
+static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct rsrc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dai_props;
 	int num = rtd->num;
 
-	dai_link	= rsrc_priv_to_link(priv, num);
-	dai_props	= rsrc_priv_to_props(priv, num);
+	dai_link	= simple_priv_to_link(priv, num);
+	dai_props	= simple_priv_to_props(priv, num);
 	dai		= dai_link->dynamic ?
 				rtd->cpu_dai :
 				rtd->codec_dai;
@@ -94,10 +94,10 @@ static int rsrc_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return asoc_simple_card_init_dai(dai, dai_props);
 }
 
-static int rsrc_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					struct snd_pcm_hw_params *params)
 {
-	struct rsrc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct asoc_simple_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_interval *rate = hw_param_interval(params,
 						      SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
@@ -114,13 +114,13 @@ static int rsrc_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int rsrc_card_parse_links(struct device_node *np,
-				 struct rsrc_card_priv *priv,
-				 int idx, bool is_fe)
+static int asoc_simple_card_parse_links(struct device_node *np,
+					struct asoc_simple_card_priv *priv,
+					int idx, bool is_fe)
 {
-	struct device *dev = rsrc_priv_to_dev(priv);
-	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
-	struct asoc_simple_dai *dai_props = rsrc_priv_to_props(priv, idx);
+	struct device *dev = simple_priv_to_dev(priv);
+	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
+	struct asoc_simple_dai *dai_props = simple_priv_to_props(priv, idx);
 	int ret;
 
 	/* Parse TDM slot */
@@ -161,7 +161,7 @@ static int rsrc_card_parse_links(struct device_node *np,
 
 		asoc_simple_card_canonicalize_cpu(dai_link, is_single_links);
 	} else {
-		const struct rsrc_card_of_data *of_data;
+		const struct asoc_simple_card_of_data *of_data;
 
 		of_data = of_device_get_match_data(dev);
 
@@ -172,7 +172,7 @@ static int rsrc_card_parse_links(struct device_node *np,
 
 		/* BE settings */
 		dai_link->no_pcm		= 1;
-		dai_link->be_hw_params_fixup	= rsrc_card_be_hw_params_fixup;
+		dai_link->be_hw_params_fixup	= asoc_simple_card_be_hw_params_fixup;
 
 		ret = asoc_simple_card_parse_codec(np, dai_link, DAI, CELL);
 		if (ret < 0)
@@ -206,8 +206,8 @@ static int rsrc_card_parse_links(struct device_node *np,
 
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
-	dai_link->ops			= &rsrc_card_ops;
-	dai_link->init			= rsrc_card_dai_init;
+	dai_link->ops			= &asoc_simple_card_ops;
+	dai_link->init			= asoc_simple_card_dai_init;
 
 	dev_dbg(dev, "\t%s / %04x / %d\n",
 		dai_link->name,
@@ -217,10 +217,10 @@ static int rsrc_card_parse_links(struct device_node *np,
 	return 0;
 }
 
-static int rsrc_card_dai_link_of(struct device_node *node,
-				 struct rsrc_card_priv *priv)
+static int asoc_simple_card_dai_link_of(struct device_node *node,
+				 struct asoc_simple_card_priv *priv)
 {
-	struct device *dev = rsrc_priv_to_dev(priv);
+	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link;
 	struct device_node *np;
 	unsigned int daifmt = 0;
@@ -230,7 +230,7 @@ static int rsrc_card_dai_link_of(struct device_node *node,
 	/* find 1st codec */
 	i = 0;
 	for_each_child_of_node(node, np) {
-		dai_link = rsrc_priv_to_link(priv, i);
+		dai_link = simple_priv_to_link(priv, i);
 
 		if (strcmp(np->name, "codec") == 0) {
 			ret = asoc_simple_card_parse_daifmt(dev, node, np,
@@ -244,14 +244,14 @@ static int rsrc_card_dai_link_of(struct device_node *node,
 
 	i = 0;
 	for_each_child_of_node(node, np) {
-		dai_link = rsrc_priv_to_link(priv, i);
+		dai_link = simple_priv_to_link(priv, i);
 		dai_link->dai_fmt = daifmt;
 
 		is_fe = false;
 		if (strcmp(np->name, "cpu") == 0)
 			is_fe = true;
 
-		ret = rsrc_card_parse_links(np, priv, i, is_fe);
+		ret = asoc_simple_card_parse_links(np, priv, i, is_fe);
 		if (ret < 0)
 			return ret;
 		i++;
@@ -260,11 +260,11 @@ static int rsrc_card_dai_link_of(struct device_node *node,
 	return 0;
 }
 
-static int rsrc_card_parse_of(struct device_node *node,
-			      struct rsrc_card_priv *priv,
+static int asoc_simple_card_parse_of(struct device_node *node,
+			      struct asoc_simple_card_priv *priv,
 			      struct device *dev)
 {
-	const struct rsrc_card_of_data *of_data = of_device_get_match_data(dev);
+	const struct asoc_simple_card_of_data *of_data = of_device_get_match_data(dev);
 	struct asoc_simple_dai *props;
 	struct snd_soc_dai_link *links;
 	int ret;
@@ -309,7 +309,7 @@ static int rsrc_card_parse_of(struct device_node *node,
 	dev_dbg(dev, "SRC : convert_rate     %d\n", priv->convert_rate);
 	dev_dbg(dev, "CTU : convert_channels %d\n", priv->convert_channels);
 
-	ret = rsrc_card_dai_link_of(node, priv);
+	ret = asoc_simple_card_dai_link_of(node, priv);
 	if (ret < 0)
 		return ret;
 
@@ -320,9 +320,9 @@ static int rsrc_card_parse_of(struct device_node *node,
 	return 0;
 }
 
-static int rsrc_card_probe(struct platform_device *pdev)
+static int asoc_simple_card_probe(struct platform_device *pdev)
 {
-	struct rsrc_card_priv *priv;
+	struct asoc_simple_card_priv *priv;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -332,7 +332,7 @@ static int rsrc_card_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	ret = rsrc_card_parse_of(np, priv, dev);
+	ret = asoc_simple_card_parse_of(np, priv, dev);
 	if (ret < 0) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "parse error %d\n", ret);
@@ -350,25 +350,25 @@ err:
 	return ret;
 }
 
-static int rsrc_card_remove(struct platform_device *pdev)
+static int asoc_simple_card_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
 	return asoc_simple_card_clean_reference(card);
 }
 
-static struct platform_driver rsrc_card = {
+static struct platform_driver asoc_simple_card = {
 	.driver = {
 		.name = "renesas-src-audio-card",
-		.of_match_table = rsrc_card_of_match,
+		.of_match_table = asoc_simple_card_of_match,
 	},
-	.probe = rsrc_card_probe,
-	.remove = rsrc_card_remove,
+	.probe = asoc_simple_card_probe,
+	.remove = asoc_simple_card_remove,
 };
 
-module_platform_driver(rsrc_card);
+module_platform_driver(asoc_simple_card);
 
-MODULE_ALIAS("platform:renesas-src-audio-card");
+MODULE_ALIAS("platform:asoc-simple-scu-card");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Renesas Sampling Rate Convert Sound Card");
+MODULE_DESCRIPTION("ASoC Simple SCU Sound Card");
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
-- 
2.8.1
