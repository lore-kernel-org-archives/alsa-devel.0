From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: pcm: Unify delay calculation in
	snd_pcm_status() and snd_pcm_delay()
Date: Mon, 16 Apr 2018 14:14:17 +0200
Message-ID: <20180416121417.27452-4-tiwai@suse.de>
References: <20180416121417.27452-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B72C2673C4
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 14:14:19 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BFD7AADE2
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 12:14:18 +0000 (UTC)
In-Reply-To: <20180416121417.27452-1-tiwai@suse.de>
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

Yet another slight code cleanup: there are two places where
calculating the PCM delay, and they can be unified in a single
helper.  It reduces the multiple open codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index eddb0cd6d1eb..81bbe0b3284b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -857,6 +857,18 @@ static int snd_pcm_sw_params_user(struct snd_pcm_substream *substream,
 	return err;
 }
 
+static inline snd_pcm_uframes_t
+snd_pcm_calc_delay(struct snd_pcm_substream *substream)
+{
+	snd_pcm_uframes_t delay;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		delay = snd_pcm_playback_hw_avail(substream->runtime);
+	else
+		delay = snd_pcm_capture_avail(substream->runtime);
+	return delay + substream->runtime->delay;
+}
+
 int snd_pcm_status(struct snd_pcm_substream *substream,
 		   struct snd_pcm_status *status)
 {
@@ -909,19 +921,7 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	status->appl_ptr = runtime->control->appl_ptr;
 	status->hw_ptr = runtime->status->hw_ptr;
 	status->avail = snd_pcm_avail(substream);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
-		    runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
-			status->delay = runtime->buffer_size - status->avail;
-			status->delay += runtime->delay;
-		} else
-			status->delay = 0;
-	} else {
-		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
-			status->delay = status->avail + runtime->delay;
-		else
-			status->delay = 0;
-	}
+	status->delay = snd_pcm_calc_delay(substream);
 	status->avail_max = runtime->avail_max;
 	status->overrange = runtime->overrange;
 	runtime->avail_max = 0;
@@ -2655,19 +2655,13 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 		
 static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 	snd_pcm_sframes_t n = 0;
 
 	snd_pcm_stream_lock_irq(substream);
 	err = do_pcm_hwsync(substream);
-	if (!err) {
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			n = snd_pcm_playback_hw_avail(runtime);
-		else
-			n = snd_pcm_capture_avail(runtime);
-		n += runtime->delay;
-	}
+	if (!err)
+		n = snd_pcm_calc_delay(substream);
 	snd_pcm_stream_unlock_irq(substream);
 	return err < 0 ? err : n;
 }
-- 
2.16.3
