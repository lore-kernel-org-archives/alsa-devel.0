From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Terratec PHASE 26 MIDI support
Date: Wed, 11 Feb 2004 10:47:33 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402111046260.24733-100000@studcom.urz.uni-halle.de>
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


This adds a quirk for the PHASE 26's MIDI interface.


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.26
diff -u -r1.26 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	20 Jan 2004 15:31:59 -0000	1.26
+++ alsa-kernel/usb/usbquirks.h	11 Feb 2004 09:33:45 -0000
@@ -688,4 +688,14 @@

 },

+{
+	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0013),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Terratec",
+		.product_name = "PHASE 26",
+		.ifnum = 3,
+		.type = QUIRK_MIDI_STANDARD_INTERFACE
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
