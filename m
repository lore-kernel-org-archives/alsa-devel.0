From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] more USB MIDI quirks
Date: Wed, 08 Oct 2003 11:18:29 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310081113450.17384-100000@studcom.urz.uni-halle.de>
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


- fix Edirol comment
- use special macros for Yamaha devices
- add support for Yamaha MOTIF-R, CVP-204, CVP-206, CVP-208, CVP-210,
  PSR-1100, PSR-2100, PSR-K1, EZ-250i, MOTIF ES 6, MOTIF ES 7,
  MOTIF ES 8, CS1D, DSP1D, ACU16-C, NHB32-C, DM1000, 01V96


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.22
diff -u -r1.22 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	2 Sep 2003 18:06:40 -0000	1.22
+++ alsa-kernel/usb/usbquirks.h	8 Oct 2003 09:12:28 -0000
@@ -39,202 +39,72 @@
 	.idProduct = prod, \
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC

-/* Yamaha devices */
-{
-	USB_DEVICE(0x0499, 0x1000),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "UX256",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1001),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "MU1000",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1002),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "MU2000",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1003),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "MU500",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1004),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "UW500",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1005),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "MOTIF6",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1006),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "MOTIF7",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1007),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "MOTIF8",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1008),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "UX96",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1009),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "UX16",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x100a),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "EOS BX",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x100e),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "S08",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x100f),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "CLP-150",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1010),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "CLP-170",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1011),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "P-250",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1012),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "TYROS",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1013),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "PF-500",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x1014),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "S90",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x5002),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "DME32",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x5003),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "DM2000",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
-{
-	USB_DEVICE(0x0499, 0x5004),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "Yamaha",
-		.product_name = "02R96",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_YAMAHA
-	}
-},
+/*
+ * Yamaha devices
+ */
+
+#define YAMAHA_DEVICE(id, name) { \
+	USB_DEVICE(0x0499, id), \
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) { \
+		.vendor_name = "Yamaha", \
+		.product_name = name, \
+		.ifnum = QUIRK_ANY_INTERFACE, \
+		.type = QUIRK_MIDI_YAMAHA \
+	} \
+}
+#define YAMAHA_INTERFACE(id, intf, name) { \
+	USB_DEVICE_VENDOR_SPEC(0x0499, id), \
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) { \
+		.vendor_name = "Yamaha", \
+		.product_name = name, \
+		.ifnum = intf, \
+		.type = QUIRK_MIDI_YAMAHA \
+	} \
+}
+YAMAHA_DEVICE(0x1000, "UX256"),
+YAMAHA_DEVICE(0x1001, "MU1000"),
+YAMAHA_DEVICE(0x1002, "MU2000"),
+YAMAHA_DEVICE(0x1003, "MU500"),
+YAMAHA_INTERFACE(0x1004, 3, "UW500"),
+YAMAHA_DEVICE(0x1005, "MOTIF6"),
+YAMAHA_DEVICE(0x1006, "MOTIF7"),
+YAMAHA_DEVICE(0x1007, "MOTIF8"),
+YAMAHA_DEVICE(0x1008, "UX96"),
+YAMAHA_DEVICE(0x1009, "UX16"),
+YAMAHA_INTERFACE(0x100a, 3, "EOS BX"),
+YAMAHA_DEVICE(0x100e, "S08"),
+YAMAHA_DEVICE(0x100f, "CLP-150"),
+YAMAHA_DEVICE(0x1010, "CLP-170"),
+YAMAHA_DEVICE(0x1011, "P-250"),
+YAMAHA_DEVICE(0x1012, "TYROS"),
+YAMAHA_DEVICE(0x1013, "PF-500"),
+YAMAHA_DEVICE(0x1014, "S90"),
+YAMAHA_DEVICE(0x1015, "MOTIF-R"),
+YAMAHA_DEVICE(0x1017, "CVP-204"),
+YAMAHA_DEVICE(0x1018, "CVP-206"),
+YAMAHA_DEVICE(0x1019, "CVP-208"),
+YAMAHA_DEVICE(0x101a, "CVP-210"),
+YAMAHA_DEVICE(0x101b, "PSR-1100"),
+YAMAHA_DEVICE(0x101c, "PSR-2100"),
+YAMAHA_DEVICE(0x101e, "PSR-K1"),
+YAMAHA_DEVICE(0x1020, "EZ-250i"),
+YAMAHA_DEVICE(0x1021, "MOTIF ES 6"),
+YAMAHA_DEVICE(0x1022, "MOTIF ES 7"),
+YAMAHA_DEVICE(0x1023, "MOTIF ES 8"),
+YAMAHA_DEVICE(0x5000, "CS1D"),
+YAMAHA_DEVICE(0x5001, "DSP1D"),
+YAMAHA_DEVICE(0x5002, "DME32"),
+YAMAHA_DEVICE(0x5003, "DM2000"),
+YAMAHA_DEVICE(0x5004, "02R96"),
+YAMAHA_DEVICE(0x5005, "ACU16-C"),
+YAMAHA_DEVICE(0x5006, "NHB32-C"),
+YAMAHA_DEVICE(0x5007, "DM1000"),
+YAMAHA_DEVICE(0x5008, "01V96"),
+#undef YAMAHA_DEVICE
+#undef YAMAHA_INTERFACE

 /*
  * Roland/RolandED/Edirol devices
- *
- * The USB MIDI Specification has been written by Roland,
- * but a 100% conforming Roland device has yet to be found.
  */
 {
 	USB_DEVICE(0x0582, 0x0000),




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
