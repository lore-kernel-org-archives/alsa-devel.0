From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share
	asoc_simple_startup()" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:59 +0000 (GMT)
Message-ID: <20190321150659.9E8F111288EC@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B332EF89731
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:07:00 +0100 (CET)
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

   ASoC: simple-card-utils: share asoc_simple_startup()

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

>From f38df5bf0c9cb905fa9d5abc86c3a00128cdbba5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:55:14 +0900
Subject: [PATCH] ASoC: simple-card-utils: share asoc_simple_startup()

The difference between simple-card / audio-graph are just using
OF graph style, or not. In other words, other things should be same.
This means, simple-card/audio-graph common functions should be
implemented at simple-card-utils, and its own functions should be
implemented at each files.

Current simple-card / audio-graph have almost same functions.
This patch shares asoc_simple_startup() between in these 2 drivers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 +-
 sound/soc/generic/audio-graph-card.c  | 20 +-------------------
 sound/soc/generic/simple-card-utils.c | 22 ++++++++++++++++++++--
 sound/soc/generic/simple-card.c       | 21 +--------------------
 4 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index c0161ec17572..0653fb9385d1 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -84,8 +84,8 @@ int asoc_simple_card_parse_clk(struct device *dev,
 			       struct asoc_simple_dai *simple_dai,
 			       const char *dai_name,
 			       struct snd_soc_dai_link_component *dlc);
-int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai);
 void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
+int asoc_simple_startup(struct snd_pcm_substream *substream);
 
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 656ca49ba727..29ae71b427ec 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -56,24 +56,6 @@ static const struct snd_soc_dapm_widget graph_dapm_widgets[] = {
 			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 };
 
-static int graph_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
-	int ret;
-
-	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
-	if (ret)
-		return ret;
-
-	ret = asoc_simple_card_clk_enable(dai_props->codec_dai);
-	if (ret)
-		asoc_simple_card_clk_disable(dai_props->cpu_dai);
-
-	return ret;
-}
-
 static void graph_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -117,7 +99,7 @@ static int graph_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_ops graph_ops = {
-	.startup	= graph_startup,
+	.startup	= asoc_simple_startup,
 	.shutdown	= graph_shutdown,
 	.hw_params	= graph_hw_params,
 };
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index f5ba5ad300cc..83ea1afa3c72 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -143,14 +143,13 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
 
-int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
+static int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
 {
 	if (dai)
 		return clk_prepare_enable(dai->clk);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_clk_enable);
 
 void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai)
 {
@@ -206,6 +205,25 @@ int asoc_simple_card_parse_clk(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_clk);
 
+int asoc_simple_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
+	int ret;
+
+	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
+	if (ret)
+		return ret;
+
+	ret = asoc_simple_card_clk_enable(dai_props->codec_dai);
+	if (ret)
+		asoc_simple_card_clk_disable(dai_props->cpu_dai);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_startup);
+
 int asoc_simple_card_parse_dai(struct device_node *node,
 				    struct snd_soc_dai_link_component *dlc,
 				    struct device_node **dai_of_node,
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 628c19a3aaff..d0ea5736889e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -26,25 +26,6 @@ struct link_info {
 #define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
 
-static int simple_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props =
-		simple_priv_to_props(priv, rtd->num);
-	int ret;
-
-	ret = asoc_simple_card_clk_enable(dai_props->cpu_dai);
-	if (ret)
-		return ret;
-
-	ret = asoc_simple_card_clk_enable(dai_props->codec_dai);
-	if (ret)
-		asoc_simple_card_clk_disable(dai_props->cpu_dai);
-
-	return ret;
-}
-
 static void simple_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -114,7 +95,7 @@ static int simple_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_ops simple_ops = {
-	.startup	= simple_startup,
+	.startup	= asoc_simple_startup,
 	.shutdown	= simple_shutdown,
 	.hw_params	= simple_hw_params,
 };
-- 
2.20.1
