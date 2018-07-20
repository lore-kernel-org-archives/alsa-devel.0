From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: remove clock divider and pll setup
	from zylonite and magician" to the asoc tree
Date: Fri, 20 Jul 2018 17:42:58 +0100
Message-ID: <E1fgYUc-0000g3-QZ@debutante>
References: <20180716062445.15819-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF73E26774A
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 18:43:02 +0200 (CEST)
In-Reply-To: <20180716062445.15819-1-daniel@zonque.org>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: remove clock divider and pll setup from zylonite and magician

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

>From a8e43c21a8a32a3af4abc605b6ebcab039f28e00 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Mon, 16 Jul 2018 08:24:45 +0200
Subject: [PATCH] ASoC: pxa: remove clock divider and pll setup from zylonite
 and magician

The SSP DAI now handles the clocking setup itself, all it needs is the
master clock frequency. Remove the code from Zylonite and Magician
platforms.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/magician.c | 106 +--------------------------------------
 sound/soc/pxa/zylonite.c |   9 ----
 2 files changed, 2 insertions(+), 113 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 2fc012b06c43..935a248e5bf6 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -90,95 +90,9 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	unsigned int acps, acds, width;
-	unsigned int div4 = PXA_SSP_CLK_SCDB_4;
+	unsigned int width;
 	int ret = 0;
 
-	width = snd_pcm_format_physical_width(params_format(params));
-
-	/*
-	 * rate = SSPSCLK / (2 * width(16 or 32))
-	 * SSPSCLK = (ACPS / ACDS) / SSPSCLKDIV(div4 or div1)
-	 */
-	switch (params_rate(params)) {
-	case 8000:
-		/* off by a factor of 2: bug in the PXA27x audio clock? */
-		acps = 32842000;
-		switch (width) {
-		case 16:
-			/* 513156 Hz ~= _2_ * 8000 Hz * 32 (+0.23%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_16;
-			break;
-		default: /* 32 */
-			/* 1026312 Hz ~= _2_ * 8000 Hz * 64 (+0.23%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_8;
-		}
-		break;
-	case 11025:
-		acps = 5622000;
-		switch (width) {
-		case 16:
-			/* 351375 Hz ~= 11025 Hz * 32 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_4;
-			break;
-		default: /* 32 */
-			/* 702750 Hz ~= 11025 Hz * 64 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
-		}
-		break;
-	case 22050:
-		acps = 5622000;
-		switch (width) {
-		case 16:
-			/* 702750 Hz ~= 22050 Hz * 32 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
-			break;
-		default: /* 32 */
-			/* 1405500 Hz ~= 22050 Hz * 64 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_1;
-		}
-		break;
-	case 44100:
-		acps = 5622000;
-		switch (width) {
-		case 16:
-			/* 1405500 Hz ~= 44100 Hz * 32 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
-			break;
-		default: /* 32 */
-			/* 2811000 Hz ~= 44100 Hz * 64 (-0.41%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_1;
-		}
-		break;
-	case 48000:
-		acps = 12235000;
-		switch (width) {
-		case 16:
-			/* 1529375 Hz ~= 48000 Hz * 32 (-0.44%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
-			break;
-		default: /* 32 */
-			/* 3058750 Hz ~= 48000 Hz * 64 (-0.44%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_1;
-		}
-		break;
-	case 96000:
-	default:
-		acps = 12235000;
-		switch (width) {
-		case 16:
-			/* 3058750 Hz ~= 96000 Hz * 32 (-0.44%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_1;
-			break;
-		default: /* 32 */
-			/* 6117500 Hz ~= 96000 Hz * 64 (-0.44%) */
-			acds = PXA_SSP_CLK_AUDIO_DIV_2;
-			div4 = PXA_SSP_CLK_SCDB_1;
-			break;
-		}
-		break;
-	}
-
 	/* set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_MSB |
 			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
@@ -191,6 +105,7 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	width = snd_pcm_format_physical_width(params_format(params));
 	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 0, 1, width);
 	if (ret < 0)
 		return ret;
@@ -201,23 +116,6 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* set the SSP audio system clock ACDS divider */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai,
-			PXA_SSP_AUDIO_DIV_ACDS, acds);
-	if (ret < 0)
-		return ret;
-
-	/* set the SSP audio system clock SCDB divider4 */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai,
-			PXA_SSP_AUDIO_DIV_SCDB, div4);
-	if (ret < 0)
-		return ret;
-
-	/* set SSP audio pll clock */
-	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, 0, acps);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index ba468e560dd2..230eee450f45 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -83,11 +83,9 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	unsigned int pll_out = 0;
 	unsigned int wm9713_div = 0;
 	int ret = 0;
 	int rate = params_rate(params);
-	int width = snd_pcm_format_physical_width(params_format(params));
 
 	/* Only support ratios that we can generate neatly from the AC97
 	 * based master clock - in particular, this excludes 44.1kHz.
@@ -109,17 +107,10 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* Add 1 to the width for the leading clock cycle */
-	pll_out = rate * (width + 1) * 8;
-
 	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_AUDIO, 0, 1);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, 0, pll_out);
-	if (ret < 0)
-		return ret;
-
 	if (clk_pout)
 		ret = snd_soc_dai_set_clkdiv(codec_dai, WM9713_PCMCLK_PLL_DIV,
 					     WM9713_PCMDIV(wm9713_div));
-- 
2.18.0
