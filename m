From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: OMAP: Add support for OMAP2430 and
	OMAP34xx in McBSP DAI driver
Date: Fri, 10 Oct 2008 15:52:16 +0100
Message-ID: <1223650337-15371-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081010145127.GA15329@rakim.wolfsonmicro.main>
	<1223650337-15371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223650337-15371-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 575242476F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 16:52:36 +0200 (CEST)
In-Reply-To: <1223650337-15371-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Thanks to Arun KS <arunks@mistralsolutions.com> for fixing one typo in
original version of this patch.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-mcbsp.c |   95 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d32eb47..e97e6b2 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -84,11 +84,22 @@ static const unsigned long omap1_mcbsp_port[][2] = {
 static const int omap1_dma_reqs[][2] = {};
 static const unsigned long omap1_mcbsp_port[][2] = {};
 #endif
-#if defined(CONFIG_ARCH_OMAP2420)
-static const int omap2420_dma_reqs[][2] = {
+
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+static const int omap24xx_dma_reqs[][2] = {
 	{ OMAP24XX_DMA_MCBSP1_TX, OMAP24XX_DMA_MCBSP1_RX },
 	{ OMAP24XX_DMA_MCBSP2_TX, OMAP24XX_DMA_MCBSP2_RX },
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	{ OMAP24XX_DMA_MCBSP3_TX, OMAP24XX_DMA_MCBSP3_RX },
+	{ OMAP24XX_DMA_MCBSP4_TX, OMAP24XX_DMA_MCBSP4_RX },
+	{ OMAP24XX_DMA_MCBSP5_TX, OMAP24XX_DMA_MCBSP5_RX },
+#endif
 };
+#else
+static const int omap24xx_dma_reqs[][2] = {};
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2420)
 static const unsigned long omap2420_mcbsp_port[][2] = {
 	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
 	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
@@ -96,10 +107,43 @@ static const unsigned long omap2420_mcbsp_port[][2] = {
 	  OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1 },
 };
 #else
-static const int omap2420_dma_reqs[][2] = {};
 static const unsigned long omap2420_mcbsp_port[][2] = {};
 #endif
 
+#if defined(CONFIG_ARCH_OMAP2430)
+static const unsigned long omap2430_mcbsp_port[][2] = {
+	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP2430_MCBSP3_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP2430_MCBSP3_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP2430_MCBSP4_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP2430_MCBSP4_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP2430_MCBSP5_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP2430_MCBSP5_BASE + OMAP_MCBSP_REG_DRR },
+};
+#else
+static const unsigned long omap2430_mcbsp_port[][2] = {};
+#endif
+
+#if defined(CONFIG_ARCH_OMAP34XX)
+static const unsigned long omap34xx_mcbsp_port[][2] = {
+	{ OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP34XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP34XX_MCBSP3_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP3_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP34XX_MCBSP4_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP4_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP34XX_MCBSP5_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP5_BASE + OMAP_MCBSP_REG_DRR },
+};
+#else
+static const unsigned long omap34xx_mcbsp_port[][2] = {};
+#endif
+
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -167,12 +211,15 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		dma = omap1_dma_reqs[bus_id][substream->stream];
 		port = omap1_mcbsp_port[bus_id][substream->stream];
 	} else if (cpu_is_omap2420()) {
-		dma = omap2420_dma_reqs[bus_id][substream->stream];
+		dma = omap24xx_dma_reqs[bus_id][substream->stream];
 		port = omap2420_mcbsp_port[bus_id][substream->stream];
+	} else if (cpu_is_omap2430()) {
+		dma = omap24xx_dma_reqs[bus_id][substream->stream];
+		port = omap2430_mcbsp_port[bus_id][substream->stream];
+	} else if (cpu_is_omap343x()) {
+		dma = omap24xx_dma_reqs[bus_id][substream->stream];
+		port = omap34xx_mcbsp_port[bus_id][substream->stream];
 	} else {
-		/*
-		 * TODO: Add support for 2430 and 3430
-		 */
 		return -ENODEV;
 	}
 	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
@@ -315,7 +362,7 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 				       int clk_id)
 {
 	int sel_bit;
-	u16 reg;
+	u16 reg, reg_devconf1 = OMAP243X_CONTROL_DEVCONF1;
 
 	if (cpu_class_is_omap1()) {
 		/* OMAP1's can use only external source clock */
@@ -325,6 +372,12 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 			return 0;
 	}
 
+	if (cpu_is_omap2420() && mcbsp_data->bus_id > 1)
+		return -EINVAL;
+
+	if (cpu_is_omap343x())
+		reg_devconf1 = OMAP343X_CONTROL_DEVCONF1;
+
 	switch (mcbsp_data->bus_id) {
 	case 0:
 		reg = OMAP2_CONTROL_DEVCONF0;
@@ -334,20 +387,26 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 		reg = OMAP2_CONTROL_DEVCONF0;
 		sel_bit = 6;
 		break;
-	/* TODO: Support for ports 3 - 5 in OMAP2430 and OMAP34xx */
+	case 2:
+		reg = reg_devconf1;
+		sel_bit = 0;
+		break;
+	case 3:
+		reg = reg_devconf1;
+		sel_bit = 2;
+		break;
+	case 4:
+		reg = reg_devconf1;
+		sel_bit = 4;
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (cpu_class_is_omap2()) {
-		if (clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK) {
-			omap_ctrl_writel(omap_ctrl_readl(reg) &
-					 ~(1 << sel_bit), reg);
-		} else {
-			omap_ctrl_writel(omap_ctrl_readl(reg) |
-					 (1 << sel_bit), reg);
-		}
-	}
+	if (clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK)
+		omap_ctrl_writel(omap_ctrl_readl(reg) & ~(1 << sel_bit), reg);
+	else
+		omap_ctrl_writel(omap_ctrl_readl(reg) | (1 << sel_bit), reg);
 
 	return 0;
 }
-- 
1.5.6.5
