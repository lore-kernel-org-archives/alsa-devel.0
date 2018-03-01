From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 6/6] ASoC: max9867: Use continuous sample rate
Date: Thu, 1 Mar 2018 15:22:16 +0100
Message-ID: <20180301142216.GH30722@lenoch>
References: <20180301141843.GB30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id E1EEB267952
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 15:22:19 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993890AbeCAOWTnzjIy (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 15:22:19 +0100
Content-Disposition: inline
In-Reply-To: <20180301141843.GB30722@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Drop "Common NI Values Table" and calculate LRCLK divider.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---

 Hi,

 what is exact meaning of SNDRV_PCM_RATE_CONTINUOUS? What if codec is
 able to set "any" rate, but there are rounding errors?
 Shall we pick exact matches based on master clock frequency?
 Few other drivers are also setting SNDRV_PCM_RATE_CONTINUOUS, but
 certainly cannot set any rate exactly.

 Thank you,
	ladis

 sound/soc/codecs/max9867.c | 86 ++++++++--------------------------------------
 1 file changed, 15 insertions(+), 71 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 4ea3287162ad..3b552b417d0d 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -126,75 +126,19 @@ static const struct snd_soc_dapm_route max9867_audio_map[] = {
 	{"LINE_IN", NULL, "Right Line"},
 };
 
-enum rates {
-	pcm_rate_8, pcm_rate_16, pcm_rate_24,
-	pcm_rate_32, pcm_rate_44,
-	pcm_rate_48, max_pcm_rate,
-};
-
-static const struct ni_div_rates {
-	u32 mclk;
-	u16 ni[max_pcm_rate];
-} ni_div[] = {
-	{11289600, {0x116A, 0x22D4, 0x343F, 0x45A9, 0x6000, 0x687D} },
-	{12000000, {0x1062, 0x20C5, 0x3127, 0x4189, 0x5A51, 0x624E} },
-	{12288000, {0x1000, 0x2000, 0x3000, 0x4000, 0x5833, 0x6000} },
-	{13000000, {0x0F20, 0x1E3F, 0x2D5F, 0x3C7F, 0x535F, 0x5ABE} },
-	{19200000, {0x0A3D, 0x147B, 0x1EB8, 0x28F6, 0x3873, 0x3D71} },
-	{24000000, {0x1062, 0x20C5, 0x1893, 0x4189, 0x5A51, 0x624E} },
-	{26000000, {0x0F20, 0x1E3F, 0x16AF, 0x3C7F, 0x535F, 0x5ABE} },
-	{27000000, {0x0E90, 0x1D21, 0x15D8, 0x3A41, 0x5048, 0x5762} },
-};
-
-static inline int get_ni_value(int mclk, int rate)
-{
-	int i, ret = 0;
-
-	/* find the closest rate index*/
-	for (i = 0; i < ARRAY_SIZE(ni_div); i++) {
-		if (ni_div[i].mclk >= mclk)
-			break;
-	}
-	if (i == ARRAY_SIZE(ni_div))
-		return -EINVAL;
-
-	switch (rate) {
-	case 8000:
-		return ni_div[i].ni[pcm_rate_8];
-	case 16000:
-		return ni_div[i].ni[pcm_rate_16];
-	case 32000:
-		return ni_div[i].ni[pcm_rate_32];
-	case 44100:
-		return ni_div[i].ni[pcm_rate_44];
-	case 48000:
-		return ni_div[i].ni[pcm_rate_48];
-	default:
-		pr_err("%s wrong rate %d\n", __func__, rate);
-		ret = -EINVAL;
-	}
-	return ret;
-}
-
 static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
 	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
-	unsigned int ni_h, ni_l;
-	int value;
+	unsigned int ni = DIV_ROUND_CLOSEST_ULL(96ULL * 0x10000 * params_rate(params),
+						max9867->pclk);
 
-	value = get_ni_value(max9867->sysclk, params_rate(params));
-	if (value < 0)
-		return value;
-
-	ni_h = (0xFF00 & value) >> 8;
-	ni_l = 0x00FF & value;
 	/* set up the ni value */
 	regmap_update_bits(max9867->regmap, MAX9867_AUDIOCLKHIGH,
-		MAX9867_NI_HIGH_MASK, ni_h);
+		MAX9867_NI_HIGH_MASK, (0xFF00 & ni) >> 8);
 	regmap_update_bits(max9867->regmap, MAX9867_AUDIOCLKLOW,
-		MAX9867_NI_LOW_MASK, ni_l);
+		MAX9867_NI_LOW_MASK, 0x00FF & ni);
 	if (!max9867->master) {
 		/*
 		 * digital pll locks on to any externally supplied LRCLK signal
@@ -283,13 +227,13 @@ static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	/* Set the prescaler based on the master clock frequency*/
 	if (freq >= 10000000 && freq <= 20000000) {
 		value |= MAX9867_PSCLK_10_20;
-		max9867->pclk =  freq;
+		max9867->pclk = freq;
 	} else if (freq >= 20000000 && freq <= 40000000) {
 		value |= MAX9867_PSCLK_20_40;
-		max9867->pclk =  freq/2;
+		max9867->pclk = freq / 2;
 	} else if (freq >= 40000000 && freq <= 60000000) {
 		value |= MAX9867_PSCLK_40_60;
-		max9867->pclk =  freq/4;
+		max9867->pclk = freq / 4;
 	} else {
 		dev_err(component->dev,
 			"Invalid clock frequency %uHz (required 10-60MHz)\n",
@@ -366,10 +310,6 @@ static const struct snd_soc_dai_ops max9867_dai_ops = {
 	.hw_params = max9867_dai_hw_params,
 };
 
-#define MAX9867_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
-	SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
-#define MAX9867_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
-
 static struct snd_soc_dai_driver max9867_dai[] = {
 	{
 	.name = "max9867-aif1",
@@ -377,15 +317,19 @@ static struct snd_soc_dai_driver max9867_dai[] = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = MAX9867_RATES,
-		.formats = MAX9867_FORMATS,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 8000,
+		.rate_max = 48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
 		.stream_name = "HiFi Capture",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = MAX9867_RATES,
-		.formats = MAX9867_FORMATS,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 8000,
+		.rate_max = 48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.ops = &max9867_dai_ops,
 	.symmetric_rates = 1,
-- 
2.16.2
