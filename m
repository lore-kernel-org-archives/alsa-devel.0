From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v5 3/8] ASoC: fsl: rename imx-pcm Kconfig
	options and filename
Date: Fri, 16 Mar 2012 16:56:39 +0800
Message-ID: <1331888204-27058-4-git-send-email-shawn.guo@linaro.org>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3616F104742
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 09:56:43 +0100 (CET)
Received: by mail-iy0-f179.google.com with SMTP id h37so5771144iak.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 01:56:42 -0700 (PDT)
In-Reply-To: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Rename a couple of imx-pcm Kconfig options and filename to get them
well named and less confusing.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/Kconfig                              |   12 ++++++------
 sound/soc/fsl/Makefile                             |    4 ++--
 sound/soc/fsl/{imx-pcm-dma-mx2.c => imx-pcm-dma.c} |    0
 3 files changed, 8 insertions(+), 8 deletions(-)
 rename sound/soc/fsl/{imx-pcm-dma-mx2.c => imx-pcm-dma.c} (100%)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 19856a0..e3f7509 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -97,12 +97,12 @@ config SND_SOC_IMX_SSI
 config SND_SOC_IMX_PCM
 	tristate
 
-config SND_MXC_SOC_FIQ
+config SND_SOC_IMX_PCM_FIQ
 	tristate
 	select FIQ
 	select SND_SOC_IMX_PCM
 
-config SND_MXC_SOC_MX2
+config SND_SOC_IMX_PCM_DMA
 	tristate
 	select SND_SOC_DMAENGINE_PCM
 	select SND_SOC_IMX_PCM
@@ -114,7 +114,7 @@ config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
 	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
-	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	help
@@ -125,7 +125,7 @@ config SND_SOC_MX27VIS_AIC32X4
 	tristate "SoC audio support for Visstrim M10 boards"
 	depends on MACH_IMX27_VISSTRIM_M10 && I2C
 	select SND_SOC_TLV320AIC32X4
-	select SND_MXC_SOC_MX2
+	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	help
@@ -137,7 +137,7 @@ config SND_SOC_PHYCORE_AC97
 	depends on MACH_PCM043 || MACH_PCA100
 	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
-	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	help
@@ -152,7 +152,7 @@ config SND_SOC_EUKREA_TLV320
 		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
 	depends on I2C
 	select SND_SOC_TLV320AIC23
-	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	help
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 36c257f..f031409 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -30,8 +30,8 @@ obj-$(CONFIG_SND_SOC_IMX_AUDMUX) += snd-soc-imx-audmux.o
 
 obj-$(CONFIG_SND_SOC_IMX_PCM) += snd-soc-imx-pcm.o
 snd-soc-imx-pcm-y := imx-pcm.o
-snd-soc-imx-pcm-$(CONFIG_SND_MXC_SOC_FIQ) += imx-pcm-fiq.o
-snd-soc-imx-pcm-$(CONFIG_SND_MXC_SOC_MX2) += imx-pcm-dma-mx2.o
+snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_FIQ) += imx-pcm-fiq.o
+snd-soc-imx-pcm-$(CONFIG_SND_SOC_IMX_PCM_DMA) += imx-pcm-dma.o
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
diff --git a/sound/soc/fsl/imx-pcm-dma-mx2.c b/sound/soc/fsl/imx-pcm-dma.c
similarity index 100%
rename from sound/soc/fsl/imx-pcm-dma-mx2.c
rename to sound/soc/fsl/imx-pcm-dma.c
-- 
1.7.5.4
