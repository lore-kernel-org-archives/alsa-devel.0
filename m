From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH] ALSA: line6: Always setup isochronous transfer
	properties
Date: Mon,  6 Feb 2017 20:34:58 +0100
Message-ID: <1486409698-32147-1-git-send-email-dev@andree.sk>
References: <s5h1svb7ewb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AD862654AD
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 20:35:14 +0100 (CET)
Received: by mail-wr0-f193.google.com with SMTP id k90so3644952wrc.3
 for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2017 11:35:14 -0800 (PST)
In-Reply-To: <s5h1svb7ewb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Igor Zinovev <zinigor@gmail.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

While not all line6 devices currently support PCM, it causes no
harm to 'have it prepared'.

This also fixes toneport, which only has PCM - in which case
we previously skipped the USB transfer properties detection completely.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.c | 49 ++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 90009c0..0ff5a7d 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -492,42 +492,46 @@ static void line6_destruct(struct snd_card *card)
 	usb_put_dev(usbdev);
 }
 
-/* get data from endpoint descriptor (see usb_maxpacket): */
-static void line6_get_interval(struct usb_line6 *line6)
+static void line6_get_usb_properties(struct usb_line6 *line6)
 {
 	struct usb_device *usbdev = line6->usbdev;
 	const struct line6_properties *properties = line6->properties;
 	int pipe;
-	struct usb_host_endpoint *ep;
+	struct usb_host_endpoint *ep = NULL;
 
-	if (properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		pipe =
-			usb_rcvintpipe(line6->usbdev, line6->properties->ep_ctrl_r);
-	} else {
-		pipe =
-			usb_rcvbulkpipe(line6->usbdev, line6->properties->ep_ctrl_r);
+	if (properties->capabilities & LINE6_CAP_CONTROL) {
+		if (properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+			pipe = usb_rcvintpipe(line6->usbdev,
+				line6->properties->ep_ctrl_r);
+		} else {
+			pipe = usb_rcvbulkpipe(line6->usbdev,
+				line6->properties->ep_ctrl_r);
+		}
+		ep = usbdev->ep_in[usb_pipeendpoint(pipe)];
 	}
-	ep = usbdev->ep_in[usb_pipeendpoint(pipe)];
 
+	/* Control data transfer properties */
 	if (ep) {
 		line6->interval = ep->desc.bInterval;
-		if (usbdev->speed == USB_SPEED_LOW) {
-			line6->intervals_per_second = USB_LOW_INTERVALS_PER_SECOND;
-			line6->iso_buffers = USB_LOW_ISO_BUFFERS;
-		} else {
-			line6->intervals_per_second = USB_HIGH_INTERVALS_PER_SECOND;
-			line6->iso_buffers = USB_HIGH_ISO_BUFFERS;
-		}
-
 		line6->max_packet_size = le16_to_cpu(ep->desc.wMaxPacketSize);
 	} else {
-		dev_err(line6->ifcdev,
-			"endpoint not available, using fallback values");
+		if (properties->capabilities & LINE6_CAP_CONTROL) {
+			dev_err(line6->ifcdev,
+				"endpoint not available, using fallback values");
+		}
 		line6->interval = LINE6_FALLBACK_INTERVAL;
 		line6->max_packet_size = LINE6_FALLBACK_MAXPACKETSIZE;
 	}
-}
 
+	/* Isochronous transfer properties */
+	if (usbdev->speed == USB_SPEED_LOW) {
+		line6->intervals_per_second = USB_LOW_INTERVALS_PER_SECOND;
+		line6->iso_buffers = USB_LOW_ISO_BUFFERS;
+	} else {
+		line6->intervals_per_second = USB_HIGH_INTERVALS_PER_SECOND;
+		line6->iso_buffers = USB_HIGH_ISO_BUFFERS;
+	}
+}
 
 /* Enable buffering of incoming messages, flush the buffer */
 static int line6_hwdep_open(struct snd_hwdep *hw, struct file *file)
@@ -754,8 +758,9 @@ int line6_probe(struct usb_interface *interface,
 		goto error;
 	}
 
+	line6_get_usb_properties(line6);
+
 	if (properties->capabilities & LINE6_CAP_CONTROL) {
-		line6_get_interval(line6);
 		ret = line6_init_cap_control(line6);
 		if (ret < 0)
 			goto error;
-- 
2.7.4
