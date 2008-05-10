From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH,
	RFC] ASoC: update pxa2xx-ssp to work with current mainline
Date: Sat, 10 May 2008 14:50:13 +0200
Message-ID: <1210423813.3876.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A8AF243D4
	for <alsa-devel@alsa-project.org>;
	Sat, 10 May 2008 14:50:20 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1212139fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 10 May 2008 05:50:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch against the ASoC dev branch updates pxa2xx-ssp to work with
current mainline. I only made minimal changes to clock/register access
and some dbg->pr_debug cleanup, I guess the DMA setup should be reworked
properly, but I'm not familiar enough with that.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa2xx-ssp.c |  266 +++++++++++++++++++++++++-------------------
 1 files changed, 151 insertions(+), 115 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ssp.c b/sound/soc/pxa/pxa2xx-ssp.c
index 25118cc..6b1baee 100644
--- a/sound/soc/pxa/pxa2xx-ssp.c
+++ b/sound/soc/pxa/pxa2xx-ssp.c
@@ -20,8 +20,9 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
 
-#include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
@@ -30,21 +31,13 @@
 
 #include <asm/hardware.h>
 #include <asm/arch/pxa-regs.h>
+#include <asm/arch/regs-ssp.h>
 #include <asm/arch/audio.h>
 #include <asm/arch/ssp.h>
 
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ssp.h"
 
-#define PXA_SSP_DEBUG 0
-
-#if PXA_SSP_DEBUG
-#define dbg(format, arg...) \
-	printk(KERN_DEBUG format "\n" , ## arg)
-#else
-#define dbg(format, arg...) do {} while (0)
-#endif
-
 /*
  * SSP audio private data
  */
@@ -58,9 +51,13 @@ static struct ssp_dev ssp[3];
 static struct ssp_state ssp_state[3];
 #endif
 
+#define PXA2xx_SSP1_BASE	0x41000000
+#define PXA27x_SSP2_BASE	0x41700000
+#define PXA27x_SSP3_BASE	0x41900000
+
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_mono_out = {
 	.name			= "SSP1 PCM Mono out",
-	.dev_addr		= __PREG(SSDR_P1),
+	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
 	.drcmr			= &DRCMRTXSSDR,
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
@@ -68,7 +65,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_mono_out = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_mono_in = {
 	.name			= "SSP1 PCM Mono in",
-	.dev_addr		= __PREG(SSDR_P1),
+	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
 	.drcmr			= &DRCMRRXSSDR,
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
@@ -76,7 +73,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_mono_in = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_stereo_out = {
 	.name			= "SSP1 PCM Stereo out",
-	.dev_addr		= __PREG(SSDR_P1),
+	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
 	.drcmr			= &DRCMRTXSSDR,
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
@@ -84,7 +81,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_stereo_out = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_stereo_in = {
 	.name			= "SSP1 PCM Stereo in",
-	.dev_addr		= __PREG(SSDR_P1),
+	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
 	.drcmr			= &DRCMRRXSSDR,
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
@@ -92,7 +89,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_stereo_in = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_mono_out = {
 	.name			= "SSP2 PCM Mono out",
-	.dev_addr		= __PREG(SSDR_P2),
+	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
 	.drcmr			= &DRCMRTXSS2DR,
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
@@ -100,7 +97,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_mono_out = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_mono_in = {
 	.name			= "SSP2 PCM Mono in",
-	.dev_addr		= __PREG(SSDR_P2),
+	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
 	.drcmr			= &DRCMRRXSS2DR,
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
@@ -108,7 +105,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_mono_in = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_stereo_out = {
 	.name			= "SSP2 PCM Stereo out",
-	.dev_addr		= __PREG(SSDR_P2),
+	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
 	.drcmr			= &DRCMRTXSS2DR,
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
@@ -116,7 +113,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_stereo_out = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_stereo_in = {
 	.name			= "SSP2 PCM Stereo in",
-	.dev_addr		= __PREG(SSDR_P2),
+	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
 	.drcmr			= &DRCMRRXSS2DR,
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
@@ -124,7 +121,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_stereo_in = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_mono_out = {
 	.name			= "SSP3 PCM Mono out",
-	.dev_addr		= __PREG(SSDR_P3),
+	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
 	.drcmr			= &DRCMRTXSS3DR,
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
@@ -132,7 +129,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_mono_out = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_mono_in = {
 	.name			= "SSP3 PCM Mono in",
-	.dev_addr		= __PREG(SSDR_P3),
+	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
 	.drcmr			= &DRCMRRXSS3DR,
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
@@ -140,7 +137,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_mono_in = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_stereo_out = {
 	.name			= "SSP3 PCM Stereo out",
-	.dev_addr		= __PREG(SSDR_P3),
+	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
 	.drcmr			= &DRCMRTXSS3DR,
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
@@ -148,7 +145,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_stereo_out = {
 
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_stereo_in = {
 	.name			= "SSP3 PCM Stereo in",
-	.dev_addr		= __PREG(SSDR_P3),
+	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
 	.drcmr			= &DRCMRRXSS3DR,
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
@@ -156,11 +153,11 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_stereo_in = {
 
 static struct pxa2xx_pcm_dma_params *ssp_dma_params[3][4] = {
 	{&pxa2xx_ssp1_pcm_mono_out, &pxa2xx_ssp1_pcm_mono_in,
-	&pxa2xx_ssp1_pcm_stereo_out,&pxa2xx_ssp1_pcm_stereo_in,},
+	&pxa2xx_ssp1_pcm_stereo_out, &pxa2xx_ssp1_pcm_stereo_in,},
 	{&pxa2xx_ssp2_pcm_mono_out, &pxa2xx_ssp2_pcm_mono_in,
 	&pxa2xx_ssp2_pcm_stereo_out, &pxa2xx_ssp2_pcm_stereo_in,},
 	{&pxa2xx_ssp3_pcm_mono_out, &pxa2xx_ssp3_pcm_mono_in,
-	&pxa2xx_ssp3_pcm_stereo_out,&pxa2xx_ssp3_pcm_stereo_in,},
+	&pxa2xx_ssp3_pcm_stereo_out, &pxa2xx_ssp3_pcm_stereo_in,},
 };
 
 static int pxa2xx_ssp_startup(struct snd_pcm_substream *substream)
@@ -170,7 +167,7 @@ static int pxa2xx_ssp_startup(struct snd_pcm_substream *substream)
 	int ret = 0;
 
 	if (!rtd->dai->cpu_dai->active) {
-		ret = ssp_init (&ssp[cpu_dai->id], cpu_dai->id + 1,
+		ret = ssp_init(&ssp[cpu_dai->id], cpu_dai->id + 1,
 			SSP_NO_IRQ);
 		if (ret < 0)
 			return ret;
@@ -190,12 +187,6 @@ static void pxa2xx_ssp_shutdown(struct snd_pcm_substream *substream)
 	}
 }
 
-#if defined (CONFIG_PXA27x)
-static int cken[3] = {CKEN_SSP1, CKEN_SSP2, CKEN_SSP3};
-#else
-static int cken[3] = {CKEN_SSP, CKEN_NSSP, CKEN_ASSP};
-#endif
-
 #ifdef CONFIG_PM
 
 static int pxa2xx_ssp_suspend(struct platform_device *pdev,
@@ -205,7 +196,7 @@ static int pxa2xx_ssp_suspend(struct platform_device *pdev,
 		return 0;
 
 	ssp_save_state(&ssp[dai->id], &ssp_state[dai->id]);
-	pxa_set_cken(cken[dai->id], 0);
+	clk_disable(ssp[dai->id].ssp->clk);
 	return 0;
 }
 
@@ -215,7 +206,7 @@ static int pxa2xx_ssp_resume(struct platform_device *pdev,
 	if (!dai->active)
 		return 0;
 
-	pxa_set_cken(cken[dai->id], 1);
+	clk_enable(ssp[dai->id].ssp->clk);
 	ssp_restore_state(&ssp[dai->id], &ssp_state[dai->id]);
 	ssp_enable(&ssp[dai->id]);
 
@@ -227,17 +218,31 @@ static int pxa2xx_ssp_resume(struct platform_device *pdev,
 #define pxa2xx_ssp_resume	NULL
 #endif
 
+/**
+ * ssp_set_clkdiv - set SSP clock divider
+ * @div: serial clock rate divider
+ */
+void ssp_set_scr(struct ssp_dev *dev, u32 div)
+{
+	struct ssp_device *ssp = dev->ssp;
+	u32 sscr0 = __raw_readl(ssp->mmio_base + SSCR0) & ~SSCR0_SCR;
+
+	__raw_writel(sscr0 | SSCR0_SerClkDiv(div), ssp->mmio_base + SSCR0);
+}
+
 /*
  * Set the SSP ports SYSCLK.
  */
 static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 	int clk_id, unsigned int freq, int dir)
 {
-	int port = cpu_dai->id + 1;
-	u32 sscr0 = SSCR0_P(port) &
+	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
+	int val;
+
+	u32 sscr0 = __raw_readl(mmio_base + SSCR0) &
 		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ADC);
 
-	dbg("pxa2xx_ssp_set_dai_sysclk id: %d, clk_id %d, freq %d",
+	pr_debug("pxa2xx_ssp_set_dai_sysclk id: %d, clk_id %d, freq %d",
 		cpu_dai->id, clk_id, freq);
 
 	switch (clk_id) {
@@ -245,11 +250,10 @@ static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 		sscr0 |= SSCR0_MOD;
 	case PXA2XX_SSP_CLK_PLL:
 		/* Internal PLL is fixed on pxa25x and pxa27x */
-#ifdef CONFIG_PXA27x
-		ssp_clk[cpu_dai->id].sysclk = 13000000;
-#else
-		ssp_clk[cpu_dai->id].sysclk = 1843200;
-#endif
+		if (cpu_is_pxa25x())
+			ssp_clk[cpu_dai->id].sysclk = 1843200;
+		else
+			ssp_clk[cpu_dai->id].sysclk = 13000000;
 		break;
 	case PXA2XX_SSP_CLK_EXT:
 		ssp_clk[cpu_dai->id].sysclk = freq;
@@ -261,7 +265,7 @@ static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 		break;
 	case PXA2XX_SSP_CLK_AUDIO:
 		ssp_clk[cpu_dai->id].sysclk = 0;
-		SSCR0_P(port) |= SSCR0_SerClkDiv(1);
+		ssp_set_scr(&ssp[cpu_dai->id], 1);
 		sscr0 |= SSCR0_ADC;
 		break;
 	default:
@@ -269,9 +273,10 @@ static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 	}
 
 	/* the SSP CKEN clock must be disabled when changing SSP clock mode */
-	pxa_set_cken(cken[cpu_dai->id], 0);
-	SSCR0_P(port) |= sscr0;
-	pxa_set_cken(cken[cpu_dai->id], 1);
+	clk_disable(ssp[cpu_dai->id].ssp->clk);
+	val = __raw_readl(mmio_base + SSCR0) | sscr0;
+	__raw_writel(val, mmio_base + SSCR0);
+	clk_enable(ssp[cpu_dai->id].ssp->clk);
 	return 0;
 }
 
@@ -281,21 +286,22 @@ static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 static int pxa2xx_ssp_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
 	int div_id, int div)
 {
-	int port = cpu_dai->id + 1;
+	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
+	int val;
 
 	switch (div_id) {
 	case PXA2XX_SSP_AUDIO_DIV_ACDS:
-		SSACD_P(port) &= ~ 0x7;
-		SSACD_P(port) |= SSACD_ACDS(div);
+		val = (__raw_readl(mmio_base + SSACD) & ~0x7) | SSACD_ACDS(div);
+		__raw_writel(val, mmio_base + SSACD);
 		break;
 	case PXA2XX_SSP_AUDIO_DIV_SCDB:
-		SSACD_P(port) &= ~0x8;
+		val = __raw_readl(mmio_base + SSACD) & ~0x8;
 		if (div == PXA2XX_SSP_CLK_SCDB_1)
-			SSACD_P(port) |= SSACD_SCDB;
+			val |= SSACD_SCDB;
+		__raw_writel(val, mmio_base + SSACD);
 		break;
 	case PXA2XX_SSP_DIV_SCR:
-		SSCR0_P(port) &= ~SSCR0_SCR;
-		SSCR0_P(port) |= SSCR0_SerClkDiv(div);
+		ssp_set_scr(&ssp[cpu_dai->id], div);
 		break;
 	default:
 		return -ENODEV;
@@ -310,28 +316,30 @@ static int pxa2xx_ssp_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
 static int pxa2xx_ssp_set_dai_pll(struct snd_soc_cpu_dai *cpu_dai,
 	int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
-	int port = cpu_dai->id + 1;
+	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
+	u32 ssacd;
 
-	SSACD_P(port) &= ~0x70;
+	ssacd = __raw_readl(mmio_base + SSACD) & ~0x70;
 	switch (freq_out) {
 	case 5622000:
 		break;
 	case 11345000:
-		SSACD_P(port) |= (0x1 << 4);
+		ssacd |= (0x1 << 4);
 		break;
 	case 12235000:
-		SSACD_P(port) |= (0x2 << 4);
+		ssacd |= (0x2 << 4);
 		break;
 	case 14857000:
-		SSACD_P(port) |= (0x3 << 4);
+		ssacd |= (0x3 << 4);
 		break;
 	case 32842000:
-		SSACD_P(port) |= (0x4 << 4);
+		ssacd |= (0x4 << 4);
 		break;
 	case 48000000:
-		SSACD_P(port) |= (0x5 << 4);
+		ssacd |= (0x5 << 4);
 		break;
 	}
+	__raw_writel(ssacd, mmio_base + SSACD);
 	return 0;
 }
 
@@ -341,16 +349,18 @@ static int pxa2xx_ssp_set_dai_pll(struct snd_soc_cpu_dai *cpu_dai,
 static int pxa2xx_ssp_set_dai_tdm_slot(struct snd_soc_cpu_dai *cpu_dai,
 	unsigned int mask, int slots)
 {
-	int port = cpu_dai->id + 1;
+	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
+	u32 sscr0;
 
-	SSCR0_P(port) &= ~SSCR0_SlotsPerFrm(7);
+	sscr0 = __raw_readl(mmio_base + SSCR0) & ~SSCR0_SlotsPerFrm(7);
 
 	/* set number of active slots */
-	SSCR0_P(port) |= SSCR0_SlotsPerFrm(slots);
+	sscr0 |= SSCR0_SlotsPerFrm(slots);
+	__raw_writel(sscr0, mmio_base + SSCR0);
 
 	/* set active slot mask */
-	SSTSA_P(port) = mask;
-	SSRSA_P(port) = mask;
+	__raw_writel(mask, mmio_base + SSTSA);
+	__raw_writel(mask, mmio_base + SSRSA);
 	return 0;
 }
 
@@ -360,12 +370,15 @@ static int pxa2xx_ssp_set_dai_tdm_slot(struct snd_soc_cpu_dai *cpu_dai,
 static int pxa2xx_ssp_set_dai_tristate(struct snd_soc_cpu_dai *cpu_dai,
 	int tristate)
 {
-	int port = cpu_dai->id + 1;
+	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
+	u32 sscr1;
 
+	sscr1 = __raw_readl(mmio_base + SSCR1);
 	if (tristate)
-		SSCR1_P(port) &= ~SSCR1_TTE;
+		sscr1 &= ~SSCR1_TTE;
 	else
-		SSCR1_P(port) |= SSCR1_TTE;
+		sscr1 |= SSCR1_TTE;
+	__raw_writel(sscr1, mmio_base + SSCR1);
 
 	return 0;
 }
@@ -378,22 +391,20 @@ static int pxa2xx_ssp_set_dai_tristate(struct snd_soc_cpu_dai *cpu_dai,
 static int pxa2xx_ssp_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
 		unsigned int fmt)
 {
-	int port = cpu_dai->id + 1;
-
-	/* we can only change the settings if the port is not in use */
-	if (SSCR0_P(port) & SSCR0_SSE)
-		return 0;
+	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
+	int val;
 
 	/* reset port settings */
-	SSCR0_P(port) = 0;
-	SSCR1_P(port) = 0;
-	SSPSP_P(port) = 0;
+	__raw_writel(0, mmio_base + SSCR0);
+	__raw_writel(0, mmio_base + SSCR1);
+	__raw_writel(0, mmio_base + SSPSP);
 
 	/* NOTE: I2S emulation is still very much work in progress here */
 
 	/* FIXME: this is what wince uses for msb */
 	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_MSB) {
-		SSCR0_P(port) = SSCR0_EDSS | SSCR0_TISSP | SSCR0_DataSize(16);
+		__raw_writel(SSCR0_EDSS | SSCR0_TISSP | SSCR0_DataSize(16),
+				mmio_base + SSCR0);
 		goto master;
 	}
 
@@ -402,42 +413,50 @@ static int pxa2xx_ssp_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
 		/* 8.4.11 */
 
 		/* Only SSCR0[NCS] or SSCR0[ECS] bit fields settings are optional */
-		SSCR0_P(port) = SSCR0_EDSS | SSCR0_PSP | SSCR0_DataSize(16);
+		__raw_writel(SSCR0_EDSS | SSCR0_PSP | SSCR0_DataSize(16),
+				mmio_base + SSCR0);
 
 		/* set FIFO thresholds */
-		SSCR1_P(port) = SSCR1_RxTresh(14) | SSCR1_TxTresh(1);
+		__raw_writel(SSCR1_RxTresh(14) | SSCR1_TxTresh(1),
+				mmio_base + SSCR1);
 
 		/* normal: */
 		/* all bit fields must be cleared except: FSRT = 1 and
 		 * SFRMWDTH = 16, DMYSTART=0,1) */
-		SSPSP_P(port) = SSPSP_FSRT | SSPSP_SFRMWDTH(16) | SSPSP_DMYSTRT(0);
+		__raw_writel(SSPSP_FSRT | SSPSP_SFRMWDTH(16) | SSPSP_DMYSTRT(0),
+				mmio_base + SSPSP);
 		goto master;
 	}
 
-	SSCR0_P(port) |= SSCR0_PSP;
-	SSCR1_P(port) = SSCR1_RxTresh(14) | SSCR1_TxTresh(1) |
-		SSCR1_TRAIL | SSCR1_RWOT;
+	val = __raw_readl(mmio_base + SSCR0) | SSCR0_PSP;
+	__raw_writel(val, mmio_base + SSCR0);
+	__raw_writel(SSCR1_RxTresh(14) | SSCR1_TxTresh(1) |
+			SSCR1_TRAIL | SSCR1_RWOT,
+			mmio_base + SSCR1);
 
 master:
-	switch(fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	val = __raw_readl(mmio_base + SSCR1);
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		SSCR1_P(port) |= (SSCR1_SCLKDIR | SSCR1_SFRMDIR);
+		val |= (SSCR1_SCLKDIR | SSCR1_SFRMDIR);
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
-		SSCR1_P(port) |= SSCR1_SCLKDIR;
+		val |= SSCR1_SCLKDIR;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
-		SSCR1_P(port) |= SSCR1_SFRMDIR;
+		val |= SSCR1_SFRMDIR;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
 	default:
 		return -EINVAL;
 	}
+	__raw_writel(val, mmio_base + SSCR1);
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
-		SSPSP_P(port) |= SSPSP_SFRMP | SSPSP_FSRT;
+		val = __raw_readl(mmio_base + SSPSP) | SSPSP_SFRMP | SSPSP_FSRT;
+		__raw_writel(val, mmio_base + SSPSP);
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		break;
@@ -445,11 +464,12 @@ master:
 		return -EINVAL;
 	}
 
+	val = __raw_readl(mmio_base + SSPSP);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
-		SSPSP_P(port) |= SSPSP_DMYSTRT(1);
+		val |= SSPSP_DMYSTRT(1);
 	case SND_SOC_DAIFMT_DSP_B:
-		SSPSP_P(port) |= SSPSP_SCMODE(2);
+		val |= SSPSP_SCMODE(2);
 		break;
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_MSB:
@@ -458,6 +478,7 @@ master:
 	default:
 		return -EINVAL;
 	}
+	__raw_writel(val, mmio_base + SSPSP);
 
 	return 0;
 }
@@ -472,7 +493,8 @@ static int pxa2xx_ssp_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
 	int dma = 0, chn = params_channels(params);
-	int port = cpu_dai->id + 1;
+	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
+	u32 sscr0;
 
 	/* select correct DMA params */
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
@@ -481,34 +503,37 @@ static int pxa2xx_ssp_hw_params(struct snd_pcm_substream *substream,
 		dma += 2; /* stereo DMA offset is 2, mono is 0 */
 	cpu_dai->dma_data = ssp_dma_params[cpu_dai->id][dma];
 
-	dbg("pxa2xx_ssp_hw_params: dma %d", dma);
+	pr_debug("pxa2xx_ssp_hw_params: dma %d", dma);
 
 	/* we can only change the settings if the port is not in use */
-	if (SSCR0_P(port) & SSCR0_SSE)
+	if (__raw_readl(mmio_base + SSCR0) & SSCR0_SSE)
 		return 0;
 
 	/* clear selected SSP bits */
-	SSCR0_P(port) &= ~(SSCR0_DSS | SSCR0_EDSS);
+	sscr0 = __raw_readl(mmio_base + SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
+	__raw_writel(sscr0, mmio_base + SSCR0);
 
 	/* bit size */
-	switch(params_format(params)) {
+	sscr0 = __raw_readl(mmio_base + SSCR0);
+	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		SSCR0_P(port) |= SSCR0_DataSize(16);
+		sscr0 |= SSCR0_DataSize(16);
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		SSCR0_P(port) |=(SSCR0_EDSS | SSCR0_DataSize(8));
+		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(8));
 		/* we must be in network mode (2 slots) for 24 bit stereo */
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		SSCR0_P(port) |= (SSCR0_EDSS | SSCR0_DataSize(16));
+		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
 		/* we must be in network mode (2 slots) for 32 bit stereo */
 		break;
 	}
+	__raw_writel(sscr0, mmio_base + SSCR0);
 
-	dbg("SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x SSPSP 0x%08x SSSR 0x%08x SSACD 0x%08x",
-		SSCR0_P(port), SSCR1_P(port),
-		SSTO_P(port), SSPSP_P(port),
-		SSSR_P(port), SSACD_P(port));
+	pr_debug("SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x SSPSP 0x%08x SSSR 0x%08x SSACD 0x%08x",
+		__raw_readl(mmio_base + SSCR0), __raw_readl(mmio_base + SSCR1),
+		__raw_readl(mmio_base + SSTO), __raw_readl(mmio_base + SSPSP),
+		__raw_readl(mmio_base + SSSR), __raw_readl(mmio_base + SSACD));
 
 	return 0;
 }
@@ -518,50 +543,61 @@ static int pxa2xx_ssp_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret = 0;
-	int port = cpu_dai->id + 1;
+	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
+	int val;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 		ssp_enable(&ssp[cpu_dai->id]);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		val = __raw_readl(mmio_base + SSCR1);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			SSCR1_P(port) |= SSCR1_TSRE;
+			val |= SSCR1_TSRE;
 		else
-			SSCR1_P(port) |= SSCR1_RSRE;
-		SSSR_P(port) |= SSSR_P(port);
+			val |= SSCR1_RSRE;
+		__raw_writel(val, mmio_base + SSCR1);
+		/* SSSR_P(port) |= SSSR_P(port); */
+		val = __raw_readl(mmio_base + SSSR);
+		__raw_writel(val, mmio_base + SSSR);
 		break;
 	case SNDRV_PCM_TRIGGER_START:
+		val = __raw_readl(mmio_base + SSCR1);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			SSCR1_P(port) |= SSCR1_TSRE;
+			val |= SSCR1_TSRE;
 		else
-			SSCR1_P(port) |= SSCR1_RSRE;
+			val |= SSCR1_RSRE;
+		__raw_writel(val, mmio_base + SSCR1);
 		ssp_enable(&ssp[cpu_dai->id]);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
+		val = __raw_readl(mmio_base + SSCR1);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			SSCR1_P(port) &= ~SSCR1_TSRE;
+			val &= ~SSCR1_TSRE;
 		else
-			SSCR1_P(port) &= ~SSCR1_RSRE;
+			val &= ~SSCR1_RSRE;
+		__raw_writel(val, mmio_base + SSCR1);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		ssp_disable(&ssp[cpu_dai->id]);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		val = __raw_readl(mmio_base + SSCR1);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			SSCR1_P(port) &= ~SSCR1_TSRE;
+			val &= ~SSCR1_TSRE;
 		else
-			SSCR1_P(port) &= ~SSCR1_RSRE;
+			val &= ~SSCR1_RSRE;
+		__raw_writel(val, mmio_base + SSCR1);
 		break;
 
 	default:
 		ret = -EINVAL;
 	}
 
-	dbg("SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x SSPSP 0x%08x SSSR 0x%08x",
-		SSCR0_P(port), SSCR1_P(port),
-		SSTO_P(port), SSPSP_P(port),
-		SSSR_P(port));
+	pr_debug("SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x SSPSP 0x%08x SSSR 0x%08x",
+		__raw_readl(mmio_base + SSCR0), __raw_readl(mmio_base + SSCR1),
+		__raw_readl(mmio_base + SSTO), __raw_readl(mmio_base + SSPSP),
+		__raw_readl(mmio_base + SSSR));
 
 	return ret;
 }
-- 
1.5.5.1
