From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Remove open coded symmetry
	implementation from WM8903
Date: Fri, 10 Dec 2010 19:17:07 +0000
Message-ID: <1292008628-29457-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1292008628-29457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CAC7D245E1
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 20:17:12 +0100 (CET)
In-Reply-To: <1292008628-29457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We're already flagged as using symmetric rates so we don't need to
have a custom implementation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   79 +--------------------------------------------
 1 files changed, 1 insertions(+), 78 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 542c7c4..f9ae403 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -218,10 +218,8 @@ struct wm8903_priv {
 	int sysclk;
 	int irq;
 
-	/* Reference counts */
+	/* Reference count */
 	int class_w_users;
-	int playback_active;
-	int capture_active;
 
 	struct completion wseq;
 
@@ -230,9 +228,6 @@ struct wm8903_priv {
 	int mic_short;
 	int mic_last_report;
 	int mic_delay;
-
-	struct snd_pcm_substream *master_substream;
-	struct snd_pcm_substream *slave_substream;
 };
 
 static int wm8903_volatile_register(unsigned int reg)
@@ -1243,58 +1238,6 @@ static struct {
 	{ 0,      0 },
 };
 
-static int wm8903_startup(struct snd_pcm_substream *substream,
-			  struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	struct snd_pcm_runtime *master_runtime;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		wm8903->playback_active++;
-	else
-		wm8903->capture_active++;
-
-	/* The DAI has shared clocks so if we already have a playback or
-	 * capture going then constrain this substream to match it.
-	 */
-	if (wm8903->master_substream) {
-		master_runtime = wm8903->master_substream->runtime;
-
-		dev_dbg(codec->dev, "Constraining to %d bits\n",
-			master_runtime->sample_bits);
-
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-					     master_runtime->sample_bits,
-					     master_runtime->sample_bits);
-
-		wm8903->slave_substream = substream;
-	} else
-		wm8903->master_substream = substream;
-
-	return 0;
-}
-
-static void wm8903_shutdown(struct snd_pcm_substream *substream,
-			    struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		wm8903->playback_active--;
-	else
-		wm8903->capture_active--;
-
-	if (wm8903->master_substream == substream)
-		wm8903->master_substream = wm8903->slave_substream;
-
-	wm8903->slave_substream = NULL;
-}
-
 static int wm8903_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
@@ -1319,11 +1262,6 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 	u16 clock1 = snd_soc_read(codec, WM8903_CLOCK_RATES_1);
 	u16 dac_digital1 = snd_soc_read(codec, WM8903_DAC_DIGITAL_1);
 
-	if (substream == wm8903->slave_substream) {
-		dev_dbg(codec->dev, "Ignoring hw_params for slave substream\n");
-		return 0;
-	}
-
 	/* Enable sloping stopband filter for low sample rates */
 	if (fs <= 24000)
 		dac_digital1 |= WM8903_DAC_SB_FILT;
@@ -1341,19 +1279,6 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	/* Constraints should stop us hitting this but let's make sure */
-	if (wm8903->capture_active)
-		switch (sample_rates[dsp_config].rate) {
-		case 88200:
-		case 96000:
-			dev_err(codec->dev, "%dHz unsupported by ADC\n",
-				fs);
-			return -EINVAL;
-
-		default:
-			break;
-		}
-
 	dev_dbg(codec->dev, "DSP fs = %dHz\n", sample_rates[dsp_config].rate);
 	clock1 &= ~WM8903_SAMPLE_RATE_MASK;
 	clock1 |= sample_rates[dsp_config].value;
@@ -1592,8 +1517,6 @@ static irqreturn_t wm8903_irq(int irq, void *data)
 			SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_ops wm8903_dai_ops = {
-	.startup	= wm8903_startup,
-	.shutdown	= wm8903_shutdown,
 	.hw_params	= wm8903_hw_params,
 	.digital_mute	= wm8903_digital_mute,
 	.set_fmt	= wm8903_set_dai_fmt,
-- 
1.7.1
