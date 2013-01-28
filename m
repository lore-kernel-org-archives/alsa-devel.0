From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] Revert "ASoC: fsl: fix multiple definition
	of init_module"
Date: Mon, 28 Jan 2013 14:25:42 +0800
Message-ID: <1359354343-1711-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 126892650CE
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 07:25:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

This reverts commit 25b8d31488a3fb3611651991969526b2ea475764.

While the commit fixes multiple init_module definition error with
module build, it breaks build when both imx-pcm-fiq and imx-pcm-dma
are built in as below.

  LD      sound/soc/fsl/snd-soc-fsl-ssi.o
  LD      sound/soc/fsl/snd-soc-fsl-utils.o
  LD      sound/soc/fsl/snd-soc-imx-ssi.o
  LD      sound/soc/fsl/snd-soc-imx-audmux.o
  LD      sound/soc/fsl/snd-soc-imx-pcm-fiq.o
  LD      sound/soc/fsl/snd-soc-imx-pcm-dma.o
  LD      sound/soc/fsl/snd-soc-eukrea-tlv320.o
  LD      sound/soc/fsl/snd-soc-imx-sgtl5000.o
  LD      sound/soc/fsl/snd-soc-imx-mc13783.o
  LD      sound/soc/fsl/built-in.o
sound/soc/fsl/snd-soc-imx-pcm-dma.o: In function `imx_pcm_free':
imx-pcm.c:(.text+0x464): multiple definition of `imx_pcm_free'
sound/soc/fsl/snd-soc-imx-pcm-fiq.o:imx-pcm-fiq.c:(.text+0x1a8): first defined here
sound/soc/fsl/snd-soc-imx-pcm-dma.o: In function `snd_imx_pcm_mmap':
imx-pcm.c:(.text+0x35c): multiple definition of `snd_imx_pcm_mmap'
sound/soc/fsl/snd-soc-imx-pcm-fiq.o:imx-pcm-fiq.c:(.text+0xa0): first defined here
sound/soc/fsl/snd-soc-imx-pcm-dma.o: In function `imx_pcm_new':
imx-pcm.c:(.text+0x3dc): multiple definition of `imx_pcm_new'
sound/soc/fsl/snd-soc-imx-pcm-fiq.o:imx-pcm-fiq.c:(.text+0x120): first defined here
make[4]: *** [sound/soc/fsl/built-in.o] Error 1

Let's revert the commit and find a proper fix for multiple init_module
definition error later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/Kconfig   |    9 +++++++--
 sound/soc/fsl/Makefile  |    5 +----
 sound/soc/fsl/imx-pcm.c |    3 +++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index a210c8d..3b98159 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -108,13 +108,18 @@ if SND_IMX_SOC
 config SND_SOC_IMX_SSI
 	tristate
 
-config SND_SOC_IMX_PCM_FIQ
+config SND_SOC_IMX_PCM
 	tristate
+
+config SND_SOC_IMX_PCM_FIQ
+	bool
 	select FIQ
+	select SND_SOC_IMX_PCM
 
 config SND_SOC_IMX_PCM_DMA
-	tristate
+	bool
 	select SND_SOC_DMAENGINE_PCM
+	select SND_SOC_IMX_PCM
 
 config SND_SOC_IMX_AUDMUX
 	tristate
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index ec14579..afd3479 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -41,10 +41,7 @@ endif
 obj-$(CONFIG_SND_SOC_IMX_SSI) += snd-soc-imx-ssi.o
 obj-$(CONFIG_SND_SOC_IMX_AUDMUX) += snd-soc-imx-audmux.o
 
-obj-$(CONFIG_SND_SOC_IMX_PCM_FIQ) += snd-soc-imx-pcm-fiq.o
-snd-soc-imx-pcm-fiq-y := imx-pcm-fiq.o imx-pcm.o
-obj-$(CONFIG_SND_SOC_IMX_PCM_DMA) += snd-soc-imx-pcm-dma.o
-snd-soc-imx-pcm-dma-y := imx-pcm-dma.o imx-pcm.o
+obj-$(CONFIG_SND_SOC_IMX_PCM) += snd-soc-imx-pcm.o
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
diff --git a/sound/soc/fsl/imx-pcm.c b/sound/soc/fsl/imx-pcm.c
index 0c9f188..d5cd9ef 100644
--- a/sound/soc/fsl/imx-pcm.c
+++ b/sound/soc/fsl/imx-pcm.c
@@ -31,6 +31,7 @@ int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 			runtime->dma_bytes);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_imx_pcm_mmap);
 
 static int imx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 {
@@ -79,6 +80,7 @@ int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(imx_pcm_new);
 
 void imx_pcm_free(struct snd_pcm *pcm)
 {
@@ -100,6 +102,7 @@ void imx_pcm_free(struct snd_pcm *pcm)
 		buf->area = NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(imx_pcm_free);
 
 MODULE_DESCRIPTION("Freescale i.MX PCM driver");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
1.7.9.5
