From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v3 07/12] ALSA: line6: Allow processing of raw
	incoming messages
Date: Fri, 16 Sep 2016 11:12:51 +0200
Message-ID: <1474017177-23769-8-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474017177-23769-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id B044A265B3E
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 11:13:22 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id l132so1524603wmf.1
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 02:13:22 -0700 (PDT)
In-Reply-To: <1474017177-23769-1-git-send-email-dev@andree.sk>
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

Not all PODs use MIDI via USB data interface, thus allow avoiding
that code and instead using direct processing.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.c | 59 ++++++++++++++++++++++++++++--------------------
 sound/usb/line6/driver.h |  8 ++++---
 sound/usb/line6/midi.c   |  2 +-
 3 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 9b16777..853a143 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -290,26 +290,31 @@ static void line6_data_received(struct urb *urb)
 	if (urb->status == -ESHUTDOWN)
 		return;
 
-	done =
-	    line6_midibuf_write(mb, urb->transfer_buffer, urb->actual_length);
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		done =
+			line6_midibuf_write(mb, urb->transfer_buffer, urb->actual_length);
 
-	if (done < urb->actual_length) {
-		line6_midibuf_ignore(mb, done);
-		dev_dbg(line6->ifcdev, "%d %d buffer overflow - message skipped\n",
-			done, urb->actual_length);
-	}
+		if (done < urb->actual_length) {
+			line6_midibuf_ignore(mb, done);
+			dev_dbg(line6->ifcdev, "%d %d buffer overflow - message skipped\n",
+				done, urb->actual_length);
+		}
 
-	for (;;) {
-		done =
-		    line6_midibuf_read(mb, line6->buffer_message,
-				       LINE6_MESSAGE_MAXLEN);
+		for (;;) {
+			done =
+				line6_midibuf_read(mb, line6->buffer_message,
+						LINE6_MESSAGE_MAXLEN);
 
-		if (done == 0)
-			break;
+			if (done == 0)
+				break;
 
-		line6->message_length = done;
-		line6_midi_receive(line6, line6->buffer_message, done);
+			line6->message_length = done;
+			line6_midi_receive(line6, line6->buffer_message, done);
 
+			if (line6->process_message)
+				line6->process_message(line6);
+		}
+	} else {
 		if (line6->process_message)
 			line6->process_message(line6);
 	}
@@ -469,7 +474,9 @@ static void line6_destruct(struct snd_card *card)
 	struct usb_device *usbdev = line6->usbdev;
 
 	/* free buffer memory first: */
-	kfree(line6->buffer_message);
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)
+		kfree(line6->buffer_message);
+
 	kfree(line6->buffer_listen);
 
 	/* then free URBs: */
@@ -515,7 +522,7 @@ static void line6_get_interval(struct usb_line6 *line6)
 	}
 }
 
-static int line6_init_cap_control_midi(struct usb_line6 *line6)
+static int line6_init_cap_control(struct usb_line6 *line6)
 {
 	int ret;
 
@@ -524,14 +531,16 @@ static int line6_init_cap_control_midi(struct usb_line6 *line6)
 	if (!line6->buffer_listen)
 		return -ENOMEM;
 
-	line6->buffer_message = kmalloc(LINE6_MESSAGE_MAXLEN, GFP_KERNEL);
-	if (!line6->buffer_message)
-		return -ENOMEM;
-
 	line6->urb_listen = usb_alloc_urb(0, GFP_KERNEL);
 	if (!line6->urb_listen)
 		return -ENOMEM;
 
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		line6->buffer_message = kmalloc(LINE6_MESSAGE_MAXLEN, GFP_KERNEL);
+		if (!line6->buffer_message)
+			return -ENOMEM;
+	}
+
 	ret = line6_start_listen(line6);
 	if (ret < 0) {
 		dev_err(line6->ifcdev, "cannot start listening: %d\n", ret);
@@ -605,8 +614,8 @@ int line6_probe(struct usb_interface *interface,
 
 	line6_get_interval(line6);
 
-	if (properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		ret = line6_init_cap_control_midi(line6);
+	if (properties->capabilities & LINE6_CAP_CONTROL) {
+		ret = line6_init_cap_control(line6);
 		if (ret < 0)
 			goto error;
 	}
@@ -676,7 +685,7 @@ int line6_suspend(struct usb_interface *interface, pm_message_t message)
 
 	snd_power_change_state(line6->card, SNDRV_CTL_POWER_D3hot);
 
-	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL)
 		line6_stop_listen(line6);
 
 	if (line6pcm != NULL) {
@@ -695,7 +704,7 @@ int line6_resume(struct usb_interface *interface)
 {
 	struct usb_line6 *line6 = usb_get_intfdata(interface);
 
-	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL)
 		line6_start_listen(line6);
 
 	snd_power_change_state(line6->card, SNDRV_CTL_POWER_D0);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index d48c7d2..d7eefe1 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -147,15 +147,17 @@ struct usb_line6 {
 	/* URB for listening to POD data endpoint */
 	struct urb *urb_listen;
 
-	/* Buffer for listening to POD data endpoint */
+	/* Buffer for incoming data from POD data endpoint */
 	unsigned char *buffer_listen;
 
-	/* Buffer for message to be processed */
+	/* Buffer for message to be processed, generated from MIDI layer */
 	unsigned char *buffer_message;
 
-	/* Length of message to be processed */
+	/* Length of message to be processed, generated from MIDI layer  */
 	int message_length;
 
+	/* If MIDI is supported, buffer_message contains the pre-processed data;
+	 * otherwise the data is only in urb_listen (buffer_incoming). */
 	void (*process_message)(struct usb_line6 *);
 	void (*disconnect)(struct usb_line6 *line6);
 };
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index cebea9b..d0fb2f2 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -258,7 +258,7 @@ int line6_init_midi(struct usb_line6 *line6)
 	struct snd_rawmidi *rmidi;
 	struct snd_line6_midi *line6midi;
 
-	if (!(line6->properties->capabilities & LINE6_CAP_CONTROL)) {
+	if (!(line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)) {
 		/* skip MIDI initialization and report success */
 		return 0;
 	}
-- 
1.9.1
