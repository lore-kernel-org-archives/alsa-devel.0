From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: usb-audio: fix delay account during
	pause
Date: Fri, 23 Nov 2012 16:21:48 +0100
Message-ID: <1353684108-16669-3-git-send-email-tiwai@suse.de>
References: <1353684108-16669-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CFAE26171E
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 16:21:56 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 13B1CA30EC
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 16:21:56 +0100 (CET)
In-Reply-To: <1353684108-16669-1-git-send-email-tiwai@suse.de>
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

When a playback stream is paused, the stream isn't actually stopped,
thus we still need to take care of the in-flight data amount for the
delay calculation.  Otherwise the value of subs->last_delay is no
longer reliable and can give a bogus value after resuming from pause.
This will result in "delay: estimated XX, actual YY" error messages.

Also, during pause after all in flight data are processed
(i.e. last_delay = 0), we don't have to calculate the actual delay
from the current frame.  Give a short path in such a case.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 8e1d5e0..7c64b95 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -46,6 +46,9 @@ snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
 	int frame_diff;
 	int est_delay;
 
+	if (!subs->last_delay)
+		return 0; /* short path */
+
 	current_frame_number = usb_get_current_frame_number(subs->dev);
 	/*
 	 * HCD implementations use different widths, use lower 8 bits.
@@ -1195,6 +1198,9 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
 		return;
 
 	spin_lock_irqsave(&subs->lock, flags);
+	if (!subs->last_delay)
+		goto out; /* short path */
+
 	est_delay = snd_usb_pcm_delay(subs, runtime->rate);
 	/* update delay with exact number of samples played */
 	if (processed > subs->last_delay)
@@ -1212,6 +1218,15 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
 		snd_printk(KERN_DEBUG "delay: estimated %d, actual %d\n",
 			est_delay, subs->last_delay);
 
+	if (!subs->running) {
+		/* update last_frame_number for delay counting here since
+		 * prepare_playback_urb won't be called during pause
+		 */
+		subs->last_frame_number =
+			usb_get_current_frame_number(subs->dev) & 0xff;
+	}
+
+ out:
 	spin_unlock_irqrestore(&subs->lock, flags);
 }
 
@@ -1253,7 +1268,8 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 		return 0;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		subs->data_endpoint->prepare_data_urb = NULL;
-		subs->data_endpoint->retire_data_urb = NULL;
+		/* keep retire_data_urb for delay calculation */
+		subs->data_endpoint->retire_data_urb = retire_playback_urb;
 		subs->running = 0;
 		return 0;
 	}
-- 
1.8.0
