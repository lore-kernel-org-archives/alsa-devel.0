From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: USB Audio questions
Date: Fri, 19 Aug 2011 17:02:04 -0500
Message-ID: <1313791325.22440.9.camel@plb-Dell>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-2-git-send-email-lars@metafoo.de>
	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
	<4E4A100D.9020302@ladisch.de>
	<000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
	<4E4A9644.3020507@ladisch.de>
	<000001cc5c38$b07abee0$11703ca0$@bossart@linux.intel.com>
	<4E4B5FC7.7090001@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-56gX/nn7MUklQN1dik6m"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 88446103822
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 00:02:22 +0200 (CEST)
In-Reply-To: <4E4B5FC7.7090001@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org


--=-56gX/nn7MUklQN1dik6m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


> > Any idea on how this frame number can be read,
> 
> With usb_get_current_frame_number().

I hacked something to refine the delay information based on the USB
frame number. see attached patch. 
Two points can be improved:
- I am not sure how to convert from USB frames to ALSA frames. I used a
fixed value based what my headset supports
- Every second or so the estimate seems to be off by 96 samples, see
below. Not sure why this happens, how accurate the counter is and if
there a delay in handling retired urbs? Looks good enough though.
Thanks,
-Pierre

[10880.896486] plb-urb -- actual delay 96 estimated delay 0 
[10881.917729] plb-urb -- actual delay 48 estimated delay 0 
[10882.937948] plb-urb -- actual delay 96 estimated delay 0 
[10883.966190] plb-urb -- actual delay 96 estimated delay 0 
[10884.987425] plb-urb -- actual delay 96 estimated delay 0 
[10886.008654] plb-urb -- actual delay 96 estimated delay 0 
[10887.029931] plb-urb -- actual delay 96 estimated delay 0 
[10888.050153] plb-urb -- actual delay 96 estimated delay 0 
[10889.071375] plb-urb -- actual delay 96 estimated delay 0




--=-56gX/nn7MUklQN1dik6m
Content-Disposition: attachment; filename="usb-delay.patch"
Content-Type: text/x-patch; name="usb-delay.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

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
index b8dcbf4..ca17711 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -34,6 +34,27 @@
 #include "clock.h"
 #include "power.h"
 
+/* return the estimated delay based on USB frame counters */
+snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs)
+{
+	int current_frame_number;
+	int frame_diff;
+	int est_delay;
+
+	current_frame_number= usb_get_current_frame_number(subs->dev);
+	frame_diff = current_frame_number-subs->last_frame_number;
+	if (frame_diff < 0)
+		frame_diff += 2048; /* handle 11-bit wrap-around */
+
+	/* FIXME: need to make this formula more general */
+	est_delay =  subs->last_delay-frame_diff*48;
+	if (est_delay < 0) {
+		//printk(KERN_ERR "\t est_delay %d last_delay %d frame_diff %d curr_frame %d last_frame %d \n", est_delay, subs->last_delay, frame_diff, current_frame_number, subs->last_frame_number);
+		est_delay = 0;
+	}
+	return est_delay;
+}
+
 /*
  * return the current pcm pointer.  just based on the hwptr_done value.
  */
@@ -45,6 +66,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
 	subs = (struct snd_usb_substream *)substream->runtime->private_data;
 	spin_lock(&subs->lock);
 	hwptr_done = subs->hwptr_done;
+	substream->runtime->delay = snd_usb_pcm_delay(subs);
 	spin_unlock(&subs->lock);
 	return hwptr_done / (substream->runtime->frame_bits >> 3);
 }
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index ed3e283..11b7bd9 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -1,6 +1,8 @@
 #ifndef __USBAUDIO_PCM_H
 #define __USBAUDIO_PCM_H
 
+snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs);
+
 void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream);
 
 int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
diff --git a/sound/usb/urb.c b/sound/usb/urb.c
index e184349..a0897a5 100644
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
+	subs->last_frame_number = usb_get_current_frame_number(subs->dev);
+
+	//printk(KERN_ERR "\t\tplb-urb: increased delay %d current frame %d \n", runtime->delay, subs->last_frame_number);
+
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = bytes;
 	if (period_elapsed)
@@ -737,12 +746,21 @@ static int retire_playback_urb(struct snd_usb_substream *subs,
 	unsigned long flags;
 	int stride = runtime->frame_bits >> 3;
 	int processed = urb->transfer_buffer_length / stride;
+	int est_delay;
 
 	spin_lock_irqsave(&subs->lock, flags);
-	if (processed > runtime->delay)
-		runtime->delay = 0;
+
+	est_delay = snd_usb_pcm_delay(subs);
+	/* update delay with exact number of samples played*/
+	if (processed > subs->last_delay)
+		subs->last_delay = 0;
 	else
-		runtime->delay -= processed;
+		subs->last_delay -= processed;
+	runtime->delay = subs->last_delay;
+
+	if (runtime->delay != est_delay)
+		printk(KERN_ERR "plb-urb -- actual delay %d estimated delay %d \n", runtime->delay, est_delay);
+
 	spin_unlock_irqrestore(&subs->lock, flags);
 	return 0;
 }

--=-56gX/nn7MUklQN1dik6m
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-56gX/nn7MUklQN1dik6m--
