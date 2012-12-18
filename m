From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ALSA: usb-audio: support delay calculation
	on capture streams
Date: Tue, 18 Dec 2012 17:54:40 -0600
Message-ID: <1355874880-9941-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1355874880-9941-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id EE41E265020
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 06:12:42 +0100 (CET)
In-Reply-To: <1355874880-9941-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Enable delay report on capture path. The delay is reset when an
URB is retired and increment at each call to .pointer based
on frame counter changes. The precision of the delay
information is limited to 1ms as in the playback case.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/usb/pcm.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b09b895..3a38447 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -59,7 +59,12 @@ snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
 
 	/* Approximation based on number of samples per USB frame (ms),
 	   some truncation for 44.1 but the estimate is good enough */
-	est_delay =  subs->last_delay - (frame_diff * rate / 1000);
+	est_delay =  frame_diff * rate / 1000;
+	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		est_delay = subs->last_delay - est_delay;
+	else
+		est_delay = subs->last_delay + est_delay;
+
 	if (est_delay < 0)
 		est_delay = 0;
 	return est_delay;
@@ -1146,6 +1151,10 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 	int i, period_elapsed = 0;
 	unsigned long flags;
 	unsigned char *cp;
+	int current_frame_number;
+
+	/* read frame number here, update pointer in critical section */
+	current_frame_number = usb_get_current_frame_number(subs->dev);
 
 	stride = runtime->frame_bits >> 3;
 
@@ -1179,6 +1188,15 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 			subs->transfer_done -= runtime->period_size;
 			period_elapsed = 1;
 		}
+		/* capture delay is by construction limited to one URB,
+		 * reset delays here
+		 */
+		runtime->delay = subs->last_delay = 0;
+
+		/* realign last_frame_number */
+		subs->last_frame_number = current_frame_number;
+		subs->last_frame_number &= 0xFF; /* keep 8 LSBs */
+
 		spin_unlock_irqrestore(&subs->lock, flags);
 		/* copy a data chunk */
 		if (oldptr + bytes > runtime->buffer_size * stride) {
-- 
1.7.9.5
