From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: imx: Add MODULE_LICENSE to DMA drivers
Date: Fri, 16 Aug 2013 12:07:58 +0100
Message-ID: <1376651278-23197-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EC13261B28
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 13:08:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Ben Hutchings <ben@decadent.org.uk>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Reported-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/imx-pcm-dma.c | 2 ++
 sound/soc/fsl/imx-pcm-fiq.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index f323ce0..aa6de5c 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -73,3 +73,5 @@ void imx_pcm_dma_exit(struct platform_device *pdev)
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(imx_pcm_dma_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 3b2ba99..34043c5 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -408,3 +408,5 @@ void imx_pcm_fiq_exit(struct platform_device *pdev)
 	snd_soc_unregister_platform(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(imx_pcm_fiq_exit);
+
+MODULE_LICENSE("GPL");
-- 
1.8.4.rc2
