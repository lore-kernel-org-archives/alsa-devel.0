From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9713: use snd_soc_*() calls to update
	ac97 registers" to the asoc tree
Date: Wed, 04 Nov 2015 14:31:07 +0000
Message-ID: <E1Ztz5f-0002L7-Pq@finisterre>
References: <1446405820-24923-2-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 03254265745
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:31:23 +0100 (CET)
In-Reply-To: <1446405820-24923-2-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9713: use snd_soc_*() calls to update ac97 registers

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c895e0be4064b6e76dd5fe0a1d26491857f8c2cd Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 1 Nov 2015 20:23:40 +0100
Subject: [PATCH] ASoC: wm9713: use snd_soc_*() calls to update ac97 registers

Convert wm9713 to use the more modern registers manipulation functions,
such as snd_soc_read(), snd_soc_write() and snd_soc_update_bits().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9713.c | 140 +++++++++++++++++-----------------------------
 1 file changed, 52 insertions(+), 88 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 22985c4..79e1436 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -40,16 +40,6 @@ struct wm9713_priv {
 	struct mutex lock;
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	return snd_soc_read(codec, reg);
-}
-static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-		      unsigned int val)
-{
-	return snd_soc_write(codec, reg, val);
-}
-
 #define HPL_MIXER 0
 #define HPR_MIXER 1
 
@@ -203,18 +193,15 @@ static int wm9713_voice_shutdown(struct snd_soc_dapm_widget *w,
 				 struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	u16 status, rate;
 
 	if (WARN_ON(event != SND_SOC_DAPM_PRE_PMD))
 		return -EINVAL;
 
 	/* Gracefully shut down the voice interface. */
-	status = ac97_read(codec, AC97_EXTENDED_MID) | 0x1000;
-	rate = ac97_read(codec, AC97_HANDSET_RATE) & 0xF0FF;
-	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0200);
+	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, 0x0200);
 	schedule_timeout_interruptible(msecs_to_jiffies(1));
-	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0F00);
-	ac97_write(codec, AC97_EXTENDED_MID, status);
+	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, 0x0f00);
+	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x1000, 0x1000);
 
 	return 0;
 }
@@ -834,10 +821,8 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 	/* turn PLL off ? */
 	if (freq_in == 0) {
 		/* disable PLL power and select ext source */
-		reg = ac97_read(codec, AC97_HANDSET_RATE);
-		ac97_write(codec, AC97_HANDSET_RATE, reg | 0x0080);
-		reg = ac97_read(codec, AC97_EXTENDED_MID);
-		ac97_write(codec, AC97_EXTENDED_MID, reg | 0x0200);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0080, 0x0080);
+		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x0200, 0x0200);
 		wm9713->pll_in = 0;
 		return 0;
 	}
@@ -847,7 +832,7 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 	if (pll_div.k == 0) {
 		reg = (pll_div.n << 12) | (pll_div.lf << 11) |
 			(pll_div.divsel << 9) | (pll_div.divctl << 8);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 	} else {
 		/* write the fractional k to the reg 0x46 pages */
 		reg2 = (pll_div.n << 12) | (pll_div.lf << 11) | (1 << 10) |
@@ -855,33 +840,31 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 
 		/* K [21:20] */
 		reg = reg2 | (0x5 << 4) | (pll_div.k >> 20);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		/* K [19:16] */
 		reg = reg2 | (0x4 << 4) | ((pll_div.k >> 16) & 0xf);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		/* K [15:12] */
 		reg = reg2 | (0x3 << 4) | ((pll_div.k >> 12) & 0xf);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		/* K [11:8] */
 		reg = reg2 | (0x2 << 4) | ((pll_div.k >> 8) & 0xf);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		/* K [7:4] */
 		reg = reg2 | (0x1 << 4) | ((pll_div.k >> 4) & 0xf);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		reg = reg2 | (0x0 << 4) | (pll_div.k & 0xf); /* K [3:0] */
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 	}
 
 	/* turn PLL on and select as source */
-	reg = ac97_read(codec, AC97_EXTENDED_MID);
-	ac97_write(codec, AC97_EXTENDED_MID, reg & 0xfdff);
-	reg = ac97_read(codec, AC97_HANDSET_RATE);
-	ac97_write(codec, AC97_HANDSET_RATE, reg & 0xff7f);
+	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x0200, 0x0000);
+	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0080, 0x0000);
 	wm9713->pll_in = freq_in;
 
 	/* wait 10ms AC97 link frames for the link to stabilise */
@@ -904,10 +887,10 @@ static int wm9713_set_dai_tristate(struct snd_soc_dai *codec_dai,
 	int tristate)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 reg = ac97_read(codec, AC97_CENTER_LFE_MASTER) & 0x9fff;
 
 	if (tristate)
-		ac97_write(codec, AC97_CENTER_LFE_MASTER, reg);
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+				    0x6000, 0x0000);
 
 	return 0;
 }
@@ -920,36 +903,30 @@ static int wm9713_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 reg;
 
 	switch (div_id) {
 	case WM9713_PCMCLK_DIV:
-		reg = ac97_read(codec, AC97_HANDSET_RATE) & 0xf0ff;
-		ac97_write(codec, AC97_HANDSET_RATE, reg | div);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, div);
 		break;
 	case WM9713_CLKA_MULT:
-		reg = ac97_read(codec, AC97_HANDSET_RATE) & 0xfffd;
-		ac97_write(codec, AC97_HANDSET_RATE, reg | div);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0002, div);
 		break;
 	case WM9713_CLKB_MULT:
-		reg = ac97_read(codec, AC97_HANDSET_RATE) & 0xfffb;
-		ac97_write(codec, AC97_HANDSET_RATE, reg | div);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0004, div);
 		break;
 	case WM9713_HIFI_DIV:
-		reg = ac97_read(codec, AC97_HANDSET_RATE) & 0x8fff;
-		ac97_write(codec, AC97_HANDSET_RATE, reg | div);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x7000, div);
 		break;
 	case WM9713_PCMBCLK_DIV:
-		reg = ac97_read(codec, AC97_CENTER_LFE_MASTER) & 0xf1ff;
-		ac97_write(codec, AC97_CENTER_LFE_MASTER, reg | div);
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER, 0x0e00, div);
 		break;
 	case WM9713_PCMCLK_PLL_DIV:
-		reg = ac97_read(codec, AC97_LINE1_LEVEL) & 0xff80;
-		ac97_write(codec, AC97_LINE1_LEVEL, reg | 0x60 | div);
+		snd_soc_update_bits(codec, AC97_LINE1_LEVEL,
+				    0x007f, div | 0x60);
 		break;
 	case WM9713_HIFI_PLL_DIV:
-		reg = ac97_read(codec, AC97_LINE1_LEVEL) & 0xff80;
-		ac97_write(codec, AC97_LINE1_LEVEL, reg | 0x70 | div);
+		snd_soc_update_bits(codec, AC97_LINE1_LEVEL,
+				    0x007f, div | 0x70);
 		break;
 	default:
 		return -EINVAL;
@@ -962,7 +939,7 @@ static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 gpio = ac97_read(codec, AC97_GPIO_CFG) & 0xffc5;
+	u16 gpio = snd_soc_read(codec, AC97_GPIO_CFG) & 0xffc5;
 	u16 reg = 0x8000;
 
 	/* clock masters */
@@ -1015,8 +992,8 @@ static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	}
 
-	ac97_write(codec, AC97_GPIO_CFG, gpio);
-	ac97_write(codec, AC97_CENTER_LFE_MASTER, reg);
+	snd_soc_write(codec, AC97_GPIO_CFG, gpio);
+	snd_soc_write(codec, AC97_CENTER_LFE_MASTER, reg);
 	return 0;
 }
 
@@ -1025,24 +1002,24 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 reg = ac97_read(codec, AC97_CENTER_LFE_MASTER) & 0xfff3;
 
+	/* enable PCM interface in master mode */
 	switch (params_width(params)) {
 	case 16:
 		break;
 	case 20:
-		reg |= 0x0004;
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+				    0x000c, 0x0004);
 		break;
 	case 24:
-		reg |= 0x0008;
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+				    0x000c, 0x0008);
 		break;
 	case 32:
-		reg |= 0x000c;
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+				    0x000c, 0x000c);
 		break;
 	}
-
-	/* enable PCM interface in master mode */
-	ac97_write(codec, AC97_CENTER_LFE_MASTER, reg);
 	return 0;
 }
 
@@ -1052,17 +1029,15 @@ static int ac97_hifi_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int reg;
-	u16 vra;
 
-	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x0001, 0x0001);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return ac97_write(codec, reg, runtime->rate);
+	return snd_soc_write(codec, reg, runtime->rate);
 }
 
 static int ac97_aux_prepare(struct snd_pcm_substream *substream,
@@ -1070,17 +1045,14 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	u16 vra, xsle;
 
-	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
-	xsle = ac97_read(codec, AC97_PCI_SID);
-	ac97_write(codec, AC97_PCI_SID, xsle | 0x8000);
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x0001, 0x0001);
+	snd_soc_update_bits(codec, AC97_PCI_SID, 0x8000, 0x8000);
 
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 
-	return ac97_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
+	return snd_soc_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
 }
 
 #define WM9713_RATES (SNDRV_PCM_RATE_8000  |	\
@@ -1169,27 +1141,23 @@ static struct snd_soc_dai_driver wm9713_dai[] = {
 static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* enable thermal shutdown */
-		reg = ac97_read(codec, AC97_EXTENDED_MID) & 0x1bff;
-		ac97_write(codec, AC97_EXTENDED_MID, reg);
+		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0xe400, 0x0000);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* enable master bias and vmid */
-		reg = ac97_read(codec, AC97_EXTENDED_MID) & 0x3bff;
-		ac97_write(codec, AC97_EXTENDED_MID, reg);
-		ac97_write(codec, AC97_POWERDOWN, 0x0000);
+		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0xc400, 0x0000);
+		snd_soc_write(codec, AC97_POWERDOWN, 0x0000);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* disable everything including AC link */
-		ac97_write(codec, AC97_EXTENDED_MID, 0xffff);
-		ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
-		ac97_write(codec, AC97_POWERDOWN, 0xffff);
+		snd_soc_write(codec, AC97_EXTENDED_MID, 0xffff);
+		snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
+		snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
 	return 0;
@@ -1197,16 +1165,14 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 
 static int wm9713_soc_suspend(struct snd_soc_codec *codec)
 {
-	u16 reg;
-
 	/* Disable everything except touchpanel - that will be handled
 	 * by the touch driver and left disabled if touch is not in
 	 * use. */
-	reg = ac97_read(codec, AC97_EXTENDED_MID);
-	ac97_write(codec, AC97_EXTENDED_MID, reg | 0x7fff);
-	ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
-	ac97_write(codec, AC97_POWERDOWN, 0x6f00);
-	ac97_write(codec, AC97_POWERDOWN, 0xffff);
+	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x7fff,
+				 0x7fff);
+	snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
+	snd_soc_write(codec, AC97_POWERDOWN, 0x6f00);
+	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
 
 	return 0;
 }
@@ -1240,7 +1206,6 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	struct regmap *regmap;
-	int reg;
 
 	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
 		WM9713_VENDOR_ID_MASK);
@@ -1256,8 +1221,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_codec_init_regmap(codec, regmap);
 
 	/* unmute the adc - move to kcontrol */
-	reg = ac97_read(codec, AC97_CD) & 0x7fff;
-	ac97_write(codec, AC97_CD, reg);
+	snd_soc_update_bits(codec, AC97_CD, 0x7fff, 0x0000);
 
 	return 0;
 }
-- 
2.6.1
