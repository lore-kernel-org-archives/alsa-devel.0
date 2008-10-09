From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][DON'T PUSH][PATCH 1/3] ASoC: OMAP: Add
	support for OMAP2430 and OMAP34xx in McBSP DAI driver
Date: Thu,  9 Oct 2008 15:57:20 +0300
Message-ID: <1223557042-17279-2-git-send-email-jarkko.nikula@nokia.com>
References: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 12FE724487
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 14:58:14 +0200 (CEST)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m99Cvqcg020884
	for <alsa-devel@alsa-project.org>; Thu, 9 Oct 2008 07:57:55 -0500
In-Reply-To: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Thanks to Arun KS <arunks@mistralsolutions.com> for fixing one typo in
original version of this patch.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   95 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index fb920e1..4ff73fc 100644
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
