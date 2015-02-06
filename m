From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 1/4] ALSA: line6: Add toneport_has_source_select()
Date: Fri,  6 Feb 2015 08:51:09 -0600
Message-ID: <1423234272-7348-2-git-send-email-chris@rorvick.com>
References: <1423234272-7348-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423234272-7348-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add a predicate for testing if the device supports source selection to
make the conditional logic around this a bit cleaner.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/toneport.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index b107cf4..de56180a 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -343,6 +343,20 @@ static void toneport_remove_leds(struct usb_line6_toneport *toneport)
 	}
 }
 
+static bool toneport_has_source_select(struct usb_line6_toneport *toneport)
+{
+	switch (toneport->type) {
+	case LINE6_TONEPORT_UX1:
+	case LINE6_TONEPORT_UX2:
+	case LINE6_PODSTUDIO_UX1:
+	case LINE6_PODSTUDIO_UX2:
+		return 1;
+
+	default:
+		return 0;
+	}
+}
+
 /*
 	Setup Toneport device.
 */
@@ -360,17 +374,10 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 	toneport_send_cmd(usbdev, 0x0301, 0x0000);
 
 	/* initialize source select: */
-	switch (toneport->type) {
-	case LINE6_TONEPORT_UX1:
-	case LINE6_TONEPORT_UX2:
-	case LINE6_PODSTUDIO_UX1:
-	case LINE6_PODSTUDIO_UX2:
+	if (toneport_has_source_select(toneport))
 		toneport_send_cmd(usbdev,
 				  toneport_source_info[toneport->source].code,
 				  0x0000);
-	default:
-		break;
-	}
 
 	if (toneport_has_led(toneport->type))
 		toneport_update_led(toneport);
@@ -421,20 +428,13 @@ static int toneport_init(struct usb_line6 *line6,
 		return err;
 
 	/* register source select control: */
-	switch (toneport->type) {
-	case LINE6_TONEPORT_UX1:
-	case LINE6_TONEPORT_UX2:
-	case LINE6_PODSTUDIO_UX1:
-	case LINE6_PODSTUDIO_UX2:
+	if (toneport_has_source_select(toneport)) {
 		err =
 		    snd_ctl_add(line6->card,
 				snd_ctl_new1(&toneport_control_source,
 					     line6->line6pcm));
 		if (err < 0)
 			return err;
-
-	default:
-		break;
 	}
 
 	line6_read_serial_number(line6, &toneport->serial_number);
-- 
2.1.0
