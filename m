From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Support more sample rates" to the asoc tree
Date: Tue, 10 May 2016 19:49:22 +0100
Message-ID: <E1b0Cig-0007Rb-S2@debutante>
References: <20160509112437.8924-9-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-9-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Support more sample rates

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

>From 45749c918129e409c44777f051dc0a5afb689459 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Mon, 9 May 2016 12:24:36 +0100
Subject: [PATCH] ASoC: es8328: Support more sample rates

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 135 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 100 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index a66c21c7b5a0..b8ca214a5332 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -26,18 +26,30 @@
 #include <sound/tlv.h>
 #include "es8328.h"
 
-#define ES8328_SYSCLK_RATE_1X 11289600
-#define ES8328_SYSCLK_RATE_2X 22579200
+static const unsigned int rates_12288[] = {
+	8000, 12000, 16000, 24000, 32000, 48000, 96000,
+};
 
-/* Run the codec at 22.5792 or 11.2896 MHz to support these rates */
-static struct {
-	int rate;
-	u8 ratio;
-} mclk_ratios[] = {
-	{ 8000, 9 },
-	{11025, 7 },
-	{22050, 4 },
-	{44100, 2 },
+static const int ratios_12288[] = {
+	10, 7, 6, 4, 3, 2, 0,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_12288 = {
+	.count	= ARRAY_SIZE(rates_12288),
+	.list	= rates_12288,
+};
+
+static const unsigned int rates_11289[] = {
+	8018, 11025, 22050, 44100, 88200,
+};
+
+static const int ratios_11289[] = {
+	9, 7, 4, 2, 0,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_11289 = {
+	.count	= ARRAY_SIZE(rates_11289),
+	.list	= rates_11289,
 };
 
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
@@ -57,9 +69,14 @@ static const char * const supply_names[ES8328_SUPPLY_NUM] = {
 	"HPVDD",
 };
 
-#define ES8328_RATES (SNDRV_PCM_RATE_44100 | \
+#define ES8328_RATES (SNDRV_PCM_RATE_96000 | \
+		SNDRV_PCM_RATE_48000 | \
+		SNDRV_PCM_RATE_44100 | \
+		SNDRV_PCM_RATE_32000 | \
 		SNDRV_PCM_RATE_22050 | \
-		SNDRV_PCM_RATE_11025)
+		SNDRV_PCM_RATE_16000 | \
+		SNDRV_PCM_RATE_11025 | \
+		SNDRV_PCM_RATE_8000)
 #define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 		SNDRV_PCM_FMTBIT_S18_3LE | \
 		SNDRV_PCM_FMTBIT_S20_3LE | \
@@ -71,6 +88,9 @@ struct es8328_priv {
 	struct clk *clk;
 	int playback_fs;
 	bool deemph;
+	int mclkdiv2;
+	const struct snd_pcm_hw_constraint_list *sysclk_constraints;
+	const int *mclk_ratios;
 	struct regulator_bulk_data supplies[ES8328_SUPPLY_NUM];
 };
 
@@ -443,40 +463,55 @@ static int es8328_mute(struct snd_soc_dai *dai, int mute)
 			mute ? ES8328_DACCONTROL3_DACMUTE : 0);
 }
 
+static int es8328_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
+
+	if (es8328->sysclk_constraints)
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE,
+				es8328->sysclk_constraints);
+
+	return 0;
+}
+
 static int es8328_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
-	int clk_rate = clk_get_rate(es8328->clk);
 	int i;
 	int reg;
-	int val;
 	int wl;
-	u8 ratio;
+	int ratio;
+
+	if (!es8328->sysclk_constraints) {
+		dev_err(codec->dev, "No MCLK configured\n");
+		return -EINVAL;
+	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = ES8328_DACCONTROL2;
 	else
 		reg = ES8328_ADCCONTROL5;
 
-	switch (clk_rate) {
-	case ES8328_SYSCLK_RATE_1X:
-		val = 0;
-		break;
-	case ES8328_SYSCLK_RATE_2X:
-		val = ES8328_MASTERMODE_MCLKDIV2;
-		break;
-	default:
-		dev_err(codec->dev,
-			"%s: clock is running at %d Hz, not %d or %d Hz\n",
-			 __func__, clk_rate,
-			 ES8328_SYSCLK_RATE_1X, ES8328_SYSCLK_RATE_2X);
+	for (i = 0; i < es8328->sysclk_constraints->count; i++)
+		if (es8328->sysclk_constraints->list[i] == params_rate(params))
+			break;
+
+	if (i == es8328->sysclk_constraints->count) {
+		dev_err(codec->dev, "LRCLK %d unsupported with current clock\n",
+			params_rate(params));
 		return -EINVAL;
 	}
+
+	ratio = es8328->mclk_ratios[i];
 	snd_soc_update_bits(codec, ES8328_MASTERMODE,
-			ES8328_MASTERMODE_MCLKDIV2, val);
+			ES8328_MASTERMODE_MCLKDIV2,
+			es8328->mclkdiv2 ? ES8328_MASTERMODE_MCLKDIV2 : 0);
 
 	switch (params_width(params)) {
 	case 16:
@@ -498,12 +533,6 @@ static int es8328_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* find master mode MCLK to sampling frequency ratio */
-	ratio = mclk_ratios[0].rate;
-	for (i = 1; i < ARRAY_SIZE(mclk_ratios); i++)
-		if (params_rate(params) <= mclk_ratios[i].rate)
-			ratio = mclk_ratios[i].ratio;
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		snd_soc_update_bits(codec, ES8328_DACCONTROL1,
 				ES8328_DACCONTROL1_DACWL_MASK,
@@ -519,6 +548,40 @@ static int es8328_hw_params(struct snd_pcm_substream *substream,
 	return snd_soc_update_bits(codec, reg, ES8328_RATEMASK, ratio);
 }
 
+static int es8328_set_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
+	int mclkdiv2 = 0;
+
+	switch (freq) {
+	case 0:
+		es8328->sysclk_constraints = NULL;
+		es8328->mclk_ratios = NULL;
+		break;
+	case 22579200:
+		mclkdiv2 = 1;
+		/* fallthru */
+	case 11289600:
+		es8328->sysclk_constraints = &constraints_11289;
+		es8328->mclk_ratios = ratios_11289;
+		break;
+	case 24576000:
+		mclkdiv2 = 1;
+		/* fallthru */
+	case 12288000:
+		es8328->sysclk_constraints = &constraints_12288;
+		es8328->mclk_ratios = ratios_12288;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	es8328->mclkdiv2 = mclkdiv2;
+	return 0;
+}
+
 static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
@@ -616,8 +679,10 @@ static int es8328_set_bias_level(struct snd_soc_codec *codec,
 }
 
 static const struct snd_soc_dai_ops es8328_dai_ops = {
+	.startup	= es8328_startup,
 	.hw_params	= es8328_hw_params,
 	.digital_mute	= es8328_mute,
+	.set_sysclk	= es8328_set_sysclk,
 	.set_fmt	= es8328_set_dai_fmt,
 };
 
-- 
2.8.1
