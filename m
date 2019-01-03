From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: ti: davinci-mcasp: No need for
	IS_MODULE/BUILTIN check for pcm driver
Date: Thu, 3 Jan 2019 14:53:45 +0200
Message-ID: <20190103125345.16139-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 79ABF267B2D
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 13:51:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Since the platform drivers are selected by the DAI drivers (including
McASP) there is no longer a need to check whether the modules are built-in
or module.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index eeda6d5565bc..ee9ab58d4d0c 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2149,26 +2149,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	ret = davinci_mcasp_get_dma_type(mcasp);
 	switch (ret) {
 	case PCM_EDMA:
-#if IS_BUILTIN(CONFIG_SND_SOC_TI_EDMA_PCM) || \
-	(IS_MODULE(CONFIG_SND_SOC_DAVINCI_MCASP) && \
-	 IS_MODULE(CONFIG_SND_SOC_TI_EDMA_PCM))
 		ret = edma_pcm_platform_register(&pdev->dev);
-#else
-		dev_err(&pdev->dev, "Missing SND_EDMA_SOC\n");
-		ret = -EINVAL;
-		goto err;
-#endif
 		break;
 	case PCM_SDMA:
-#if IS_BUILTIN(CONFIG_SND_SOC_TI_SDMA_PCM) || \
-	(IS_MODULE(CONFIG_SND_SOC_DAVINCI_MCASP) && \
-	 IS_MODULE(CONFIG_SND_SOC_TI_SDMA_PCM))
 		ret = sdma_pcm_platform_register(&pdev->dev, NULL, NULL);
-#else
-		dev_err(&pdev->dev, "Missing SND_SDMA_SOC\n");
-		ret = -EINVAL;
-		goto err;
-#endif
 		break;
 	default:
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
