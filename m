From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] more Yamaha USB MIDI quirks
Date: Tue, 03 Dec 2002 09:27:49 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212030922321.17800-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


quirks for the Yamaha TYROS, PF-500, S90, DME32, DM2000, 02R96


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.7
diff -u -r1.7 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	28 Oct 2002 11:57:41 -0000	1.7
+++ alsa-kernel/usb/usbquirks.h	3 Dec 2002 08:17:07 -0000
@@ -161,6 +161,60 @@
 		.type = QUIRK_MIDI_YAMAHA
 	}
 },
+{
+	USB_DEVICE(0x0499, 0x1012),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Yamaha",
+		.product_name = "TYROS",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_YAMAHA
+	}
+},
+{
+	USB_DEVICE(0x0499, 0x1013),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Yamaha",
+		.product_name = "PF-500",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_YAMAHA
+	}
+},
+{
+	USB_DEVICE(0x0499, 0x1014),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Yamaha",
+		.product_name = "S90",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_YAMAHA
+	}
+},
+{
+	USB_DEVICE(0x0499, 0x5002),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Yamaha",
+		.product_name = "DME32",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_YAMAHA
+	}
+},
+{
+	USB_DEVICE(0x0499, 0x5003),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Yamaha",
+		.product_name = "DM2000",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_YAMAHA
+	}
+},
+{
+	USB_DEVICE(0x0499, 0x5004),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Yamaha",
+		.product_name = "02R96",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_YAMAHA
+	}
+},

 /*
  * Once upon a time people thought, "Wouldn't it be nice if there was a



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
