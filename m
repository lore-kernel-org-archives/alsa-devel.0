From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: support
	snd_soc_dai_link_component style for cpu" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:17 +0100 (BST)
Message-ID: <20190606212717.F0BBF440046@finisterre.sirena.org.uk>
References: <87ef47mkub.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEE1EF89813
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:18 +0200 (CEST)
In-Reply-To: <87ef47mkub.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: support snd_soc_dai_link_component style for cpu

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From f107294c6422e772773b53dbf802186175b6289e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:07:35 +0900
Subject: [PATCH] ASoC: simple-card: support snd_soc_dai_link_component style
 for cpu

ASoC supports modern style dai_link (= snd_soc_dai_link_component) for
CPU. legacy style dai_link (= cpu_dai_name, cpu_name, cpu_of_node) are
no longer needed.
This patch switches to modern style.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     | 20 +++++---------
 sound/soc/generic/audio-graph-card.c  | 30 ++++++---------------
 sound/soc/generic/simple-card-utils.c | 21 +++++----------
 sound/soc/generic/simple-card.c       | 39 ++++++++++-----------------
 4 files changed, 34 insertions(+), 76 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 3429888347e7..954563ee2277 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -42,6 +42,7 @@ struct asoc_simple_priv {
 	struct simple_dai_props {
 		struct asoc_simple_dai *cpu_dai;
 		struct asoc_simple_dai *codec_dai;
+		struct snd_soc_dai_link_component cpus;   /* single cpu */
 		struct snd_soc_dai_link_component codecs; /* single codec */
 		struct snd_soc_dai_link_component platforms;
 		struct asoc_simple_data adata;
@@ -80,16 +81,12 @@ int asoc_simple_parse_card_name(struct snd_soc_card *card,
 				char *prefix);
 
 #define asoc_simple_parse_clk_cpu(dev, node, dai_link, simple_dai)		\
-	asoc_simple_parse_clk(dev, node, dai_link->cpu_of_node, simple_dai, \
-				   dai_link->cpu_dai_name, NULL)
+	asoc_simple_parse_clk(dev, node, simple_dai, dai_link->cpus)
 #define asoc_simple_parse_clk_codec(dev, node, dai_link, simple_dai)	\
-	asoc_simple_parse_clk(dev, node, dai_link->codec_of_node, simple_dai,\
-				   dai_link->codec_dai_name, dai_link->codecs)
+	asoc_simple_parse_clk(dev, node, simple_dai, dai_link->codecs)
 int asoc_simple_parse_clk(struct device *dev,
 			  struct device_node *node,
-			  struct device_node *dai_of_node,
 			  struct asoc_simple_dai *simple_dai,
-			  const char *dai_name,
 			  struct snd_soc_dai_link_component *dlc);
 int asoc_simple_startup(struct snd_pcm_substream *substream);
 void asoc_simple_shutdown(struct snd_pcm_substream *substream);
@@ -100,16 +97,11 @@ int asoc_simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				   struct snd_pcm_hw_params *params);
 
 #define asoc_simple_parse_cpu(node, dai_link, is_single_link)	\
-	asoc_simple_parse_dai(node, NULL,				\
-		&dai_link->cpu_of_node,					\
-		&dai_link->cpu_dai_name, is_single_link)
+	asoc_simple_parse_dai(node, dai_link->cpus, is_single_link)
 #define asoc_simple_parse_codec(node, dai_link)	\
-	asoc_simple_parse_dai(node, dai_link->codecs,			\
-				   &dai_link->codec_of_node,			\
-				   &dai_link->codec_dai_name, NULL)
+	asoc_simple_parse_dai(node, dai_link->codecs, NULL)
 #define asoc_simple_parse_platform(node, dai_link)	\
-	asoc_simple_parse_dai(node, dai_link->platforms,			\
-		&dai_link->platform_of_node, NULL, NULL)
+	asoc_simple_parse_dai(node, dai_link->platforms, NULL)
 
 #define asoc_simple_parse_tdm(np, dai)			\
 	snd_soc_of_parse_tdm_slot(np,	&(dai)->tx_slot_mask,	\
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index ec7e673ba475..e438011f5e45 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -111,29 +111,14 @@ static int graph_get_dai_id(struct device_node *ep)
 
 static int asoc_simple_parse_dai(struct device_node *ep,
 				 struct snd_soc_dai_link_component *dlc,
-				 struct device_node **dai_of_node,
-				 const char **dai_name,
 				 int *is_single_link)
 {
 	struct device_node *node;
 	struct of_phandle_args args;
 	int ret;
 
-	/*
-	 * Use snd_soc_dai_link_component instead of legacy style.
-	 * It is only for codec, but cpu will be supported in the future.
-	 * see
-	 *	soc-core.c :: snd_soc_init_multicodec()
-	 */
-	if (dlc) {
-		dai_name	= &dlc->dai_name;
-		dai_of_node	= &dlc->of_node;
-	}
-
 	if (!ep)
 		return 0;
-	if (!dai_name)
-		return 0;
 
 	node = of_graph_get_port_parent(ep);
 
@@ -142,11 +127,11 @@ static int asoc_simple_parse_dai(struct device_node *ep,
 	args.args[0]	= graph_get_dai_id(ep);
 	args.args_count	= (of_graph_get_endpoint_count(node) > 1);
 
-	ret = snd_soc_get_dai_name(&args, dai_name);
+	ret = snd_soc_get_dai_name(&args, &dlc->dai_name);
 	if (ret < 0)
 		return ret;
 
-	*dai_of_node = node;
+	dlc->of_node = node;
 
 	if (is_single_link)
 		*is_single_link = of_graph_get_endpoint_count(node) == 1;
@@ -207,6 +192,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	struct device_node *ports;
 	struct device_node *node;
 	struct asoc_simple_dai *dai;
+	struct snd_soc_dai_link_component *cpus = dai_link->cpus;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	int ret;
 
@@ -251,7 +237,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "fe.%s",
-						   dai_link->cpu_dai_name);
+						   cpus->dai_name);
 		if (ret < 0)
 			return ret;
 
@@ -261,9 +247,9 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		struct snd_soc_codec_conf *cconf;
 
 		/* FE is dummy */
-		dai_link->cpu_of_node		= NULL;
-		dai_link->cpu_dai_name		= "snd-soc-dummy-dai";
-		dai_link->cpu_name		= "snd-soc-dummy";
+		cpus->of_node		= NULL;
+		cpus->dai_name		= "snd-soc-dummy-dai";
+		cpus->name		= "snd-soc-dummy";
 
 		/* BE settings */
 		dai_link->no_pcm		= 1;
@@ -383,7 +369,7 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 
 	ret = asoc_simple_set_dailink_name(dev, dai_link,
 					   "%s-%s",
-					   dai_link->cpu_dai_name,
+					   dai_link->cpus->dai_name,
 					   dai_link->codecs->dai_name);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index f4c6375d11c7..ac8678fe55ff 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -159,23 +159,12 @@ static void asoc_simple_clk_disable(struct asoc_simple_dai *dai)
 
 int asoc_simple_parse_clk(struct device *dev,
 			  struct device_node *node,
-			  struct device_node *dai_of_node,
 			  struct asoc_simple_dai *simple_dai,
-			  const char *dai_name,
 			  struct snd_soc_dai_link_component *dlc)
 {
 	struct clk *clk;
 	u32 val;
 
-	/*
-	 * Use snd_soc_dai_link_component instead of legacy style.
-	 * It is only for codec, but cpu will be supported in the future.
-	 * see
-	 *	soc-core.c :: snd_soc_init_multicodec()
-	 */
-	if (dlc)
-		dai_of_node	= dlc->of_node;
-
 	/*
 	 * Parse dai->sysclk come from "clocks = <&xxx>"
 	 * (if system has common clock)
@@ -190,7 +179,7 @@ int asoc_simple_parse_clk(struct device *dev,
 	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
 		simple_dai->sysclk = val;
 	} else {
-		clk = devm_get_clk_from_child(dev, dai_of_node, NULL);
+		clk = devm_get_clk_from_child(dev, dlc->of_node, NULL);
 		if (!IS_ERR(clk))
 			simple_dai->sysclk = clk_get_rate(clk);
 	}
@@ -359,7 +348,7 @@ void asoc_simple_canonicalize_platform(struct snd_soc_dai_link *dai_link)
 {
 	/* Assumes platform == cpu */
 	if (!dai_link->platforms->of_node)
-		dai_link->platforms->of_node = dai_link->cpu_of_node;
+		dai_link->platforms->of_node = dai_link->cpus->of_node;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_canonicalize_platform);
 
@@ -376,7 +365,7 @@ void asoc_simple_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 	 *	fmt_multiple_name()
 	 */
 	if (is_single_links)
-		dai_link->cpu_dai_name = NULL;
+		dai_link->cpus->dai_name = NULL;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_canonicalize_cpu);
 
@@ -386,7 +375,7 @@ int asoc_simple_clean_reference(struct snd_soc_card *card)
 	int i;
 
 	for_each_card_prelinks(card, i, dai_link) {
-		of_node_put(dai_link->cpu_of_node);
+		of_node_put(dai_link->cpus->of_node);
 		of_node_put(dai_link->codecs->of_node);
 	}
 	return 0;
@@ -576,6 +565,8 @@ int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 	 *	simple-card-utils.c :: asoc_simple_canonicalize_platform()
 	 */
 	for (i = 0; i < li->link; i++) {
+		dai_link[i].cpus		= &dai_props[i].cpus;
+		dai_link[i].num_cpus		= 1;
 		dai_link[i].codecs		= &dai_props[i].codecs;
 		dai_link[i].num_codecs		= 1;
 		dai_link[i].platforms		= &dai_props[i].platforms;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d16e894fce2b..e5cde0d5e63c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -30,8 +30,6 @@ static const struct snd_soc_ops simple_ops = {
 
 static int asoc_simple_parse_dai(struct device_node *node,
 				 struct snd_soc_dai_link_component *dlc,
-				 struct device_node **dai_of_node,
-				 const char **dai_name,
 				 int *is_single_link)
 {
 	struct of_phandle_args args;
@@ -40,17 +38,6 @@ static int asoc_simple_parse_dai(struct device_node *node,
 	if (!node)
 		return 0;
 
-	/*
-	 * Use snd_soc_dai_link_component instead of legacy style.
-	 * It is only for codec, but cpu will be supported in the future.
-	 * see
-	 *	soc-core.c :: snd_soc_init_multicodec()
-	 */
-	if (dlc) {
-		dai_name	= &dlc->dai_name;
-		dai_of_node	= &dlc->of_node;
-	}
-
 	/*
 	 * Get node via "sound-dai = <&phandle port>"
 	 * it will be used as xxx_of_node on soc_bind_dai_link()
@@ -60,13 +47,11 @@ static int asoc_simple_parse_dai(struct device_node *node,
 		return ret;
 
 	/* Get dai->name */
-	if (dai_name) {
-		ret = snd_soc_of_get_dai_name(node, dai_name);
-		if (ret < 0)
-			return ret;
-	}
+	ret = snd_soc_of_get_dai_name(node, &dlc->dai_name);
+	if (ret < 0)
+		return ret;
 
-	*dai_of_node = args.np;
+	dlc->of_node = args.np;
 
 	if (is_single_link)
 		*is_single_link = !args.args_count;
@@ -119,6 +104,7 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, li->link);
 	struct asoc_simple_dai *dai;
+	struct snd_soc_dai_link_component *cpus = dai_link->cpus;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	struct device_node *top = dev->of_node;
 	struct device_node *node = of_get_parent(np);
@@ -169,7 +155,7 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "fe.%s",
-						   dai_link->cpu_dai_name);
+						   cpus->dai_name);
 		if (ret < 0)
 			return ret;
 
@@ -178,9 +164,9 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		struct snd_soc_codec_conf *cconf;
 
 		/* FE is dummy */
-		dai_link->cpu_of_node		= NULL;
-		dai_link->cpu_dai_name		= "snd-soc-dummy-dai";
-		dai_link->cpu_name		= "snd-soc-dummy";
+		cpus->of_node		= NULL;
+		cpus->dai_name		= "snd-soc-dummy-dai";
+		cpus->name		= "snd-soc-dummy";
 
 		/* BE settings */
 		dai_link->no_pcm		= 1;
@@ -320,7 +306,7 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 
 	ret = asoc_simple_set_dailink_name(dev, dai_link,
 					   "%s-%s",
-					   dai_link->cpu_dai_name,
+					   dai_link->cpus->dai_name,
 					   dai_link->codecs->dai_name);
 	if (ret < 0)
 		goto dai_link_of_err;
@@ -646,6 +632,7 @@ static int asoc_simple_probe(struct platform_device *pdev)
 
 	} else {
 		struct asoc_simple_card_info *cinfo;
+		struct snd_soc_dai_link_component *cpus;
 		struct snd_soc_dai_link_component *codecs;
 		struct snd_soc_dai_link_component *platform;
 		struct snd_soc_dai_link *dai_link = priv->dai_link;
@@ -671,6 +658,9 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		dai_props->cpu_dai	= &priv->dais[dai_idx++];
 		dai_props->codec_dai	= &priv->dais[dai_idx++];
 
+		cpus			= dai_link->cpus;
+		cpus->dai_name		= cinfo->cpu_dai.name;
+
 		codecs			= dai_link->codecs;
 		codecs->name		= cinfo->codec;
 		codecs->dai_name	= cinfo->codec_dai.name;
@@ -681,7 +671,6 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
 		dai_link->name		= cinfo->name;
 		dai_link->stream_name	= cinfo->name;
-		dai_link->cpu_dai_name	= cinfo->cpu_dai.name;
 		dai_link->dai_fmt	= cinfo->daifmt;
 		dai_link->init		= asoc_simple_dai_init;
 		memcpy(dai_props->cpu_dai, &cinfo->cpu_dai,
-- 
2.20.1
