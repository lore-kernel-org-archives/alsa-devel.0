From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 09/10] ALSA: usb-audio: clarify implicit fb
	quirk for Roland
Date: Fri, 19 Jul 2013 20:23:29 +0200
Message-ID: <1374258210-14486-10-git-send-email-eldad@fogrefinery.com>
References: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 260D52657DD
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:24:08 +0200 (CEST)
Received: by mail-ea0-f177.google.com with SMTP id j14so2522364eak.8
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 11:24:08 -0700 (PDT)
In-Reply-To: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Move the vendor ID check to the outside and also propogate
the error code.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 9f9639d..0704823 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -363,15 +363,20 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		alts = &iface->altsetting[1];
 		goto add_sync_ep;
 	}
-	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
-	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
-	    altsd->bInterfaceProtocol == 2 &&
-	    altsd->bNumEndpoints == 1 &&
-	    USB_ID_VENDOR(subs->stream->chip->usb_id) == 0x0582 /* Roland */ &&
-	    search_roland_implicit_fb(subs->dev, altsd->bInterfaceNumber + 1,
-				      altsd->bAlternateSetting,
-				      &alts, &ep) >= 0) {
-		goto add_sync_ep;
+
+	if (USB_ID_VENDOR(subs->stream->chip->usb_id) == 0x0582) { /* Roland */
+		if (attr == USB_ENDPOINT_SYNC_ASYNC &&
+		    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+		    altsd->bInterfaceProtocol == 2 &&
+		    altsd->bNumEndpoints == 1) {
+			int err = search_roland_implicit_fb(subs->dev, altsd->bInterfaceNumber + 1,
+							altsd->bAlternateSetting,
+						        &alts, &ep);
+			if (err < 0)
+				return err;
+
+			goto add_sync_ep;
+		}
 	}
 
 	/* No quirk */
-- 
1.8.1.5
