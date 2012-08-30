From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3] ALSA: snd-usb: restore delay information
Date: Thu, 30 Aug 2012 18:52:29 +0200
Message-ID: <1346345551-8956-2-git-send-email-zonque@gmail.com>
References: <1346345551-8956-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 979382660B9
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 18:52:56 +0200 (CEST)
In-Reply-To: <1346345551-8956-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, "[3.5+]"@mail.zonque.de, clemens@ladisch.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, linux@romal.de, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Parts of commit 294c4fb8 ("ALSA: usb: refine delay information with USB
frame counter") were unfortunately lost during the refactoring of the
snd-usb driver in 3.5.

This patch adds them back, restoring the correct delay information
behaviour.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: stable@kernel.org [3.5+]
---
 sound/usb/pcm.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 1546577..5ceb8f1 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1091,7 +1091,16 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
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
@@ -1109,12 +1118,26 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
 	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
 	int stride = runtime->frame_bits >> 3;
 	int processed = urb->transfer_buffer_length / stride;
+	int est_delay;
 
 	spin_lock_irqsave(&subs->lock, flags);
-	if (processed > runtime->delay)
-		runtime->delay = 0;
+	est_delay = snd_usb_pcm_delay(subs, runtime->rate);
+	/* update delay with exact number of samples played */
+	if (processed > subs->last_delay)
+		subs->last_delay = 0;
 	else
-		runtime->delay -= processed;
+		subs->last_delay -= processed;
+	runtime->delay = subs->last_delay;
+
+	/*
+	 * Report when delay estimate is off by more than 2ms.
+	 * The error should be lower than 2ms since the estimate relies
+	 * on two reads of a counter updated every ms.
+	 */
+	if (abs(est_delay - subs->last_delay) * 1000 > runtime->rate * 2)
+		snd_printk(KERN_DEBUG "delay: estimated %d, actual %d\n",
+			est_delay, subs->last_delay);
+
 	spin_unlock_irqrestore(&subs->lock, flags);
 }
 
-- 
1.7.11.4
