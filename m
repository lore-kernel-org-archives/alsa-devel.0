From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Yamaha P-250 support
Date: Tue, 21 Jan 2003 08:57:29 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301210856160.21713-100000@studcom.urz.uni-halle.de>
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


This patch adds a new quirk for the Yamaha P-250.


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.11
diff -u -r1.11 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	10 Jan 2003 10:31:58 -0000	1.11
+++ alsa-kernel/usb/usbquirks.h	21 Jan 2003 07:49:12 -0000
@@ -162,6 +162,15 @@
 	}
 },
 {
+	USB_DEVICE(0x0499, 0x1011),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Yamaha",
+		.product_name = "P-250",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_YAMAHA
+	}
+},
+{
 	USB_DEVICE(0x0499, 0x1012),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
