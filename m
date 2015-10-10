From: maillist@superlative.org
Subject: [PATCH 1/1] Allow any MIDI endpoint to drive use of
	interrupt transfer on Roland devices
Date: Sat, 10 Oct 2015 19:59:01 +0100
Message-ID: <56195ffb.8ac9c20a.97c1e.ffffff8a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id F021126052B
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 20:59:08 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so108078304wic.0
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 11:59:08 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, "Keith A. Milner" <maillist@superlative.org>, "Keith A. Milner" <kamilner@superlative.org>
List-Id: alsa-devel@alsa-project.org

From: "Keith A. Milner" <kamilner@superlative.org>

Signed-off-by: Keith A. Milner <maillist@superlative.org>

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index b901f46..52b8c72 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1860,9 +1860,14 @@ static void snd_usbmidi_switch_roland_altsetting(struct snd_usb_midi* umidi)
 
 	hostif = &intf->altsetting[1];
 	intfd = get_iface_desc(hostif);
+	/* If either or both of the endpoints support interrupt transfer,
+	 * then use the alternate setting
+	 */
 	if (intfd->bNumEndpoints != 2 ||
-	    (get_endpoint(hostif, 0)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK ||
-	    (get_endpoint(hostif, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_INT)
+	    !((get_endpoint(hostif, 0)->bmAttributes
+	      & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT ||
+	    (get_endpoint(hostif, 1)->bmAttributes
+	      & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT))
 		return;
 
 	snd_printdd(KERN_INFO "switching to altsetting %d with int ep\n",
-- 
1.9.1
