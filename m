From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ALSA: usb-audio: fix automatic Roland/Yamaha
	MIDI detection
Date: Sun, 11 Aug 2013 14:13:13 +0200
Message-ID: <52077FD9.6060404@ladisch.de>
References: <51CC9D8B.7060601@ladisch.de> <4161390.DqJ0fEoIrV@kamdesktop>
 <52053269.2050706@ladisch.de> <2663331.bA47oXYmkZ@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id CDFD9261B31
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 14:13:37 +0200 (CEST)
In-Reply-To: <2663331.bA47oXYmkZ@kamdesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Keith A. Milner" <maillist@superlative.org>
List-Id: alsa-devel@alsa-project.org

Commit aafe77cc45a5 (ALSA: usb-audio: add support for many Roland/Yamaha
devices) had several logic errors that prevented create_auto_midi_quirk
from enumerating any MIDI ports.

Reported-by: Keith A. Milner <maillist@superlative.org>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/quirks.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -319,19 +319,19 @@ static int create_auto_midi_quirk(struct snd_usb_audio *chip,
 	if (altsd->bNumEndpoints < 1)
 		return -ENODEV;
 	epd = get_endpoint(alts, 0);
-	if (!usb_endpoint_xfer_bulk(epd) ||
+	if (!usb_endpoint_xfer_bulk(epd) &&
 	    !usb_endpoint_xfer_int(epd))
 		return -ENODEV;

 	switch (USB_ID_VENDOR(chip->usb_id)) {
 	case 0x0499: /* Yamaha */
 		err = create_yamaha_midi_quirk(chip, iface, driver, alts);
-		if (err < 0 && err != -ENODEV)
+		if (err != -ENODEV)
 			return err;
 		break;
 	case 0x0582: /* Roland */
 		err = create_roland_midi_quirk(chip, iface, driver, alts);
-		if (err < 0 && err != -ENODEV)
+		if (err != -ENODEV)
 			return err;
 		break;
 	}
