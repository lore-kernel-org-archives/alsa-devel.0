From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v4 02/12] ALSA: line6: Add high-speed USB
	support
Date: Sun, 18 Sep 2016 20:59:22 +0200
Message-ID: <1474225172-32081-3-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1474225172-32081-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 44D8B260A59
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 21:00:46 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id 133so11707958wmq.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 12:00:46 -0700 (PDT)
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

This has two parts:
* intervals_per_second setup
  (high speed needs 8000, instead of 1000)
* iso_buffers setup (count of iso buffers depends on
  USB speed, 2 is not enough for high speed)

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/capture.c  | 10 +++++++++-
 sound/usb/line6/driver.c   | 15 ++++++++++-----
 sound/usb/line6/driver.h   | 15 ++++++++++++---
 sound/usb/line6/pcm.h      |  6 ++----
 sound/usb/line6/playback.c |  2 +-
 5 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index e20a6bd..44e9a8c 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -181,7 +181,15 @@ static void audio_in_callback(struct urb *urb)
 
 		length += fsize;
 
-		/* the following assumes LINE6_ISO_PACKETS == 1: */
+		BUILD_BUG_ON_MSG(LINE6_ISO_PACKETS != 1,
+			"The following code assumes LINE6_ISO_PACKETS == 1");
+		/* TODO:
+		 * Also, if iso_buffers != 2, the prev frame is almost random at
+		 * playback side.
+		 * This needs to be redesigned. It should be "stable", but we may
+		 * experience sync problems on such high-speed configs.
+		 */
+
 		line6pcm->prev_fbuf = fbuf;
 		line6pcm->prev_fsize = fsize;
 
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 527c408..14032d9 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -462,14 +462,18 @@ static void line6_destruct(struct snd_card *card)
 static void line6_get_interval(struct usb_line6 *line6)
 {
 	struct usb_device *usbdev = line6->usbdev;
-	struct usb_host_endpoint *ep;
-	unsigned pipe = usb_rcvintpipe(usbdev, line6->properties->ep_ctrl_r);
-	unsigned epnum = usb_pipeendpoint(pipe);
+	struct usb_host_endpoint *ep = usbdev->ep_in[line6->properties->ep_ctrl_r];
 
-	ep = usbdev->ep_in[epnum];
-	line6->iso_buffers = LINE6_ISO_BUFFERS;
 	if (ep) {
 		line6->interval = ep->desc.bInterval;
+		if (usbdev->speed == USB_SPEED_LOW) {
+			line6->intervals_per_second = USB_LOW_INTERVALS_PER_SECOND;
+			line6->iso_buffers = USB_LOW_ISO_BUFFERS;
+		} else {
+			line6->intervals_per_second = USB_HIGH_INTERVALS_PER_SECOND;
+			line6->iso_buffers = USB_HIGH_ISO_BUFFERS;
+		}
+
 		line6->max_packet_size = le16_to_cpu(ep->desc.wMaxPacketSize);
 	} else {
 		dev_err(line6->ifcdev,
@@ -559,6 +563,7 @@ int line6_probe(struct usb_interface *interface,
 	/* query interface number */
 	interface_number = interface->cur_altsetting->desc.bInterfaceNumber;
 
+	/* TODO reserves the bus bandwidth even without actual transfer */
 	ret = usb_set_interface(usbdev, interface_number,
 				properties->altsetting);
 	if (ret < 0) {
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 43dd1d0..a55eb88 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -18,7 +18,13 @@
 
 #include "midi.h"
 
-#define USB_INTERVALS_PER_SECOND 1000
+/* USB 1.1 speed configuration */
+#define USB_LOW_INTERVALS_PER_SECOND 1000
+#define USB_LOW_ISO_BUFFERS 2
+
+/* USB 2.0+ speed configuration */
+#define USB_HIGH_INTERVALS_PER_SECOND 8000
+#define USB_HIGH_ISO_BUFFERS 16
 
 /* Fallback USB interval and max packet size values */
 #define LINE6_FALLBACK_INTERVAL 10
@@ -109,12 +115,15 @@ struct usb_line6 {
 	/* Properties */
 	const struct line6_properties *properties;
 
-	/* Interval (ms) */
+	/* Interval for data USB packets */
 	int interval;
+	/* ...for isochronous transfers framing */
+	int intervals_per_second;
+
 	/* Number of isochronous URBs used for frame transfers */
 	int iso_buffers;
 
-	/* Maximum size of USB packet */
+	/* Maximum size of data USB packet */
 	int max_packet_size;
 
 	/* Device representing the USB interface */
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index e983880..38bf4df 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -20,9 +20,6 @@
 
 #include "driver.h"
 
-/* number of URBs */
-#define LINE6_ISO_BUFFERS	2
-
 /*
 	number of USB frames per URB
 	The Line 6 Windows driver always transmits two frames per packet, but
@@ -31,7 +28,8 @@
 */
 #define LINE6_ISO_PACKETS	1
 
-/* in a "full speed" device (such as the PODxt Pro) this means 1ms */
+/* in a "full speed" device (such as the PODxt Pro) this means 1ms,
+   for "high speed" it's 1/8ms */
 #define LINE6_ISO_INTERVAL	1
 
 #define LINE6_IMPULSE_DEFAULT_PERIOD 100
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 7a52806..d53aad1 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -151,7 +151,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		line6pcm->properties->rates.rats[0].num_min;
 	const int frame_factor =
 		line6pcm->properties->rates.rats[0].den *
-		(USB_INTERVALS_PER_SECOND / LINE6_ISO_INTERVAL);
+		(line6pcm->line6->intervals_per_second / LINE6_ISO_INTERVAL);
 	struct urb *urb_out;
 
 	index = find_first_zero_bit(&line6pcm->out.active_urbs,
-- 
1.9.1
