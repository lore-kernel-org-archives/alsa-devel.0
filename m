From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: Fix module build
Date: Mon, 29 Jul 2013 18:37:32 -0300
Message-ID: <1375133852-15248-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f181.google.com (mail-gh0-f181.google.com
 [209.85.160.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D3A7A26507D
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 23:37:47 +0200 (CEST)
Received: by mail-gh0-f181.google.com with SMTP id z12so1884948ghb.40
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 14:37:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, g.liakhovetski@gmx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Building imx_v6_v7_defconfig with all audio drivers as modules results in
the folowing build error:

ERROR: "imx_pcm_fiq_init" [sound/soc/fsl/snd-soc-imx-ssi.ko] undefined!
ERROR: "imx_pcm_dma_init" [sound/soc/fsl/snd-soc-imx-ssi.ko] undefined!
ERROR: "imx_pcm_fiq_exit" [sound/soc/fsl/snd-soc-imx-ssi.ko] undefined!
ERROR: "imx_pcm_dma_exit" [sound/soc/fsl/snd-soc-imx-ssi.ko] undefined!
ERROR: "imx_pcm_dma_init" [sound/soc/fsl/snd-soc-fsl-ssi.ko] undefined!
ERROR: "imx_pcm_dma_exit" [sound/soc/fsl/snd-soc-fsl-ssi.ko] undefined!

Fix this by allowing SND_SOC_IMX_PCM_FIQ and SND_SOC_IMX_PCM_DMA to be also
built as modules and by using 'IS_ENABLED' to cover the module case.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/Kconfig   | 4 ++--
 sound/soc/fsl/imx-pcm.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3a79d01..c26449b 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -109,11 +109,11 @@ config SND_SOC_IMX_SSI
 	tristate
 
 config SND_SOC_IMX_PCM_FIQ
-	bool
+	tristate
 	select FIQ
 
 config SND_SOC_IMX_PCM_DMA
-	bool
+	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_SOC_IMX_AUDMUX
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 9136625..5d5b733 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -38,7 +38,7 @@ struct imx_pcm_fiq_params {
 	struct snd_dmaengine_dai_dma_data *dma_params_tx;
 };
 
-#ifdef CONFIG_SND_SOC_IMX_PCM_DMA
+#if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_DMA)
 int imx_pcm_dma_init(struct platform_device *pdev);
 void imx_pcm_dma_exit(struct platform_device *pdev);
 #else
@@ -52,7 +52,7 @@ static inline void imx_pcm_dma_exit(struct platform_device *pdev)
 }
 #endif
 
-#ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
+#if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_FIQ)
 int imx_pcm_fiq_init(struct platform_device *pdev,
 		struct imx_pcm_fiq_params *params);
 void imx_pcm_fiq_exit(struct platform_device *pdev);
-- 
1.8.1.2
