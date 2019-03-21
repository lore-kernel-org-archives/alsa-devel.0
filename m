From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: rename
	asoc_simple_card_xxx() to asoc_simple_()" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:45 +0000 (GMT)
Message-ID: <20190321150645.9523111288EC@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1E18F89717
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:46 +0100 (CET)
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

   ASoC: simple-card-utils: rename asoc_simple_card_xxx() to asoc_simple_()

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

>From ad11e59f52d6fc75037ac3cb66dc711b83c1bbf8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:56:50 +0900
Subject: [PATCH] ASoC: simple-card-utils: rename asoc_simple_card_xxx() to
 asoc_simple_()

Current simple-card-utils is using asoc_simple_card_xxx() for each
function naming, but it is very verbose.
Thus it is easy to be over 80 char.
This patch renames it to asoc_simple_xxx().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  90 +++++++++----------
 sound/soc/generic/audio-graph-card.c  |  98 ++++++++++-----------
 sound/soc/generic/simple-card-utils.c | 122 +++++++++++++-------------
 sound/soc/generic/simple-card.c       |  98 ++++++++++-----------
 4 files changed, 204 insertions(+), 204 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 0c070c2bc119..67dc3ee6ed01 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -10,10 +10,10 @@
 
 #include <sound/soc.h>
 
-#define asoc_simple_card_init_hp(card, sjack, prefix) \
-	asoc_simple_card_init_jack(card, sjack, 1, prefix)
-#define asoc_simple_card_init_mic(card, sjack, prefix) \
-	asoc_simple_card_init_jack(card, sjack, 0, prefix)
+#define asoc_simple_init_hp(card, sjack, prefix) \
+	asoc_simple_init_jack(card, sjack, 1, prefix)
+#define asoc_simple_init_mic(card, sjack, prefix) \
+	asoc_simple_init_jack(card, sjack, 0, prefix)
 
 struct asoc_simple_dai {
 	const char *name;
@@ -26,7 +26,7 @@ struct asoc_simple_dai {
 	struct clk *clk;
 };
 
-struct asoc_simple_card_data {
+struct asoc_simple_data {
 	u32 convert_rate;
 	u32 convert_channels;
 };
@@ -44,7 +44,7 @@ struct asoc_simple_priv {
 		struct asoc_simple_dai *codec_dai;
 		struct snd_soc_dai_link_component codecs; /* single codec */
 		struct snd_soc_dai_link_component platforms;
-		struct asoc_simple_card_data adata;
+		struct asoc_simple_data adata;
 		struct snd_soc_codec_conf *codec_conf;
 		unsigned int mclk_fs;
 	} *dai_props;
@@ -67,30 +67,30 @@ struct link_info {
 	int cpu;  /* turn for CPU / Codec */
 };
 
-int asoc_simple_card_parse_daifmt(struct device *dev,
-				  struct device_node *node,
-				  struct device_node *codec,
-				  char *prefix,
-				  unsigned int *retfmt);
+int asoc_simple_parse_daifmt(struct device *dev,
+			     struct device_node *node,
+			     struct device_node *codec,
+			     char *prefix,
+			     unsigned int *retfmt);
 __printf(3, 4)
-int asoc_simple_card_set_dailink_name(struct device *dev,
-				      struct snd_soc_dai_link *dai_link,
-				      const char *fmt, ...);
-int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
-				     char *prefix);
-
-#define asoc_simple_card_parse_clk_cpu(dev, node, dai_link, simple_dai)		\
-	asoc_simple_card_parse_clk(dev, node, dai_link->cpu_of_node, simple_dai, \
+int asoc_simple_set_dailink_name(struct device *dev,
+				 struct snd_soc_dai_link *dai_link,
+				 const char *fmt, ...);
+int asoc_simple_parse_card_name(struct snd_soc_card *card,
+				char *prefix);
+
+#define asoc_simple_parse_clk_cpu(dev, node, dai_link, simple_dai)		\
+	asoc_simple_parse_clk(dev, node, dai_link->cpu_of_node, simple_dai, \
 				   dai_link->cpu_dai_name, NULL)
-#define asoc_simple_card_parse_clk_codec(dev, node, dai_link, simple_dai)	\
-	asoc_simple_card_parse_clk(dev, node, dai_link->codec_of_node, simple_dai,\
+#define asoc_simple_parse_clk_codec(dev, node, dai_link, simple_dai)	\
+	asoc_simple_parse_clk(dev, node, dai_link->codec_of_node, simple_dai,\
 				   dai_link->codec_dai_name, dai_link->codecs)
-int asoc_simple_card_parse_clk(struct device *dev,
-			       struct device_node *node,
-			       struct device_node *dai_of_node,
-			       struct asoc_simple_dai *simple_dai,
-			       const char *dai_name,
-			       struct snd_soc_dai_link_component *dlc);
+int asoc_simple_parse_clk(struct device *dev,
+			  struct device_node *node,
+			  struct device_node *dai_of_node,
+			  struct asoc_simple_dai *simple_dai,
+			  const char *dai_name,
+			  struct snd_soc_dai_link_component *dlc);
 int asoc_simple_startup(struct snd_pcm_substream *substream);
 void asoc_simple_shutdown(struct snd_pcm_substream *substream);
 int asoc_simple_hw_params(struct snd_pcm_substream *substream,
@@ -99,45 +99,45 @@ int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd);
 int asoc_simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				   struct snd_pcm_hw_params *params);
 
-#define asoc_simple_card_parse_cpu(node, dai_link, is_single_link)	\
-	asoc_simple_card_parse_dai(node, NULL,				\
+#define asoc_simple_parse_cpu(node, dai_link, is_single_link)	\
+	asoc_simple_parse_dai(node, NULL,				\
 		&dai_link->cpu_of_node,					\
 		&dai_link->cpu_dai_name, is_single_link)
-#define asoc_simple_card_parse_codec(node, dai_link)	\
-	asoc_simple_card_parse_dai(node, dai_link->codecs,			\
+#define asoc_simple_parse_codec(node, dai_link)	\
+	asoc_simple_parse_dai(node, dai_link->codecs,			\
 				   &dai_link->codec_of_node,			\
 				   &dai_link->codec_dai_name, NULL)
-#define asoc_simple_card_parse_platform(node, dai_link)	\
-	asoc_simple_card_parse_dai(node, dai_link->platforms,			\
+#define asoc_simple_parse_platform(node, dai_link)	\
+	asoc_simple_parse_dai(node, dai_link->platforms,			\
 		&dai_link->platform_of_node, NULL, NULL)
 
-#define asoc_simple_card_of_parse_tdm(np, dai)			\
+#define asoc_simple_parse_tdm(np, dai)			\
 	snd_soc_of_parse_tdm_slot(np,	&(dai)->tx_slot_mask,	\
 					&(dai)->rx_slot_mask,	\
 					&(dai)->slots,		\
 					&(dai)->slot_width);
 
-void asoc_simple_card_canonicalize_platform(struct snd_soc_dai_link *dai_link);
-void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
+void asoc_simple_canonicalize_platform(struct snd_soc_dai_link *dai_link);
+void asoc_simple_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 				      int is_single_links);
 
-int asoc_simple_card_clean_reference(struct snd_soc_card *card);
+int asoc_simple_clean_reference(struct snd_soc_card *card);
 
-void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
+void asoc_simple_convert_fixup(struct asoc_simple_data *data,
 				      struct snd_pcm_hw_params *params);
-void asoc_simple_card_parse_convert(struct device *dev,
-				    struct device_node *np, char *prefix,
-				    struct asoc_simple_card_data *data);
+void asoc_simple_parse_convert(struct device *dev,
+			       struct device_node *np, char *prefix,
+			       struct asoc_simple_data *data);
 
-int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
+int asoc_simple_parse_routing(struct snd_soc_card *card,
 				      char *prefix);
-int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
+int asoc_simple_parse_widgets(struct snd_soc_card *card,
 				      char *prefix);
 
-int asoc_simple_card_init_jack(struct snd_soc_card *card,
+int asoc_simple_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
 			       int is_hp, char *prefix);
-int asoc_simple_card_init_priv(struct asoc_simple_priv *priv,
+int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			       struct link_info *li);
 
 #ifdef DEBUG
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 3370b6fc6da2..8114b5ea9319 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -107,11 +107,11 @@ static int graph_get_dai_id(struct device_node *ep)
 	return id;
 }
 
-static int asoc_simple_card_parse_dai(struct device_node *ep,
-				      struct snd_soc_dai_link_component *dlc,
-				      struct device_node **dai_of_node,
-				      const char **dai_name,
-				      int *is_single_link)
+static int asoc_simple_parse_dai(struct device_node *ep,
+				 struct snd_soc_dai_link_component *dlc,
+				 struct device_node **dai_of_node,
+				 const char **dai_name,
+				 int *is_single_link)
 {
 	struct device_node *node;
 	struct of_phandle_args args;
@@ -154,18 +154,18 @@ static int asoc_simple_card_parse_dai(struct device_node *ep,
 
 static void graph_parse_convert(struct device *dev,
 				struct device_node *ep,
-				struct asoc_simple_card_data *adata)
+				struct asoc_simple_data *adata)
 {
 	struct device_node *top = dev->of_node;
 	struct device_node *port = of_get_parent(ep);
 	struct device_node *ports = of_get_parent(port);
 	struct device_node *node = of_graph_get_port_parent(ep);
 
-	asoc_simple_card_parse_convert(dev, top,   NULL,   adata);
-	asoc_simple_card_parse_convert(dev, node,  PREFIX, adata);
-	asoc_simple_card_parse_convert(dev, ports, NULL,   adata);
-	asoc_simple_card_parse_convert(dev, port,  NULL,   adata);
-	asoc_simple_card_parse_convert(dev, ep,    NULL,   adata);
+	asoc_simple_parse_convert(dev, top,   NULL,   adata);
+	asoc_simple_parse_convert(dev, node,  PREFIX, adata);
+	asoc_simple_parse_convert(dev, ports, NULL,   adata);
+	asoc_simple_parse_convert(dev, port,  NULL,   adata);
+	asoc_simple_parse_convert(dev, ep,    NULL,   adata);
 
 	of_node_put(port);
 	of_node_put(ports);
@@ -239,22 +239,22 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		dai =
 		dai_props->cpu_dai	= &priv->dais[li->dais++];
 
-		ret = asoc_simple_card_parse_cpu(ep, dai_link, &is_single_links);
+		ret = asoc_simple_parse_cpu(ep, dai_link, &is_single_links);
 		if (ret)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_cpu(dev, ep, dai_link, dai);
+		ret = asoc_simple_parse_clk_cpu(dev, ep, dai_link, dai);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
-							"fe.%s",
-							dai_link->cpu_dai_name);
+		ret = asoc_simple_set_dailink_name(dev, dai_link,
+						   "fe.%s",
+						   dai_link->cpu_dai_name);
 		if (ret < 0)
 			return ret;
 
 		/* card->num_links includes Codec */
-		asoc_simple_card_canonicalize_cpu(dai_link, is_single_links);
+		asoc_simple_canonicalize_cpu(dai_link, is_single_links);
 	} else {
 		struct snd_soc_codec_conf *cconf;
 
@@ -273,17 +273,17 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		cconf =
 		dai_props->codec_conf	= &priv->codec_conf[li->conf++];
 
-		ret = asoc_simple_card_parse_codec(ep, dai_link);
+		ret = asoc_simple_parse_codec(ep, dai_link);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_codec(dev, ep, dai_link, dai);
+		ret = asoc_simple_parse_clk_codec(dev, ep, dai_link, dai);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
-							"be.%s",
-							codecs->dai_name);
+		ret = asoc_simple_set_dailink_name(dev, dai_link,
+						   "be.%s",
+						   codecs->dai_name);
 		if (ret < 0)
 			return ret;
 
@@ -301,14 +301,14 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	graph_parse_convert(dev, ep, &dai_props->adata);
 	graph_parse_mclk_fs(top, ep, dai_props);
 
-	asoc_simple_card_canonicalize_platform(dai_link);
+	asoc_simple_canonicalize_platform(dai_link);
 
-	ret = asoc_simple_card_of_parse_tdm(ep, dai);
+	ret = asoc_simple_parse_tdm(ep, dai);
 	if (ret)
 		return ret;
 
-	ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
-					    NULL, &dai_link->dai_fmt);
+	ret = asoc_simple_parse_daifmt(dev, cpu_ep, codec_ep,
+				       NULL, &dai_link->dai_fmt);
 	if (ret < 0)
 		return ret;
 
@@ -350,47 +350,47 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 	graph_parse_mclk_fs(top, cpu_ep,   dai_props);
 	graph_parse_mclk_fs(top, codec_ep, dai_props);
 
-	ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
-					    NULL, &dai_link->dai_fmt);
+	ret = asoc_simple_parse_daifmt(dev, cpu_ep, codec_ep,
+				       NULL, &dai_link->dai_fmt);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_parse_cpu(cpu_ep, dai_link, &single_cpu);
+	ret = asoc_simple_parse_cpu(cpu_ep, dai_link, &single_cpu);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_parse_codec(codec_ep, dai_link);
+	ret = asoc_simple_parse_codec(codec_ep, dai_link);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_of_parse_tdm(cpu_ep, cpu_dai);
+	ret = asoc_simple_parse_tdm(cpu_ep, cpu_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_of_parse_tdm(codec_ep, codec_dai);
+	ret = asoc_simple_parse_tdm(codec_ep, codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_parse_clk_cpu(dev, cpu_ep, dai_link, cpu_dai);
+	ret = asoc_simple_parse_clk_cpu(dev, cpu_ep, dai_link, cpu_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_parse_clk_codec(dev, codec_ep, dai_link, codec_dai);
+	ret = asoc_simple_parse_clk_codec(dev, codec_ep, dai_link, codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_set_dailink_name(dev, dai_link,
-						"%s-%s",
-						dai_link->cpu_dai_name,
-						dai_link->codecs->dai_name);
+	ret = asoc_simple_set_dailink_name(dev, dai_link,
+					   "%s-%s",
+					   dai_link->cpu_dai_name,
+					   dai_link->codecs->dai_name);
 	if (ret < 0)
 		return ret;
 
 	dai_link->ops = &graph_ops;
 	dai_link->init = asoc_simple_dai_init;
 
-	asoc_simple_card_canonicalize_platform(dai_link);
-	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
+	asoc_simple_canonicalize_cpu(dai_link, single_cpu);
+	asoc_simple_canonicalize_platform(dai_link);
 
 	return 0;
 }
@@ -414,7 +414,7 @@ static int graph_for_each_link(struct asoc_simple_priv *priv,
 	struct device_node *codec_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old = NULL;
-	struct asoc_simple_card_data adata;
+	struct asoc_simple_data adata;
 	int rc, ret;
 
 	/* loop for all listed CPU port */
@@ -469,11 +469,11 @@ static int graph_parse_of(struct asoc_simple_priv *priv)
 	struct link_info li;
 	int ret;
 
-	ret = asoc_simple_card_of_parse_widgets(card, NULL);
+	ret = asoc_simple_parse_widgets(card, NULL);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_of_parse_routing(card, NULL);
+	ret = asoc_simple_parse_routing(card, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -498,7 +498,7 @@ static int graph_parse_of(struct asoc_simple_priv *priv)
 			return ret;
 	}
 
-	return asoc_simple_card_parse_card_name(card, NULL);
+	return asoc_simple_parse_card_name(card, NULL);
 }
 
 static int graph_count_noml(struct asoc_simple_priv *priv,
@@ -601,11 +601,11 @@ static int graph_card_probe(struct snd_soc_card *card)
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
-	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
+	ret = asoc_simple_init_hp(card, &priv->hp_jack, NULL);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
+	ret = asoc_simple_init_mic(card, &priv->mic_jack, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -637,7 +637,7 @@ static int graph_probe(struct platform_device *pdev)
 	if (!li.link || !li.dais)
 		return -EINVAL;
 
-	ret = asoc_simple_card_init_priv(priv, &li);
+	ret = asoc_simple_init_priv(priv, &li);
 	if (ret < 0)
 		return ret;
 
@@ -665,7 +665,7 @@ static int graph_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	asoc_simple_card_clean_reference(card);
+	asoc_simple_clean_reference(card);
 
 	return ret;
 }
@@ -674,7 +674,7 @@ static int graph_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-	return asoc_simple_card_clean_reference(card);
+	return asoc_simple_clean_reference(card);
 }
 
 static const struct of_device_id graph_of_match[] = {
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 40cefbde6d9b..a794f767ff7f 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -14,8 +14,8 @@
 #include <sound/jack.h>
 #include <sound/simple_card_utils.h>
 
-void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
-				    struct snd_pcm_hw_params *params)
+void asoc_simple_convert_fixup(struct asoc_simple_data *data,
+			       struct snd_pcm_hw_params *params)
 {
 	struct snd_interval *rate = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_RATE);
@@ -30,12 +30,12 @@ void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
 		channels->min =
 		channels->max = data->convert_channels;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_convert_fixup);
+EXPORT_SYMBOL_GPL(asoc_simple_convert_fixup);
 
-void asoc_simple_card_parse_convert(struct device *dev,
-				    struct device_node *np,
-				    char *prefix,
-				    struct asoc_simple_card_data *data)
+void asoc_simple_parse_convert(struct device *dev,
+			       struct device_node *np,
+			       char *prefix,
+			       struct asoc_simple_data *data)
 {
 	char prop[128];
 
@@ -50,13 +50,13 @@ void asoc_simple_card_parse_convert(struct device *dev,
 	snprintf(prop, sizeof(prop), "%s%s", prefix, "convert-channels");
 	of_property_read_u32(np, prop, &data->convert_channels);
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_parse_convert);
+EXPORT_SYMBOL_GPL(asoc_simple_parse_convert);
 
-int asoc_simple_card_parse_daifmt(struct device *dev,
-				  struct device_node *node,
-				  struct device_node *codec,
-				  char *prefix,
-				  unsigned int *retfmt)
+int asoc_simple_parse_daifmt(struct device *dev,
+			     struct device_node *node,
+			     struct device_node *codec,
+			     char *prefix,
+			     unsigned int *retfmt)
 {
 	struct device_node *bitclkmaster = NULL;
 	struct device_node *framemaster = NULL;
@@ -92,11 +92,11 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_parse_daifmt);
+EXPORT_SYMBOL_GPL(asoc_simple_parse_daifmt);
 
-int asoc_simple_card_set_dailink_name(struct device *dev,
-				      struct snd_soc_dai_link *dai_link,
-				      const char *fmt, ...)
+int asoc_simple_set_dailink_name(struct device *dev,
+				 struct snd_soc_dai_link *dai_link,
+				 const char *fmt, ...)
 {
 	va_list ap;
 	char *name = NULL;
@@ -115,10 +115,10 @@ int asoc_simple_card_set_dailink_name(struct device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_set_dailink_name);
+EXPORT_SYMBOL_GPL(asoc_simple_set_dailink_name);
 
-int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
-				     char *prefix)
+int asoc_simple_parse_card_name(struct snd_soc_card *card,
+				char *prefix)
 {
 	int ret;
 
@@ -141,9 +141,9 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
+EXPORT_SYMBOL_GPL(asoc_simple_parse_card_name);
 
-static int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
+static int asoc_simple_clk_enable(struct asoc_simple_dai *dai)
 {
 	if (dai)
 		return clk_prepare_enable(dai->clk);
@@ -151,18 +151,18 @@ static int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
 	return 0;
 }
 
-static void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai)
+static void asoc_simple_clk_disable(struct asoc_simple_dai *dai)
 {
 	if (dai)
 		clk_disable_unprepare(dai->clk);
 }
 
-int asoc_simple_card_parse_clk(struct device *dev,
-			       struct device_node *node,
-			       struct device_node *dai_of_node,
-			       struct asoc_simple_dai *simple_dai,
-			       const char *dai_name,
-			       struct snd_soc_dai_link_component *dlc)
+int asoc_simple_parse_clk(struct device *dev,
+			  struct device_node *node,
+			  struct device_node *dai_of_node,
+			  struct asoc_simple_dai *simple_dai,
+			  const char *dai_name,
+			  struct snd_soc_dai_link_component *dlc)
 {
 	struct clk *clk;
 	u32 val;
@@ -202,7 +202,7 @@ int asoc_simple_card_parse_clk(struct device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_parse_clk);
+EXPORT_SYMBOL_GPL(asoc_simple_parse_clk);
 
 int asoc_simple_startup(struct snd_pcm_substream *substream)
 {
@@ -211,13 +211,13 @@ int asoc_simple_startup(struct snd_pcm_substream *substream)
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	int ret;
 
-	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
+	ret = asoc_simple_clk_enable(dai_props->cpu_dai);
 	if (ret)
 		return ret;
 
-	ret = asoc_simple_card_clk_enable(dai_props->codec_dai);
+	ret = asoc_simple_clk_enable(dai_props->codec_dai);
 	if (ret)
-		asoc_simple_card_clk_disable(dai_props->cpu_dai);
+		asoc_simple_clk_disable(dai_props->cpu_dai);
 
 	return ret;
 }
@@ -230,9 +230,9 @@ void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
-	asoc_simple_card_clk_disable(dai_props->cpu_dai);
+	asoc_simple_clk_disable(dai_props->cpu_dai);
 
-	asoc_simple_card_clk_disable(dai_props->codec_dai);
+	asoc_simple_clk_disable(dai_props->codec_dai);
 }
 EXPORT_SYMBOL_GPL(asoc_simple_shutdown);
 
@@ -299,13 +299,13 @@ int asoc_simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 
-	asoc_simple_card_convert_fixup(&dai_props->adata, params);
+	asoc_simple_convert_fixup(&dai_props->adata, params);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_be_hw_params_fixup);
 
-static int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
+static int asoc_simple_init_dai(struct snd_soc_dai *dai,
 				     struct asoc_simple_dai *simple_dai)
 {
 	int ret;
@@ -343,13 +343,13 @@ int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 	int ret;
 
-	ret = asoc_simple_card_init_dai(rtd->codec_dai,
-					dai_props->codec_dai);
+	ret = asoc_simple_init_dai(rtd->codec_dai,
+				   dai_props->codec_dai);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_dai(rtd->cpu_dai,
-					dai_props->cpu_dai);
+	ret = asoc_simple_init_dai(rtd->cpu_dai,
+				   dai_props->cpu_dai);
 	if (ret < 0)
 		return ret;
 
@@ -357,16 +357,16 @@ int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 }
 EXPORT_SYMBOL_GPL(asoc_simple_dai_init);
 
-void asoc_simple_card_canonicalize_platform(struct snd_soc_dai_link *dai_link)
+void asoc_simple_canonicalize_platform(struct snd_soc_dai_link *dai_link)
 {
 	/* Assumes platform == cpu */
 	if (!dai_link->platforms->of_node)
 		dai_link->platforms->of_node = dai_link->cpu_of_node;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_platform);
+EXPORT_SYMBOL_GPL(asoc_simple_canonicalize_platform);
 
-void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
-				       int is_single_links)
+void asoc_simple_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
+				  int is_single_links)
 {
 	/*
 	 * In soc_bind_dai_link() will check cpu name after
@@ -380,9 +380,9 @@ void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 	if (is_single_links)
 		dai_link->cpu_dai_name = NULL;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_cpu);
+EXPORT_SYMBOL_GPL(asoc_simple_canonicalize_cpu);
 
-int asoc_simple_card_clean_reference(struct snd_soc_card *card)
+int asoc_simple_clean_reference(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *dai_link;
 	int i;
@@ -393,10 +393,10 @@ int asoc_simple_card_clean_reference(struct snd_soc_card *card)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_clean_reference);
+EXPORT_SYMBOL_GPL(asoc_simple_clean_reference);
 
-int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
-				      char *prefix)
+int asoc_simple_parse_routing(struct snd_soc_card *card,
+			      char *prefix)
 {
 	struct device_node *node = card->dev->of_node;
 	char prop[128];
@@ -411,10 +411,10 @@ int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
 
 	return snd_soc_of_parse_audio_routing(card, prop);
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_of_parse_routing);
+EXPORT_SYMBOL_GPL(asoc_simple_parse_routing);
 
-int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
-				      char *prefix)
+int asoc_simple_parse_widgets(struct snd_soc_card *card,
+			      char *prefix)
 {
 	struct device_node *node = card->dev->of_node;
 	char prop[128];
@@ -430,11 +430,11 @@ int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
 	/* no widgets is not error */
 	return 0;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_of_parse_widgets);
+EXPORT_SYMBOL_GPL(asoc_simple_parse_widgets);
 
-int asoc_simple_card_init_jack(struct snd_soc_card *card,
-			       struct asoc_simple_jack *sjack,
-			       int is_hp, char *prefix)
+int asoc_simple_init_jack(struct snd_soc_card *card,
+			  struct asoc_simple_jack *sjack,
+			  int is_hp, char *prefix)
 {
 	struct device *dev = card->dev;
 	enum of_gpio_flags flags;
@@ -485,10 +485,10 @@ int asoc_simple_card_init_jack(struct snd_soc_card *card,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_init_jack);
+EXPORT_SYMBOL_GPL(asoc_simple_init_jack);
 
-int asoc_simple_card_init_priv(struct asoc_simple_priv *priv,
-				struct link_info *li)
+int asoc_simple_init_priv(struct asoc_simple_priv *priv,
+			  struct link_info *li)
 {
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct device *dev = simple_priv_to_dev(priv);
@@ -513,7 +513,7 @@ int asoc_simple_card_init_priv(struct asoc_simple_priv *priv,
 	 *
 	 * "platform" might be removed
 	 * see
-	 *	simple-card-utils.c :: asoc_simple_card_canonicalize_platform()
+	 *	simple-card-utils.c :: asoc_simple_canonicalize_platform()
 	 */
 	for (i = 0; i < li->link; i++) {
 		dai_link[i].codecs		= &dai_props[i].codecs;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d8560fb1f5de..dd9ac60d61f1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -25,11 +25,11 @@ static const struct snd_soc_ops simple_ops = {
 	.hw_params	= asoc_simple_hw_params,
 };
 
-static int asoc_simple_card_parse_dai(struct device_node *node,
-				      struct snd_soc_dai_link_component *dlc,
-				      struct device_node **dai_of_node,
-				      const char **dai_name,
-				      int *is_single_link)
+static int asoc_simple_parse_dai(struct device_node *node,
+				 struct snd_soc_dai_link_component *dlc,
+				 struct device_node **dai_of_node,
+				 const char **dai_name,
+				 int *is_single_link)
 {
 	struct of_phandle_args args;
 	int ret;
@@ -73,15 +73,15 @@ static int asoc_simple_card_parse_dai(struct device_node *node,
 
 static void simple_parse_convert(struct device *dev,
 				 struct device_node *np,
-				 struct asoc_simple_card_data *adata)
+				 struct asoc_simple_data *adata)
 {
 	struct device_node *top = dev->of_node;
 	struct device_node *node = of_get_parent(np);
 
-	asoc_simple_card_parse_convert(dev, top,  PREFIX, adata);
-	asoc_simple_card_parse_convert(dev, node, PREFIX, adata);
-	asoc_simple_card_parse_convert(dev, node, NULL,   adata);
-	asoc_simple_card_parse_convert(dev, np,   NULL,   adata);
+	asoc_simple_parse_convert(dev, top,  PREFIX, adata);
+	asoc_simple_parse_convert(dev, node, PREFIX, adata);
+	asoc_simple_parse_convert(dev, node, NULL,   adata);
+	asoc_simple_parse_convert(dev, np,   NULL,   adata);
 
 	of_node_put(node);
 }
@@ -156,21 +156,21 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		dai =
 		dai_props->cpu_dai	= &priv->dais[li->dais++];
 
-		ret = asoc_simple_card_parse_cpu(np, dai_link, &is_single_links);
+		ret = asoc_simple_parse_cpu(np, dai_link, &is_single_links);
 		if (ret)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_cpu(dev, np, dai_link, dai);
+		ret = asoc_simple_parse_clk_cpu(dev, np, dai_link, dai);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
-							"fe.%s",
-							dai_link->cpu_dai_name);
+		ret = asoc_simple_set_dailink_name(dev, dai_link,
+						   "fe.%s",
+						   dai_link->cpu_dai_name);
 		if (ret < 0)
 			return ret;
 
-		asoc_simple_card_canonicalize_cpu(dai_link, is_single_links);
+		asoc_simple_canonicalize_cpu(dai_link, is_single_links);
 	} else {
 		struct snd_soc_codec_conf *cconf;
 
@@ -189,17 +189,17 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 		cconf =
 		dai_props->codec_conf	= &priv->codec_conf[li->conf++];
 
-		ret = asoc_simple_card_parse_codec(np, dai_link);
+		ret = asoc_simple_parse_codec(np, dai_link);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_codec(dev, np, dai_link, dai);
+		ret = asoc_simple_parse_clk_codec(dev, np, dai_link, dai);
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
-							"be.%s",
-							codecs->dai_name);
+		ret = asoc_simple_set_dailink_name(dev, dai_link,
+						   "be.%s",
+						   codecs->dai_name);
 		if (ret < 0)
 			return ret;
 
@@ -215,14 +215,14 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	simple_parse_convert(dev, np, &dai_props->adata);
 	simple_parse_mclk_fs(top, np, codec, dai_props, prefix);
 
-	asoc_simple_card_canonicalize_platform(dai_link);
+	asoc_simple_canonicalize_platform(dai_link);
 
-	ret = asoc_simple_card_of_parse_tdm(np, dai);
+	ret = asoc_simple_parse_tdm(np, dai);
 	if (ret)
 		return ret;
 
-	ret = asoc_simple_card_parse_daifmt(dev, node, codec,
-					    prefix, &dai_link->dai_fmt);
+	ret = asoc_simple_parse_daifmt(dev, node, codec,
+				       prefix, &dai_link->dai_fmt);
 	if (ret < 0)
 		return ret;
 
@@ -280,53 +280,53 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	codec_dai		=
 	dai_props->codec_dai	= &priv->dais[li->dais++];
 
-	ret = asoc_simple_card_parse_daifmt(dev, node, codec,
-					    prefix, &dai_link->dai_fmt);
+	ret = asoc_simple_parse_daifmt(dev, node, codec,
+				       prefix, &dai_link->dai_fmt);
 	if (ret < 0)
 		goto dai_link_of_err;
 
 	simple_parse_mclk_fs(top, cpu, codec, dai_props, prefix);
 
-	ret = asoc_simple_card_parse_cpu(cpu, dai_link, &single_cpu);
+	ret = asoc_simple_parse_cpu(cpu, dai_link, &single_cpu);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_parse_codec(codec, dai_link);
+	ret = asoc_simple_parse_codec(codec, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_parse_platform(plat, dai_link);
+	ret = asoc_simple_parse_platform(plat, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_of_parse_tdm(cpu, cpu_dai);
+	ret = asoc_simple_parse_tdm(cpu, cpu_dai);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_of_parse_tdm(codec, codec_dai);
+	ret = asoc_simple_parse_tdm(codec, codec_dai);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_parse_clk_cpu(dev, cpu, dai_link, cpu_dai);
+	ret = asoc_simple_parse_clk_cpu(dev, cpu, dai_link, cpu_dai);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_parse_clk_codec(dev, codec, dai_link, codec_dai);
+	ret = asoc_simple_parse_clk_codec(dev, codec, dai_link, codec_dai);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_set_dailink_name(dev, dai_link,
-						"%s-%s",
-						dai_link->cpu_dai_name,
-						dai_link->codecs->dai_name);
+	ret = asoc_simple_set_dailink_name(dev, dai_link,
+					   "%s-%s",
+					   dai_link->cpu_dai_name,
+					   dai_link->codecs->dai_name);
 	if (ret < 0)
 		goto dai_link_of_err;
 
 	dai_link->ops = &simple_ops;
 	dai_link->init = asoc_simple_dai_init;
 
-	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
-	asoc_simple_card_canonicalize_platform(dai_link);
+	asoc_simple_canonicalize_cpu(dai_link, single_cpu);
+	asoc_simple_canonicalize_platform(dai_link);
 
 dai_link_of_err:
 	of_node_put(plat);
@@ -361,7 +361,7 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 
 	/* loop for all dai-link */
 	do {
-		struct asoc_simple_card_data adata;
+		struct asoc_simple_data adata;
 		struct device_node *codec;
 		struct device_node *np;
 		int num = of_get_child_count(node);
@@ -451,11 +451,11 @@ static int simple_parse_of(struct asoc_simple_priv *priv)
 	if (!top)
 		return -EINVAL;
 
-	ret = asoc_simple_card_of_parse_widgets(card, PREFIX);
+	ret = asoc_simple_parse_widgets(card, PREFIX);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_of_parse_routing(card, PREFIX);
+	ret = asoc_simple_parse_routing(card, PREFIX);
 	if (ret < 0)
 		return ret;
 
@@ -481,7 +481,7 @@ static int simple_parse_of(struct asoc_simple_priv *priv)
 			return ret;
 	}
 
-	ret = asoc_simple_card_parse_card_name(card, PREFIX);
+	ret = asoc_simple_parse_card_name(card, PREFIX);
 	if (ret < 0)
 		return ret;
 
@@ -587,11 +587,11 @@ static int simple_soc_probe(struct snd_soc_card *card)
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(card);
 	int ret;
 
-	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, PREFIX);
+	ret = asoc_simple_init_hp(card, &priv->hp_jack, PREFIX);
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, PREFIX);
+	ret = asoc_simple_init_mic(card, &priv->mic_jack, PREFIX);
 	if (ret < 0)
 		return ret;
 
@@ -622,7 +622,7 @@ static int simple_probe(struct platform_device *pdev)
 	if (!li.link || !li.dais)
 		return -EINVAL;
 
-	ret = asoc_simple_card_init_priv(priv, &li);
+	ret = asoc_simple_init_priv(priv, &li);
 	if (ret < 0)
 		return ret;
 
@@ -691,7 +691,7 @@ static int simple_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	asoc_simple_card_clean_reference(card);
+	asoc_simple_clean_reference(card);
 
 	return ret;
 }
@@ -700,7 +700,7 @@ static int simple_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-	return asoc_simple_card_clean_reference(card);
+	return asoc_simple_clean_reference(card);
 }
 
 static const struct of_device_id simple_of_match[] = {
-- 
2.20.1
