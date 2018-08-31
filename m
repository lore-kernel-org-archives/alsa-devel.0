From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple_card_utils: support
	snd_soc_dai_link_component style for codec" to the asoc tree
Date: Fri, 31 Aug 2018 16:38:39 +0100 (BST)
Message-ID: <20180831153839.A7D3211226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 16B5E267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:38:40 +0200 (CEST)
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

   ASoC: simple_card_utils: support snd_soc_dai_link_component style for codec

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

>From e664de680b10c13d65f982bcb9cfe56096e1de55 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:08:09 +0000
Subject: [PATCH] ASoC: simple_card_utils: support snd_soc_dai_link_component
 style for codec

Current ASoC is supporting snd_soc_dai_link_component for binding,
it is more useful than current legacy style.
Currently only codec is supporting it as multicodec (= codecs).
CPU will support multi style in the future.
We want to have it on Platform too in the future.

If all Codec/CPU/Platform are replaced into snd_soc_dai_link_component
style, we can remove legacy complex style.
This patch supports snd_soc_dai_link_component style
for simple_card_utils for codec.

[current]
struct snd_soc_dai_link {
	...
	*cpu_name;
	*cpu_of_node;
	*cpu_dai_name;

	*codec_name;
	*codec_of_node;
	*codec_dai_name;
	*codecs;
	num_codecs;

	*platform_name;
	*platform_of_node;
	...
}

[in the future]
struct snd_soc_dai_link {
	...
	*cpus
	num_cpus;

	*codecs;
	num_codecs;

	*platform;
	...
}

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     | 27 +++++++++++------
 sound/soc/generic/simple-card-utils.c | 42 +++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 8bc5e2d8b13c..3b5bd6e76f88 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -51,29 +51,35 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 
 #define asoc_simple_card_parse_clk_cpu(dev, node, dai_link, simple_dai)		\
 	asoc_simple_card_parse_clk(dev, node, dai_link->cpu_of_node, simple_dai, \
-				   dai_link->cpu_dai_name)
+				   dai_link->cpu_dai_name, NULL)
 #define asoc_simple_card_parse_clk_codec(dev, node, dai_link, simple_dai)	\
 	asoc_simple_card_parse_clk(dev, node, dai_link->codec_of_node, simple_dai,\
-				   dai_link->codec_dai_name)
+				   dai_link->codec_dai_name, dai_link->codecs)
 int asoc_simple_card_parse_clk(struct device *dev,
 			       struct device_node *node,
 			       struct device_node *dai_of_node,
 			       struct asoc_simple_dai *simple_dai,
-			       const char *name);
+			       const char *dai_name,
+			       struct snd_soc_dai_link_component *dlc);
 int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai);
 void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
 
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
-	asoc_simple_card_parse_dai(node, &dai_link->cpu_of_node,		\
+	asoc_simple_card_parse_dai(node, NULL,					\
+		&dai_link->cpu_of_node,						\
 		&dai_link->cpu_dai_name, list_name, cells_name, is_single_link)
 #define asoc_simple_card_parse_codec(node, dai_link, list_name, cells_name)	\
-	asoc_simple_card_parse_dai(node, &dai_link->codec_of_node,		\
-		&dai_link->codec_dai_name, list_name, cells_name, NULL)
+	asoc_simple_card_parse_dai(node, dai_link->codecs,			\
+				   &dai_link->codec_of_node,			\
+				   &dai_link->codec_dai_name,			\
+				   list_name, cells_name, NULL)
 #define asoc_simple_card_parse_platform(node, dai_link, list_name, cells_name)	\
-	asoc_simple_card_parse_dai(node, &dai_link->platform_of_node,		\
+	asoc_simple_card_parse_dai(node, NULL,					\
+		&dai_link->platform_of_node,					\
 		NULL, list_name, cells_name, NULL)
 int asoc_simple_card_parse_dai(struct device_node *node,
+				  struct snd_soc_dai_link_component *dlc,
 				  struct device_node **endpoint_np,
 				  const char **dai_name,
 				  const char *list_name,
@@ -81,12 +87,15 @@ int asoc_simple_card_parse_dai(struct device_node *node,
 				  int *is_single_links);
 
 #define asoc_simple_card_parse_graph_cpu(ep, dai_link)			\
-	asoc_simple_card_parse_graph_dai(ep, &dai_link->cpu_of_node,	\
+	asoc_simple_card_parse_graph_dai(ep, NULL,			\
+					 &dai_link->cpu_of_node,	\
 					 &dai_link->cpu_dai_name)
 #define asoc_simple_card_parse_graph_codec(ep, dai_link)		\
-	asoc_simple_card_parse_graph_dai(ep, &dai_link->codec_of_node,	\
+	asoc_simple_card_parse_graph_dai(ep, dai_link->codecs,		\
+					 &dai_link->codec_of_node,	\
 					 &dai_link->codec_dai_name)
 int asoc_simple_card_parse_graph_dai(struct device_node *ep,
+				     struct snd_soc_dai_link_component *dlc,
 				     struct device_node **endpoint_np,
 				     const char **dai_name);
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index d3f3f0fec74c..73c0a904f32e 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -173,11 +173,23 @@ int asoc_simple_card_parse_clk(struct device *dev,
 			       struct device_node *node,
 			       struct device_node *dai_of_node,
 			       struct asoc_simple_dai *simple_dai,
-			       const char *name)
+			       const char *dai_name,
+			       struct snd_soc_dai_link_component *dlc)
 {
 	struct clk *clk;
 	u32 val;
 
+	/*
+	 * Use snd_soc_dai_link_component instead of legacy style.
+	 * It is only for codec, but cpu will be supported in the future.
+	 * see
+	 *	soc-core.c :: snd_soc_init_multicodec()
+	 */
+	if (dlc) {
+		dai_of_node	= dlc->of_node;
+		dai_name	= dlc->dai_name;
+	}
+
 	/*
 	 * Parse dai->sysclk come from "clocks = <&xxx>"
 	 * (if system has common clock)
@@ -200,7 +212,7 @@ int asoc_simple_card_parse_clk(struct device *dev,
 	if (of_property_read_bool(node, "system-clock-direction-out"))
 		simple_dai->clk_direction = SND_SOC_CLOCK_OUT;
 
-	dev_dbg(dev, "%s : sysclk = %d, direction %d\n", name,
+	dev_dbg(dev, "%s : sysclk = %d, direction %d\n", dai_name,
 		simple_dai->sysclk, simple_dai->clk_direction);
 
 	return 0;
@@ -208,6 +220,7 @@ int asoc_simple_card_parse_clk(struct device *dev,
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_clk);
 
 int asoc_simple_card_parse_dai(struct device_node *node,
+				    struct snd_soc_dai_link_component *dlc,
 				    struct device_node **dai_of_node,
 				    const char **dai_name,
 				    const char *list_name,
@@ -220,6 +233,17 @@ int asoc_simple_card_parse_dai(struct device_node *node,
 	if (!node)
 		return 0;
 
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
 	/*
 	 * Get node via "sound-dai = <&phandle port>"
 	 * it will be used as xxx_of_node on soc_bind_dai_link()
@@ -278,6 +302,7 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 }
 
 int asoc_simple_card_parse_graph_dai(struct device_node *ep,
+				     struct snd_soc_dai_link_component *dlc,
 				     struct device_node **dai_of_node,
 				     const char **dai_name)
 {
@@ -285,6 +310,17 @@ int asoc_simple_card_parse_graph_dai(struct device_node *ep,
 	struct of_phandle_args args;
 	int ret;
 
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
 	if (!ep)
 		return 0;
 	if (!dai_name)
@@ -374,6 +410,8 @@ int asoc_simple_card_clean_reference(struct snd_soc_card *card)
 	     num_links++, dai_link++) {
 		of_node_put(dai_link->cpu_of_node);
 		of_node_put(dai_link->codec_of_node);
+		if (dai_link->codecs)
+			of_node_put(dai_link->codecs->of_node);
 	}
 	return 0;
 }
-- 
2.19.0.rc1
