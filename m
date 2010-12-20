From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH] ASoC: mcbsp: Add McBSP support for OMAP4
Date: Mon, 20 Dec 2010 11:32:47 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4F6D3A7@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EBCAC103969
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 18:32:49 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

This patch adds McBSP support for the OMAP4 CPU

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   38 +++++++++++++++++++++++++++++++++++---
 sound/soc/omap/omap-mcbsp.h |    4 ++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 7e84f24..69cb4d1 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -102,6 +102,17 @@ static const int omap24xx_dma_reqs[][2] = {
 static const int omap24xx_dma_reqs[][2] = {};
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4)
+static const int omap44xx_dma_reqs[][2] = {
+	{ OMAP44XX_DMA_MCBSP1_TX, OMAP44XX_DMA_MCBSP1_RX },
+	{ OMAP44XX_DMA_MCBSP2_TX, OMAP44XX_DMA_MCBSP2_RX },
+	{ OMAP44XX_DMA_MCBSP3_TX, OMAP44XX_DMA_MCBSP3_RX },
+	{ OMAP44XX_DMA_MCBSP4_TX, OMAP44XX_DMA_MCBSP4_RX },
+};
+#else
+static const int omap44xx_dma_reqs[][2] = {};
+#endif
+
 #if defined(CONFIG_ARCH_OMAP2420)
 static const unsigned long omap2420_mcbsp_port[][2] = {
 	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
@@ -147,6 +158,21 @@ static const unsigned long omap34xx_mcbsp_port[][2] = {
 static const unsigned long omap34xx_mcbsp_port[][2] = {};
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4)
+static const unsigned long omap44xx_mcbsp_port[][2] = {
+	{ OMAP44XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP44XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP44XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP44XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP44XX_MCBSP3_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP44XX_MCBSP3_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP44XX_MCBSP4_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP44XX_MCBSP4_BASE + OMAP_MCBSP_REG_DRR },
+};
+#else
+static const unsigned long omap44xx_mcbsp_port[][2] = {};
+#endif
+
 static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -224,7 +250,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 * 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
 	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
 	 */
-	if (cpu_is_omap343x()) {
+	if (cpu_is_omap343x() || cpu_is_omap44xx()) {
 		/*
 		* Rule for the buffer size. We should not allow
 		* smaller buffer than the FIFO size to avoid underruns
@@ -332,6 +358,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else if (cpu_is_omap343x()) {
 		dma = omap24xx_dma_reqs[bus_id][substream->stream];
 		port = omap34xx_mcbsp_port[bus_id][substream->stream];
+	 } else if (cpu_is_omap44xx()) {
+		dma = omap44xx_dma_reqs[bus_id][substream->stream];
+		port = omap44xx_mcbsp_port[bus_id][substream->stream];
 	} else {
 		return -ENODEV;
 	}
@@ -498,11 +527,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	regs->spcr2	|= XINTM(3) | FREE;
 	regs->spcr1	|= RINTM(3);
 	/* RFIG and XFIG are not defined in 34xx */
-	if (!cpu_is_omap34xx()) {
+	if (!cpu_is_omap34xx() && !cpu_is_omap44xx()) {
 		regs->rcr2	|= RFIG;
 		regs->xcr2	|= XFIG;
 	}
-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		regs->xccr = DXENDLY(1) | XDMAEN | XDISABLE;
 		regs->rccr = RFULL_CYCLE | RDMAEN | RDISABLE;
 	}
@@ -623,6 +652,9 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		if (cpu_class_is_omap1()) {
 			err = -EINVAL;
 			break;
+		} else if (cpu_is_omap44xx()) {
+			regs->srgr2     &= ~CLKSM;
+			break;
 		}
 		err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
 					       MCBSP_CLKS_PRCM_SRC);
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index ffdcc5a..110c106 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -50,6 +50,10 @@ enum omap_mcbsp_div {
 #undef  NUM_LINKS
 #define NUM_LINKS	3
 #endif
+#if defined(CONFIG_ARCH_OMAP4)
+#undef  NUM_LINKS
+#define NUM_LINKS	4
+#endif
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
 #undef  NUM_LINKS
 #define NUM_LINKS	5
-- 
1.7.0.4
