From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa-ssp: remove .set_pll() and
	.set_clkdiv() callbacks" to the asoc tree
Date: Mon, 02 Jul 2018 11:09:45 +0100
Message-ID: <E1fZvmD-0006O4-Do@debutante>
References: <20180629125940.27359-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 47C8B2677E4
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:13 +0200 (CEST)
In-Reply-To: <20180629125940.27359-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com, broonie@kernel.org, philipp.zabel@gmail.com, robert.jarzmik@free.fr
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa-ssp: remove .set_pll() and .set_clkdiv() callbacks

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 05739375f1c0a1048fea8b9c4cb54d9e4a891938 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Fri, 29 Jun 2018 14:59:40 +0200
Subject: [PATCH] ASoC: pxa-ssp: remove .set_pll() and .set_clkdiv() callbacks

The .set_pll() and .set_clkdiv() callbacks are considered legacy and should
not be used anymore. In order to support PXA boards on DT platforms, remove
them and let the code figure out the correct dividers and PLL base
frequencies itself.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/pxa2xx_ssp.h |   8 ++
 sound/soc/pxa/pxa-ssp.c    | 146 ++++++++++++++++++-------------------
 2 files changed, 81 insertions(+), 73 deletions(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 03a7ca46735b..13b4244d44c1 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -171,6 +171,14 @@
 #define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
 #define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
 #define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
+#define SSACD_ACDS_1		(0)
+#define SSACD_ACDS_2		(1)
+#define SSACD_ACDS_4		(2)
+#define SSACD_ACDS_8		(3)
+#define SSACD_ACDS_16		(4)
+#define SSACD_ACDS_32		(5)
+#define SSACD_SCDB_4X		(0)
+#define SSACD_SCDB_1X		(1)
 #define SSACD_SCDX8		(1 << 7)	/* SYSCLK division ratio select */
 
 /* LPSS SSP */
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 01d54697ede4..f8339bb01251 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -41,6 +41,7 @@
  */
 struct ssp_priv {
 	struct ssp_device *ssp;
+	unsigned long ssp_clk;
 	unsigned int sysclk;
 	unsigned int dai_fmt;
 	unsigned int configured_dai_fmt;
@@ -192,21 +193,6 @@ static void pxa_ssp_set_scr(struct ssp_device *ssp, u32 div)
 	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
 }
 
-/**
- * pxa_ssp_get_clkdiv - get SSP clock divider
- */
-static u32 pxa_ssp_get_scr(struct ssp_device *ssp)
-{
-	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
-	u32 div;
-
-	if (ssp->type == PXA25x_SSP)
-		div = ((sscr0 >> 8) & 0xff) * 2 + 2;
-	else
-		div = ((sscr0 >> 8) & 0xfff) + 1;
-	return div;
-}
-
 /*
  * Set the SSP ports SYSCLK.
  */
@@ -262,67 +248,18 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
-/*
- * Set the SSP clock dividers.
- */
-static int pxa_ssp_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
-	int div_id, int div)
-{
-	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
-	struct ssp_device *ssp = priv->ssp;
-	int val;
-
-	switch (div_id) {
-	case PXA_SSP_AUDIO_DIV_ACDS:
-		val = (pxa_ssp_read_reg(ssp, SSACD) & ~0x7) | SSACD_ACDS(div);
-		pxa_ssp_write_reg(ssp, SSACD, val);
-		break;
-	case PXA_SSP_AUDIO_DIV_SCDB:
-		val = pxa_ssp_read_reg(ssp, SSACD);
-		val &= ~SSACD_SCDB;
-		if (ssp->type == PXA3xx_SSP)
-			val &= ~SSACD_SCDX8;
-		switch (div) {
-		case PXA_SSP_CLK_SCDB_1:
-			val |= SSACD_SCDB;
-			break;
-		case PXA_SSP_CLK_SCDB_4:
-			break;
-		case PXA_SSP_CLK_SCDB_8:
-			if (ssp->type == PXA3xx_SSP)
-				val |= SSACD_SCDX8;
-			else
-				return -EINVAL;
-			break;
-		default:
-			return -EINVAL;
-		}
-		pxa_ssp_write_reg(ssp, SSACD, val);
-		break;
-	case PXA_SSP_DIV_SCR:
-		pxa_ssp_set_scr(ssp, div);
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
 /*
  * Configure the PLL frequency pxa27x and (afaik - pxa320 only)
  */
-static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
-	int source, unsigned int freq_in, unsigned int freq_out)
+static int pxa_ssp_set_pll(struct ssp_priv *priv, unsigned int freq)
 {
-	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
 	u32 ssacd = pxa_ssp_read_reg(ssp, SSACD) & ~0x70;
 
 	if (ssp->type == PXA3xx_SSP)
 		pxa_ssp_write_reg(ssp, SSACDD, 0);
 
-	switch (freq_out) {
+	switch (freq) {
 	case 5622000:
 		break;
 	case 11345000:
@@ -353,7 +290,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 			u64 tmp = 19968;
 
 			tmp *= 1000000;
-			do_div(tmp, freq_out);
+			do_div(tmp, freq);
 			val = tmp;
 
 			val = (val << 16) | 64;
@@ -363,7 +300,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 
 			dev_dbg(&ssp->pdev->dev,
 				"Using SSACDD %x to supply %uHz\n",
-				val, freq_out);
+				val, freq);
 			break;
 		}
 
@@ -568,6 +505,24 @@ static int pxa_ssp_configure_dai_fmt(struct ssp_priv *priv)
 	return 0;
 }
 
+struct pxa_ssp_clock_mode {
+	int rate;
+	int pll;
+	u8 acds;
+	u8 scdb;
+};
+
+static const struct pxa_ssp_clock_mode pxa_ssp_clock_modes[] = {
+	{ .rate =  8000, .pll = 32842000, .acds = SSACD_ACDS_32, .scdb = SSACD_SCDB_4X },
+	{ .rate = 11025, .pll =  5622000, .acds = SSACD_ACDS_4,  .scdb = SSACD_SCDB_4X },
+	{ .rate = 16000, .pll = 32842000, .acds = SSACD_ACDS_16, .scdb = SSACD_SCDB_4X },
+	{ .rate = 22050, .pll =  5622000, .acds = SSACD_ACDS_2,  .scdb = SSACD_SCDB_4X },
+	{ .rate = 44100, .pll = 11345000, .acds = SSACD_ACDS_2,  .scdb = SSACD_SCDB_4X },
+	{ .rate = 48000, .pll = 12235000, .acds = SSACD_ACDS_2,  .scdb = SSACD_SCDB_4X },
+	{ .rate = 96000, .pll = 12235000, .acds = SSACD_ACDS_4,  .scdb = SSACD_SCDB_1X },
+	{}
+};
+
 /*
  * Set the SSP audio DMA parameters and sample size.
  * Can be called multiple times by oss emulation.
@@ -579,11 +534,12 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
 	int chn = params_channels(params);
-	u32 sscr0;
-	u32 sspsp;
+	u32 sscr0, sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
 	int ttsa = pxa_ssp_read_reg(ssp, SSTSA) & 0xf;
 	struct snd_dmaengine_dai_dma_data *dma_data;
+	int rate = params_rate(params);
+	int bclk = rate * chn * (width / 8);
 	int ret;
 
 	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
@@ -623,11 +579,57 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	}
 	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
 
+	if (sscr0 & SSCR0_ACS) {
+		ret = pxa_ssp_set_pll(priv, bclk);
+
+		/*
+		 * If we were able to generate the bclk directly,
+		 * all is fine. Otherwise, look up the closest rate
+		 * from the table and also set the dividers.
+		 */
+
+		if (ret < 0) {
+			const struct pxa_ssp_clock_mode *m;
+			int ssacd, acds;
+
+			for (m = pxa_ssp_clock_modes; m->rate; m++) {
+				if (m->rate == rate)
+					break;
+			}
+
+			if (!m->rate)
+				return -EINVAL;
+
+			acds = m->acds;
+
+			/* The values in the table are for 16 bits */
+			if (width == 32)
+				acds--;
+
+			ret = pxa_ssp_set_pll(priv, bclk);
+			if (ret < 0)
+				return ret;
+
+			ssacd = pxa_ssp_read_reg(ssp, SSACD);
+			ssacd &= ~(SSACD_ACDS(7) | SSACD_SCDB_1X);
+			ssacd |= SSACD_ACDS(m->acds);
+			ssacd |= m->scdb;
+			pxa_ssp_write_reg(ssp, SSACD, ssacd);
+		}
+	} else if (sscr0 & SSCR0_ECS) {
+		/*
+		 * For setups with external clocking, the PLL and its diviers
+		 * are not active. Instead, the SCR bits in SSCR0 can be used
+		 * to divide the clock.
+		 */
+		pxa_ssp_set_scr(ssp, bclk / rate);
+	}
+
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	       sspsp = pxa_ssp_read_reg(ssp, SSPSP);
 
-		if ((pxa_ssp_get_scr(ssp) == 4) && (width == 16)) {
+		if (((priv->sysclk / bclk) == 64) && (width == 16)) {
 			/* This is a special case where the bitclk is 64fs
 			 * and we're not dealing with 2*32 bits of audio
 			 * samples.
@@ -812,8 +814,6 @@ static const struct snd_soc_dai_ops pxa_ssp_dai_ops = {
 	.trigger	= pxa_ssp_trigger,
 	.hw_params	= pxa_ssp_hw_params,
 	.set_sysclk	= pxa_ssp_set_dai_sysclk,
-	.set_clkdiv	= pxa_ssp_set_dai_clkdiv,
-	.set_pll	= pxa_ssp_set_dai_pll,
 	.set_fmt	= pxa_ssp_set_dai_fmt,
 	.set_tdm_slot	= pxa_ssp_set_dai_tdm_slot,
 	.set_tristate	= pxa_ssp_set_dai_tristate,
-- 
2.18.0.rc2
