From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Edirol PCR-30/50 support
Date: Thu, 05 Dec 2002 10:16:32 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212051009450.29579-100000@studcom.urz.uni-halle.de>
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


This adds a quirk for the Edirol PCR-30/50 keyboards.


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.9
diff -u -r1.9 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	3 Dec 2002 11:07:10 -0000	1.9
+++ alsa-kernel/usb/usbquirks.h	5 Dec 2002 09:08:12 -0000
@@ -475,6 +475,20 @@
 		}
 	}
 },
+{
+	USB_DEVICE(0x0582, 0x0033),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "PCR",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.epnum = -1,
+			.out_cables = 0x0003,
+			.in_cables  = 0x0007
+		}
+	}
+},

 /* Midiman/M-Audio devices */
 {



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
