From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: aloop: Fix racy hw constraints adjustment
Date: Thu,  4 Jan 2018 18:04:08 +0100
Message-ID: <20180104170408.23750-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DD1A26790C
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 18:04:11 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0520BAE06
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 17:04:11 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The aloop driver tries to update the hw constraints of the connected
target on the cable of the opened PCM substream.  This is done by
adding the extra hw constraints rules referring to the substream
runtime->hw fields, while the other substream may update the runtime
hw of another side on the fly.

This is, however, racy and may result in the inconsistent values when
both PCM streams perform the prepare concurrently.  One of the reason
is that it overwrites the other's runtime->hw field; which is not only
racy but also broken when it's called before the open of another side
finishes.  And, since the reference to runtime->hw isn't protected,
the concurrent write may give the partial value update and become
inconsistent.

This patch is an attempt to fix and clean up:
- The prepare doesn't change the runtime->hw of other side any longer,
  but only update the cable->hw that is referred commonly.
- The extra rules refer to the loopback_pcm object instead of the
  runtime->hw.  The actual hw is deduced from cable->hw.
- The extra rules take the cable_lock to protect against the race.

Fixes: b1c73fc8e697 ("ALSA: snd-aloop: Fix hw_params restrictions and checking")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 51 +++++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index afac886ffa28..b1eee1a1e925 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -305,19 +305,6 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
-static void params_change_substream(struct loopback_pcm *dpcm,
-				    struct snd_pcm_runtime *runtime)
-{
-	struct snd_pcm_runtime *dst_runtime;
-
-	if (dpcm == NULL || dpcm->substream == NULL)
-		return;
-	dst_runtime = dpcm->substream->runtime;
-	if (dst_runtime == NULL)
-		return;
-	dst_runtime->hw = dpcm->cable->hw;
-}
-
 static void params_change(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -329,10 +316,6 @@ static void params_change(struct snd_pcm_substream *substream)
 	cable->hw.rate_max = runtime->rate;
 	cable->hw.channels_min = runtime->channels;
 	cable->hw.channels_max = runtime->channels;
-	params_change_substream(cable->streams[SNDRV_PCM_STREAM_PLAYBACK],
-				runtime);
-	params_change_substream(cable->streams[SNDRV_PCM_STREAM_CAPTURE],
-				runtime);
 }
 
 static int loopback_prepare(struct snd_pcm_substream *substream)
@@ -620,12 +603,14 @@ static unsigned int get_cable_index(struct snd_pcm_substream *substream)
 static int rule_format(struct snd_pcm_hw_params *params,
 		       struct snd_pcm_hw_rule *rule)
 {
-
-	struct snd_pcm_hardware *hw = rule->private;
+	struct loopback_pcm *dpcm = rule->private;
+	struct loopback_cable *cable = dpcm->cable;
 	struct snd_mask *maskp = hw_param_mask(params, rule->var);
 
-	maskp->bits[0] &= (u_int32_t)hw->formats;
-	maskp->bits[1] &= (u_int32_t)(hw->formats >> 32);
+	mutex_lock(&dpcm->loopback->cable_lock);
+	maskp->bits[0] &= (u_int32_t)cable->hw.formats;
+	maskp->bits[1] &= (u_int32_t)(cable->hw.formats >> 32);
+	mutex_unlock(&dpcm->loopback->cable_lock);
 	memset(maskp->bits + 2, 0, (SNDRV_MASK_MAX-64) / 8); /* clear rest */
 	if (! maskp->bits[0] && ! maskp->bits[1])
 		return -EINVAL;
@@ -635,11 +620,14 @@ static int rule_format(struct snd_pcm_hw_params *params,
 static int rule_rate(struct snd_pcm_hw_params *params,
 		     struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hardware *hw = rule->private;
+	struct loopback_pcm *dpcm = rule->private;
+	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-        t.min = hw->rate_min;
-        t.max = hw->rate_max;
+	mutex_lock(&dpcm->loopback->cable_lock);
+	t.min = cable->hw.rate_min;
+	t.max = cable->hw.rate_max;
+	mutex_unlock(&dpcm->loopback->cable_lock);
         t.openmin = t.openmax = 0;
         t.integer = 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -648,11 +636,14 @@ static int rule_rate(struct snd_pcm_hw_params *params,
 static int rule_channels(struct snd_pcm_hw_params *params,
 			 struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hardware *hw = rule->private;
+	struct loopback_pcm *dpcm = rule->private;
+	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-        t.min = hw->channels_min;
-        t.max = hw->channels_max;
+	mutex_lock(&dpcm->loopback->cable_lock);
+	t.min = cable->hw.channels_min;
+	t.max = cable->hw.channels_max;
+	mutex_unlock(&dpcm->loopback->cable_lock);
         t.openmin = t.openmax = 0;
         t.integer = 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -699,19 +690,19 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	/* are cached -> they do not reflect the actual state */
 	err = snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_FORMAT,
-				  rule_format, &runtime->hw,
+				  rule_format, dpcm,
 				  SNDRV_PCM_HW_PARAM_FORMAT, -1);
 	if (err < 0)
 		goto unlock;
 	err = snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_RATE,
-				  rule_rate, &runtime->hw,
+				  rule_rate, dpcm,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		goto unlock;
 	err = snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_CHANNELS,
-				  rule_channels, &runtime->hw,
+				  rule_channels, dpcm,
 				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		goto unlock;
-- 
2.15.1
