From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: ignore delay
 calculation for capture stream
Date: Mon, 10 Dec 2012 15:33:56 -0600
Message-ID: <50C65544.7060003@linux.intel.com>
References: <1353684108-16669-1-git-send-email-tiwai@suse.de>
 <1353684108-16669-2-git-send-email-tiwai@suse.de>
 <50B37B90.7020403@linux.intel.com> <s5hr4ngh1u1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020800040706050408000501"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7229E2650A1
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 22:33:59 +0100 (CET)
In-Reply-To: <s5hr4ngh1u1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020800040706050408000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>> Shouldn't we add support for delay on the capture path instead? We could
>> use the same frame counter to report the delay and resync when the urb
>> is retired.
>
> Sure, it must be possible like that way.
> Wouldn't you like to volunteer? ;)

here's a suggestion. Since we don't submit multiple URBs as in the 
playback case, we can only track the delay using the frame counter for a 
single URB, and we reset the counters when the URB is retired.
Did a couple of tests, seems to work ok.
I couldn't figure out if the related patches are already in git, I 
didn't find them. Takashi, did you merge them already?
-Pierre



--------------020800040706050408000501
Content-Type: text/x-patch;
 name="usb_delay.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="usb_delay.patch"

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index c659310..65dc53e 100644
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
@@ -1147,6 +1152,10 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 	int i, period_elapsed = 0;
 	unsigned long flags;
 	unsigned char *cp;
+	int current_frame_number;
+
+	/* read frame number here, update pointer in critical section */
+	current_frame_number = usb_get_current_frame_number(subs->dev);
 
 	stride = runtime->frame_bits >> 3;
 
@@ -1180,6 +1189,13 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 			subs->transfer_done -= runtime->period_size;
 			period_elapsed = 1;
 		}
+		/* capture delay is by construction limited to one URB, reset delays here */
+		runtime->delay = subs->last_delay = 0;
+
+		/* realign last_frame_number */
+		subs->last_frame_number = current_frame_number;
+		subs->last_frame_number &= 0xFF; /* keep 8 LSBs */
+
 		spin_unlock_irqrestore(&subs->lock, flags);
 		/* copy a data chunk */
 		if (oldptr + bytes > runtime->buffer_size * stride) {

--------------020800040706050408000501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020800040706050408000501--
