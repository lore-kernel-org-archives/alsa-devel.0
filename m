From: John Keeping <john@metanate.com>
Subject: [PATCH 1/9] ASoC: es8328: Move clock setup to hw_params
Date: Mon,  9 May 2016 12:24:29 +0100
Message-ID: <20160509112437.8924-2-john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metanate.com (dougal.metanate.com [90.155.101.14])
 by alsa0.perex.cz (Postfix) with ESMTP id B232A2606F5
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 13:24:48 +0200 (CEST)
In-Reply-To: <20160509112437.8924-1-john@metanate.com>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

This ensures that the clock is setup after its frequency has been set;
the existing code in set_dai_fmt may be called before the clock rate has
been set resulting in an incorrect configuration.

Signed-off-by: John Keeping <john@metanate.com>
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
2.8.0.rc4.238.g874082a
