From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: cleanup DAI link loop
	method - step1" to the asoc tree
Date: Mon,  7 Jan 2019 12:31:10 +0000 (GMT)
Message-ID: <20190107123110.24A171127490@debutante.sirena.org.uk>
References: <87imzp7zcc.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CE261267C33
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:31:10 +0100 (CET)
In-Reply-To: <87imzp7zcc.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: cleanup DAI link loop method - step1

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

>From d947cdfd4be29c48c6c529c2b5ce7b1988387c67 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:47:23 +0900
Subject: [PATCH] ASoC: simple-card: cleanup DAI link loop method - step1

Current simple-card is parsing DAI link for both "normal sound" and
"DPCM sound". On this driver, it needs to count and parse
DAIs/Links/Codec Conf from each links.
Then, counting/parsing link loop are very similar, but using different
implementation. Because of this background, the link loop code is very
mysterious. Mystery code will be trouble in the future.

This patch adds/modifies counting and parsing function for
"normal sound" and "DPCM sound", and call it from link loop.
This is prepare for cleanup DAI link loop method.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 210 +++++++++++++++++++++-----------
 1 file changed, 137 insertions(+), 73 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 3820ad719059..4987db667165 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -187,32 +187,43 @@ static void asoc_simple_card_get_conversion(struct device *dev,
 	of_node_put(node);
 }
 
-static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
-					     struct device_node *node,
+static int asoc_simple_card_dai_link_of_dpcm(struct simple_card_data *priv,
 					     struct device_node *np,
 					     struct device_node *codec,
-					     struct simple_card_data *priv,
 					     struct link_info *li,
-					     bool is_top_level_node)
+					     bool is_top)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, li->link);
 	struct asoc_simple_dai *dai;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
+	struct device_node *top = dev->of_node;
+	struct device_node *node = of_get_parent(np);
 	char prop[128];
 	char *prefix = "";
 	int ret;
 
+	/*
+	 *	 |CPU   |Codec   : turn
+	 * CPU	 |Pass  |return
+	 * Codec |return|Pass
+	 * np
+	 */
+	if (li->cpu == (np == codec))
+		return 0;
+
 	dev_dbg(dev, "link_of DPCM (%pOF)\n", np);
 
 	li->link++;
 
+	of_node_put(node);
+
 	/* For single DAI link & old style of DT node */
-	if (is_top_level_node)
+	if (is_top)
 		prefix = PREFIX;
 
-	if (np != codec) {
+	if (li->cpu) {
 		int is_single_links = 0;
 
 		/* BE is dummy */
@@ -312,53 +323,47 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 	return 0;
 }
 
-static int asoc_simple_card_dai_link_of(struct device_node *top,
-					struct device_node *node,
-					struct simple_card_data *priv,
+static int asoc_simple_card_dai_link_of(struct simple_card_data *priv,
+					struct device_node *np,
+					struct device_node *codec,
 					struct link_info *li,
-					bool is_top_level_node)
+					bool is_top)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, li->link);
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
+	struct device_node *top = dev->of_node;
 	struct device_node *cpu = NULL;
+	struct device_node *node = NULL;
 	struct device_node *plat = NULL;
-	struct device_node *codec = NULL;
 	char prop[128];
 	char *prefix = "";
 	int ret, single_cpu;
 
+	/*
+	 *	 |CPU   |Codec   : turn
+	 * CPU	 |Pass  |return
+	 * Codec |return|return
+	 * np
+	 */
+	if (!li->cpu || np == codec)
+		return 0;
+
+	cpu  = np;
+	node = of_get_parent(np);
 	li->link++;
 
 	dev_dbg(dev, "link_of (%pOF)\n", node);
 
 	/* For single DAI link & old style of DT node */
-	if (is_top_level_node)
+	if (is_top)
 		prefix = PREFIX;
 
-	snprintf(prop, sizeof(prop), "%scpu", prefix);
-	cpu = of_get_child_by_name(node, prop);
-
-	if (!cpu) {
-		ret = -EINVAL;
-		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
-		goto dai_link_of_err;
-	}
-
 	snprintf(prop, sizeof(prop), "%splat", prefix);
 	plat = of_get_child_by_name(node, prop);
 
-	snprintf(prop, sizeof(prop), "%scodec", prefix);
-	codec = of_get_child_by_name(node, prop);
-
-	if (!codec) {
-		ret = -EINVAL;
-		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
-		goto dai_link_of_err;
-	}
-
 	cpu_dai			=
 	dai_props->cpu_dai	= &priv->dais[li->dais++];
 	codec_dai		=
@@ -421,8 +426,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *top,
 	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
 
 dai_link_of_err:
-	of_node_put(cpu);
-	of_node_put(codec);
+	of_node_put(node);
 
 	return ret;
 }
@@ -464,9 +468,6 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	struct device_node *top = dev->of_node;
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct device_node *node;
-	struct device_node *np;
-	struct device_node *codec;
-	struct asoc_simple_card_data adata;
 	struct link_info li;
 	int ret, loop;
 
@@ -483,6 +484,10 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 
 	/* Single/Muti DAI link(s) & New style of DT node */
 	memset(&li, 0, sizeof(li));
+
+	/* FIXME */
+	li.cpu = 1;
+parse_loop:
 	loop		= 1;
 	node = of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
@@ -491,37 +496,59 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	}
 
 	do  {
+		struct asoc_simple_card_data adata;
+		struct device_node *codec;
+		struct device_node *np;
+		int num = of_get_child_count(node);
+		int ret;
+
+		codec = of_get_child_by_name(node, !loop ?
+					     PREFIX "codec" : "codec");
+		if (!codec)
+			return -ENODEV;
+
+		of_node_put(codec);
+
 		memset(&adata, 0, sizeof(adata));
 		for_each_child_of_node(node, np)
 			asoc_simple_card_get_conversion(dev, np, &adata);
 
-		/* DPCM */
-		if (of_get_child_count(node) > 2 ||
-		    adata.convert_rate || adata.convert_channels) {
-			for_each_child_of_node(node, np) {
-				codec = of_get_child_by_name(node,
-							loop ?	"codec" :
-								PREFIX "codec");
-				if (!codec)
-					return -ENODEV;
-
+		/*
+		 * Detect all CPU first, and Detect all Codec 2nd.
+		 *
+		 * In Normal sound case, all DAIs are detected
+		 * as "CPU-Codec".
+		 *
+		 * In DPCM sound case,
+		 * all CPUs   are detected as "CPU-dummy", and
+		 * all Codecs are detected as "dummy-Codec".
+		 * To avoid random sub-device numbering,
+		 * detect "dummy-Codec" in last;
+		 */
+
+		/* loop for all CPU/Codec node */
+		for_each_child_of_node(node, np) {
+			if (num > 2 ||
+			    adata.convert_rate || adata.convert_channels) {
 				ret = asoc_simple_card_dai_link_of_dpcm(
-						top, node, np, codec, priv,
-						&li, !loop);
+					priv, np, codec, &li, !loop);
+				if (ret < 0)
+					return ret;
+			} else {
+				ret = asoc_simple_card_dai_link_of(
+					priv, np, codec, &li, !loop);
 				if (ret < 0)
 					return ret;
 			}
-		} else {
-			ret = asoc_simple_card_dai_link_of(
-						top, node, priv,
-						&li, !loop);
-			if (ret < 0)
-				return ret;
 		}
-
 		node = of_get_next_child(top, node);
 	} while (loop && node);
 
+	/* FIXME */
+	li.cpu--;
+	if (li.cpu >= 0)
+		goto parse_loop;
+
 	ret = asoc_simple_card_parse_card_name(card, PREFIX);
 	if (ret < 0)
 		return ret;
@@ -531,12 +558,39 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	return ret;
 }
 
-static void asoc_simple_card_get_dais_count(struct device *dev,
+static int asoc_simple_card_count_noml(struct simple_card_data *priv,
+				       struct device_node *np,
+				       struct device_node *codec,
+				       struct link_info *li, bool is_top)
+{
+	li->dais++; /* CPU or Codec */
+	if (np != codec)
+		li->link++; /* CPU-Codec */
+
+	return 0;
+}
+
+static int asoc_simple_card_count_dpcm(struct simple_card_data *priv,
+				       struct device_node *np,
+				       struct device_node *codec,
+				       struct link_info *li, bool is_top)
+{
+	li->dais++; /* CPU or Codec */
+	li->link++; /* CPU-dummy or dummy-Codec */
+	if (np == codec)
+		li->conf++;
+
+	return 0;
+}
+
+static void asoc_simple_card_get_dais_count(struct simple_card_data *priv,
 					    struct link_info *li)
 {
+	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *top = dev->of_node;
 	struct device_node *node;
 	struct device_node *np;
+	struct device_node *codec;
 	struct asoc_simple_card_data adata;
 	int loop;
 	int num;
@@ -602,18 +656,28 @@ static void asoc_simple_card_get_dais_count(struct device *dev,
 	}
 
 	do {
+		num = of_get_child_count(node);
+
+		codec = of_get_child_by_name(node, !loop ?
+					     PREFIX "codec" : "codec");
+		if (!codec)
+			return;
+
+		of_node_put(codec);
+
 		memset(&adata, 0, sizeof(adata));
 		for_each_child_of_node(node, np)
 			asoc_simple_card_get_conversion(dev, np, &adata);
 
-		num = of_get_child_count(node);
-		li->dais += num;
-		if (num > 2 ||
-		    adata.convert_rate || adata.convert_channels) {
-			li->link += num;
-			li->conf++;
-		} else {
-			li->link++;
+		for_each_child_of_node(node, np) {
+			if (num > 2 ||
+			    adata.convert_rate || adata.convert_channels) {
+				asoc_simple_card_count_dpcm(priv, np, codec,
+							    li, !loop);
+			} else {
+				asoc_simple_card_count_noml(priv, np, codec,
+							    li, !loop);
+			}
 		}
 		node = of_get_next_child(top, node);
 	} while (loop && node);
@@ -653,8 +717,13 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	card = simple_priv_to_card(priv);
+	card->owner		= THIS_MODULE;
+	card->dev		= dev;
+	card->probe		= asoc_simple_soc_card_probe;
+
 	memset(&li, 0, sizeof(li));
-	asoc_simple_card_get_dais_count(dev, &li);
+	asoc_simple_card_get_dais_count(priv, &li);
 	if (!li.link || !li.dais)
 		return -EINVAL;
 
@@ -677,20 +746,15 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		dai_link[i].platform	= &dai_props[i].platform;
 	}
 
-	priv->dai_props			= dai_props;
-	priv->dai_link			= dai_link;
-	priv->dais			= dais;
-	priv->codec_conf		= cconf;
+	priv->dai_props		= dai_props;
+	priv->dai_link		= dai_link;
+	priv->dais		= dais;
+	priv->codec_conf	= cconf;
 
-	/* Init snd_soc_card */
-	card = simple_priv_to_card(priv);
-	card->owner		= THIS_MODULE;
-	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
 	card->num_links		= li.link;
 	card->codec_conf	= cconf;
 	card->num_configs	= li.conf;
-	card->probe		= asoc_simple_soc_card_probe;
 
 	if (np && of_device_is_available(np)) {
 
-- 
2.20.1
