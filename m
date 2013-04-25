From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 4/5] ASoC: fsl: remove use of imx-fiq-pcm-audio
	from imx-ssi
Date: Thu, 25 Apr 2013 11:18:49 +0800
Message-ID: <1366859930-1232-5-git-send-email-shawn.guo@linaro.org>
References: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 539E4265D1F
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 05:20:09 +0200 (CEST)
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

Rather than instantiating imx-fiq-pcm-audio to call imx_pcm_fiq_init(),
imx-ssi can just directly call it to save the use of imx-fiq-pcm-audio.
With this change, imx-ssi becomes not only a cpu DAI but also a platform
device, so updates platform device setup in eukrea-tlv320, phycore-ac97
and wm1133-ev1 accordingly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/eukrea-tlv320.c |    2 +-
 sound/soc/fsl/imx-ssi.c       |   23 ++++++-----------------
 sound/soc/fsl/imx-ssi.h       |    2 --
 sound/soc/fsl/phycore-ac97.c  |    2 +-
 sound/soc/fsl/wm1133-ev1.c    |    2 +-
 5 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 75ffdf0..9a4a0ca 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -80,7 +80,7 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
 	.codec_dai_name	= "tlv320aic23-hifi",
-	.platform_name	= "imx-fiq-pcm-audio.0",
+	.platform_name	= "imx-ssi.0",
 	.codec_name	= "tlv320aic23-codec.0-001a",
 	.cpu_dai_name	= "imx-ssi.0",
 	.ops		= &eukrea_tlv320_snd_ops,
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index b5a2b04..1b2e750 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -595,18 +595,9 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		goto failed_register;
 	}
 
-	ssi->soc_platform_pdev_fiq = platform_device_alloc("imx-fiq-pcm-audio", pdev->id);
-	if (!ssi->soc_platform_pdev_fiq) {
-		ret = -ENOMEM;
-		goto failed_pdev_fiq_alloc;
-	}
-
-	platform_set_drvdata(ssi->soc_platform_pdev_fiq, ssi);
-	ret = platform_device_add(ssi->soc_platform_pdev_fiq);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add platform device\n");
-		goto failed_pdev_fiq_add;
-	}
+	ret = imx_pcm_fiq_init(pdev);
+	if (ret)
+		goto failed_pcm_fiq;
 
 	ret = imx_pcm_dma_init(pdev);
 	if (ret)
@@ -615,10 +606,8 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	return 0;
 
 failed_pcm_dma:
-	platform_device_del(ssi->soc_platform_pdev_fiq);
-failed_pdev_fiq_add:
-	platform_device_put(ssi->soc_platform_pdev_fiq);
-failed_pdev_fiq_alloc:
+	imx_pcm_fiq_exit(pdev);
+failed_pcm_fiq:
 	snd_soc_unregister_component(&pdev->dev);
 failed_register:
 	release_mem_region(res->start, resource_size(res));
@@ -635,7 +624,7 @@ static int imx_ssi_remove(struct platform_device *pdev)
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 
 	imx_pcm_dma_exit(pdev);
-	platform_device_unregister(ssi->soc_platform_pdev_fiq);
+	imx_pcm_fiq_exit(pdev);
 
 	snd_soc_unregister_component(&pdev->dev);
 
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index b052fad..d5003ce 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -211,8 +211,6 @@ struct imx_ssi {
 	struct imx_dma_data filter_data_rx;
 
 	int enabled;
-
-	struct platform_device *soc_platform_pdev_fiq;
 };
 
 #endif /* _IMX_SSI_H */
diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index f8da6dd..ae403c2 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -33,7 +33,7 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 		.codec_dai_name		= "wm9712-hifi",
 		.codec_name	= "wm9712-codec",
 		.cpu_dai_name	= "imx-ssi.0",
-		.platform_name	= "imx-fiq-pcm-audio.0",
+		.platform_name	= "imx-ssi.0",
 		.ops		= &imx_phycore_hifi_ops,
 	},
 };
diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index fe54a69..fce6325 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -245,7 +245,7 @@ static struct snd_soc_dai_link wm1133_ev1_dai = {
 	.stream_name = "Audio",
 	.cpu_dai_name = "imx-ssi.0",
 	.codec_dai_name = "wm8350-hifi",
-	.platform_name = "imx-fiq-pcm-audio.0",
+	.platform_name = "imx-ssi.0",
 	.codec_name = "wm8350-codec.0-0x1a",
 	.init = wm1133_ev1_init,
 	.ops = &wm1133_ev1_ops,
-- 
1.7.9.5
