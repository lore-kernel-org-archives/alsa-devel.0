From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Ozone MIDI quirk
Date: Tue, 02 Sep 2003 17:35:45 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309021734551.5961-100000@studcom.urz.uni-halle.de>
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


adds a quirk for the Midiman Ozone


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.21
diff -u -r1.21 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	18 Jun 2003 12:55:34 -0000	1.21
+++ alsa-kernel/usb/usbquirks.h	2 Sep 2003 15:23:47 -0000
@@ -755,6 +755,19 @@
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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
