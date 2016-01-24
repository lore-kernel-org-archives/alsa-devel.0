From: Guillaume Fougnies <guillaume@eulerian.com>
Subject: [PATCH] teac ud-501/ud-503 usb delay
Date: Sun, 24 Jan 2016 17:36:17 +0100
Message-ID: <20160124163617.GE4388@eulerian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.eulerian.com (mail.eulerian.com [109.232.193.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 172F6260670
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2016 17:34:42 +0100 (CET)
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


Hello,

This is a small patch against sound/usb/quirks.c to correct "Teac
Corp." products delay.
Tested on Teac UD-501 and UD-503 products, could not harm other
Teac products.
It corrects the "clock source 41 is not valid, cannot use" error
for both devices.
And more critically on the new UD-503, a complete freeze of the
teac usb interface when switching between different rate/format.
(Freeze only solved by a power switch of the device...)

The patch matches the problem of the "Playback Design" products. I just
refactored a bit the code to include Teac products properly.

Regards,
Guillaume


---
 sound/usb/quirks.c | 58 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 23ea6d8..f3faaef 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1202,40 +1202,48 @@ void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 void snd_usb_set_interface_quirk(struct usb_device *dev)
 {
 	/*
-	 * "Playback Design" products need a 50ms delay after setting the
+	 * Products needing a 50ms delay after setting the
 	 * USB interface.
 	 */
-	if (le16_to_cpu(dev->descriptor.idVendor) == 0x23ba)
-		mdelay(50);
+	switch (le16_to_cpu(dev->descriptor.idVendor)) {
+		case 0x23ba: /* Playback Design */
+		case 0x0644: /* TEAC Corp. */
+			mdelay(50);
+	}
 }
 
 void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size)
 {
-	/*
-	 * "Playback Design" products need a 20ms delay after each
-	 * class compliant request
-	 */
-	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x23ba) &&
-	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(20);
-
-	/* Marantz/Denon devices with USB DAC functionality need a delay
-	 * after each class compliant request
-	 */
-	if (is_marantz_denon_dac(USB_ID(le16_to_cpu(dev->descriptor.idVendor),
-					le16_to_cpu(dev->descriptor.idProduct)))
-	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(20);
+	if ((requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS) {
+		switch (le16_to_cpu(dev->descriptor.idVendor)) {
+			/*
+			 * "Playback Design"/"TEAC Corp." products need a 20ms delay after each
+			 * class compliant request
+			 */
+			case 0x23ba: /* "Playback Design" */
+			case 0x0644: /* TEAC Corp. */
+				mdelay(20);
+				return;
+
+				/* Zoom R16/24 needs a tiny delay here, otherwise requests like
+				 * get/set frequency return as failed despite actually succeeding.
+				 */
+			case 0x1686:
+				/* restrict to 0x00dd */
+				if (le16_to_cpu(dev->descriptor.idProduct) == 0x00dd)
+					mdelay(1);
+				return;
+		}
 
-	/* Zoom R16/24 needs a tiny delay here, otherwise requests like
-	 * get/set frequency return as failed despite actually succeeding.
-	 */
-	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x1686) &&
-	    (le16_to_cpu(dev->descriptor.idProduct) == 0x00dd) &&
-	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(1);
+		/* Marantz/Denon devices with USB DAC functionality need a delay
+		 * after each class compliant request
+		 */
+		if (is_marantz_denon_dac(USB_ID(le16_to_cpu(dev->descriptor.idVendor),
+						le16_to_cpu(dev->descriptor.idProduct))))
+			mdelay(20);
+	}
 }
 
 /*
-- 
2.6.4
