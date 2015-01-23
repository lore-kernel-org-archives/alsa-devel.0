From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/16] ALSA: line6: Minor refactoring
Date: Fri, 23 Jan 2015 18:13:08 +0100
Message-ID: <1422033203-23254-2-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 92EF52654F1
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:41 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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

Split some codes in the lengthy line6_probe().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 94 +++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index e7f9a99e1949..b783c0788e45 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -448,6 +448,52 @@ static void line6_destruct(struct snd_card *card)
 	usb_put_dev(usbdev);
 }
 
+/* get data from endpoint descriptor (see usb_maxpacket): */
+static void line6_get_interval(struct usb_line6 *line6)
+{
+	struct usb_device *usbdev = line6->usbdev;
+	struct usb_host_endpoint *ep;
+	unsigned pipe = usb_rcvintpipe(usbdev, line6->properties->ep_ctrl_r);
+	unsigned epnum = usb_pipeendpoint(pipe);
+
+	ep = usbdev->ep_in[epnum];
+	if (ep) {
+		line6->interval = ep->desc.bInterval;
+		line6->max_packet_size = le16_to_cpu(ep->desc.wMaxPacketSize);
+	} else {
+		dev_err(line6->ifcdev,
+			"endpoint not available, using fallback values");
+		line6->interval = LINE6_FALLBACK_INTERVAL;
+		line6->max_packet_size = LINE6_FALLBACK_MAXPACKETSIZE;
+	}
+}
+
+static int line6_init_cap_control(struct usb_line6 *line6)
+{
+	int ret;
+
+	/* initialize USB buffers: */
+	line6->buffer_listen = kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
+	if (!line6->buffer_listen)
+		return -ENOMEM;
+
+	line6->buffer_message = kmalloc(LINE6_MESSAGE_MAXLEN, GFP_KERNEL);
+	if (!line6->buffer_message)
+		return -ENOMEM;
+
+	line6->urb_listen = usb_alloc_urb(0, GFP_KERNEL);
+	if (!line6->urb_listen)
+		return -ENOMEM;
+
+	ret = line6_start_listen(line6);
+	if (ret < 0) {
+		dev_err(line6->ifcdev, "cannot start listening: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
 	Probe USB device.
 */
@@ -485,24 +531,7 @@ int line6_probe(struct usb_interface *interface,
 	line6->usbdev = usbdev;
 	line6->ifcdev = &interface->dev;
 
-	/* get data from endpoint descriptor (see usb_maxpacket): */
-	{
-		struct usb_host_endpoint *ep;
-		unsigned pipe = usb_rcvintpipe(usbdev, properties->ep_ctrl_r);
-		unsigned epnum = usb_pipeendpoint(pipe);
-		ep = usbdev->ep_in[epnum];
-
-		if (ep != NULL) {
-			line6->interval = ep->desc.bInterval;
-			line6->max_packet_size =
-			    le16_to_cpu(ep->desc.wMaxPacketSize);
-		} else {
-			line6->interval = LINE6_FALLBACK_INTERVAL;
-			line6->max_packet_size = LINE6_FALLBACK_MAXPACKETSIZE;
-			dev_err(line6->ifcdev,
-				"endpoint not available, using fallback values");
-		}
-	}
+	line6_get_interval(line6);
 
 	ret = snd_card_new(line6->ifcdev,
 			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
@@ -525,34 +554,9 @@ int line6_probe(struct usb_interface *interface,
 	usb_get_dev(usbdev);
 
 	if (properties->capabilities & LINE6_CAP_CONTROL) {
-		/* initialize USB buffers: */
-		line6->buffer_listen =
-		    kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
-		if (line6->buffer_listen == NULL) {
-			ret = -ENOMEM;
-			goto err_destruct;
-		}
-
-		line6->buffer_message =
-		    kmalloc(LINE6_MESSAGE_MAXLEN, GFP_KERNEL);
-		if (line6->buffer_message == NULL) {
-			ret = -ENOMEM;
+		ret = line6_init_cap_control(line6);
+		if (ret < 0)
 			goto err_destruct;
-		}
-
-		line6->urb_listen = usb_alloc_urb(0, GFP_KERNEL);
-
-		if (line6->urb_listen == NULL) {
-			ret = -ENOMEM;
-			goto err_destruct;
-		}
-
-		ret = line6_start_listen(line6);
-		if (ret < 0) {
-			dev_err(&interface->dev, "%s: usb_submit_urb failed\n",
-				__func__);
-			goto err_destruct;
-		}
 	}
 
 	/* initialize device data based on device: */
-- 
2.2.2
