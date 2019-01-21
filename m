From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: rename to
	asoc_simple_card_canonicalize_platform()" to the asoc tree
Date: Mon, 21 Jan 2019 19:20:18 +0000 (GMT)
Message-ID: <20190121192018.CEC4E1127D00@debutante.sirena.org.uk>
References: <874la2a2o6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 11A7626680F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 20:20:19 +0100 (CET)
In-Reply-To: <874la2a2o6.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: rename to asoc_simple_card_canonicalize_platform()

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

>From fe7ed4dec2e6289eab81dd18c0d613c0851d85a1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Jan 2019 16:40:59 +0900
Subject: [PATCH] ASoC: simple-card: rename to
 asoc_simple_card_canonicalize_platform()

Current simple-card is using asoc_simple_card_canonicalize_dailink().
Its naming is "dailink", but is for "platform".
We already have asoc_simple_card_canonicalize_cpu() for "cpu",
let's follow same naming rule.
It never return error, so, void function is better idea.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 +-
 sound/soc/generic/audio-graph-card.c  | 11 +++--------
 sound/soc/generic/simple-card-utils.c |  7 ++-----
 sound/soc/generic/simple-card.c       | 11 +++--------
 4 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index ab5a2ba09c07..7afe45389972 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -108,7 +108,7 @@ int asoc_simple_card_parse_graph_dai(struct device_node *ep,
 int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 			      struct asoc_simple_dai *simple_dai);
 
-int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link);
+void asoc_simple_card_canonicalize_platform(struct snd_soc_dai_link *dai_link);
 void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 				      int is_single_links);
 
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 42b077c6be4c..bb12351330e8 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -307,14 +307,12 @@ static int graph_dai_link_of_dpcm(struct graph_priv *priv,
 					     "prefix");
 	}
 
+	asoc_simple_card_canonicalize_platform(dai_link);
+
 	ret = asoc_simple_card_of_parse_tdm(ep, dai);
 	if (ret)
 		return ret;
 
-	ret = asoc_simple_card_canonicalize_dailink(dai_link);
-	if (ret < 0)
-		return ret;
-
 	ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
 					    NULL, &dai_link->dai_fmt);
 	if (ret < 0)
@@ -405,10 +403,6 @@ static int graph_dai_link_of(struct graph_priv *priv,
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_canonicalize_dailink(dai_link);
-	if (ret < 0)
-		return ret;
-
 	ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 						"%s-%s",
 						dai_link->cpu_dai_name,
@@ -419,6 +413,7 @@ static int graph_dai_link_of(struct graph_priv *priv,
 	dai_link->ops = &graph_ops;
 	dai_link->init = graph_dai_init;
 
+	asoc_simple_card_canonicalize_platform(dai_link);
 	asoc_simple_card_canonicalize_cpu(dai_link,
 		of_graph_get_endpoint_count(dai_link->cpu_of_node) == 1);
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 3c0901df5796..5c1424f03620 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -394,16 +394,13 @@ int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
 
-int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link)
+void asoc_simple_card_canonicalize_platform(struct snd_soc_dai_link *dai_link)
 {
 	/* Assumes platform == cpu */
 	if (!dai_link->platforms->of_node)
 		dai_link->platforms->of_node = dai_link->cpu_of_node;
-
-	return 0;
-
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_dailink);
+EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_platform);
 
 void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 				       int is_single_links)
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d8a0d1ec256e..08df261024cf 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -297,14 +297,12 @@ static int simple_dai_link_of_dpcm(struct simple_priv *priv,
 
 	simple_get_conversion(dev, np, &dai_props->adata);
 
+	asoc_simple_card_canonicalize_platform(dai_link);
+
 	ret = asoc_simple_card_of_parse_tdm(np, dai);
 	if (ret)
 		return ret;
 
-	ret = asoc_simple_card_canonicalize_dailink(dai_link);
-	if (ret < 0)
-		return ret;
-
 	snprintf(prop, sizeof(prop), "%smclk-fs", prefix);
 	of_property_read_u32(top,  PREFIX "mclk-fs", &dai_props->mclk_fs);
 	of_property_read_u32(node, prop, &dai_props->mclk_fs);
@@ -409,10 +407,6 @@ static int simple_dai_link_of(struct simple_priv *priv,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_canonicalize_dailink(dai_link);
-	if (ret < 0)
-		goto dai_link_of_err;
-
 	ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 						"%s-%s",
 						dai_link->cpu_dai_name,
@@ -424,6 +418,7 @@ static int simple_dai_link_of(struct simple_priv *priv,
 	dai_link->init = simple_dai_init;
 
 	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
+	asoc_simple_card_canonicalize_platform(dai_link);
 
 dai_link_of_err:
 	of_node_put(node);
-- 
2.20.1
