From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 09/17] ASoC: fsl: separate SSI and DMA
	Kconfig options
Date: Mon,  5 Mar 2012 22:30:57 +0800
Message-ID: <1330957865-19085-10-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 207F91042CD
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 15:21:48 +0100 (CET)
Received: by yenl1 with SMTP id l1so1646578yen.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 06:21:47 -0800 (PST)
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
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

The fsl_ssi driver will possibly be shared between Freescale PowerPC
and ARM/IMX families, so give it a separate Kconfig option.  Then
fsl_ssi driver can possibly be selected independently from selecting
PowerPC DMA based PCM driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/Kconfig  |   15 +++++++++------
 sound/soc/fsl/Makefile |    3 ++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d754d34..ca693b2 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,10 +1,11 @@
 config SND_MPC52xx_DMA
 	tristate
 
-# ASoC platform support for the Freescale PowerPC SOCs that have an SSI and
-# an Elo DMA controller, such as the MPC8610 and P1022.  You will still need to
-# select a platform driver and a codec driver.
-config SND_SOC_POWERPC_SSI
+config SND_SOC_FSL_SSI
+	tristate
+	depends on FSL_SOC
+
+config SND_SOC_POWERPC_DMA
 	tristate
 	depends on FSL_SOC
 
@@ -12,7 +13,8 @@ config SND_SOC_MPC8610_HPCD
 	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
 	# I2C is necessary for the CS4270 driver
 	depends on MPC8610_HPCD && I2C
-	select SND_SOC_POWERPC_SSI
+	select SND_SOC_FSL_SSI
+	select SND_SOC_POWERPC_DMA
 	select SND_SOC_CS4270
 	select SND_SOC_CS4270_VD33_ERRATA
 	default y if MPC8610_HPCD
@@ -23,7 +25,8 @@ config SND_SOC_P1022_DS
 	tristate "ALSA SoC support for the Freescale P1022 DS board"
 	# I2C is necessary for the WM8776 driver
 	depends on P1022_DS && I2C
-	select SND_SOC_POWERPC_SSI
+	select SND_SOC_FSL_SSI
+	select SND_SOC_POWERPC_DMA
 	select SND_SOC_WM8776
 	default y if P1022_DS
 	help
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index b4a38c0..95d483f 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_SND_SOC_P1022_DS) += snd-soc-p1022-ds.o
 # Freescale PowerPC SSI/DMA Platform Support
 snd-soc-fsl-ssi-objs := fsl_ssi.o
 snd-soc-fsl-dma-objs := fsl_dma.o
-obj-$(CONFIG_SND_SOC_POWERPC_SSI) += snd-soc-fsl-ssi.o snd-soc-fsl-dma.o
+obj-$(CONFIG_SND_SOC_FSL_SSI) += snd-soc-fsl-ssi.o
+obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o
 
 # MPC5200 Platform Support
 obj-$(CONFIG_SND_MPC52xx_DMA) += mpc5200_dma.o
-- 
1.7.5.4
