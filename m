From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [RFC] ASoC: Fix Zylonite for non-networked SSP mode
Date: Fri, 13 Mar 2009 14:37:55 +0000
Message-ID: <1236955075-14253-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090313143720.GC8989@sirena.org.uk>
	<1236955075-14253-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1236955075-14253-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 248E91037FD
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 16:06:51 +0100 (CET)
In-Reply-To: <1236955075-14253-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>, pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This also simplifies the code a bit.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/zylonite.c |   55 +++++++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 9f6116e..9a386b4 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -96,42 +96,35 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	unsigned int pll_out = 0;
-	unsigned int acds = 0;
 	unsigned int wm9713_div = 0;
 	int ret = 0;
-
-	switch (params_rate(params)) {
+	int rate = params_rate(params);
+	int width = snd_pcm_format_physical_width(params_format(params));
+
+	/* Only support ratios that we can generate neatly from the AC97
+	 * based master clock - in particular, this excludes 44.1kHz.
+	 * In most applications the voice DAC will be used for telephony
+	 * data so multiples of 8kHz will be the common case.
+	 */
+	switch (rate) {
 	case 8000:
 		wm9713_div = 12;
-		pll_out = 2048000;
 		break;
 	case 16000:
 		wm9713_div = 6;
-		pll_out = 4096000;
 		break;
 	case 48000:
-	default:
 		wm9713_div = 2;
-		pll_out = 12288000;
-		acds = 1;
 		break;
+	default:
+		/* Don't support OSS emulation */
+		return -EINVAL;
 	}
 
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
+	/* Add 1 to the width for the leading clock cycle */
+	pll_out = rate * (width + 1) * 8;
 
-	/* Use network mode for stereo, one slot per channel. */
-	if (params_channels(params) > 1)
-		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 2);
-	else
-		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_AUDIO, 0, 1);
 	if (ret < 0)
 		return ret;
 
@@ -139,14 +132,6 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_AUDIO_DIV_ACDS, acds);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_AUDIO, 0, 1);
-	if (ret < 0)
-		return ret;
-
 	if (clk_pout)
 		ret = snd_soc_dai_set_clkdiv(codec_dai, WM9713_PCMCLK_PLL_DIV,
 					     WM9713_PCMDIV(wm9713_div));
@@ -156,6 +141,16 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
1.5.6.3
