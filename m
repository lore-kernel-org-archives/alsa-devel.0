From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: arizona: Enable ASYNCCLK domain for
	audio interfaces
Date: Thu,  5 Jul 2012 17:32:56 +0100
Message-ID: <1341505977-10904-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE6592445B
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 18:32:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If an audio interface is configured to use ASYNCCLK then update the
asynchronous sample rate rather than one of our primary sample rates.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 8e066eb..d0bcca9 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -507,6 +507,8 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
 	int base = dai->driver->base;
 	const int *rates;
 	int i;
@@ -530,10 +532,6 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/*
-	 * We will need to be more flexible than this in future,
-	 * currently we use a single sample rate for the chip.
-	 */
 	for (i = 0; i < ARRAY_SIZE(arizona_sr_vals); i++)
 		if (arizona_sr_vals[i] == params_rate(params))
 			break;
@@ -552,8 +550,28 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	wl = snd_pcm_format_width(params_format(params));
 	frame = wl << ARIZONA_AIF1TX_WL_SHIFT | wl;
 
-	snd_soc_update_bits(codec, ARIZONA_SAMPLE_RATE_1,
-			    ARIZONA_SAMPLE_RATE_1_MASK, sr_val);
+	/*
+	 * We will need to be more flexible than this in future,
+	 * currently we use a single sample rate for SYSCLK.
+	 */
+	switch (dai_priv->clk) {
+	case ARIZONA_CLK_SYSCLK:
+		snd_soc_update_bits(codec, ARIZONA_SAMPLE_RATE_1,
+				    ARIZONA_SAMPLE_RATE_1_MASK, sr_val);
+		snd_soc_update_bits(codec, base + ARIZONA_AIF_RATE_CTRL,
+				    ARIZONA_AIF1_RATE_MASK, 0);
+		break;
+	case ARIZONA_CLK_ASYNCCLK:
+		snd_soc_update_bits(codec, ARIZONA_ASYNC_SAMPLE_RATE_1,
+				    ARIZONA_ASYNC_SAMPLE_RATE_MASK, sr_val);
+		snd_soc_update_bits(codec, base + ARIZONA_AIF_RATE_CTRL,
+				    ARIZONA_AIF1_RATE_MASK, 8);
+		break;
+	default:
+		arizona_aif_err(dai, "Invalid clock %d\n", dai_priv->clk);
+		return -EINVAL;
+	}
+
 	snd_soc_update_bits(codec, base + ARIZONA_AIF_BCLK_CTRL,
 			    ARIZONA_AIF1_BCLK_FREQ_MASK, bclk);
 	snd_soc_update_bits(codec, base + ARIZONA_AIF_TX_BCLK_RATE,
-- 
1.7.10
