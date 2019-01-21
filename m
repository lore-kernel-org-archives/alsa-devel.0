From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add .num_platform for
	dai_link" to the asoc tree
Date: Mon, 21 Jan 2019 19:20:29 +0000 (GMT)
Message-ID: <20190121192029.CB44E1127D00@debutante.sirena.org.uk>
References: <87h8e2ami9.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D7994267499
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 20:20:30 +0100 (CET)
In-Reply-To: <87h8e2ami9.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: add .num_platform for dai_link

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

>From 910fdcabedd2354d161b1beab6ad7dc7e859651d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Jan 2019 09:32:32 +0900
Subject: [PATCH] ASoC: soc-core: add .num_platform for dai_link

Current snd_soc_dai_link is starting to use snd_soc_dai_link_component
(= modern) style for Platform, but it is still assuming single Platform
so far. We will need to have multi Platform support in the not far
future.

Currently only simple card is using it as sound card driver,
and other drivers are converted to it from legacy style by
snd_soc_init_platform().
To avoid future problem of multi Platform support, let's add
num_platforms before it is too late.

In the same time, to make it same naming mothed, "platform" should
be "platforms". This patch fixup it too.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 +-
 include/sound/soc.h                   |  3 ++-
 sound/soc/generic/audio-graph-card.c  |  5 +++--
 sound/soc/generic/simple-card-utils.c |  4 ++--
 sound/soc/generic/simple-card.c       |  7 ++++---
 sound/soc/soc-core.c                  | 23 ++++++++++++++++-------
 6 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 6d69ed2bd7b1..ab5a2ba09c07 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -75,7 +75,7 @@ void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
 				   &dai_link->codec_dai_name,			\
 				   list_name, cells_name, NULL)
 #define asoc_simple_card_parse_platform(node, dai_link, list_name, cells_name)	\
-	asoc_simple_card_parse_dai(node, dai_link->platform,					\
+	asoc_simple_card_parse_dai(node, dai_link->platforms,			\
 		&dai_link->platform_of_node,					\
 		NULL, list_name, cells_name, NULL)
 int asoc_simple_card_parse_dai(struct device_node *node,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index c31b6d122ff6..3089257ead95 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -961,7 +961,8 @@ struct snd_soc_dai_link {
 	 */
 	const char *platform_name;
 	struct device_node *platform_of_node;
-	struct snd_soc_dai_link_component *platform;
+	struct snd_soc_dai_link_component *platforms;
+	unsigned int num_platforms;
 
 	int id;	/* optional ID for machine driver link identification */
 
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 3ec96cdc683b..42b077c6be4c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -26,7 +26,7 @@ struct graph_priv {
 		struct asoc_simple_dai *cpu_dai;
 		struct asoc_simple_dai *codec_dai;
 		struct snd_soc_dai_link_component codecs; /* single codec */
-		struct snd_soc_dai_link_component platform;
+		struct snd_soc_dai_link_component platforms;
 		struct asoc_simple_card_data adata;
 		struct snd_soc_codec_conf *codec_conf;
 		unsigned int mclk_fs;
@@ -687,7 +687,8 @@ static int graph_probe(struct platform_device *pdev)
 	for (i = 0; i < li.link; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
-		dai_link[i].platform	= &dai_props[i].platform;
+		dai_link[i].platforms	= &dai_props[i].platforms;
+		dai_link[i].num_platforms = 1;
 	}
 
 	priv->pa_gpio = devm_gpiod_get_optional(dev, "pa", GPIOD_OUT_LOW);
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 336895f7fd1e..3c0901df5796 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -397,8 +397,8 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
 int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link)
 {
 	/* Assumes platform == cpu */
-	if (!dai_link->platform->of_node)
-		dai_link->platform->of_node = dai_link->cpu_of_node;
+	if (!dai_link->platforms->of_node)
+		dai_link->platforms->of_node = dai_link->cpu_of_node;
 
 	return 0;
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 479de236e694..d8a0d1ec256e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -21,7 +21,7 @@ struct simple_priv {
 		struct asoc_simple_dai *cpu_dai;
 		struct asoc_simple_dai *codec_dai;
 		struct snd_soc_dai_link_component codecs; /* single codec */
-		struct snd_soc_dai_link_component platform;
+		struct snd_soc_dai_link_component platforms;
 		struct asoc_simple_card_data adata;
 		struct snd_soc_codec_conf *codec_conf;
 		unsigned int mclk_fs;
@@ -732,7 +732,8 @@ static int simple_probe(struct platform_device *pdev)
 	for (i = 0; i < li.link; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
-		dai_link[i].platform	= &dai_props[i].platform;
+		dai_link[i].platforms	= &dai_props[i].platforms;
+		dai_link[i].num_platforms = 1;
 	}
 
 	priv->dai_props		= dai_props;
@@ -782,7 +783,7 @@ static int simple_probe(struct platform_device *pdev)
 		codecs->name		= cinfo->codec;
 		codecs->dai_name	= cinfo->codec_dai.name;
 
-		platform		= dai_link->platform;
+		platform		= dai_link->platforms;
 		platform->name		= cinfo->platform;
 
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index de2851f1b3df..2c63921675d5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -915,7 +915,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	/* find one from the set of registered platforms */
 	for_each_component(component) {
-		if (!snd_soc_is_matching_component(dai_link->platform,
+		if (!snd_soc_is_matching_component(dai_link->platforms,
 						   component))
 			continue;
 
@@ -1026,7 +1026,7 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
-	struct snd_soc_dai_link_component *platform = dai_link->platform;
+	struct snd_soc_dai_link_component *platform = dai_link->platforms;
 
 	/*
 	 * REMOVE ME
@@ -1046,7 +1046,8 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 		if (!platform)
 			return -ENOMEM;
 
-		dai_link->platform	  = platform;
+		dai_link->platforms	  = platform;
+		dai_link->num_platforms	  = 1;
 		dai_link->legacy_platform = 1;
 		platform->name		  = dai_link->platform_name;
 		platform->of_node	  = dai_link->platform_of_node;
@@ -1136,11 +1137,19 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 		}
 	}
 
+	/* FIXME */
+	if (link->num_platforms > 1) {
+		dev_err(card->dev,
+			"ASoC: multi platform is not yet supported %s\n",
+			link->name);
+		return -EINVAL;
+	}
+
 	/*
 	 * Platform may be specified by either name or OF node, but
 	 * can be left unspecified, and a dummy platform will be used.
 	 */
-	if (link->platform->name && link->platform->of_node) {
+	if (link->platforms->name && link->platforms->of_node) {
 		dev_err(card->dev,
 			"ASoC: Both platform name/of_node are set for %s\n",
 			link->name);
@@ -1151,8 +1160,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Defer card registartion if platform dai component is not added to
 	 * component list.
 	 */
-	if ((link->platform->of_node || link->platform->name) &&
-	    !soc_find_component(link->platform->of_node, link->platform->name))
+	if ((link->platforms->of_node || link->platforms->name) &&
+	    !soc_find_component(link->platforms->of_node, link->platforms->name))
 		return -EPROBE_DEFER;
 
 	/*
@@ -1956,7 +1965,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 				dev_err(card->dev, "init platform error");
 				continue;
 			}
-			dai_link->platform->name = component->name;
+			dai_link->platforms->name = component->name;
 
 			/* convert non BE into BE */
 			dai_link->no_pcm = 1;
-- 
2.20.1
