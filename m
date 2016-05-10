From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Move clock setup to hw_params" to the asoc tree
Date: Tue, 10 May 2016 19:49:41 +0100
Message-ID: <E1b0Ciz-0007wt-Af@debutante>
References: <20160509112437.8924-2-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-2-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Move clock setup to hw_params

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

>From 420c470d6b5c2924a3182edf5b002870ff770331 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Mon, 9 May 2016 12:24:29 +0100
Subject: [PATCH] ASoC: es8328: Move clock setup to hw_params

This ensures that the clock is setup after its frequency has been set;
the existing code in set_dai_fmt may be called before the clock rate has
been set resulting in an incorrect configuration.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index afa6c5db9dcc..3ca89ae32889 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -445,9 +445,10 @@ static int es8328_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
-	int clk_rate;
+	int clk_rate = clk_get_rate(es8328->clk);
 	int i;
 	int reg;
+	int val;
 	u8 ratio;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -455,16 +456,24 @@ static int es8328_hw_params(struct snd_pcm_substream *substream,
 	else
 		reg = ES8328_ADCCONTROL5;
 
-	clk_rate = clk_get_rate(es8328->clk);
-
-	if ((clk_rate != ES8328_SYSCLK_RATE_1X) &&
-		(clk_rate != ES8328_SYSCLK_RATE_2X)) {
+	switch (clk_rate) {
+	case ES8328_SYSCLK_RATE_1X:
+		val = 0;
+		break;
+	case ES8328_SYSCLK_RATE_2X:
+		val = ES8328_MASTERMODE_MCLKDIV2;
+		break;
+	default:
 		dev_err(codec->dev,
 			"%s: clock is running at %d Hz, not %d or %d Hz\n",
 			 __func__, clk_rate,
 			 ES8328_SYSCLK_RATE_1X, ES8328_SYSCLK_RATE_2X);
 		return -EINVAL;
 	}
+	ret = snd_soc_update_bits(codec, ES8328_MASTERMODE,
+			ES8328_MASTERMODE_MCLKDIV2, val);
+	if (ret < 0)
+		return ret;
 
 	/* find master mode MCLK to sampling frequency ratio */
 	ratio = mclk_ratios[0].rate;
@@ -484,8 +493,6 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
-	int clk_rate;
 	u8 mode = ES8328_DACCONTROL1_DACWL_16;
 
 	/* set master/slave audio interface */
@@ -515,14 +522,8 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	snd_soc_write(codec, ES8328_ADCCONTROL4, mode);
 
 	/* Master serial port mode, with BCLK generated automatically */
-	clk_rate = clk_get_rate(es8328->clk);
-	if (clk_rate == ES8328_SYSCLK_RATE_1X)
-		snd_soc_write(codec, ES8328_MASTERMODE,
-				ES8328_MASTERMODE_MSC);
-	else
-		snd_soc_write(codec, ES8328_MASTERMODE,
-				ES8328_MASTERMODE_MCLKDIV2 |
-				ES8328_MASTERMODE_MSC);
+	snd_soc_update_bits(codec, ES8328_MASTERMODE,
+			ES8328_MASTERMODE_MSC, ES8328_MASTERMODE_MSC);
 
 	return 0;
 }
-- 
2.8.1
