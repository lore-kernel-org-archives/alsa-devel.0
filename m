From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH] ASoC: fsl: Fix multiple symbol definitions
Date: Wed, 30 Jan 2013 21:24:31 +0100
Message-ID: <1359577471-15029-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit 25b8d31 (ASoC: fsl: fix multiple definition of init_module) fixed
a build error due to multiple symbol definitions when building as a
module. However, it causes the build to break when the driver is builtin
because the imx-pcm.o object is included multiple times. Solve the issue
by adding imx-pcm.o to each of the modules that require it, but only add
it to the kernel once when one or both drivers are builtin.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 sound/soc/fsl/Makefile | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index ec14579..8446d49 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -30,21 +30,24 @@ obj-$(CONFIG_SND_MPC52xx_SOC_EFIKA) += efika-audio-fabric.o
 # i.MX Platform Support
 snd-soc-imx-ssi-objs := imx-ssi.o
 snd-soc-imx-audmux-objs := imx-audmux.o
-snd-soc-imx-pcm-objs := imx-pcm.o
-ifneq ($(CONFIG_SND_SOC_IMX_PCM_FIQ),)
-	snd-soc-imx-pcm-objs += imx-pcm-fiq.o
-endif
-ifneq ($(CONFIG_SND_SOC_IMX_PCM_DMA),)
-	snd-soc-imx-pcm-objs += imx-pcm-dma.o
-endif
 
 obj-$(CONFIG_SND_SOC_IMX_SSI) += snd-soc-imx-ssi.o
 obj-$(CONFIG_SND_SOC_IMX_AUDMUX) += snd-soc-imx-audmux.o
 
 obj-$(CONFIG_SND_SOC_IMX_PCM_FIQ) += snd-soc-imx-pcm-fiq.o
-snd-soc-imx-pcm-fiq-y := imx-pcm-fiq.o imx-pcm.o
+snd-soc-imx-pcm-fiq-y := imx-pcm-fiq.o
+ifeq ($(CONFIG_SND_SOC_IMX_PCM_FIQ),m)
+snd-soc-imx-pcm-fiq-y += imx-pcm.o
+else
+obj-$(CONFIG_SND_SOC_IMX_PCM_FIQ) += imx-pcm.o
+endif
 obj-$(CONFIG_SND_SOC_IMX_PCM_DMA) += snd-soc-imx-pcm-dma.o
-snd-soc-imx-pcm-dma-y := imx-pcm-dma.o imx-pcm.o
+snd-soc-imx-pcm-dma-y := imx-pcm-dma.o
+ifeq ($(CONFIG_SND_SOC_IMX_PCM_DMA),m)
+snd-soc-imx-pcm-dma-y := imx-pcm.o
+else
+obj-$(CONFIG_SND_SOC_IMX_PCM_DMA) += imx-pcm.o
+endif
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
-- 
1.8.1.2
