From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: separate
	asoc_simple_card_parse_dai()" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:47 +0000 (GMT)
Message-ID: <20190321150647.91F9411288EC@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C76B4F8970F
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:48 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: separate asoc_simple_card_parse_dai()

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

>From 8f7f298a333761a528e103cda3b42f3a416ad1ee Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:56:36 +0900
Subject: [PATCH] ASoC: simple-card-utils: separate
 asoc_simple_card_parse_dai()

The difference between simple-card / audio-graph are just using
OF graph style, or not. In other words, other things should be same.
This means, simple-card/audio-graph common functions should be
implemented at simple-card-utils, and its own functions should be
implemented at each files.

Current simple-card / audio-graph are using
asoc_simple_card_parse_dai() which is different implementation.
But, these are implemanted at simple-card-utils.
It should be implemanted at each files.
This patch separate these into each files.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  39 ++-----
 sound/soc/generic/audio-graph-card.c  | 114 ++++++++++++++++++--
 sound/soc/generic/simple-card-utils.c | 143 --------------------------
 sound/soc/generic/simple-card.c       |  58 +++++++++--
 4 files changed, 164 insertions(+), 190 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index c0be02de6993..0c070c2bc119 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -99,40 +99,17 @@ int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd);
 int asoc_simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				   struct snd_pcm_hw_params *params);
 
-#define asoc_simple_card_parse_cpu(node, dai_link,				\
-				   list_name, cells_name, is_single_link)	\
-	asoc_simple_card_parse_dai(node, NULL,					\
-		&dai_link->cpu_of_node,						\
-		&dai_link->cpu_dai_name, list_name, cells_name, is_single_link)
-#define asoc_simple_card_parse_codec(node, dai_link, list_name, cells_name)	\
+#define asoc_simple_card_parse_cpu(node, dai_link, is_single_link)	\
+	asoc_simple_card_parse_dai(node, NULL,				\
+		&dai_link->cpu_of_node,					\
+		&dai_link->cpu_dai_name, is_single_link)
+#define asoc_simple_card_parse_codec(node, dai_link)	\
 	asoc_simple_card_parse_dai(node, dai_link->codecs,			\
 				   &dai_link->codec_of_node,			\
-				   &dai_link->codec_dai_name,			\
-				   list_name, cells_name, NULL)
-#define asoc_simple_card_parse_platform(node, dai_link, list_name, cells_name)	\
+				   &dai_link->codec_dai_name, NULL)
+#define asoc_simple_card_parse_platform(node, dai_link)	\
 	asoc_simple_card_parse_dai(node, dai_link->platforms,			\
-		&dai_link->platform_of_node,					\
-		NULL, list_name, cells_name, NULL)
-int asoc_simple_card_parse_dai(struct device_node *node,
-				  struct snd_soc_dai_link_component *dlc,
-				  struct device_node **endpoint_np,
-				  const char **dai_name,
-				  const char *list_name,
-				  const char *cells_name,
-				  int *is_single_links);
-
-#define asoc_simple_card_parse_graph_cpu(ep, dai_link)			\
-	asoc_simple_card_parse_graph_dai(ep, NULL,			\
-					 &dai_link->cpu_of_node,	\
-					 &dai_link->cpu_dai_name)
-#define asoc_simple_card_parse_graph_codec(ep, dai_link)		\
-	asoc_simple_card_parse_graph_dai(ep, dai_link->codecs,		\
-					 &dai_link->codec_of_node,	\
-					 &dai_link->codec_dai_name)
-int asoc_simple_card_parse_graph_dai(struct device_node *ep,
-				     struct snd_soc_dai_link_component *dlc,
-				     struct device_node **endpoint_np,
-				     const char **dai_name);
+		&dai_link->platform_of_node, NULL, NULL)
 
 #define asoc_simple_card_of_parse_tdm(np, dai)			\
 	snd_soc_of_parse_tdm_slot(np,	&(dai)->tx_slot_mask,	\
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index b9a93379098d..3370b6fc6da2 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -55,6 +55,103 @@ static const struct snd_soc_ops graph_ops = {
 	.hw_params	= asoc_simple_hw_params,
 };
 
+static int graph_get_dai_id(struct device_node *ep)
+{
+	struct device_node *node;
+	struct device_node *endpoint;
+	struct of_endpoint info;
+	int i, id;
+	int ret;
+
+	/* use driver specified DAI ID if exist */
+	ret = snd_soc_get_dai_id(ep);
+	if (ret != -ENOTSUPP)
+		return ret;
+
+	/* use endpoint/port reg if exist */
+	ret = of_graph_parse_endpoint(ep, &info);
+	if (ret == 0) {
+		/*
+		 * Because it will count port/endpoint if it doesn't have "reg".
+		 * But, we can't judge whether it has "no reg", or "reg = <0>"
+		 * only of_graph_parse_endpoint().
+		 * We need to check "reg" property
+		 */
+		if (of_get_property(ep,   "reg", NULL))
+			return info.id;
+
+		node = of_get_parent(ep);
+		of_node_put(node);
+		if (of_get_property(node, "reg", NULL))
+			return info.port;
+	}
+	node = of_graph_get_port_parent(ep);
+
+	/*
+	 * Non HDMI sound case, counting port/endpoint on its DT
+	 * is enough. Let's count it.
+	 */
+	i = 0;
+	id = -1;
+	for_each_endpoint_of_node(node, endpoint) {
+		if (endpoint == ep)
+			id = i;
+		i++;
+	}
+
+	of_node_put(node);
+
+	if (id < 0)
+		return -ENODEV;
+
+	return id;
+}
+
+static int asoc_simple_card_parse_dai(struct device_node *ep,
+				      struct snd_soc_dai_link_component *dlc,
+				      struct device_node **dai_of_node,
+				      const char **dai_name,
+				      int *is_single_link)
+{
+	struct device_node *node;
+	struct of_phandle_args args;
+	int ret;
+
+	/*
+	 * Use snd_soc_dai_link_component instead of legacy style.
+	 * It is only for codec, but cpu will be supported in the future.
+	 * see
+	 *	soc-core.c :: snd_soc_init_multicodec()
+	 */
+	if (dlc) {
+		dai_name	= &dlc->dai_name;
+		dai_of_node	= &dlc->of_node;
+	}
+
+	if (!ep)
+		return 0;
+	if (!dai_name)
+		return 0;
+
+	node = of_graph_get_port_parent(ep);
+
+	/* Get dai->name */
+	args.np		= node;
+	args.args[0]	= graph_get_dai_id(ep);
+	args.args_count	= (of_graph_get_endpoint_count(node) > 1);
+
+	ret = snd_soc_get_dai_name(&args, dai_name);
+	if (ret < 0)
+		return ret;
+
+	*dai_of_node = node;
+
+	if (is_single_link)
+		*is_single_link = of_graph_get_endpoint_count(node) == 1;
+
+	return 0;
+}
+
 static void graph_parse_convert(struct device *dev,
 				struct device_node *ep,
 				struct asoc_simple_card_data *adata)
@@ -128,6 +225,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	of_node_put(node);
 
 	if (li->cpu) {
+		int is_single_links = 0;
 
 		/* BE is dummy */
 		codecs->of_node		= NULL;
@@ -141,7 +239,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		dai =
 		dai_props->cpu_dai	= &priv->dais[li->dais++];
 
-		ret = asoc_simple_card_parse_graph_cpu(ep, dai_link);
+		ret = asoc_simple_card_parse_cpu(ep, dai_link, &is_single_links);
 		if (ret)
 			return ret;
 
@@ -156,8 +254,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 			return ret;
 
 		/* card->num_links includes Codec */
-		asoc_simple_card_canonicalize_cpu(dai_link,
-			of_graph_get_endpoint_count(dai_link->cpu_of_node) == 1);
+		asoc_simple_card_canonicalize_cpu(dai_link, is_single_links);
 	} else {
 		struct snd_soc_codec_conf *cconf;
 
@@ -176,7 +273,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		cconf =
 		dai_props->codec_conf	= &priv->codec_conf[li->conf++];
 
-		ret = asoc_simple_card_parse_graph_codec(ep, dai_link);
+		ret = asoc_simple_card_parse_codec(ep, dai_link);
 		if (ret < 0)
 			return ret;
 
@@ -234,7 +331,7 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 	struct device_node *top = dev->of_node;
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
-	int ret;
+	int ret, single_cpu;
 
 	/* Do it only CPU turn */
 	if (!li->cpu)
@@ -258,11 +355,11 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_parse_graph_cpu(cpu_ep, dai_link);
+	ret = asoc_simple_card_parse_cpu(cpu_ep, dai_link, &single_cpu);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_parse_graph_codec(codec_ep, dai_link);
+	ret = asoc_simple_card_parse_codec(codec_ep, dai_link);
 	if (ret < 0)
 		return ret;
 
@@ -293,8 +390,7 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 	dai_link->init = asoc_simple_dai_init;
 
 	asoc_simple_card_canonicalize_platform(dai_link);
-	asoc_simple_card_canonicalize_cpu(dai_link,
-		of_graph_get_endpoint_count(dai_link->cpu_of_node) == 1);
+	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
 
 	return 0;
 }
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 697e820bee18..40cefbde6d9b 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -305,149 +305,6 @@ int asoc_simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_be_hw_params_fixup);
 
-int asoc_simple_card_parse_dai(struct device_node *node,
-				    struct snd_soc_dai_link_component *dlc,
-				    struct device_node **dai_of_node,
-				    const char **dai_name,
-				    const char *list_name,
-				    const char *cells_name,
-				    int *is_single_link)
-{
-	struct of_phandle_args args;
-	int ret;
-
-	if (!node)
-		return 0;
-
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
-	/*
-	 * Get node via "sound-dai = <&phandle port>"
-	 * it will be used as xxx_of_node on soc_bind_dai_link()
-	 */
-	ret = of_parse_phandle_with_args(node, list_name, cells_name, 0, &args);
-	if (ret)
-		return ret;
-
-	/* Get dai->name */
-	if (dai_name) {
-		ret = snd_soc_of_get_dai_name(node, dai_name);
-		if (ret < 0)
-			return ret;
-	}
-
-	*dai_of_node = args.np;
-
-	if (is_single_link)
-		*is_single_link = !args.args_count;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(asoc_simple_card_parse_dai);
-
-static int asoc_simple_card_get_dai_id(struct device_node *ep)
-{
-	struct device_node *node;
-	struct device_node *endpoint;
-	struct of_endpoint info;
-	int i, id;
-	int ret;
-
-	/* use driver specified DAI ID if exist */
-	ret = snd_soc_get_dai_id(ep);
-	if (ret != -ENOTSUPP)
-		return ret;
-
-	/* use endpoint/port reg if exist */
-	ret = of_graph_parse_endpoint(ep, &info);
-	if (ret == 0) {
-		/*
-		 * Because it will count port/endpoint if it doesn't have "reg".
-		 * But, we can't judge whether it has "no reg", or "reg = <0>"
-		 * only of_graph_parse_endpoint().
-		 * We need to check "reg" property
-		 */
-		if (of_get_property(ep,   "reg", NULL))
-			return info.id;
-
-		node = of_get_parent(ep);
-		of_node_put(node);
-		if (of_get_property(node, "reg", NULL))
-			return info.port;
-	}
-	node = of_graph_get_port_parent(ep);
-
-	/*
-	 * Non HDMI sound case, counting port/endpoint on its DT
-	 * is enough. Let's count it.
-	 */
-	i = 0;
-	id = -1;
-	for_each_endpoint_of_node(node, endpoint) {
-		if (endpoint == ep)
-			id = i;
-		i++;
-	}
-
-	of_node_put(node);
-
-	if (id < 0)
-		return -ENODEV;
-
-	return id;
-}
-
-int asoc_simple_card_parse_graph_dai(struct device_node *ep,
-				     struct snd_soc_dai_link_component *dlc,
-				     struct device_node **dai_of_node,
-				     const char **dai_name)
-{
-	struct device_node *node;
-	struct of_phandle_args args;
-	int ret;
-
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
-	if (!ep)
-		return 0;
-	if (!dai_name)
-		return 0;
-
-	node = of_graph_get_port_parent(ep);
-
-	/* Get dai->name */
-	args.np		= node;
-	args.args[0]	= asoc_simple_card_get_dai_id(ep);
-	args.args_count	= (of_graph_get_endpoint_count(node) > 1);
-
-	ret = snd_soc_get_dai_name(&args, dai_name);
-	if (ret < 0)
-		return ret;
-
-	*dai_of_node = node;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(asoc_simple_card_parse_graph_dai);
-
 static int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 				     struct asoc_simple_dai *simple_dai)
 {
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 4e3e6b34593c..d8560fb1f5de 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -25,6 +25,52 @@ static const struct snd_soc_ops simple_ops = {
 	.hw_params	= asoc_simple_hw_params,
 };
 
+static int asoc_simple_card_parse_dai(struct device_node *node,
+				      struct snd_soc_dai_link_component *dlc,
+				      struct device_node **dai_of_node,
+				      const char **dai_name,
+				      int *is_single_link)
+{
+	struct of_phandle_args args;
+	int ret;
+
+	if (!node)
+		return 0;
+
+	/*
+	 * Use snd_soc_dai_link_component instead of legacy style.
+	 * It is only for codec, but cpu will be supported in the future.
+	 * see
+	 *	soc-core.c :: snd_soc_init_multicodec()
+	 */
+	if (dlc) {
+		dai_name	= &dlc->dai_name;
+		dai_of_node	= &dlc->of_node;
+	}
+
+	/*
+	 * Get node via "sound-dai = <&phandle port>"
+	 * it will be used as xxx_of_node on soc_bind_dai_link()
+	 */
+	ret = of_parse_phandle_with_args(node, DAI, CELL, 0, &args);
+	if (ret)
+		return ret;
+
+	/* Get dai->name */
+	if (dai_name) {
+		ret = snd_soc_of_get_dai_name(node, dai_name);
+		if (ret < 0)
+			return ret;
+	}
+
+	*dai_of_node = args.np;
+
+	if (is_single_link)
+		*is_single_link = !args.args_count;
+
+	return 0;
+}
+
 static void simple_parse_convert(struct device *dev,
 				 struct device_node *np,
 				 struct asoc_simple_card_data *adata)
@@ -110,8 +156,7 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		dai =
 		dai_props->cpu_dai	= &priv->dais[li->dais++];
 
-		ret = asoc_simple_card_parse_cpu(np, dai_link, DAI, CELL,
-						 &is_single_links);
+		ret = asoc_simple_card_parse_cpu(np, dai_link, &is_single_links);
 		if (ret)
 			return ret;
 
@@ -144,7 +189,7 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		cconf =
 		dai_props->codec_conf	= &priv->codec_conf[li->conf++];
 
-		ret = asoc_simple_card_parse_codec(np, dai_link, DAI, CELL);
+		ret = asoc_simple_card_parse_codec(np, dai_link);
 		if (ret < 0)
 			return ret;
 
@@ -242,16 +287,15 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 
 	simple_parse_mclk_fs(top, cpu, codec, dai_props, prefix);
 
-	ret = asoc_simple_card_parse_cpu(cpu, dai_link,
-					 DAI, CELL, &single_cpu);
+	ret = asoc_simple_card_parse_cpu(cpu, dai_link, &single_cpu);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_parse_codec(codec, dai_link, DAI, CELL);
+	ret = asoc_simple_card_parse_codec(codec, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_parse_platform(plat, dai_link, DAI, CELL);
+	ret = asoc_simple_card_parse_platform(plat, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-- 
2.20.1
