From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v4 03/12] ALSA: line6: Support assymetrical
	in/out configurations
Date: Sun, 18 Sep 2016 20:59:23 +0200
Message-ID: <1474225172-32081-4-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474225172-32081-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 783E22614A0
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 21:00:47 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id w84so4549203wmg.0
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 12:00:47 -0700 (PDT)
In-Reply-To: <1474225172-32081-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Splits max_packet_size to max_packet_size_in/out (e.g. for
different channel counts).

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/capture.c  | 10 +++++-----
 sound/usb/line6/pcm.c      | 33 +++++++++++++++++++--------------
 sound/usb/line6/pcm.h      |  5 +++--
 sound/usb/line6/playback.c |  2 +-
 4 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 44e9a8c..73cea26 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -44,13 +44,13 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 		struct usb_iso_packet_descriptor *fin =
 		    &urb_in->iso_frame_desc[i];
 		fin->offset = urb_size;
-		fin->length = line6pcm->max_packet_size;
-		urb_size += line6pcm->max_packet_size;
+		fin->length = line6pcm->max_packet_size_in;
+		urb_size += line6pcm->max_packet_size_in;
 	}
 
 	urb_in->transfer_buffer =
 	    line6pcm->in.buffer +
-	    index * LINE6_ISO_PACKETS * line6pcm->max_packet_size;
+	    index * LINE6_ISO_PACKETS * line6pcm->max_packet_size_in;
 	urb_in->transfer_buffer_length = urb_size;
 	urb_in->context = line6pcm;
 
@@ -173,10 +173,10 @@ static void audio_in_callback(struct urb *urb)
 		fbuf = urb->transfer_buffer + fin->offset;
 		fsize = fin->actual_length;
 
-		if (fsize > line6pcm->max_packet_size) {
+		if (fsize > line6pcm->max_packet_size_in) {
 			dev_err(line6pcm->line6->ifcdev,
 				"driver and/or device bug: packet too large (%d > %d)\n",
-				fsize, line6pcm->max_packet_size);
+				fsize, line6pcm->max_packet_size_in);
 		}
 
 		length += fsize;
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 6c9b7cf..31b68fa 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -146,16 +146,20 @@ get_stream(struct snd_line6_pcm *line6pcm, int direction)
 }
 
 /* allocate a buffer if not opened yet;
- * call this in line6pcm.state_change mutex
+ * call this in line6pcm.state_mutex
  */
 static int line6_buffer_acquire(struct snd_line6_pcm *line6pcm,
-				struct line6_pcm_stream *pstr, int type)
+				struct line6_pcm_stream *pstr, int direction, int type)
 {
+	const int pkt_size =
+		(direction == SNDRV_PCM_STREAM_PLAYBACK) ?
+			line6pcm->max_packet_size_out :
+			line6pcm->max_packet_size_in;
+
 	/* Invoked multiple times in a row so allocate once only */
 	if (!test_and_set_bit(type, &pstr->opened) && !pstr->buffer) {
 		pstr->buffer = kmalloc(line6pcm->line6->iso_buffers *
-                                      LINE6_ISO_PACKETS *
-                                      line6pcm->max_packet_size, GFP_KERNEL);
+		                       LINE6_ISO_PACKETS * pkt_size, GFP_KERNEL);
 		if (!pstr->buffer)
 			return -ENOMEM;
 	}
@@ -163,12 +167,11 @@ static int line6_buffer_acquire(struct snd_line6_pcm *line6pcm,
 }
 
 /* free a buffer if all streams are closed;
- * call this in line6pcm.state_change mutex
+ * call this in line6pcm.state_mutex
  */
 static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
 				 struct line6_pcm_stream *pstr, int type)
 {
-
 	clear_bit(type, &pstr->opened);
 	if (!pstr->opened) {
 		line6_wait_clear_audio_urbs(line6pcm, pstr);
@@ -195,6 +198,7 @@ static int line6_stream_start(struct snd_line6_pcm *line6pcm, int direction,
 		else
 			ret = line6_submit_audio_in_all_urbs(line6pcm);
 	}
+
 	if (ret < 0)
 		clear_bit(type, &pstr->running);
 	spin_unlock_irqrestore(&pstr->lock, flags);
@@ -290,7 +294,7 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type)
 	mutex_lock(&line6pcm->state_mutex);
 	for (dir = 0; dir < 2; dir++) {
 		pstr = get_stream(line6pcm, dir);
-		ret = line6_buffer_acquire(line6pcm, pstr, type);
+		ret = line6_buffer_acquire(line6pcm, pstr, dir, type);
 		if (ret < 0)
 			goto error;
 		if (!pstr->running)
@@ -335,7 +339,8 @@ int snd_line6_hw_params(struct snd_pcm_substream *substream,
 	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
 
 	mutex_lock(&line6pcm->state_mutex);
-	ret = line6_buffer_acquire(line6pcm, pstr, LINE6_STREAM_PCM);
+	ret = line6_buffer_acquire(line6pcm, pstr, substream->stream,
+	                           LINE6_STREAM_PCM);
 	if (ret < 0)
 		goto error;
 
@@ -530,12 +535,12 @@ int line6_init_pcm(struct usb_line6 *line6,
 	line6pcm->volume_monitor = 255;
 	line6pcm->line6 = line6;
 
-	/* Read and write buffers are sized identically, so choose minimum */
-	line6pcm->max_packet_size = min(
-			usb_maxpacket(line6->usbdev,
-				usb_rcvisocpipe(line6->usbdev, ep_read), 0),
-			usb_maxpacket(line6->usbdev,
-				usb_sndisocpipe(line6->usbdev, ep_write), 1));
+	line6pcm->max_packet_size_in =
+		usb_maxpacket(line6->usbdev,
+			usb_rcvisocpipe(line6->usbdev, ep_read), 0);
+	line6pcm->max_packet_size_out =
+		usb_maxpacket(line6->usbdev,
+			usb_sndisocpipe(line6->usbdev, ep_write), 1);
 
 	spin_lock_init(&line6pcm->out.lock);
 	spin_lock_init(&line6pcm->in.lock);
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 38bf4df..f408d15 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -155,11 +155,12 @@ struct snd_line6_pcm {
 	/* Previously captured frame (for software monitoring) */
 	unsigned char *prev_fbuf;
 
-	/* Size of previously captured frame (for software monitoring) */
+	/* Size of previously captured frame (for software monitoring/sync) */
 	int prev_fsize;
 
 	/* Maximum size of USB packet */
-	int max_packet_size;
+	int max_packet_size_in;
+	int max_packet_size_out;
 
 	/* PCM playback volume (left and right) */
 	int volume_playback[2];
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index d53aad1..7b2644f 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -195,7 +195,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	urb_frames = urb_size / bytes_per_frame;
 	urb_out->transfer_buffer =
 	    line6pcm->out.buffer +
-	    index * LINE6_ISO_PACKETS * line6pcm->max_packet_size;
+	    index * LINE6_ISO_PACKETS * line6pcm->max_packet_size_out;
 	urb_out->transfer_buffer_length = urb_size;
 	urb_out->context = line6pcm;
 
-- 
1.9.1
