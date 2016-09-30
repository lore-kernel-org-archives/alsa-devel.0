From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 7/7] ALSA: usb: take startup delay into account
Date: Fri, 30 Sep 2016 18:13:30 +0530
Message-ID: <1475239410-16548-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 154DB2665C3
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 14:50:23 +0200 (CEST)
In-Reply-To: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

For playback usages, the endpoints are started before the prepare
step, and valid audio data will be rendered with a delay that
cannot be recovered.
Worst-case the initial delay due to buffering of empty URBS can
be up to 12ms

Tested with audio_time:

Timestamps without delay taken into account:
test$ ./audio_time -Dhw:1,0 -p
playback: systime: 120093327 nsec, audio time 125000000 nsec, systime delta -4906673
playback: systime: 245090755 nsec, audio time 250000000 nsec, systime delta -4909245
playback: systime: 370034641 nsec, audio time 375000000 nsec, systime delta -4965359
playback: systime: 495089634 nsec, audio time 500000000 nsec, systime delta -4910366

Timestamps with delay taken into account (12ms delay shown)
test$ ./audio_time -Dhw:1,0 -p -d
playback: systime: 120095090 nsec, audio time 108000000 nsec, systime delta 12095090
playback: systime: 245090932 nsec, audio time 232000000 nsec, systime delta 13090932
playback: systime: 370091792 nsec, audio time 357000000 nsec, systime delta 13091792
playback: systime: 495092309 nsec, audio time 482000000 nsec, systime delta 13092309

Suggested-by: Rakesh Ughreja <rakesh.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/usb/card.h |  1 +
 sound/usb/pcm.c  | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 71778ca..d128058 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -148,6 +148,7 @@ struct snd_usb_substream {
 
 	int last_frame_number;          /* stored frame number */
 	int last_delay;                 /* stored delay */
+	int start_delay;                /* initial delay due to empty frames */
 
 	struct {
 		int marker;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 5bcc729..2bf7537 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -86,6 +86,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
 	hwptr_done = subs->hwptr_done;
 	substream->runtime->delay = snd_usb_pcm_delay(subs,
 						substream->runtime->rate);
+	substream->runtime->delay += subs->start_delay;
 	spin_unlock(&subs->lock);
 	return hwptr_done / (substream->runtime->frame_bits >> 3);
 }
@@ -858,9 +859,34 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 
 	/* for playback, submit the URBs now; otherwise, the first hwptr_done
 	 * updates for all URBs would happen at the same time when starting */
-	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
+	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = start_endpoints(subs, true);
 
+		/*
+		 * Since we submit empty URBS, the constant initial delay will
+		 * not be recovered and will be added to the dynamic delay
+		 * measured with the frame counter. Worst-case the
+		 * startup delay can be (MAX_URBS-1) * MAX_PACKS = 12ms
+		 */
+		if (ret == 0) {
+			struct snd_usb_endpoint *ep = subs->data_endpoint;
+			int total_packs = 0;
+			int i;
+
+			for (i = 0; i < ep->nurbs - 1; i++) {
+				struct snd_urb_ctx *u = &ep->urb[i];
+
+				total_packs += u->packets;
+			}
+			subs->start_delay = DIV_ROUND_UP(total_packs *
+							 subs->cur_rate, 1000);
+			if (subs->start_delay)
+				dev_dbg(&subs->dev->dev,
+					"Initial delay for EP @%p: %d frames\n",
+					ep, subs->start_delay);
+		}
+	}
+
  unlock:
 	snd_usb_unlock_shutdown(subs->stream->chip);
 	return ret;
@@ -1549,6 +1575,7 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 	runtime->delay = subs->last_delay;
 	runtime->delay += frames;
 	subs->last_delay = runtime->delay;
+	runtime->delay += subs->start_delay;
 
 	/* realign last_frame_number */
 	subs->last_frame_number = usb_get_current_frame_number(subs->dev);
@@ -1597,8 +1624,7 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
 		subs->last_delay = 0;
 	else
 		subs->last_delay -= processed;
-	runtime->delay = subs->last_delay;
-
+	runtime->delay = subs->last_delay + subs->start_delay;
 	/*
 	 * Report when delay estimate is off by more than 2ms.
 	 * The error should be lower than 2ms since the estimate relies
-- 
1.9.1
