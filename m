From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usbmidi: remove interface class from most quirks
Date: Mon, 14 Oct 2002 11:44:18 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210141137010.2848-100000@studcom.urz.uni-halle.de>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

snd-usb-audio isn't loaded when hotplugging devices with multiple
interfaces because the hotplug system doesn't pass the interface class.

This patch removes the interface class specification (except from those
devices where it matters).


-- 
Clemens


Index: usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.2
diff -u -r1.2 usbquirks.h
--- usb/usbquirks.h	4 Oct 2002 13:18:24 -0000	1.2
+++ usb/usbquirks.h	14 Oct 2002 09:33:27 -0000
@@ -38,7 +38,7 @@

 /* Yamaha devices */
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1000),
+	USB_DEVICE(0x0499, 0x1000),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "UX256",
@@ -47,7 +47,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1001),
+	USB_DEVICE(0x0499, 0x1001),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "MU1000",
@@ -56,7 +56,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1002),
+	USB_DEVICE(0x0499, 0x1002),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "MU2000",
@@ -65,7 +65,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1003),
+	USB_DEVICE(0x0499, 0x1003),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "MU500",
@@ -74,7 +74,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1004),
+	USB_DEVICE(0x0499, 0x1004),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "UW500",
@@ -83,7 +83,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1005),
+	USB_DEVICE(0x0499, 0x1005),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "MOTIF6",
@@ -92,7 +92,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1006),
+	USB_DEVICE(0x0499, 0x1006),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "MOTIF7",
@@ -101,7 +101,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1007),
+	USB_DEVICE(0x0499, 0x1007),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "MOTIF8",
@@ -110,7 +110,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1008),
+	USB_DEVICE(0x0499, 0x1008),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "UX96",
@@ -119,7 +119,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1009),
+	USB_DEVICE(0x0499, 0x1009),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "UX16",
@@ -128,7 +128,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x100a),
+	USB_DEVICE(0x0499, 0x100a),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "EOS BX",
@@ -137,7 +137,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x100e),
+	USB_DEVICE(0x0499, 0x100e),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "S08",
@@ -146,7 +146,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x100f),
+	USB_DEVICE(0x0499, 0x100f),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "CLP-150",
@@ -155,7 +155,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1010),
+	USB_DEVICE(0x0499, 0x1010),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "CLP-170",
@@ -177,7 +177,7 @@
  * class-specific descriptors.
  */
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0000),
+	USB_DEVICE(0x0582, 0x0000),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "UA-100",
@@ -191,7 +191,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0002),
+	USB_DEVICE(0x0582, 0x0002),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-4",
@@ -205,7 +205,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0003),
+	USB_DEVICE(0x0582, 0x0003),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "SC-8850",
@@ -219,7 +219,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0004),
+	USB_DEVICE(0x0582, 0x0004),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "U-8",
@@ -233,7 +233,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0005),
+	USB_DEVICE(0x0582, 0x0005),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-2",
@@ -247,7 +247,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0007),
+	USB_DEVICE(0x0582, 0x0007),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "SC-8820",
@@ -261,7 +261,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0008),
+	USB_DEVICE(0x0582, 0x0008),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "PC-300",
@@ -275,7 +275,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0009),
+	USB_DEVICE(0x0582, 0x0009),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-1",
@@ -289,7 +289,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x000b),
+	USB_DEVICE(0x0582, 0x000b),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "SK-500",
@@ -303,7 +303,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x000c),
+	USB_DEVICE(0x0582, 0x000c),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "SC-D70",
@@ -317,7 +317,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0012),
+	USB_DEVICE(0x0582, 0x0012),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
 		.product_name = "XV-5050",
@@ -331,7 +331,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0014),
+	USB_DEVICE(0x0582, 0x0014),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-880",
@@ -345,7 +345,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0016),
+	USB_DEVICE(0x0582, 0x0016),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-90",
@@ -359,7 +359,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0023),
+	USB_DEVICE(0x0582, 0x0023),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-550",
@@ -373,7 +373,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0027),
+	USB_DEVICE(0x0582, 0x0027),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-20",
@@ -387,7 +387,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0029),
+	USB_DEVICE(0x0582, 0x0029),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-80",
@@ -401,7 +401,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x002b),
+	USB_DEVICE(0x0582, 0x002b),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-700",
@@ -467,7 +467,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2001),
+	USB_DEVICE(0x0763, 0x2001),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "M-Audio",
 		.product_name = "Quattro",
@@ -477,7 +477,7 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2003),
+	USB_DEVICE(0x0763, 0x2003),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "M-Audio",
 		.product_name = "AudioPhile",



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
