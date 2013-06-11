From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem using alsa to implement an Android dock
Date: Tue, 11 Jun 2013 21:44:18 +0200
Message-ID: <51B77E12.7000101@ladisch.de>
References: <312118621.168631.1370854985139.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 90C17261AD1
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 21:44:25 +0200 (CEST)
In-Reply-To: <312118621.168631.1370854985139.JavaMail.root@openwide.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please try this patch:


ALSA: usb-audio: work around Anroid accessory firmware bug

When the Android firmware enables the audio interfaces in accessory
mode, it always declares in the control interface's baInterfaceNr array
that interfaces 0 and 1 belong to the audio function.  However, the
accessory interface itself, if also enabled, already is at index 0 and
shifts the actual audio interface numbers to 1 and 2, which prevents the
PCM streaming interface from being seen by the host driver.

To get the PCM interface interface to work, detect when the descriptors
point to the (for this driver useless) accessory interface, and redirect
to the correct one.

Reported-by: Jeremy Rosen <jeremy.rosen@openwide.fr>
Not-yet-tested-by: Jeremy Rosen <jeremy.rosen@openwide.fr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/card.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 563854a..f7a38ec 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -148,14 +148,31 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 		return -EINVAL;
 	}

+	alts = &iface->altsetting[0];
+	altsd = get_iface_desc(alts);
+
+	/*
+	 * Android with both accessory and audio interfaces enabled gets the
+	 * interface numbers wrong.
+	 */
+	if ((chip->usb_id == USB_ID(0x18d1, 0x2d04) ||
+	     chip->usb_id == USB_ID(0x18d1, 0x2d05)) &&
+	    interface == 0 &&
+	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+	    altsd->bInterfaceSubClass == USB_SUBCLASS_VENDOR_SPEC) {
+		iface = usb_ifnum_to_if(dev, 2);
+		if (!iface)
+			return -EINVAL;
+		alts = &iface->altsetting[0];
+		altsd = get_iface_desc(alts);
+	}
+
 	if (usb_interface_claimed(iface)) {
 		snd_printdd(KERN_INFO "%d:%d:%d: skipping, already claimed\n",
 						dev->devnum, ctrlif, interface);
 		return -EINVAL;
 	}

-	alts = &iface->altsetting[0];
-	altsd = get_iface_desc(alts);
 	if ((altsd->bInterfaceClass == USB_CLASS_AUDIO ||
 	     altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
 	    altsd->bInterfaceSubClass == USB_SUBCLASS_MIDISTREAMING) {
