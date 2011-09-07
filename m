From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2] ALSA: usb: refine delay information with
	USB frame counter
Date: Tue,  6 Sep 2011 19:15:34 -0500
Message-ID: <1315354534-5995-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A4BC24545
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 02:15:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sarah.a.sharp@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Existing code only updates the audio delay when URBs were
submitted/retired. This can introduce an uncertainty of 8ms
on the number of samples played out with the default settings,
and a lot more when URBs convey more packets to reduce the
interrupt rate and power consumption.

This patch relies on the USB frame counter to reduce the
uncertainty to less than 2ms worst-case. The delay information
essentially becomes independent of the URB size and number of
packets. This should help applications like PulseAudio which
require accurate audio timing. Clemens Ladisch
<clemens@ladisch.de> reported a decrease of mplayer's
A-V difference from nrpacks down to at most 1ms.

Thanks to Clemens for also pointing out that the implementation
of frame counters varies between different HCDs. Only the
8 lowest-bits are used to estimate the delay.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/usb/card.h |    2 ++
 sound/usb/pcm.c  |   28 ++++++++++++++++++++++++++++
 sound/usb/pcm.h  |    3 +++
 sound/usb/urb.c  |   28 +++++++++++++++++++++++++---
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index ae4251d..a39edcc 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -94,6 +94,8 @@ struct snd_usb_substream {
 	spinlock_t lock;
 
 	struct snd_urb_ops ops;		/* callbacks (must be filled at init) */
+	int last_frame_number;          /* stored frame number */
+	int last_delay;                 /* stored delay */
 };
 
 struct snd_usb_stream {
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b8dcbf4..0b699ca 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -34,6 +34,30 @@
 #include "clock.h"
 #include "power.h"
 
+/* return the estimated delay based on USB frame counters */
+snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
+				    unsigned int rate)
+{
+	int current_frame_number;
+	int frame_diff;
+	int est_delay;
+
+	current_frame_number = usb_get_current_frame_number(subs->dev);
+	/*
+	 * HCD implementations use different widths, use lower 8 bits.
+	 * The delay will be managed up to 256ms, which is more than
+	 * enough
+	 */
+	frame_diff = (current_frame_number - subs->last_frame_number) & 0xff;
+
+	/* Approximation based on number of samples per USB frame (ms),
+	   some truncation for 44.1 but the estimate is good enough */
+	est_delay =  subs->last_delay - (frame_diff * rate / 1000);
+	if (est_delay < 0)
+		est_delay = 0;
+	return est_delay;
+}
+
 /*
  * return the current pcm pointer.  just based on the hwptr_done value.
  */
@@ -45,6 +69,8 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
 	subs = (struct snd_usb_substream *)substream->runtime->private_data;
 	spin_lock(&subs->lock);
 	hwptr_done = subs->hwptr_done;
+	substream->runtime->delay = snd_usb_pcm_delay(subs,
+						substream->runtime->rate);
 	spin_unlock(&subs->lock);
 	return hwptr_done / (substream->runtime->frame_bits >> 3);
 }
@@ -417,6 +443,8 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	subs->hwptr_done = 0;
 	subs->transfer_done = 0;
 	subs->phase = 0;
+	subs->last_delay = 0;
+	subs->last_frame_number = 0;
 	runtime->delay = 0;
 
 	return snd_usb_substream_prepare(subs, runtime);
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index ed3e283..df7a003 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -1,6 +1,9 @@
 #ifndef __USBAUDIO_PCM_H
 #define __USBAUDIO_PCM_H
 
+snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
+				    unsigned int rate);
+
 void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream);
 
 int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
diff --git a/sound/usb/urb.c b/sound/usb/urb.c
index e184349..56610bb 100644
--- a/sound/usb/urb.c
+++ b/sound/usb/urb.c
@@ -718,7 +718,16 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 	subs->hwptr_done += bytes;
 	if (subs->hwptr_done >= runtime->buffer_size * stride)
 		subs->hwptr_done -= runtime->buffer_size * stride;
+
+	/* update delay with exact number of samples queued */
+	runtime->delay = subs->last_delay;
 	runtime->delay += frames;
+	subs->last_delay = runtime->delay;
+
+	/* realign last_frame_number */
+	subs->last_frame_number = usb_get_current_frame_number(subs->dev);
+	subs->last_frame_number &= 0xFF; /* keep 8 LSBs */
+
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = bytes;
 	if (period_elapsed)
@@ -737,12 +746,25 @@ static int retire_playback_urb(struct snd_usb_substream *subs,
 	unsigned long flags;
 	int stride = runtime->frame_bits >> 3;
 	int processed = urb->transfer_buffer_length / stride;
+	int est_delay;
 
 	spin_lock_irqsave(&subs->lock, flags);
-	if (processed > runtime->delay)
-		runtime->delay = 0;
+
+	est_delay = snd_usb_pcm_delay(subs, runtime->rate);
+	/* update delay with exact number of samples played */
+	if (processed > subs->last_delay)
+		subs->last_delay = 0;
 	else
-		runtime->delay -= processed;
+		subs->last_delay -= processed;
+	runtime->delay = subs->last_delay;
+
+	/* Report when delay estimate is off by more than 2ms.
+	 * The error should be lower than 2ms since the estimate relies
+	 * on two reads of a counter updated every ms */
+	if (abs(est_delay-subs->last_delay) > (runtime->rate*2/1000))
+		snd_printk(KERN_DEBUG "Delay %d actual delay %d\n",
+			est_delay, subs->last_delay);
+
 	spin_unlock_irqrestore(&subs->lock, flags);
 	return 0;
 }
-- 
1.7.6
