From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: pcm: Always honor DAI min and max
	sample rate constraints
Date: Wed, 27 Nov 2013 09:58:18 +0100
Message-ID: <1385542698-13362-2-git-send-email-lars@metafoo.de>
References: <1385542698-13362-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-115.synserver.de
 [212.40.185.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BE1BC26260F
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 09:57:48 +0100 (CET)
In-Reply-To: <1385542698-13362-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

snd_pcm_limit_hw_rates() will initialize the minimum and maximum sample rate for
the PCM stream based on the rates specified in the rates field. Since we call
snd_pcm_limit_hw_rates() after soc_pcm_init_runtime_hw() it will essentially
overwrite the min and max rate set in soc_pcm_init_runtime_hw(). This may cause
the minimum or maximum rate to be set to a value outside the range of one of the
components if one of the components sets either SNDRV_PCM_RATE_CONTINUOUS or
SNDRV_PCM_RATE_KNOT and the other component specified a discrete rate via
SNDRV_PCM_RATE_[0-9]* that is outside of the first component's rate range. To
fix this first calculate the minimum and maximum rates using
snd_pcm_limit_hw_rates() and then on top of that apply the contraints specified
in the snd_soc_pcm_stream structs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-pcm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index c4ef880..22af038 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -215,12 +215,12 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 	}
 }
 
-static void soc_pcm_init_runtime_hw(struct snd_pcm_hardware *hw,
+static void soc_pcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 	struct snd_soc_pcm_stream *codec_stream,
 	struct snd_soc_pcm_stream *cpu_stream)
 {
-	hw->rate_min = max(codec_stream->rate_min, cpu_stream->rate_min);
-	hw->rate_max = min_not_zero(codec_stream->rate_max, cpu_stream->rate_max);
+	struct snd_pcm_hardware *hw = &runtime->hw;
+
 	hw->channels_min = max(codec_stream->channels_min,
 		cpu_stream->channels_min);
 	hw->channels_max = min(codec_stream->channels_max,
@@ -233,6 +233,13 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_hardware *hw,
 	if (cpu_stream->rates
 		& (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
 		hw->rates |= codec_stream->rates;
+
+	snd_pcm_limit_hw_rates(runtime);
+
+	hw->rate_min = max(hw->rate_min, cpu_stream->rate_min);
+	hw->rate_min = max(hw->rate_min, codec_stream->rate_min);
+	hw->rate_max = min_not_zero(hw->rate_max, cpu_stream->rate_max);
+	hw->rate_max = min_not_zero(hw->rate_max, codec_stream->rate_max);
 }
 
 /*
@@ -302,15 +309,14 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 
 	/* Check that the codec and cpu DAIs are compatible */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		soc_pcm_init_runtime_hw(&runtime->hw, &codec_dai_drv->playback,
+		soc_pcm_init_runtime_hw(runtime, &codec_dai_drv->playback,
 			&cpu_dai_drv->playback);
 	} else {
-		soc_pcm_init_runtime_hw(&runtime->hw, &codec_dai_drv->capture,
+		soc_pcm_init_runtime_hw(runtime, &codec_dai_drv->capture,
 			&cpu_dai_drv->capture);
 	}
 
 	ret = -EINVAL;
-	snd_pcm_limit_hw_rates(runtime);
 	if (!runtime->hw.rates) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching rates\n",
 			codec_dai->name, cpu_dai->name);
-- 
1.8.0
