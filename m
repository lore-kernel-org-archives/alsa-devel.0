From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: Add quirks for Playback Designs
	devices
Date: Tue,  4 Sep 2012 10:23:07 +0200
Message-ID: <1346746987-23548-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 675A7265241
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2012 10:23:17 +0200 (CEST)
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Playback Designs' USB devices have some hardware limitations on their
USB interface. In particular:

 - They need a 20ms delay after each class compliant request as the
   hardware ACKs the USB packets before the device is actually ready
   for the next command. Sending data immediately will result in buffer
   overflows in the hardware.
 - The devices send bogus feedback data at the start of each stream
   which confuse the feedback format auto-detection.

This patch introduces a new quirks hook that is called after each
control packet and which adds a delay for all devices that match
Playback Designs' USB VID for now.

In addition, it adds a counter to snd_usb_endpoint to drop received
packets on the floor. Another new quirks function that is called once
an endpoint is started initializes that counter for these devices on
their sync endpoint.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-and-tested-by: Andreas Koch <andreas@akdesigninc.com>
Supported-by: Demian Martin <demianm_1@yahoo.com>
---
 sound/usb/card.h     |  2 ++
 sound/usb/endpoint.c |  8 ++++++++
 sound/usb/helper.c   |  5 +++++
 sound/usb/quirks.c   | 24 ++++++++++++++++++++++++
 sound/usb/quirks.h   | 10 ++++++++++
 5 files changed, 49 insertions(+)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 2b9ffff..d9d2b5a 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -92,6 +92,8 @@ struct snd_usb_endpoint {
 	unsigned char silence_value;
 	unsigned int stride;
 	int iface, alt_idx;
+	int skip_packets;		/* quirks for devices to ignore the first n packets
+					   in a stream */
 
 	spinlock_t lock;
 	struct list_head list;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index d6e2bb4..a83a18d 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -31,6 +31,7 @@
 #include "card.h"
 #include "endpoint.h"
 #include "pcm.h"
+#include "quirks.h"
 
 #define EP_FLAG_ACTIVATED	0
 #define EP_FLAG_RUNNING		1
@@ -170,6 +171,11 @@ static void retire_inbound_urb(struct snd_usb_endpoint *ep,
 {
 	struct urb *urb = urb_ctx->urb;
 
+	if (unlikely(ep->skip_packets > 0)) {
+		ep->skip_packets--;
+		return;
+	}
+
 	if (ep->sync_slave)
 		snd_usb_handle_sync_urb(ep->sync_slave, ep, urb);
 
@@ -822,6 +828,8 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int can_sleep)
 	ep->unlink_mask = 0;
 	ep->phase = 0;
 
+	snd_usb_endpoint_start_quirk(ep);
+
 	/*
 	 * If this endpoint has a data endpoint as implicit feedback source,
 	 * don't start the urbs here. Instead, mark them all as available,
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index 9eed8f4..c1db28f 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -21,6 +21,7 @@
 
 #include "usbaudio.h"
 #include "helper.h"
+#include "quirks.h"
 
 /*
  * combine bytes and get an integer value
@@ -97,6 +98,10 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 		memcpy(data, buf, size);
 		kfree(buf);
 	}
+
+	snd_usb_ctl_msg_quirk(dev, pipe, request, requesttype,
+			      value, index, data, size);
+
 	return err;
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2781726..1eaacf1 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -761,3 +761,27 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	}
 }
 
+void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
+{
+	/*
+	 * "Playback Design" products send bogus feedback data at the start
+	 * of the stream. Ignore them.
+	 */
+	if ((le16_to_cpu(ep->chip->dev->descriptor.idVendor) == 0x23ba) &&
+	    ep->type == SND_USB_ENDPOINT_TYPE_SYNC)
+		ep->skip_packets = 4;
+}
+
+void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
+			   __u8 request, __u8 requesttype, __u16 value,
+			   __u16 index, void *data, __u16 size)
+{
+	/*
+	 * "Playback Design" products need a 20ms delay after each
+	 * class compliant request
+	 */
+	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x23ba) &&
+	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
+			mdelay(20);
+}
+
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 03e5e94..0ca9e91 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -1,6 +1,10 @@
 #ifndef __USBAUDIO_QUIRKS_H
 #define __USBAUDIO_QUIRKS_H
 
+struct audioformat;
+struct snd_usb_endpoint;
+struct snd_usb_substream;
+
 int snd_usb_create_quirk(struct snd_usb_audio *chip,
 			 struct usb_interface *iface,
 			 struct usb_driver *driver,
@@ -20,4 +24,10 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 int snd_usb_is_big_endian_format(struct snd_usb_audio *chip,
 				 struct audioformat *fp);
 
+void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep);
+
+void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
+			   __u8 request, __u8 requesttype, __u16 value,
+			   __u16 index, void *data, __u16 size);
+
 #endif /* __USBAUDIO_QUIRKS_H */
-- 
1.7.11.4
