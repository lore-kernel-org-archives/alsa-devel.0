From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] UM-1SX support
Date: Tue, 20 Jan 2004 16:12:31 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401201611090.17857-100000@studcom.urz.uni-halle.de>
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


add support for Edirol UM-1SX


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.25
diff -u -r1.25 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	19 Jan 2004 19:33:46 -0000	1.25
+++ alsa-kernel/usb/usbquirks.h	20 Jan 2004 15:08:18 -0000
@@ -501,6 +501,15 @@
 		}
 	}
 },
+{
+	USB_DEVICE(0x0582, 0x0052),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UM-1SX",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_STANDARD_INTERFACE
+	}
+},

 /* Midiman/M-Audio devices */
 {




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
