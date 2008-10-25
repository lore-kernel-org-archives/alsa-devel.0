From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: ASoC: pxa2xx-ssp
Date: Sat, 25 Oct 2008 03:32:47 -0200
Message-ID: <1224912767.5426.19.camel@brutus>
References: <1224809675.8330.4.camel@brutus>
	<1224863678.28382.54.camel@dell-desktop.example.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-gvkkfoavb/ikf6pCY4Nd"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.185])
	by alsa0.perex.cz (Postfix) with ESMTP id EDBF8243BC
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 07:33:13 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id j67so1071425rne.21
	for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2008 22:32:55 -0700 (PDT)
In-Reply-To: <1224863678.28382.54.camel@dell-desktop.example.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


--=-gvkkfoavb/ikf6pCY4Nd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Sex, 2008-10-24 =C3=A0s 16:54 +0100, Liam Girdwood escreveu:
> On Thu, 2008-10-23 at 22:54 -0200, Daniel Ribeiro wrote:
> > Hi!
> >=20
> > What is needed for [0] to be accepted on mainline linux?
> >=20
> > [0]http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.=
6-asoc.git;a=3Dblob;f=3Dsound/soc/pxa/pxa2xx-ssp.c;h=3D6b1baeece184e990c4=
254e2f43495013d4562c95;hb=3De4d89cdd854b4a40c963adf434d261070c67b6bb
> >=20
>=20
> When I last worked on this it was in need of updates for SSP register
> IO, clk API and more testing. It has the IO and clk stuff now.
>=20
> Does this code work well on your platform/board ?

	Not as it is.

	My sound codec needs 32bit ssp frames, even considering that it only
supports 16bit mono/stereo audio. I guess that it works with I2S
emulation mode, which pxa2xx-ssp.c dont support yet.

	After some time trying to understand the very poorly documented I2S/SSP
emulation on the pxa manual, i ended up with [1]. It works perfectly on
my board, with SND_SOC_DAIFMT_MSB.

	To ease your reading, attached is a diff against [0]. It is updated to
build on the latest linus tree and handles DAIFMT_I2S and DAIFMT_MSB
differently.

>=20
> If so, I guess we could scratch off the more testing part and consider
> it for the next merge window. Iirc it was also waiting on some pxa
> dependencies going upstream, so it may wait a little longer.
>=20
> I'm sure it's on Mark's long todo list....
>=20
> Liam=20
>=20

[1]http://git.openezx.org/?p=3Dopenezx.git;a=3Dblob;f=3Dsound/soc/pxa/pxa=
2xx-ssp.c;h=3Dcdbc15e243094fd232119b342c39be26c8ac4c7d;hb=3Dcacec205c17b9=
924db3ca625347a33d0ddd2b694

--=20
Daniel Ribeiro

--=-gvkkfoavb/ikf6pCY4Nd
Content-Disposition: attachment; filename=pxa2xx-ssp-i2s-ezx.patch
Content-Type: text/x-patch; name=pxa2xx-ssp-i2s-ezx.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /tmp/pxa2xx-ssp.c	2008-10-25 03:22:44.000000000 -0200
+++ pxa2xx-ssp.c	2008-10-24 20:19:29.000000000 -0200
@@ -28,12 +28,13 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/pxa2xx-lib.h>
 
-#include <asm/hardware.h>
-#include <asm/arch/pxa-regs.h>
-#include <asm/arch/regs-ssp.h>
-#include <asm/arch/audio.h>
-#include <asm/arch/ssp.h>
+#include <mach/hardware.h>
+#include <mach/pxa-regs.h>
+#include <mach/regs-ssp.h>
+#include <mach/audio.h>
+#include <mach/ssp.h>
 
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ssp.h"
@@ -58,7 +59,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_mono_out = {
 	.name			= "SSP1 PCM Mono out",
 	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMRTXSSDR,
+	.drcmr			= &DRCMR(14),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -66,7 +67,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_mono_in = {
 	.name			= "SSP1 PCM Mono in",
 	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMRRXSSDR,
+	.drcmr			= &DRCMR(13),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -74,7 +75,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_stereo_out = {
 	.name			= "SSP1 PCM Stereo out",
 	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMRTXSSDR,
+	.drcmr			= &DRCMR(14),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -82,7 +83,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp1_pcm_stereo_in = {
 	.name			= "SSP1 PCM Stereo in",
 	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMRRXSSDR,
+	.drcmr			= &DRCMR(13),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -90,7 +91,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_mono_out = {
 	.name			= "SSP2 PCM Mono out",
 	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS2DR,
+	.drcmr			= &DRCMR(16),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -98,7 +99,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_mono_in = {
 	.name			= "SSP2 PCM Mono in",
 	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS2DR,
+	.drcmr			= &DRCMR(15),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -106,7 +107,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_stereo_out = {
 	.name			= "SSP2 PCM Stereo out",
 	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS2DR,
+	.drcmr			= &DRCMR(16),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -114,7 +115,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp2_pcm_stereo_in = {
 	.name			= "SSP2 PCM Stereo in",
 	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS2DR,
+	.drcmr			= &DRCMR(15),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -122,7 +123,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_mono_out = {
 	.name			= "SSP3 PCM Mono out",
 	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS3DR,
+	.drcmr			= &DRCMR(67),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -130,7 +131,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_mono_in = {
 	.name			= "SSP3 PCM Mono in",
 	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS3DR,
+	.drcmr			= &DRCMR(66),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -138,7 +139,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_stereo_out = {
 	.name			= "SSP3 PCM Stereo out",
 	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMRTXSS3DR,
+	.drcmr			= &DRCMR(67),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -146,7 +147,7 @@
 static struct pxa2xx_pcm_dma_params pxa2xx_ssp3_pcm_stereo_in = {
 	.name			= "SSP3 PCM Stereo in",
 	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMRRXSS3DR,
+	.drcmr			= &DRCMR(66),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH4,
 };
@@ -163,7 +164,7 @@
 static int pxa2xx_ssp_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret = 0;
 
 	if (!rtd->dai->cpu_dai->active) {
@@ -179,7 +180,7 @@
 static void pxa2xx_ssp_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (!cpu_dai->active) {
 		ssp_disable(&ssp[cpu_dai->id]);
@@ -190,7 +191,7 @@
 #ifdef CONFIG_PM
 
 static int pxa2xx_ssp_suspend(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
+	struct snd_soc_dai *dai)
 {
 	if (!dai->active)
 		return 0;
@@ -201,7 +202,7 @@
 }
 
 static int pxa2xx_ssp_resume(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
+	struct snd_soc_dai *dai)
 {
 	if (!dai->active)
 		return 0;
@@ -233,7 +234,7 @@
 /*
  * Set the SSP ports SYSCLK.
  */
-static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+static int pxa2xx_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	int clk_id, unsigned int freq, int dir)
 {
 	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
@@ -283,7 +284,7 @@
 /*
  * Set the SSP clock dividers.
  */
-static int pxa2xx_ssp_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
+static int pxa2xx_ssp_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	int div_id, int div)
 {
 	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
@@ -313,7 +314,7 @@
 /*
  * Configure the PLL frequency pxa27x and (afaik - pxa320 only)
  */
-static int pxa2xx_ssp_set_dai_pll(struct snd_soc_cpu_dai *cpu_dai,
+static int pxa2xx_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
 	int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
 	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
@@ -346,7 +347,7 @@
 /*
  * Set the active slots in TDM/Network mode
  */
-static int pxa2xx_ssp_set_dai_tdm_slot(struct snd_soc_cpu_dai *cpu_dai,
+static int pxa2xx_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	unsigned int mask, int slots)
 {
 	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
@@ -367,7 +368,7 @@
 /*
  * Tristate the SSP DAI lines
  */
-static int pxa2xx_ssp_set_dai_tristate(struct snd_soc_cpu_dai *cpu_dai,
+static int pxa2xx_ssp_set_dai_tristate(struct snd_soc_dai *cpu_dai,
 	int tristate)
 {
 	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
@@ -388,53 +389,23 @@
  * The SSP Port must be inactive before calling this function as the
  * physical interface format is changed.
  */
-static int pxa2xx_ssp_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+static int pxa2xx_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
 	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
-	int val;
+	int val, tmp;
 
 	/* reset port settings */
 	__raw_writel(0, mmio_base + SSCR0);
 	__raw_writel(0, mmio_base + SSCR1);
 	__raw_writel(0, mmio_base + SSPSP);
 
-	/* NOTE: I2S emulation is still very much work in progress here */
-
-	/* FIXME: this is what wince uses for msb */
-	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_MSB) {
-		__raw_writel(SSCR0_EDSS | SSCR0_TISSP | SSCR0_DataSize(16),
-				mmio_base + SSCR0);
-		goto master;
-	}
-
-	/* check for I2S emulation mode - handle it separately  */
-	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S) {
-		/* 8.4.11 */
-
-		/* Only SSCR0[NCS] or SSCR0[ECS] bit fields settings are optional */
-		__raw_writel(SSCR0_EDSS | SSCR0_PSP | SSCR0_DataSize(16),
-				mmio_base + SSCR0);
-
-		/* set FIFO thresholds */
-		__raw_writel(SSCR1_RxTresh(14) | SSCR1_TxTresh(1),
-				mmio_base + SSCR1);
-
-		/* normal: */
-		/* all bit fields must be cleared except: FSRT = 1 and
-		 * SFRMWDTH = 16, DMYSTART=0,1) */
-		__raw_writel(SSPSP_FSRT | SSPSP_SFRMWDTH(16) | SSPSP_DMYSTRT(0),
-				mmio_base + SSPSP);
-		goto master;
-	}
-
 	val = __raw_readl(mmio_base + SSCR0) | SSCR0_PSP;
 	__raw_writel(val, mmio_base + SSCR0);
 	__raw_writel(SSCR1_RxTresh(14) | SSCR1_TxTresh(1) |
 			SSCR1_TRAIL | SSCR1_RWOT,
 			mmio_base + SSCR1);
 
-master:
 	val = __raw_readl(mmio_base + SSCR1);
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -465,15 +436,20 @@
 	}
 
 	val = __raw_readl(mmio_base + SSPSP);
+	val |= SSPSP_SCMODE(2);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
 		val |= SSPSP_DMYSTRT(1);
 	case SND_SOC_DAIFMT_DSP_B:
-		val |= SSPSP_SCMODE(2);
 		break;
 	case SND_SOC_DAIFMT_I2S:
+		val |= SSPSP_FSRT;
 	case SND_SOC_DAIFMT_MSB:
-		/* handled above */
+		val |= SSPSP_SFRMWDTH(16);
+
+		tmp = __raw_readl(mmio_base + SSCR0) | SSCR0_EDSS |
+			SSCR0_DataSize(16);
+		__raw_writel(tmp, mmio_base + SSCR0);
 		break;
 	default:
 		return -EINVAL;
@@ -491,7 +467,7 @@
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int dma = 0, chn = params_channels(params);
 	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
 	u32 sscr0;
@@ -505,12 +481,20 @@
 
 	pr_debug("pxa2xx_ssp_hw_params: dma %d", dma);
 
+	sscr0 = __raw_readl(mmio_base + SSCR0);
+
 	/* we can only change the settings if the port is not in use */
-	if (__raw_readl(mmio_base + SSCR0) & SSCR0_SSE)
-		return 0;
+	if (sscr0 & SSCR0_SSE)
+		goto ret;
+
+	/* check if we are running on I2S mode */
+	/* FIXME: Is there a better way to check this? */
+	if ((sscr0 & (SSCR0_EDSS | SSCR0_DataSize(16) | SSCR0_PSP)) ==
+			(SSCR0_EDSS | SSCR0_DataSize(16) | SSCR0_PSP))
+		goto ret;
 
 	/* clear selected SSP bits */
-	sscr0 = __raw_readl(mmio_base + SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
+	sscr0 &= ~(SSCR0_DSS | SSCR0_EDSS);
 	__raw_writel(sscr0, mmio_base + SSCR0);
 
 	/* bit size */
@@ -530,6 +514,7 @@
 	}
 	__raw_writel(sscr0, mmio_base + SSCR0);
 
+ret:
 	pr_debug("SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x SSPSP 0x%08x SSSR 0x%08x SSACD 0x%08x",
 		__raw_readl(mmio_base + SSCR0), __raw_readl(mmio_base + SSCR1),
 		__raw_readl(mmio_base + SSTO), __raw_readl(mmio_base + SSPSP),
@@ -541,7 +526,7 @@
 static int pxa2xx_ssp_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret = 0;
 	void __iomem *mmio_base = ssp[cpu_dai->id].ssp->mmio_base;
 	int val;
@@ -609,7 +594,7 @@
 #define PXA2XX_SSP_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-struct snd_soc_cpu_dai pxa_ssp_dai[] = {
+struct snd_soc_dai pxa_ssp_dai[] = {
 	{	.name = "pxa2xx-ssp1",
 		.id = 0,
 		.type = SND_SOC_DAI_PCM,

--=-gvkkfoavb/ikf6pCY4Nd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-gvkkfoavb/ikf6pCY4Nd--
