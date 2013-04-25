From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/5] ASoC: fsl: remove use of imx-pcm-audio
	from imx-ssi
Date: Thu, 25 Apr 2013 11:18:47 +0800
Message-ID: <1366859930-1232-3-git-send-email-shawn.guo@linaro.org>
References: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id CC654265D00
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 05:19:11 +0200 (CEST)
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
imx-ssi can just directly call it to save the use of imx-pcm-audio.
With this change, imx-ssi becomes not only a cpu DAI but also a
platform device, so updates platform device setup in imx-mc13783 and
mx27vis-aic32x4 accordingly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/imx-mc13783.c     |    2 +-
 sound/soc/fsl/imx-ssi.c         |   21 +++++----------------
 sound/soc/fsl/imx-ssi.h         |    1 -
 sound/soc/fsl/mx27vis-aic32x4.c |    2 +-
 4 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 4ae30f2..9df173c 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -64,7 +64,7 @@ static struct snd_soc_dai_link imx_mc13783_dai_mc13783[] = {
 		.codec_dai_name	 = "mc13783-hifi",
 		.codec_name	 = "mc13783-codec",
 		.cpu_dai_name	 = "imx-ssi.0",
-		.platform_name	 = "imx-pcm-audio.0",
+		.platform_name	 = "imx-ssi.0",
 		.ops		 = &imx_mc13783_hifi_ops,
 		.symmetric_rates = 1,
 		.dai_fmt 	 = FMT_SSI,
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 902fab0..b5a2b04 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -608,24 +608,13 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		goto failed_pdev_fiq_add;
 	}
 
-	ssi->soc_platform_pdev = platform_device_alloc("imx-pcm-audio", pdev->id);
-	if (!ssi->soc_platform_pdev) {
-		ret = -ENOMEM;
-		goto failed_pdev_alloc;
-	}
-
-	platform_set_drvdata(ssi->soc_platform_pdev, ssi);
-	ret = platform_device_add(ssi->soc_platform_pdev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add platform device\n");
-		goto failed_pdev_add;
-	}
+	ret = imx_pcm_dma_init(pdev);
+	if (ret)
+		goto failed_pcm_dma;
 
 	return 0;
 
-failed_pdev_add:
-	platform_device_put(ssi->soc_platform_pdev);
-failed_pdev_alloc:
+failed_pcm_dma:
 	platform_device_del(ssi->soc_platform_pdev_fiq);
 failed_pdev_fiq_add:
 	platform_device_put(ssi->soc_platform_pdev_fiq);
@@ -645,7 +634,7 @@ static int imx_ssi_remove(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 
-	platform_device_unregister(ssi->soc_platform_pdev);
+	imx_pcm_dma_exit(pdev);
 	platform_device_unregister(ssi->soc_platform_pdev_fiq);
 
 	snd_soc_unregister_component(&pdev->dev);
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index bb6b3db..b052fad 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -212,7 +212,6 @@ struct imx_ssi {
 
 	int enabled;
 
-	struct platform_device *soc_platform_pdev;
 	struct platform_device *soc_platform_pdev_fiq;
 };
 
diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index 3d10741..f4c3bda 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -161,7 +161,7 @@ static struct snd_soc_dai_link mx27vis_aic32x4_dai = {
 	.name		= "tlv320aic32x4",
 	.stream_name	= "TLV320AIC32X4",
 	.codec_dai_name	= "tlv320aic32x4-hifi",
-	.platform_name	= "imx-pcm-audio.0",
+	.platform_name	= "imx-ssi.0",
 	.codec_name	= "tlv320aic32x4.0-0018",
 	.cpu_dai_name	= "imx-ssi.0",
 	.ops		= &mx27vis_aic32x4_snd_ops,
-- 
1.7.9.5
