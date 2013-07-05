From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: Allow imx-pcm-{dma,fiq}.c to be modules
Date: Fri, 5 Jul 2013 17:45:15 +0200
Message-ID: <201307051745.16140.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: alsa-devel@alsa-project.org

This is required so we can build the imx sound support
when ALSA itself is a loadable module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index aa43854..805b83e 100644
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
index 67f656c..0e3619e 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -32,7 +32,7 @@ imx_pcm_dma_params_init_data(struct imx_dma_data *dma_data,
 		dma_data->peripheral_type = IMX_DMATYPE_SSI;
 }
 
-#ifdef CONFIG_SND_SOC_IMX_PCM_DMA
+#if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_DMA)
 int imx_pcm_dma_init(struct platform_device *pdev);
 void imx_pcm_dma_exit(struct platform_device *pdev);
 #else
@@ -46,7 +46,7 @@ static inline void imx_pcm_dma_exit(struct platform_device *pdev)
 }
 #endif
 
-#ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
+#if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_FIQ)
 int imx_pcm_fiq_init(struct platform_device *pdev);
 void imx_pcm_fiq_exit(struct platform_device *pdev);
 #else
