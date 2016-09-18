From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v4 01/12] ALSA: line6: Enable different number
	of URBs for frame transfers
Date: Sun, 18 Sep 2016 20:59:21 +0200
Message-ID: <1474225172-32081-2-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474225172-32081-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F3CB2614A0
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 21:00:44 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id 133so11707905wmq.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 12:00:44 -0700 (PDT)
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

This basically changes LINE6_ISO_BUFFERS constant to a configurable
iso_buffers property.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/capture.c  | 17 +++++++++++------
 sound/usb/line6/driver.c   |  1 +
 sound/usb/line6/driver.h   |  2 ++
 sound/usb/line6/pcm.c      | 23 +++++++++++++++--------
 sound/usb/line6/pcm.h      |  2 +-
 sound/usb/line6/playback.c | 19 ++++++++++++-------
 6 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index f518fbb..e20a6bd 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -29,10 +29,10 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 	int ret;
 	struct urb *urb_in;
 
-	index =
-	    find_first_zero_bit(&line6pcm->in.active_urbs, LINE6_ISO_BUFFERS);
+	index = find_first_zero_bit(&line6pcm->in.active_urbs,
+	                            line6pcm->line6->iso_buffers);
 
-	if (index < 0 || index >= LINE6_ISO_BUFFERS) {
+	if (index < 0 || index >= line6pcm->line6->iso_buffers) {
 		dev_err(line6pcm->line6->ifcdev, "no free URB found\n");
 		return -EINVAL;
 	}
@@ -73,7 +73,7 @@ int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm)
 {
 	int ret = 0, i;
 
-	for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
+	for (i = 0; i < line6pcm->line6->iso_buffers; ++i) {
 		ret = submit_audio_in_urb(line6pcm);
 		if (ret < 0)
 			break;
@@ -154,7 +154,7 @@ static void audio_in_callback(struct urb *urb)
 	line6pcm->in.last_frame = urb->start_frame;
 
 	/* find index of URB */
-	for (index = 0; index < LINE6_ISO_BUFFERS; ++index)
+	for (index = 0; index < line6pcm->line6->iso_buffers; ++index)
 		if (urb == line6pcm->in.urbs[index])
 			break;
 
@@ -247,8 +247,13 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 	struct usb_line6 *line6 = line6pcm->line6;
 	int i;
 
+	line6pcm->in.urbs = kzalloc(
+		sizeof(struct urb *) * line6->iso_buffers, GFP_KERNEL);
+	if (line6pcm->in.urbs == NULL)
+		return -ENOMEM;
+
 	/* create audio URBs and fill in constant values: */
-	for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
+	for (i = 0; i < line6->iso_buffers; ++i) {
 		struct urb *urb;
 
 		/* URB for audio in: */
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 81b7da8..527c408 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -467,6 +467,7 @@ static void line6_get_interval(struct usb_line6 *line6)
 	unsigned epnum = usb_pipeendpoint(pipe);
 
 	ep = usbdev->ep_in[epnum];
+	line6->iso_buffers = LINE6_ISO_BUFFERS;
 	if (ep) {
 		line6->interval = ep->desc.bInterval;
 		line6->max_packet_size = le16_to_cpu(ep->desc.wMaxPacketSize);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 7da643e..43dd1d0 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -111,6 +111,8 @@ struct usb_line6 {
 
 	/* Interval (ms) */
 	int interval;
+	/* Number of isochronous URBs used for frame transfers */
+	int iso_buffers;
 
 	/* Maximum size of USB packet */
 	int max_packet_size;
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 41aa335..6c9b7cf 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -104,7 +104,7 @@ static void line6_unlink_audio_urbs(struct snd_line6_pcm *line6pcm,
 {
 	int i;
 
-	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
+	for (i = 0; i < line6pcm->line6->iso_buffers; i++) {
 		if (test_bit(i, &pcms->active_urbs)) {
 			if (!test_and_set_bit(i, &pcms->unlink_urbs))
 				usb_unlink_urb(pcms->urbs[i]);
@@ -124,7 +124,7 @@ static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
 
 	do {
 		alive = 0;
-		for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
+		for (i = 0; i < line6pcm->line6->iso_buffers; i++) {
 			if (test_bit(i, &pcms->active_urbs))
 				alive++;
 		}
@@ -153,8 +153,9 @@ static int line6_buffer_acquire(struct snd_line6_pcm *line6pcm,
 {
 	/* Invoked multiple times in a row so allocate once only */
 	if (!test_and_set_bit(type, &pstr->opened) && !pstr->buffer) {
-		pstr->buffer = kmalloc(LINE6_ISO_BUFFERS * LINE6_ISO_PACKETS *
-				       line6pcm->max_packet_size, GFP_KERNEL);
+		pstr->buffer = kmalloc(line6pcm->line6->iso_buffers *
+                                      LINE6_ISO_PACKETS *
+                                      line6pcm->max_packet_size, GFP_KERNEL);
 		if (!pstr->buffer)
 			return -ENOMEM;
 	}
@@ -434,24 +435,30 @@ static struct snd_kcontrol_new line6_controls[] = {
 /*
 	Cleanup the PCM device.
 */
-static void cleanup_urbs(struct line6_pcm_stream *pcms)
+static void cleanup_urbs(struct line6_pcm_stream *pcms, int iso_buffers)
 {
 	int i;
 
-	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
+	/* Most likely impossible in current code... */
+	if (pcms->urbs == NULL)
+		return;
+
+	for (i = 0; i < iso_buffers; i++) {
 		if (pcms->urbs[i]) {
 			usb_kill_urb(pcms->urbs[i]);
 			usb_free_urb(pcms->urbs[i]);
 		}
 	}
+	kfree(pcms->urbs);
+	pcms->urbs = NULL;
 }
 
 static void line6_cleanup_pcm(struct snd_pcm *pcm)
 {
 	struct snd_line6_pcm *line6pcm = snd_pcm_chip(pcm);
 
-	cleanup_urbs(&line6pcm->out);
-	cleanup_urbs(&line6pcm->in);
+	cleanup_urbs(&line6pcm->out, line6pcm->line6->iso_buffers);
+	cleanup_urbs(&line6pcm->in, line6pcm->line6->iso_buffers);
 	kfree(line6pcm);
 }
 
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 508410a..e983880 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -90,7 +90,7 @@ struct line6_pcm_properties {
 
 struct line6_pcm_stream {
 	/* allocated URBs */
-	struct urb *urbs[LINE6_ISO_BUFFERS];
+	struct urb **urbs;
 
 	/* Temporary buffer;
 	 * Since the packet size is not known in advance, this buffer is
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 97ed593..7a52806 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -154,10 +154,10 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		(USB_INTERVALS_PER_SECOND / LINE6_ISO_INTERVAL);
 	struct urb *urb_out;
 
-	index =
-	    find_first_zero_bit(&line6pcm->out.active_urbs, LINE6_ISO_BUFFERS);
+	index = find_first_zero_bit(&line6pcm->out.active_urbs,
+	                            line6pcm->line6->iso_buffers);
 
-	if (index < 0 || index >= LINE6_ISO_BUFFERS) {
+	if (index < 0 || index >= line6pcm->line6->iso_buffers) {
 		dev_err(line6pcm->line6->ifcdev, "no free URB found\n");
 		return -EINVAL;
 	}
@@ -286,7 +286,7 @@ int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
 {
 	int ret = 0, i;
 
-	for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
+	for (i = 0; i < line6pcm->line6->iso_buffers; ++i) {
 		ret = submit_audio_out_urb(line6pcm);
 		if (ret < 0)
 			break;
@@ -313,11 +313,11 @@ static void audio_out_callback(struct urb *urb)
 	line6pcm->out.last_frame = urb->start_frame;
 
 	/* find index of URB */
-	for (index = 0; index < LINE6_ISO_BUFFERS; index++)
+	for (index = 0; index < line6pcm->line6->iso_buffers; index++)
 		if (urb == line6pcm->out.urbs[index])
 			break;
 
-	if (index >= LINE6_ISO_BUFFERS)
+	if (index >= line6pcm->line6->iso_buffers)
 		return;		/* URB has been unlinked asynchronously */
 
 	for (i = 0; i < LINE6_ISO_PACKETS; i++)
@@ -401,8 +401,13 @@ int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 	struct usb_line6 *line6 = line6pcm->line6;
 	int i;
 
+	line6pcm->out.urbs = kzalloc(
+		sizeof(struct urb *) * line6->iso_buffers, GFP_KERNEL);
+	if (line6pcm->out.urbs == NULL)
+		return -ENOMEM;
+
 	/* create audio URBs and fill in constant values: */
-	for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
+	for (i = 0; i < line6->iso_buffers; ++i) {
 		struct urb *urb;
 
 		/* URB for audio out: */
-- 
1.9.1
