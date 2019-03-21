From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share
	asoc_simple_dai_init()" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:53 +0000 (GMT)
Message-ID: <20190321150653.8EFF011288EC@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7103EF8972D
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:59 +0100 (CET)
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

   ASoC: simple-card-utils: share asoc_simple_dai_init()

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

>From ad934ca8010843482d61fda46786449a9bc99e10 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:55:52 +0900
Subject: [PATCH] ASoC: simple-card-utils: share asoc_simple_dai_init()

The difference between simple-card / audio-graph are just using
OF graph style, or not. In other words, other things should be same.
This means, simple-card/audio-graph common functions should be
implemented at simple-card-utils, and its own functions should be
implemented at each files.

Current simple-card / audio-graph have almost same functions.
This patch shares asoc_simple_dai_init() between in these 2 drivers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  4 +---
 sound/soc/generic/audio-graph-card.c  | 23 ++---------------------
 sound/soc/generic/simple-card-utils.c | 25 ++++++++++++++++++++++---
 sound/soc/generic/simple-card.c       | 25 +++----------------------
 4 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 89ae0841b711..204343789ae7 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -88,6 +88,7 @@ int asoc_simple_startup(struct snd_pcm_substream *substream);
 void asoc_simple_shutdown(struct snd_pcm_substream *substream);
 int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params);
+int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd);
 
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
@@ -130,9 +131,6 @@ int asoc_simple_card_parse_graph_dai(struct device_node *ep,
 					&(dai)->slots,		\
 					&(dai)->slot_width);
 
-int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
-			      struct asoc_simple_dai *simple_dai);
-
 void asoc_simple_card_canonicalize_platform(struct snd_soc_dai_link *dai_link);
 void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 				      int is_single_links);
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 51160adaf5bb..b1ceefc60879 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -62,25 +62,6 @@ static const struct snd_soc_ops graph_ops = {
 	.hw_params	= asoc_simple_hw_params,
 };
 
-static int graph_dai_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
-	int ret = 0;
-
-	ret = asoc_simple_card_init_dai(rtd->codec_dai,
-					dai_props->codec_dai);
-	if (ret < 0)
-		return ret;
-
-	ret = asoc_simple_card_init_dai(rtd->cpu_dai,
-					dai_props->cpu_dai);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static int graph_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				    struct snd_pcm_hw_params *params)
 {
@@ -255,7 +236,7 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
 	dai_link->ops			= &graph_ops;
-	dai_link->init			= graph_dai_init;
+	dai_link->init			= asoc_simple_dai_init;
 
 	return 0;
 }
@@ -327,7 +308,7 @@ static int graph_dai_link_of(struct asoc_simple_priv *priv,
 		return ret;
 
 	dai_link->ops = &graph_ops;
-	dai_link->init = graph_dai_init;
+	dai_link->init = asoc_simple_dai_init;
 
 	asoc_simple_card_canonicalize_platform(dai_link);
 	asoc_simple_card_canonicalize_cpu(dai_link,
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index de23cf8bffbd..c9b53b340028 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -436,8 +436,8 @@ int asoc_simple_card_parse_graph_dai(struct device_node *ep,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_graph_dai);
 
-int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
-			      struct asoc_simple_dai *simple_dai)
+static int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
+				     struct asoc_simple_dai *simple_dai)
 {
 	int ret;
 
@@ -467,7 +467,26 @@ int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
+
+int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
+	int ret;
+
+	ret = asoc_simple_card_init_dai(rtd->codec_dai,
+					dai_props->codec_dai);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_card_init_dai(rtd->cpu_dai,
+					dai_props->cpu_dai);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_dai_init);
 
 void asoc_simple_card_canonicalize_platform(struct snd_soc_dai_link *dai_link)
 {
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 7e836473eb11..bf4482ecfe3e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -32,25 +32,6 @@ static const struct snd_soc_ops simple_ops = {
 	.hw_params	= asoc_simple_hw_params,
 };
 
-static int simple_dai_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
-	int ret;
-
-	ret = asoc_simple_card_init_dai(rtd->codec_dai,
-					dai_props->codec_dai);
-	if (ret < 0)
-		return ret;
-
-	ret = asoc_simple_card_init_dai(rtd->cpu_dai,
-					dai_props->cpu_dai);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static int simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				     struct snd_pcm_hw_params *params)
 {
@@ -221,7 +202,7 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
 	dai_link->ops			= &simple_ops;
-	dai_link->init			= simple_dai_init;
+	dai_link->init			= asoc_simple_dai_init;
 
 	return 0;
 }
@@ -316,7 +297,7 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 		goto dai_link_of_err;
 
 	dai_link->ops = &simple_ops;
-	dai_link->init = simple_dai_init;
+	dai_link->init = asoc_simple_dai_init;
 
 	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
 	asoc_simple_card_canonicalize_platform(dai_link);
@@ -694,7 +675,7 @@ static int simple_probe(struct platform_device *pdev)
 		dai_link->stream_name	= cinfo->name;
 		dai_link->cpu_dai_name	= cinfo->cpu_dai.name;
 		dai_link->dai_fmt	= cinfo->daifmt;
-		dai_link->init		= simple_dai_init;
+		dai_link->init		= asoc_simple_dai_init;
 		memcpy(priv->dai_props->cpu_dai, &cinfo->cpu_dai,
 					sizeof(*priv->dai_props->cpu_dai));
 		memcpy(priv->dai_props->codec_dai, &cinfo->codec_dai,
-- 
2.20.1
