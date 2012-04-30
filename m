From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: wm8350: Remove check for clocks in
	trigger()
Date: Mon, 30 Apr 2012 22:53:13 +0100
Message-ID: <1335822795-4720-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1335822795-4720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C83B810419C
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 23:53:22 +0200 (CEST)
In-Reply-To: <1335822795-4720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This is now very standard behaviour for CODECs so shouldn't be device
specific and we shouldn't really be trying to peer into the register
cache from atomic context anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |   40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index aa12c6b..840380d 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -71,13 +71,6 @@ struct wm8350_data {
 	int fll_freq_in;
 };
 
-static unsigned int wm8350_codec_cache_read(struct snd_soc_codec *codec,
-					    unsigned int reg)
-{
-	struct wm8350 *wm8350 = codec->control_data;
-	return wm8350->reg_cache[reg];
-}
-
 static unsigned int wm8350_codec_read(struct snd_soc_codec *codec,
 				      unsigned int reg)
 {
@@ -929,38 +922,6 @@ static int wm8350_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
-static int wm8350_pcm_trigger(struct snd_pcm_substream *substream,
-			      int cmd, struct snd_soc_dai *codec_dai)
-{
-	struct snd_soc_codec *codec = codec_dai->codec;
-	int master = wm8350_codec_cache_read(codec, WM8350_AI_DAC_CONTROL) &
-	    WM8350_BCLK_MSTR;
-	int enabled = 0;
-
-	/* Check that the DACs or ADCs are enabled since they are
-	 * required for LRC in master mode. The DACs or ADCs need a
-	 * valid audio path i.e. pin -> ADC or DAC -> pin before
-	 * the LRC will be enabled in master mode. */
-	if (!master || cmd != SNDRV_PCM_TRIGGER_START)
-		return 0;
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		enabled = wm8350_codec_cache_read(codec, WM8350_POWER_MGMT_4) &
-		    (WM8350_ADCR_ENA | WM8350_ADCL_ENA);
-	} else {
-		enabled = wm8350_codec_cache_read(codec, WM8350_POWER_MGMT_4) &
-		    (WM8350_DACR_ENA | WM8350_DACL_ENA);
-	}
-
-	if (!enabled) {
-		dev_err(codec->dev,
-		       "%s: invalid audio path - no clocks available\n",
-		       __func__);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static int wm8350_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *codec_dai)
@@ -1491,7 +1452,6 @@ EXPORT_SYMBOL_GPL(wm8350_mic_jack_detect);
 static const struct snd_soc_dai_ops wm8350_dai_ops = {
 	 .hw_params	= wm8350_pcm_hw_params,
 	 .digital_mute	= wm8350_mute,
-	 .trigger	= wm8350_pcm_trigger,
 	 .set_fmt	= wm8350_set_dai_fmt,
 	 .set_sysclk	= wm8350_set_dai_sysclk,
 	 .set_pll	= wm8350_set_fll,
-- 
1.7.10
