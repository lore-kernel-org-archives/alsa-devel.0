From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v2 6/9] ALSA: line6: Allow bulk endpoints
	instead of interrupt endpoints
Date: Fri, 19 Aug 2016 00:20:36 +0200
Message-ID: <1471558839-14120-7-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1471558839-14120-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B119226650A
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 00:21:46 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id i5so1278141wmg.2
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 15:21:46 -0700 (PDT)
In-Reply-To: <1471558839-14120-1-git-send-email-dev@andree.sk>
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

Some PODs (e.g. POD X3) have bulk instead of interrupt endpoints for
data transfer.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.c | 63 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 5fd6cad..9b16777 100644
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
@@ -462,7 +483,19 @@ static void line6_destruct(struct snd_card *card)
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
+
 	if (ep) {
 		line6->interval = ep->desc.bInterval;
 		if (usbdev->speed == USB_SPEED_LOW) {
-- 
1.9.1
