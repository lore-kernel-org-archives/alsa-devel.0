From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: replace platform to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:30:42 +0000
Message-ID: <E1elDFq-0003HR-S8@debutante>
References: <87bmhzgb0n.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EC3C826755F
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:30:48 +0100 (CET)
In-Reply-To: <87bmhzgb0n.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, MukundaVijendar <vijendar.mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: replace platform to component

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

>From a1042a42bc5cc03969be40521c0e163be187ec8f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:44:23 +0000
Subject: [PATCH] ASoC: amd: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Mukunda,Vijendar <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index c33a512283a4..78d7b6238376 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -23,6 +23,8 @@
 #include <drm/amd_asic_type.h>
 #include "acp.h"
 
+#define DRV_NAME "acp_audio_dma"
+
 #define PLAYBACK_MIN_NUM_PERIODS    2
 #define PLAYBACK_MAX_NUM_PERIODS    2
 #define PLAYBACK_MAX_PERIOD_SIZE    16384
@@ -702,8 +704,8 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	int ret = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct audio_drv_data *intr_data = dev_get_drvdata(prtd->platform->dev);
-
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct audio_drv_data *intr_data = dev_get_drvdata(component->dev);
 	struct audio_substream_data *adata =
 		kzalloc(sizeof(struct audio_substream_data), GFP_KERNEL);
 	if (adata == NULL)
@@ -730,7 +732,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
-		dev_err(prtd->platform->dev, "set integer constraint failed\n");
+		dev_err(component->dev, "set integer constraint failed\n");
 		kfree(adata);
 		return ret;
 	}
@@ -778,7 +780,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct audio_drv_data *adata = dev_get_drvdata(prtd->platform->dev);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	runtime = substream->runtime;
 	rtd = runtime->private_data;
@@ -907,6 +910,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
 	struct audio_substream_data *rtd = runtime->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
 
 	if (!rtd)
 		return -EINVAL;
@@ -924,7 +928,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
 						BIT(SYSRAM_TO_ACP_CH_NUM)) {
 				if (!loops--) {
-					dev_err(prtd->platform->dev,
+					dev_err(component->dev,
 						"acp dma start timeout\n");
 					return -ETIMEDOUT;
 				}
@@ -970,7 +974,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
-	struct audio_drv_data *adata = dev_get_drvdata(rtd->platform->dev);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	switch (adata->asic_type) {
 	case CHIP_STONEY:
@@ -987,7 +992,7 @@ static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 		break;
 	}
 	if (ret < 0)
-		dev_err(rtd->platform->dev,
+		dev_err(component->dev,
 				"buffer preallocation failer error:%d\n", ret);
 	return ret;
 }
@@ -998,7 +1003,8 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct audio_drv_data *adata = dev_get_drvdata(prtd->platform->dev);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	kfree(rtd);
 
@@ -1044,7 +1050,8 @@ static const struct snd_pcm_ops acp_dma_ops = {
 	.prepare = acp_dma_prepare,
 };
 
-static struct snd_soc_platform_driver acp_asoc_platform = {
+static struct snd_soc_component_driver acp_asoc_platform = {
+	.name = DRV_NAME,
 	.ops = &acp_dma_ops,
 	.pcm_new = acp_dma_new,
 };
@@ -1102,7 +1109,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 		return status;
 	}
 
-	status = snd_soc_register_platform(&pdev->dev, &acp_asoc_platform);
+	status = devm_snd_soc_register_component(&pdev->dev,
+						&acp_asoc_platform, NULL, 0);
 	if (status != 0) {
 		dev_err(&pdev->dev, "Fail to register ALSA platform device\n");
 		return status;
@@ -1123,7 +1131,6 @@ static int acp_audio_remove(struct platform_device *pdev)
 	status = acp_deinit(adata->acp_mmio);
 	if (status)
 		dev_err(&pdev->dev, "ACP Deinit failed status:%d\n", status);
-	snd_soc_unregister_platform(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.16.1
