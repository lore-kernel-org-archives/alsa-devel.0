From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] USB-MIDI changes
Date: Mon, 01 Mar 2004 18:38:46 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403011835110.5532-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- fix non-working control port on Roland U-8
- more port names
- new MIDI quirks for Roland MMP-2, V-SYNTH, VariOS, FP-*, GI-20,
  BOSS GS-10, Edirol UR-80, PCR-A, PCR-1


Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.23
diff -u -r1.23 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	23 Feb 2004 10:53:07 -0000	1.23
+++ alsa-kernel/usb/usbmidi.c	1 Mar 2004 16:36:10 -0000
@@ -748,6 +748,7 @@
 	{0x0582, 0x0003, 4, "%s MIDI 1"},
 	{0x0582, 0x0003, 5, "%s MIDI 2"},
 	/* Roland U-8 */
+	{0x0582, 0x0004, 0, "%s MIDI"},
 	{0x0582, 0x0004, 1, "%s Control"},
 	/* Roland SC-8820 */
 	{0x0582, 0x0007, 0, "%s Part A"},
@@ -779,6 +780,31 @@
 	{0x0582, 0x0029, 1, "%s Part B"},
 	{0x0582, 0x0029, 2, "%s MIDI 1"},
 	{0x0582, 0x0029, 3, "%s MIDI 2"},
+	/* Edirol UA-700 */
+	{0x0582, 0x002b, 0, "%s MIDI"},
+	{0x0582, 0x002b, 1, "%s Control"},
+	/* Roland VariOS */
+	{0x0582, 0x002f, 0, "%s MIDI"},
+	{0x0582, 0x002f, 1, "%s External MIDI"},
+	{0x0582, 0x002f, 2, "%s Sync"},
+	/* Edirol PCR */
+	{0x0582, 0x0033, 0, "%s MIDI"},
+	{0x0582, 0x0033, 1, "%s 1"},
+	{0x0582, 0x0033, 2, "%s 2"},
+	/* BOSS GS-10 */
+	{0x0582, 0x003b, 0, "%s MIDI"},
+	{0x0582, 0x003b, 1, "%s Control"},
+	/* Edirol UA-1000 */
+	{0x0582, 0x0044, 0, "%s MIDI"},
+	{0x0582, 0x0044, 1, "%s Control"},
+	/* Edirol UR-80 */
+	{0x0582, 0x0048, 0, "%s MIDI"},
+	{0x0582, 0x0048, 1, "%s 1"},
+	{0x0582, 0x0048, 2, "%s 2"},
+	/* Edirol PCR-A */
+	{0x0582, 0x004d, 0, "%s MIDI"},
+	{0x0582, 0x004d, 1, "%s 1"},
+	{0x0582, 0x004d, 2, "%s 2"},
 	/* M-Audio MidiSport 8x8 */
 	{0x0763, 0x1031, 8, "%s Control"},
 	{0x0763, 0x1033, 8, "%s Control"},
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.28
diff -u -r1.28 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	18 Feb 2004 16:24:55 -0000	1.28
+++ alsa-kernel/usb/usbquirks.h	1 Mar 2004 16:36:10 -0000
@@ -104,7 +104,7 @@
 #undef YAMAHA_INTERFACE

 /*
- * Roland/RolandED/Edirol devices
+ * Roland/RolandED/Edirol/BOSS devices
  */
 {
 	USB_DEVICE(0x0582, 0x0000),
@@ -196,8 +196,8 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.out_cables = 0x0003,
-			.in_cables  = 0x0003
+			.out_cables = 0x0005,
+			.in_cables  = 0x0005
 		}
 	}
 },
@@ -393,6 +393,32 @@
 	}
 },
 {
+	USB_DEVICE(0x0582, 0x001b),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "MMP-2",
+		.ifnum = 2,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x001d),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "V-SYNTH",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
+	}
+},
+{
 	USB_DEVICE(0x0582, 0x0023),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
@@ -489,6 +515,19 @@
 	}
 },
 {
+	USB_DEVICE(0x0582, 0x002f),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "VariOS",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0007,
+			.in_cables  = 0x0007
+		}
+	}
+},
+{
 	USB_DEVICE(0x0582, 0x0033),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
@@ -498,6 +537,84 @@
 		.data = & (const snd_usb_midi_endpoint_info_t) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0037),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "Digital Piano",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x0582, 0x003b),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "BOSS",
+		.product_name = "GS-10",
+		.ifnum = 3,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0003,
+			.in_cables  = 0x0003
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0040),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Roland",
+		.product_name = "GI-20",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0048),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UR-80",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0003,
+			.in_cables  = 0x0007
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x004d),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "PCR-A",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0003,
+			.in_cables  = 0x0007
+		}
+	}
+},
+{
+	USB_DEVICE(0x0582, 0x0065),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "PCR-1",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0003
 		}
 	}
 },




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
