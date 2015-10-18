From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/18] ASoC: twl4030: Use
	snd_pcm_hw_constraint_single()
Date: Sun, 18 Oct 2015 15:39:23 +0200
Message-ID: <1445175573-11784-9-git-send-email-lars@metafoo.de>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id D075A264F28
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:53 +0200 (CEST)
In-Reply-To: <1445175573-11784-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use the new snd_pcm_hw_constraint_single() helper function instead of
calling snd_pcm_hw_constraint_minmax() with the same value for min and max
to install a constraint that limits the possible configuration values to a
single value. Using snd_pcm_hw_constraint_single() makes the indented
result clearer and is slightly shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/twl4030.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 2713e18..a5a4e9f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1612,19 +1612,16 @@ static void twl4030_constraints(struct twl4030_priv *twl4030,
 		return;
 
 	/* Set the constraints according to the already configured stream */
-	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
+	snd_pcm_hw_constraint_single(slv_substream->runtime,
 				SNDRV_PCM_HW_PARAM_RATE,
-				twl4030->rate,
 				twl4030->rate);
 
-	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
+	snd_pcm_hw_constraint_single(slv_substream->runtime,
 				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-				twl4030->sample_bits,
 				twl4030->sample_bits);
 
-	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
+	snd_pcm_hw_constraint_single(slv_substream->runtime,
 				SNDRV_PCM_HW_PARAM_CHANNELS,
-				twl4030->channels,
 				twl4030->channels);
 }
 
@@ -1669,9 +1666,9 @@ static int twl4030_startup(struct snd_pcm_substream *substream,
 			/* In option2 4 channel is not supported, set the
 			 * constraint for the first stream for channels, the
 			 * second stream will 'inherit' this cosntraint */
-			snd_pcm_hw_constraint_minmax(substream->runtime,
+			snd_pcm_hw_constraint_single(substream->runtime,
 						     SNDRV_PCM_HW_PARAM_CHANNELS,
-						     2, 2);
+						     2);
 		}
 		twl4030->master_substream = substream;
 	}
-- 
2.1.4
