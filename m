From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/5] ASoC: fsl: remove use of imx-pcm-audio
	from fsl_ssi
Date: Thu, 25 Apr 2013 11:18:46 +0800
Message-ID: <1366859930-1232-2-git-send-email-shawn.guo@linaro.org>
References: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 81B44265CDC
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 05:19:03 +0200 (CEST)
In-Reply-To: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Rather than instantiating imx-pcm-audio to call imx_pcm_dma_init(),
fsl_ssi can just directly call it to save the use of imx-pcm-audio.
With this change, fsl_ssi becomes not only a cpu DAI but also a platform
device, so updates platform device setup in imx-sgtl5000 accordingly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c      |   13 ++++---------
 sound/soc/fsl/imx-sgtl5000.c |    2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0f0bed6..2f2d837 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -122,7 +122,6 @@ struct fsl_ssi_private {
 	bool new_binding;
 	bool ssi_on_imx;
 	struct clk *clk;
-	struct platform_device *imx_pcm_pdev;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct imx_dma_data filter_data_tx;
@@ -809,13 +808,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	if (ssi_private->ssi_on_imx) {
-		ssi_private->imx_pcm_pdev =
-			platform_device_register_simple("imx-pcm-audio",
-							-1, NULL, 0);
-		if (IS_ERR(ssi_private->imx_pcm_pdev)) {
-			ret = PTR_ERR(ssi_private->imx_pcm_pdev);
+		ret = imx_pcm_dma_init(pdev);
+		if (ret)
 			goto error_dev;
-		}
 	}
 
 	/*
@@ -854,7 +849,7 @@ done:
 
 error_dai:
 	if (ssi_private->ssi_on_imx)
-		platform_device_unregister(ssi_private->imx_pcm_pdev);
+		imx_pcm_dma_exit(pdev);
 	snd_soc_unregister_component(&pdev->dev);
 
 error_dev:
@@ -889,7 +884,7 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (!ssi_private->new_binding)
 		platform_device_unregister(ssi_private->pdev);
 	if (ssi_private->ssi_on_imx) {
-		platform_device_unregister(ssi_private->imx_pcm_pdev);
+		imx_pcm_dma_exit(pdev);
 		clk_disable_unprepare(ssi_private->clk);
 		clk_put(ssi_private->clk);
 	}
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 9584e78..8d49165 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -149,7 +149,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	data->dai.codec_dai_name = "sgtl5000";
 	data->dai.codec_of_node = codec_np;
 	data->dai.cpu_of_node = ssi_np;
-	data->dai.platform_name = "imx-pcm-audio";
+	data->dai.platform_of_node = ssi_np;
 	data->dai.init = &imx_sgtl5000_dai_init;
 	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			    SND_SOC_DAIFMT_CBM_CFM;
-- 
1.7.9.5
