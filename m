From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] MidiSport 8x8 Rev1.05 and MOTU Fastlane support
Date: Fri, 21 Feb 2003 14:13:13 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302211352360.22925-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


This adds a quirk for revision 1.05 of the 8x8, which uses a different
product id when the firmware is loaded.

And a quirk for the MOTU Fastlane (stolen from Nagano Daisuke's OSS
driver).


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.16
diff -u -r1.16 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	13 Feb 2003 17:18:10 -0000	1.16
+++ alsa-kernel/usb/usbquirks.h	21 Feb 2003 12:51:54 -0000
@@ -639,6 +639,24 @@
 	}
 },
 {
+	/*
+	 * For hardware revision 1.05; in the later revisions (1.10 and
+	 * 1.21), 0x1031 is the ID for the device without firmware.
+	 * Thanks to Olaf Giesbrecht <Olaf_Giesbrecht@yahoo.de>
+	 */
+	USB_DEVICE_VER(0x0763, 0x1031, 0x0100, 0x0109),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "M-Audio",
+		.product_name = "MidiSport 8x8",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_MIDIMAN,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x01ff,
+			.in_cables  = 0x01ff
+		}
+	}
+},
+{
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1033),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "M-Audio",
@@ -687,6 +705,22 @@
 		.data = & (const snd_usb_midi_endpoint_info_t) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
+		}
+	}
+},
+
+/* Mark of the Unicorn devices */
+{
+	/* thanks to Woodley Packard <sweaglesw@thibs.menloschool.org> */
+	USB_DEVICE(0x07fd, 0x0001),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "MOTU",
+		.product_name = "Fastlane",
+		.ifnum = 1,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0003,
+			.in_cables  = 0x0003
 		}
 	}
 },





-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
