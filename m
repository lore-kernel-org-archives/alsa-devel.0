From: maillist@superlative.org
Subject: [RESEND PATCH 1/1] Allow any MIDI endpoint to drive
	use of interrupt transfer on newer Roland devices
Date: Sun, 11 Oct 2015 15:19:48 +0100
Message-ID: <561a700d.04dfc20a.4d7e9.5ab3@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id EF03D2606A5
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 16:19:58 +0200 (CEST)
Received: by wijq8 with SMTP id q8so24383879wij.0
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 07:19:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Keith A. Milner" <maillist@superlative.org>
List-Id: alsa-devel@alsa-project.org

From: "Keith A. Milner" <maillist@superlative.org>

This patch enables interrupt transfer mode for MIDI ports on newer
Boss/Roland devices such as the GT-100/001 which support interrupt
transfer on both IN and OUT MIDI endpoints. Previously this wasn't being
enabled for these devices as the code was specifically looking for the
scenario where the IN endpoint supported interrupt transfer and the OUT
endpoint was bulk transfer. Newer devices support interrupt transfer for
both endpoints.

This has been tested on Boss devices GT-001, BR-80 and JS-8 and Roland
VS-20.

It would benefit from some regresison testing with other devices if
possible.

Signed-off-by: Keith A. Milner <maillist@superlative.org>

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index b901f46..d50c649 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1860,9 +1860,14 @@ static void snd_usbmidi_switch_roland_altsetting(struct snd_usb_midi* umidi)
 
 	hostif = &intf->altsetting[1];
 	intfd = get_iface_desc(hostif);
+       /* If either or both of the endpoints support interrupt transfer,
+        * then use the alternate setting
+        */
 	if (intfd->bNumEndpoints != 2 ||
-	    (get_endpoint(hostif, 0)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK ||
-	    (get_endpoint(hostif, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_INT)
+	     !((get_endpoint(hostif, 0)->bmAttributes
+			& USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT ||
+	      (get_endpoint(hostif, 1)->bmAttributes
+			& USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT))
 		return;
 
 	snd_printdd(KERN_INFO "switching to altsetting %d with int ep\n",
-- 
1.9.1
