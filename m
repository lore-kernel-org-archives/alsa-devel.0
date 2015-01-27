From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: line6: Fix racy loopback handling
Date: Tue, 27 Jan 2015 17:13:13 +0100
Message-ID: <1422375197-17293-2-git-send-email-tiwai@suse.de>
References: <1422375197-17293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 456582608ED
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 17:13:19 +0100 (CET)
In-Reply-To: <1422375197-17293-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The impulse and monitor handling in submit_audio_out_urb() isn't
protected thus this can be racy with the capture stream handling.
This patch extends the range to protect via each stream's spinlock
(now the whole submit_audio_*_urb() are covered), and take the capture
stream lock additionally for the impulse and monitor handling part.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  | 20 +++++++++++---------
 sound/usb/line6/playback.c | 24 +++++++++++++-----------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 47cfcc2ab387..21342a9dddd7 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -20,21 +20,19 @@
 
 /*
 	Find a free URB and submit it.
+	must be called in line6pcm->in.lock context
 */
 static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 {
 	int index;
-	unsigned long flags;
 	int i, urb_size;
 	int ret;
 	struct urb *urb_in;
 
-	spin_lock_irqsave(&line6pcm->in.lock, flags);
 	index =
 	    find_first_zero_bit(&line6pcm->in.active_urbs, LINE6_ISO_BUFFERS);
 
 	if (index < 0 || index >= LINE6_ISO_BUFFERS) {
-		spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 		dev_err(line6pcm->line6->ifcdev, "no free URB found\n");
 		return -EINVAL;
 	}
@@ -64,7 +62,6 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 		dev_err(line6pcm->line6->ifcdev,
 			"URB in #%d submission failed (%d)\n", index, ret);
 
-	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 	return 0;
 }
 
@@ -73,15 +70,18 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 */
 int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm)
 {
-	int ret, i;
+	unsigned long flags;
+	int ret = 0, i;
 
+	spin_lock_irqsave(&line6pcm->in.lock, flags);
 	for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
 		ret = submit_audio_in_urb(line6pcm);
 		if (ret < 0)
-			return ret;
+			break;
 	}
 
-	return 0;
+	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
+	return ret;
 }
 
 /*
@@ -137,7 +137,9 @@ void line6_capture_check_period(struct snd_line6_pcm *line6pcm, int length)
 	line6pcm->in.bytes += length;
 	if (line6pcm->in.bytes >= line6pcm->in.period) {
 		line6pcm->in.bytes %= line6pcm->in.period;
+		spin_unlock(&line6pcm->in.lock);
 		snd_pcm_period_elapsed(substream);
+		spin_lock(&line6pcm->in.lock);
 	}
 }
 
@@ -196,8 +198,6 @@ static void audio_in_callback(struct urb *urb)
 	if (test_and_clear_bit(index, &line6pcm->in.unlink_urbs))
 		shutdown = 1;
 
-	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
-
 	if (!shutdown) {
 		submit_audio_in_urb(line6pcm);
 
@@ -206,6 +206,8 @@ static void audio_in_callback(struct urb *urb)
 				     &line6pcm->flags))
 				line6_capture_check_period(line6pcm, length);
 	}
+
+	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 }
 
 /* open capture callback */
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 3762a98026aa..b1d376501616 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -134,11 +134,11 @@ static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 
 /*
 	Find a free URB, prepare audio data, and submit URB.
+	must be called in line6pcm->out.lock context
 */
 static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 {
 	int index;
-	unsigned long flags;
 	int i, urb_size, urb_frames;
 	int ret;
 	const int bytes_per_frame = line6pcm->properties->bytes_per_frame;
@@ -149,12 +149,10 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	    (USB_INTERVALS_PER_SECOND / LINE6_ISO_INTERVAL);
 	struct urb *urb_out;
 
-	spin_lock_irqsave(&line6pcm->out.lock, flags);
 	index =
 	    find_first_zero_bit(&line6pcm->out.active_urbs, LINE6_ISO_BUFFERS);
 
 	if (index < 0 || index >= LINE6_ISO_BUFFERS) {
-		spin_unlock_irqrestore(&line6pcm->out.lock, flags);
 		dev_err(line6pcm->line6->ifcdev, "no free URB found\n");
 		return -EINVAL;
 	}
@@ -187,7 +185,6 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 
 	if (urb_size == 0) {
 		/* can't determine URB size */
-		spin_unlock_irqrestore(&line6pcm->out.lock, flags);
 		dev_err(line6pcm->line6->ifcdev, "driver bug: urb_size = 0\n");
 		return -EINVAL;
 	}
@@ -242,7 +239,8 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		       urb_out->transfer_buffer_length);
 	}
 
-	if (line6pcm->prev_fbuf != NULL) {
+	spin_lock_nested(&line6pcm->in.lock, SINGLE_DEPTH_NESTING);
+	if (line6pcm->prev_fbuf) {
 		if (line6pcm->flags & LINE6_BITS_PCM_IMPULSE) {
 			create_impulse_test_signal(line6pcm, urb_out,
 						   bytes_per_frame);
@@ -266,6 +264,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 						   bytes_per_frame);
 		}
 	}
+	spin_unlock(&line6pcm->in.lock);
 
 	ret = usb_submit_urb(urb_out, GFP_ATOMIC);
 
@@ -275,7 +274,6 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		dev_err(line6pcm->line6->ifcdev,
 			"URB out #%d submission failed (%d)\n", index, ret);
 
-	spin_unlock_irqrestore(&line6pcm->out.lock, flags);
 	return 0;
 }
 
@@ -284,15 +282,18 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 */
 int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
 {
-	int ret, i;
+	unsigned long flags;
+	int ret = 0, i;
 
+	spin_lock_irqsave(&line6pcm->out.lock, flags);
 	for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
 		ret = submit_audio_out_urb(line6pcm);
 		if (ret < 0)
-			return ret;
+			break;
 	}
 
-	return 0;
+	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
+	return ret;
 }
 
 /*
@@ -346,8 +347,6 @@ static void audio_out_callback(struct urb *urb)
 	if (test_and_clear_bit(index, &line6pcm->out.unlink_urbs))
 		shutdown = 1;
 
-	spin_unlock_irqrestore(&line6pcm->out.lock, flags);
-
 	if (!shutdown) {
 		submit_audio_out_urb(line6pcm);
 
@@ -356,10 +355,13 @@ static void audio_out_callback(struct urb *urb)
 			line6pcm->out.bytes += length;
 			if (line6pcm->out.bytes >= line6pcm->out.period) {
 				line6pcm->out.bytes %= line6pcm->out.period;
+				spin_unlock(&line6pcm->out.lock);
 				snd_pcm_period_elapsed(substream);
+				spin_lock(&line6pcm->out.lock);
 			}
 		}
 	}
+	spin_unlock_irqrestore(&line6pcm->out.lock, flags);
 }
 
 /* open playback callback */
-- 
2.2.2
