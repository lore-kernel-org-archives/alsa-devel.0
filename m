From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share
	asoc_simple_shutdown()" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:57 +0000 (GMT)
Message-ID: <20190321150657.99C8711288F0@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A256EF89731
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:07:03 +0100 (CET)
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

   ASoC: simple-card-utils: share asoc_simple_shutdown()

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

>From 686911b46fb5a08df142fe22b6c06dc6fbd3ba65 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:55:27 +0900
Subject: [PATCH] ASoC: simple-card-utils: share asoc_simple_shutdown()

The difference between simple-card / audio-graph are just using
OF graph style, or not. In other words, other things should be same.
This means, simple-card/audio-graph common functions should be
implemented at simple-card-utils, and its own functions should be
implemented at each files.

Current simple-card / audio-graph have almost same functions.
This patch shares asoc_simple_shutdown() between in these 2 drivers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 +-
 sound/soc/generic/audio-graph-card.c  | 13 +------------
 sound/soc/generic/simple-card-utils.c | 16 ++++++++++++++--
 sound/soc/generic/simple-card.c       | 14 +-------------
 4 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 0653fb9385d1..edda646c3ebe 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -84,8 +84,8 @@ int asoc_simple_card_parse_clk(struct device *dev,
 			       struct asoc_simple_dai *simple_dai,
 			       const char *dai_name,
 			       struct snd_soc_dai_link_component *dlc);
-void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
 int asoc_simple_startup(struct snd_pcm_substream *substream);
+void asoc_simple_shutdown(struct snd_pcm_substream *substream);
 
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 29ae71b427ec..f3577b5bf14c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -56,17 +56,6 @@ static const struct snd_soc_dapm_widget graph_dapm_widgets[] = {
 			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 };
 
-static void graph_shutdown(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
-
-	asoc_simple_card_clk_disable(dai_props->cpu_dai);
-
-	asoc_simple_card_clk_disable(dai_props->codec_dai);
-}
-
 static int graph_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params)
 {
@@ -100,7 +89,7 @@ static int graph_hw_params(struct snd_pcm_substream *substream,
 
 static const struct snd_soc_ops graph_ops = {
 	.startup	= asoc_simple_startup,
-	.shutdown	= graph_shutdown,
+	.shutdown	= asoc_simple_shutdown,
 	.hw_params	= graph_hw_params,
 };
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 83ea1afa3c72..7ede16347ea8 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -151,12 +151,11 @@ static int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
 	return 0;
 }
 
-void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai)
+static void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai)
 {
 	if (dai)
 		clk_disable_unprepare(dai->clk);
 }
-EXPORT_SYMBOL_GPL(asoc_simple_card_clk_disable);
 
 int asoc_simple_card_parse_clk(struct device *dev,
 			       struct device_node *node,
@@ -224,6 +223,19 @@ int asoc_simple_startup(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(asoc_simple_startup);
 
+void asoc_simple_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props =
+		simple_priv_to_props(priv, rtd->num);
+
+	asoc_simple_card_clk_disable(dai_props->cpu_dai);
+
+	asoc_simple_card_clk_disable(dai_props->codec_dai);
+}
+EXPORT_SYMBOL_GPL(asoc_simple_shutdown);
+
 int asoc_simple_card_parse_dai(struct device_node *node,
 				    struct snd_soc_dai_link_component *dlc,
 				    struct device_node **dai_of_node,
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d0ea5736889e..bb57c482eac8 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -26,18 +26,6 @@ struct link_info {
 #define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
 
-static void simple_shutdown(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props =
-		simple_priv_to_props(priv, rtd->num);
-
-	asoc_simple_card_clk_disable(dai_props->cpu_dai);
-
-	asoc_simple_card_clk_disable(dai_props->codec_dai);
-}
-
 static int simple_set_clk_rate(struct asoc_simple_dai *simple_dai,
 			       unsigned long rate)
 {
@@ -96,7 +84,7 @@ static int simple_hw_params(struct snd_pcm_substream *substream,
 
 static const struct snd_soc_ops simple_ops = {
 	.startup	= asoc_simple_startup,
-	.shutdown	= simple_shutdown,
+	.shutdown	= asoc_simple_shutdown,
 	.hw_params	= simple_hw_params,
 };
 
-- 
2.20.1
