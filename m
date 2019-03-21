From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: share
	asoc_simple_hw_param()" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:55 +0000 (GMT)
Message-ID: <20190321150655.97B3811288F0@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C51F2F8972D
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:56 +0100 (CET)
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

   ASoC: simple-card-utils: share asoc_simple_hw_param()

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

>From f48dcbb6d47d870cf3a03f453c923dd262158c66 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Mar 2019 13:55:39 +0900
Subject: [PATCH] ASoC: simple-card-utils: share asoc_simple_hw_param()

The difference between simple-card / audio-graph are just using
OF graph style, or not. In other words, other things should be same.
This means, simple-card/audio-graph common functions should be
implemented at simple-card-utils, and its own functions should be
implemented at each files.

Current simple-card / audio-graph have almost same functions.
This patch shares asoc_simple_hw_param() between in these 2 drivers.

One note is that only simple-card supports simple_set_clk_rate()
at hw_param from commit e9be4ffd4f40fcb ("ASoC: simple-card: set cpu
dai clk in hw_params").
By this patch, audio-graph has same feature.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 +
 sound/soc/generic/audio-graph-card.c  | 33 +--------------
 sound/soc/generic/simple-card-utils.c | 57 ++++++++++++++++++++++++++
 sound/soc/generic/simple-card.c       | 58 +--------------------------
 4 files changed, 61 insertions(+), 89 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index edda646c3ebe..89ae0841b711 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -86,6 +86,8 @@ int asoc_simple_card_parse_clk(struct device *dev,
 			       struct snd_soc_dai_link_component *dlc);
 int asoc_simple_startup(struct snd_pcm_substream *substream);
 void asoc_simple_shutdown(struct snd_pcm_substream *substream);
+int asoc_simple_hw_params(struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params);
 
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index f3577b5bf14c..51160adaf5bb 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -56,41 +56,10 @@ static const struct snd_soc_dapm_widget graph_dapm_widgets[] = {
 			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 };
 
-static int graph_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
-	unsigned int mclk, mclk_fs = 0;
-	int ret = 0;
-
-	if (dai_props->mclk_fs)
-		mclk_fs = dai_props->mclk_fs;
-
-	if (mclk_fs) {
-		mclk = params_rate(params) * mclk_fs;
-		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
-					     SND_SOC_CLOCK_IN);
-		if (ret && ret != -ENOTSUPP)
-			goto err;
-
-		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
-					     SND_SOC_CLOCK_OUT);
-		if (ret && ret != -ENOTSUPP)
-			goto err;
-	}
-	return 0;
-err:
-	return ret;
-}
-
 static const struct snd_soc_ops graph_ops = {
 	.startup	= asoc_simple_startup,
 	.shutdown	= asoc_simple_shutdown,
-	.hw_params	= graph_hw_params,
+	.hw_params	= asoc_simple_hw_params,
 };
 
 static int graph_dai_init(struct snd_soc_pcm_runtime *rtd)
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 7ede16347ea8..de23cf8bffbd 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -236,6 +236,63 @@ void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(asoc_simple_shutdown);
 
+static int asoc_simple_set_clk_rate(struct asoc_simple_dai *simple_dai,
+				    unsigned long rate)
+{
+	if (!simple_dai)
+		return 0;
+
+	if (!simple_dai->clk)
+		return 0;
+
+	if (clk_get_rate(simple_dai->clk) == rate)
+		return 0;
+
+	return clk_set_rate(simple_dai->clk, rate);
+}
+
+int asoc_simple_hw_params(struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props =
+		simple_priv_to_props(priv, rtd->num);
+	unsigned int mclk, mclk_fs = 0;
+	int ret = 0;
+
+	if (dai_props->mclk_fs)
+		mclk_fs = dai_props->mclk_fs;
+
+	if (mclk_fs) {
+		mclk = params_rate(params) * mclk_fs;
+
+		ret = asoc_simple_set_clk_rate(dai_props->codec_dai, mclk);
+		if (ret < 0)
+			return ret;
+
+		ret = asoc_simple_set_clk_rate(dai_props->cpu_dai, mclk);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+					     SND_SOC_CLOCK_IN);
+		if (ret && ret != -ENOTSUPP)
+			goto err;
+
+		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+					     SND_SOC_CLOCK_OUT);
+		if (ret && ret != -ENOTSUPP)
+			goto err;
+	}
+	return 0;
+err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_hw_params);
+
 int asoc_simple_card_parse_dai(struct device_node *node,
 				    struct snd_soc_dai_link_component *dlc,
 				    struct device_node **dai_of_node,
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index bb57c482eac8..7e836473eb11 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -26,66 +26,10 @@ struct link_info {
 #define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
 
-static int simple_set_clk_rate(struct asoc_simple_dai *simple_dai,
-			       unsigned long rate)
-{
-	if (!simple_dai)
-		return 0;
-
-	if (!simple_dai->clk)
-		return 0;
-
-	if (clk_get_rate(simple_dai->clk) == rate)
-		return 0;
-
-	return clk_set_rate(simple_dai->clk, rate);
-}
-
-static int simple_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props =
-		simple_priv_to_props(priv, rtd->num);
-	unsigned int mclk, mclk_fs = 0;
-	int ret = 0;
-
-	if (dai_props->mclk_fs)
-		mclk_fs = dai_props->mclk_fs;
-
-	if (mclk_fs) {
-		mclk = params_rate(params) * mclk_fs;
-
-		ret = simple_set_clk_rate(dai_props->codec_dai, mclk);
-		if (ret < 0)
-			return ret;
-
-		ret = simple_set_clk_rate(dai_props->cpu_dai, mclk);
-		if (ret < 0)
-			return ret;
-
-		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
-					     SND_SOC_CLOCK_IN);
-		if (ret && ret != -ENOTSUPP)
-			goto err;
-
-		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
-					     SND_SOC_CLOCK_OUT);
-		if (ret && ret != -ENOTSUPP)
-			goto err;
-	}
-	return 0;
-err:
-	return ret;
-}
-
 static const struct snd_soc_ops simple_ops = {
 	.startup	= asoc_simple_startup,
 	.shutdown	= asoc_simple_shutdown,
-	.hw_params	= simple_hw_params,
+	.hw_params	= asoc_simple_hw_params,
 };
 
 static int simple_dai_init(struct snd_soc_pcm_runtime *rtd)
-- 
2.20.1
