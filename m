From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-mcasp: No need for
	IS_MODULE/BUILTIN check for pcm driver" to the asoc tree
Date: Mon,  7 Jan 2019 12:30:33 +0000 (GMT)
Message-ID: <20190107123033.B3EDC1127490@debutante.sirena.org.uk>
References: <20190103125345.16139-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E47C267B50
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:30:34 +0100 (CET)
In-Reply-To: <20190103125345.16139-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, jsarha@ti.com, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-mcasp: No need for IS_MODULE/BUILTIN check for pcm driver

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

>From 2130f15d6cd9898a68dc7244084985353030514f Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 3 Jan 2019 14:53:45 +0200
Subject: [PATCH] ASoC: ti: davinci-mcasp: No need for IS_MODULE/BUILTIN check
 for pcm driver

Since the platform drivers are selected by the DAI drivers (including
McASP) there is no longer a need to check whether the modules are built-in
or module.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
