From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: lpass-platform: replace platform
	to component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:56 +0000
Message-ID: <E1elDE8-00032d-H6@debutante>
References: <87r2qvew6x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8565F267467
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:29:00 +0100 (CET)
In-Reply-To: <87r2qvew6x.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: lpass-platform: replace platform to component

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

>From 121de3b4bee60a817aee2e61df26108ccd6dd6c6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:48:52 +0000
Subject: [PATCH] ASoC: qcom: lpass-platform: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 42 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index caf71aab8196..31fe78aa207f 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -24,6 +24,8 @@
 #include "lpass-lpaif-reg.h"
 #include "lpass.h"
 
+#define DRV_NAME "lpass-platform"
+
 struct lpass_pcm_data {
 	int dma_ch;
 	int i2s_port;
@@ -61,8 +63,8 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(soc_runtime, DRV_NAME);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct lpass_variant *v = drvdata->variant;
 	int ret, dma_ch, dir = substream->stream;
 	struct lpass_pcm_data *data;
@@ -115,8 +117,8 @@ static int lpass_platform_pcmops_close(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(soc_runtime, DRV_NAME);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct lpass_variant *v = drvdata->variant;
 	struct lpass_pcm_data *data;
 
@@ -132,8 +134,8 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(soc_runtime, DRV_NAME);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct snd_pcm_runtime *rt = substream->runtime;
 	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
@@ -225,8 +227,8 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(soc_runtime, DRV_NAME);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct snd_pcm_runtime *rt = substream->runtime;
 	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
@@ -246,8 +248,8 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(soc_runtime, DRV_NAME);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct snd_pcm_runtime *rt = substream->runtime;
 	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
@@ -298,8 +300,8 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		int cmd)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(soc_runtime, DRV_NAME);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct snd_pcm_runtime *rt = substream->runtime;
 	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
@@ -372,8 +374,8 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 		struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_data *drvdata =
-			snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(soc_runtime, DRV_NAME);
+	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
 	struct snd_pcm_runtime *rt = substream->runtime;
 	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
@@ -509,13 +511,14 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 {
 	struct snd_pcm *pcm = soc_runtime->pcm;
 	struct snd_pcm_substream *psubstream, *csubstream;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(soc_runtime, DRV_NAME);
 	int ret = -EINVAL;
 	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
 	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 	if (psubstream) {
 		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-					soc_runtime->platform->dev,
+					component->dev,
 					size, &psubstream->dma_buffer);
 		if (ret) {
 			dev_err(soc_runtime->dev, "Cannot allocate buffer(s)\n");
@@ -526,7 +529,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
 	if (csubstream) {
 		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-					soc_runtime->platform->dev,
+					component->dev,
 					size, &csubstream->dma_buffer);
 		if (ret) {
 			dev_err(soc_runtime->dev, "Cannot allocate buffer(s)\n");
@@ -555,7 +558,8 @@ static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
-static const struct snd_soc_platform_driver lpass_platform_driver = {
+static const struct snd_soc_component_driver lpass_component_driver = {
+	.name		= DRV_NAME,
 	.pcm_new	= lpass_platform_pcm_new,
 	.pcm_free	= lpass_platform_pcm_free,
 	.ops		= &lpass_platform_pcm_ops,
@@ -591,8 +595,8 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 	}
 
 
-	return devm_snd_soc_register_platform(&pdev->dev,
-			&lpass_platform_driver);
+	return devm_snd_soc_register_component(&pdev->dev,
+			&lpass_component_driver, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_platform_register);
 
-- 
2.16.1
