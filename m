From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v3 06/12] ALSA: line6: Distinguish device init
	(ctrl EP) and MIDI data transfer (int EP)
Date: Fri, 16 Sep 2016 11:12:50 +0200
Message-ID: <1474017177-23769-7-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474017177-23769-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 70E152667DF
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 11:13:21 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id b184so2694931wma.3
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 02:13:21 -0700 (PDT)
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

POD X3 can initialize similarly to older PODs, but it doesn't have the MIDI
interface. Instead, configuration is done via proprietary bulk EP messages.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.c | 72 ++++++++++++++++++++++++++++++++++--------------
 sound/usb/line6/driver.h |  6 ++--
 sound/usb/line6/pod.c    |  9 +++++-
 sound/usb/line6/variax.c |  6 ++--
 4 files changed, 68 insertions(+), 25 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 14032d9..9b16777 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -66,10 +66,17 @@ static int line6_start_listen(struct usb_line6 *line6)
 {
 	int err;
 
-	usb_fill_int_urb(line6->urb_listen, line6->usbdev,
-		usb_rcvintpipe(line6->usbdev, line6->properties->ep_ctrl_r),
-		line6->buffer_listen, LINE6_BUFSIZE_LISTEN,
-		line6_data_received, line6, line6->interval);
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		usb_fill_int_urb(line6->urb_listen, line6->usbdev,
+			usb_rcvintpipe(line6->usbdev, line6->properties->ep_ctrl_r),
+			line6->buffer_listen, LINE6_BUFSIZE_LISTEN,
+			line6_data_received, line6, line6->interval);
+	} else {
+		usb_fill_bulk_urb(line6->urb_listen, line6->usbdev,
+			usb_rcvbulkpipe(line6->usbdev, line6->properties->ep_ctrl_r),
+			line6->buffer_listen, LINE6_BUFSIZE_LISTEN,
+			line6_data_received, line6);
+	}
 	line6->urb_listen->actual_length = 0;
 	err = usb_submit_urb(line6->urb_listen, GFP_ATOMIC);
 	return err;
@@ -90,6 +97,7 @@ static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
 				  int size)
 {
 	int i, done = 0;
+	const struct line6_properties *properties = line6->properties;
 
 	for (i = 0; i < size; i += line6->max_packet_size) {
 		int partial;
@@ -97,15 +105,21 @@ static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
 		int frag_size = min(line6->max_packet_size, size - i);
 		int retval;
 
-		retval = usb_interrupt_msg(line6->usbdev,
-					usb_sndintpipe(line6->usbdev,
-						line6->properties->ep_ctrl_w),
-					(char *)frag_buf, frag_size,
-					&partial, LINE6_TIMEOUT * HZ);
+		if (properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+			retval = usb_interrupt_msg(line6->usbdev,
+						usb_sndintpipe(line6->usbdev, properties->ep_ctrl_w),
+						(char *)frag_buf, frag_size,
+						&partial, LINE6_TIMEOUT * HZ);
+		} else {
+			retval = usb_bulk_msg(line6->usbdev,
+						usb_sndbulkpipe(line6->usbdev, properties->ep_ctrl_w),
+						(char *)frag_buf, frag_size,
+						&partial, LINE6_TIMEOUT * HZ);
+		}
 
 		if (retval) {
 			dev_err(line6->ifcdev,
-				"usb_interrupt_msg failed (%d)\n", retval);
+				"usb_bulk_msg failed (%d)\n", retval);
 			break;
 		}
 
@@ -140,10 +154,17 @@ static int line6_send_raw_message_async_part(struct message *msg,
 	int done = msg->done;
 	int bytes = min(msg->size - done, line6->max_packet_size);
 
-	usb_fill_int_urb(urb, line6->usbdev,
-		usb_sndintpipe(line6->usbdev, line6->properties->ep_ctrl_w),
-		(char *)msg->buffer + done, bytes,
-		line6_async_request_sent, msg, line6->interval);
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		usb_fill_int_urb(urb, line6->usbdev,
+			usb_sndintpipe(line6->usbdev, line6->properties->ep_ctrl_w),
+			(char *)msg->buffer + done, bytes,
+			line6_async_request_sent, msg, line6->interval);
+	} else {
+		usb_fill_bulk_urb(urb, line6->usbdev,
+			usb_sndbulkpipe(line6->usbdev, line6->properties->ep_ctrl_w),
+			(char *)msg->buffer + done, bytes,
+			line6_async_request_sent, msg);
+	}
 
 	msg->done += bytes;
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
@@ -462,7 +483,18 @@ static void line6_destruct(struct snd_card *card)
 static void line6_get_interval(struct usb_line6 *line6)
 {
 	struct usb_device *usbdev = line6->usbdev;
-	struct usb_host_endpoint *ep = usbdev->ep_in[line6->properties->ep_ctrl_r];
+	const struct line6_properties *properties = line6->properties;
+	int pipe;
+	struct usb_host_endpoint *ep;
+
+	if (properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		pipe =
+			usb_rcvintpipe(line6->usbdev, line6->properties->ep_ctrl_r);
+	} else {
+		pipe =
+			usb_rcvbulkpipe(line6->usbdev, line6->properties->ep_ctrl_r);
+	}
+	ep = usbdev->ep_in[usb_pipeendpoint(pipe)];
 
 	if (ep) {
 		line6->interval = ep->desc.bInterval;
@@ -483,7 +515,7 @@ static void line6_get_interval(struct usb_line6 *line6)
 	}
 }
 
-static int line6_init_cap_control(struct usb_line6 *line6)
+static int line6_init_cap_control_midi(struct usb_line6 *line6)
 {
 	int ret;
 
@@ -573,8 +605,8 @@ int line6_probe(struct usb_interface *interface,
 
 	line6_get_interval(line6);
 
-	if (properties->capabilities & LINE6_CAP_CONTROL) {
-		ret = line6_init_cap_control(line6);
+	if (properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		ret = line6_init_cap_control_midi(line6);
 		if (ret < 0)
 			goto error;
 	}
@@ -644,7 +676,7 @@ int line6_suspend(struct usb_interface *interface, pm_message_t message)
 
 	snd_power_change_state(line6->card, SNDRV_CTL_POWER_D3hot);
 
-	if (line6->properties->capabilities & LINE6_CAP_CONTROL)
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)
 		line6_stop_listen(line6);
 
 	if (line6pcm != NULL) {
@@ -663,7 +695,7 @@ int line6_resume(struct usb_interface *interface)
 {
 	struct usb_line6 *line6 = usb_get_intfdata(interface);
 
-	if (line6->properties->capabilities & LINE6_CAP_CONTROL)
+	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)
 		line6_start_listen(line6);
 
 	snd_power_change_state(line6->card, SNDRV_CTL_POWER_D0);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 0bcab38..d48c7d2 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -104,6 +104,8 @@ enum {
 	LINE6_CAP_HWMON =	1 << 2,
 	/* device requires output data when input is read */
 	LINE6_CAP_IN_NEEDS_OUT = 1 << 3,
+	/* device uses raw MIDI via USB (data endpoints) */
+	LINE6_CAP_CONTROL_MIDI = 1 << 4,
 };
 
 /*
@@ -142,10 +144,10 @@ struct usb_line6 {
 	/* Line 6 MIDI device data structure */
 	struct snd_line6_midi *line6midi;
 
-	/* URB for listening to PODxt Pro control endpoint */
+	/* URB for listening to POD data endpoint */
 	struct urb *urb_listen;
 
-	/* Buffer for listening to PODxt Pro control endpoint */
+	/* Buffer for listening to POD data endpoint */
 	unsigned char *buffer_listen;
 
 	/* Buffer for message to be processed */
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 36e7274..17aa616 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -475,6 +475,7 @@ static const struct line6_properties pod_properties_table[] = {
 		.id = "BassPODxt",
 		.name = "BassPODxt",
 		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI
 				| LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
 		.altsetting = 5,
@@ -487,6 +488,7 @@ static const struct line6_properties pod_properties_table[] = {
 		.id = "BassPODxtLive",
 		.name = "BassPODxt Live",
 		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI
 				| LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
 		.altsetting = 1,
@@ -499,6 +501,7 @@ static const struct line6_properties pod_properties_table[] = {
 		.id = "BassPODxtPro",
 		.name = "BassPODxt Pro",
 		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI
 				| LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
 		.altsetting = 5,
@@ -510,7 +513,8 @@ static const struct line6_properties pod_properties_table[] = {
 	[LINE6_POCKETPOD] = {
 		.id = "PocketPOD",
 		.name = "Pocket POD",
-		.capabilities	= LINE6_CAP_CONTROL,
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI,
 		.altsetting = 0,
 		.ep_ctrl_r = 0x82,
 		.ep_ctrl_w = 0x02,
@@ -520,6 +524,7 @@ static const struct line6_properties pod_properties_table[] = {
 		.id = "PODxt",
 		.name = "PODxt",
 		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI
 				| LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
 		.altsetting = 5,
@@ -532,6 +537,7 @@ static const struct line6_properties pod_properties_table[] = {
 		.id = "PODxtLive",
 		.name = "PODxt Live",
 		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI
 				| LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
 		.altsetting = 1,
@@ -544,6 +550,7 @@ static const struct line6_properties pod_properties_table[] = {
 		.id = "PODxtPro",
 		.name = "PODxt Pro",
 		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI
 				| LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
 		.altsetting = 5,
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index ddc23dd..0c4512d 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -259,7 +259,8 @@ static const struct line6_properties variax_properties_table[] = {
 	[LINE6_PODXTLIVE_VARIAX] = {
 		.id = "PODxtLive",
 		.name = "PODxt Live",
-		.capabilities	= LINE6_CAP_CONTROL,
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x86,
 		.ep_ctrl_w = 0x05,
@@ -269,7 +270,8 @@ static const struct line6_properties variax_properties_table[] = {
 	[LINE6_VARIAX] = {
 		.id = "Variax",
 		.name = "Variax Workbench",
-		.capabilities	= LINE6_CAP_CONTROL,
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_CONTROL_MIDI,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x82,
 		.ep_ctrl_w = 0x01,
-- 
1.9.1
