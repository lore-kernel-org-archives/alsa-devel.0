From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/7] ASoC i.MX: register dma audio device
Date: Thu,  4 Nov 2010 17:05:42 +0100
Message-ID: <1288886745-25977-5-git-send-email-s.hauer@pengutronix.de>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B7EB6103896
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 17:05:48 +0100 (CET)
In-Reply-To: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

We have two different transfer methods on i.MX: FIQ and DMA. Since
the merge of the ASoC multicomponent support the DMA device is lost.
Add it again. Also, imx_ssi_dai_probe has to be called for !AC97
aswell.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-ssi.c |   44 +++++++++++++++++++++++++++++---------------
 sound/soc/imx/imx-ssi.h |    1 +
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index d4bd345..d2d98c7 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -439,7 +439,22 @@ void imx_pcm_free(struct snd_pcm *pcm)
 }
 EXPORT_SYMBOL_GPL(imx_pcm_free);
 
+static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct imx_ssi *ssi = dev_get_drvdata(dai->dev);
+	uint32_t val;
+
+	snd_soc_dai_set_drvdata(dai, ssi);
+
+	val = SSI_SFCSR_TFWM0(ssi->dma_params_tx.burstsize) |
+		SSI_SFCSR_RFWM0(ssi->dma_params_rx.burstsize);
+	writel(val, ssi->base + SSI_SFCSR);
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver imx_ssi_dai = {
+	.probe = imx_ssi_dai_probe,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
@@ -455,20 +470,6 @@ static struct snd_soc_dai_driver imx_ssi_dai = {
 	.ops = &imx_ssi_pcm_dai_ops,
 };
 
-static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
-{
-	struct imx_ssi *ssi = dev_get_drvdata(dai->dev);
-	uint32_t val;
-
-	snd_soc_dai_set_drvdata(dai, ssi);
-
-	val = SSI_SFCSR_TFWM0(ssi->dma_params_tx.burstsize) |
-		SSI_SFCSR_RFWM0(ssi->dma_params_rx.burstsize);
-	writel(val, ssi->base + SSI_SFCSR);
-
-	return 0;
-}
-
 static struct snd_soc_dai_driver imx_ac97_dai = {
 	.probe = imx_ssi_dai_probe,
 	.ac97_control = 1,
@@ -677,7 +678,17 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		goto failed_register;
 	}
 
-	ssi->soc_platform_pdev = platform_device_alloc("imx-fiq-pcm-audio", pdev->id);
+	ssi->soc_platform_pdev_fiq = platform_device_alloc("imx-fiq-pcm-audio", pdev->id);
+	if (!ssi->soc_platform_pdev_fiq)
+		goto failed_pdev_fiq_alloc;
+	platform_set_drvdata(ssi->soc_platform_pdev_fiq, ssi);
+	ret = platform_device_add(ssi->soc_platform_pdev_fiq);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add platform device\n");
+		goto failed_pdev_fiq_add;
+	}
+
+	ssi->soc_platform_pdev = platform_device_alloc("imx-pcm-audio", pdev->id);
 	if (!ssi->soc_platform_pdev)
 		goto failed_pdev_alloc;
 	platform_set_drvdata(ssi->soc_platform_pdev, ssi);
@@ -692,6 +703,9 @@ static int imx_ssi_probe(struct platform_device *pdev)
 failed_pdev_add:
 	platform_device_put(ssi->soc_platform_pdev);
 failed_pdev_alloc:
+failed_pdev_fiq_add:
+	platform_device_put(ssi->soc_platform_pdev_fiq);
+failed_pdev_fiq_alloc:
 	snd_soc_unregister_dai(&pdev->dev);
 failed_register:
 failed_ac97:
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
index 53b780d..4fc17da 100644
--- a/sound/soc/imx/imx-ssi.h
+++ b/sound/soc/imx/imx-ssi.h
@@ -212,6 +212,7 @@ struct imx_ssi {
 	int enabled;
 
 	struct platform_device *soc_platform_pdev;
+	struct platform_device *soc_platform_pdev_fiq;
 };
 
 struct snd_soc_platform *imx_ssi_fiq_init(struct platform_device *pdev,
-- 
1.7.2.3
