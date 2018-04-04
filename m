From: Georg Chini <georg@chini.tk>
Subject: [PATCH] ALSA: usb: improve delay reporting
Date: Wed,  4 Apr 2018 15:57:44 +0200
Message-ID: <20180404135744.3921-1-georg@chini.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lolchat.de (mail.lolchat.de [80.147.226.48])
 by alsa0.perex.cz (Postfix) with ESMTP id A6A042675C8
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 15:57:50 +0200 (CEST)
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
Cc: Georg Chini <georg@chini.tk>
List-Id: alsa-devel@alsa-project.org

Currently, the kernel uses only the number of USB frames to interpolate the delay
between sending or receiving URB's. This limits the granuarity of the delay reports
to one millisecond because the frame counter is updated in a millisecond interval.

This patch additionally uses time stamps to achieve higher precision of the reported
delay. If the time difference computed using time stamps does not deviate more than
one millisecond from the difference computed using frames, it is assumed that the
system time difference delivers the more precise delay estimate.

This will significantly increase the precision of the reported delay in the majority
of cases where sound card clock and system clock are almost in sync while falling back
to the old method for the rare cases where the two times differ too much.

As a downside, the possible worst case error increases from 2ms to 3ms.
---
 sound/usb/card.h |  1 +
 sound/usb/pcm.c  | 47 +++++++++++++++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index ed87cc83eb47..8835d9628cac 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -149,6 +149,7 @@ struct snd_usb_substream {
 
 	int last_frame_number;          /* stored frame number */
 	int last_delay;                 /* stored delay */
+	struct timespec last_update_time;    /* time when last_delay was updated */
 
 	struct {
 		int marker;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 3cbfae6604f9..6d40cb0b8777 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -46,9 +46,8 @@ snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
 	int current_frame_number;
 	int frame_diff;
 	int est_delay;
-
-	if (!subs->last_delay)
-		return 0; /* short path */
+	int time_diff;
+	struct timespec now;
 
 	current_frame_number = usb_get_current_frame_number(subs->dev);
 	/*
@@ -58,9 +57,21 @@ snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
 	 */
 	frame_diff = (current_frame_number - subs->last_frame_number) & 0xff;
 
-	/* Approximation based on number of samples per USB frame (ms),
-	   some truncation for 44.1 but the estimate is good enough */
-	est_delay =  frame_diff * rate / 1000;
+	/* Estimate time since last update of last_delay */
+	snd_pcm_gettime(subs->pcm_substream->runtime, &now);
+	time_diff = (now.tv_sec - subs->last_update_time.tv_sec) * 1000000000;
+	time_diff += (int)now.tv_nsec - subs->last_update_time.tv_nsec;
+	time_diff /= 1000;
+
+	if (abs(time_diff - frame_diff * 1000) < 1000) {
+		/* System time and sound card time do not differ
+		 * too much. Use system time to calculate delay */
+		est_delay =  time_diff * rate / 1000000;
+	} else {
+		/* Approximation based on number of samples per USB frame (ms),
+		   some truncation for 44.1 but the estimate is good enough */
+		est_delay =  frame_diff * rate / 1000;
+	}
 	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		est_delay = subs->last_delay - est_delay;
 	else
@@ -853,6 +864,8 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	subs->hwptr_done = 0;
 	subs->transfer_done = 0;
 	subs->last_delay = 0;
+	subs->last_update_time.tv_sec = 0;
+	subs->last_update_time.tv_nsec = 0;
 	subs->last_frame_number = 0;
 	runtime->delay = 0;
 
@@ -1334,7 +1347,9 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 
 		/* realign last_frame_number */
 		subs->last_frame_number = current_frame_number;
-		subs->last_frame_number &= 0xFF; /* keep 8 LSBs */
+
+		/* Take time stamp for delay accounting */
+		snd_pcm_gettime(runtime, &subs->last_update_time);
 
 		spin_unlock_irqrestore(&subs->lock, flags);
 		/* copy a data chunk */
@@ -1550,7 +1565,9 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 
 	/* realign last_frame_number */
 	subs->last_frame_number = usb_get_current_frame_number(subs->dev);
-	subs->last_frame_number &= 0xFF; /* keep 8 LSBs */
+
+	/* Take time stamp for delay accounting */
+	snd_pcm_gettime(runtime, &subs->last_update_time);
 
 	if (subs->trigger_tstamp_pending_update) {
 		/* this is the first actual URB submitted,
@@ -1597,6 +1614,12 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
 		subs->last_delay -= processed;
 	runtime->delay = subs->last_delay;
 
+	/* realign last_frame_number */
+	subs->last_frame_number = usb_get_current_frame_number(subs->dev);
+
+	/* Take time stamp for delay accounting */
+	snd_pcm_gettime(runtime, &subs->last_update_time);
+
 	/*
 	 * Report when delay estimate is off by more than 2ms.
 	 * The error should be lower than 2ms since the estimate relies
@@ -1607,14 +1630,6 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
 			"delay: estimated %d, actual %d\n",
 			est_delay, subs->last_delay);
 
-	if (!subs->running) {
-		/* update last_frame_number for delay counting here since
-		 * prepare_playback_urb won't be called during pause
-		 */
-		subs->last_frame_number =
-			usb_get_current_frame_number(subs->dev) & 0xff;
-	}
-
  out:
 	spin_unlock_irqrestore(&subs->lock, flags);
 }
-- 
2.16.2
