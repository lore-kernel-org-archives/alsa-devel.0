From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Ozone support
Date: Mon, 09 Jun 2003 13:42:46 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306091339540.19508-100000@studcom.urz.uni-halle.de>
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


This will add support for the Ozone's MIDI port (when the firmware
loader actually exists).


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.20
diff -u -r1.20 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	13 May 2003 10:44:09 -0000	1.20
+++ alsa-kernel/usb/usbquirks.h	9 Jun 2003 11:37:02 -0000
@@ -725,6 +725,19 @@
 		}
 	}
 },
+{
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2008),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "M-Audio",
+		.product_name = "Ozone",
+		.ifnum = 3,
+		.type = QUIRK_MIDI_MIDIMAN,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
+	}
+},

 /* Mark of the Unicorn devices */
 {




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
