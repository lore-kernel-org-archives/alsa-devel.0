From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Edirol UA-20 MIDI / UA-700 PCM support
Date: Fri, 25 Oct 2002 10:40:38 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210251019100.17354-100000@studcom.urz.uni-halle.de>
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


Added a MIDI quirk for the UA-20. I don't know if PCM works.

The UA-700 _may_ have audio-class compatible PCM interfaces, so I changed
it to use USB_DEVICE_VENDOR_SPEC to prevent conflicts. (same as UA-20)


Index: usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.6
diff -u -r1.6 usbquirks.h
--- usbquirks.h	24 Oct 2002 12:28:05 -0000	1.6
+++ usbquirks.h	25 Oct 2002 08:17:43 -0000
@@ -366,6 +366,20 @@
 	}
 },
 {
+	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0025),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UA-20",
+		.ifnum = 3,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.epnum = -1,
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
+	}
+},
+{
 	USB_DEVICE(0x0582, 0x0027),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
@@ -394,7 +408,7 @@
 	}
 },
 {
-	USB_DEVICE(0x0582, 0x002b),
+	USB_DEVICE_VENDOR_SPEC(0x0582, 0x002b),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-700",



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
