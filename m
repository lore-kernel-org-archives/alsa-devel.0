From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usbaudio fixes
Date: Thu, 19 Jun 2003 09:00:47 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306190856050.13411-100000@studcom.urz.uni-halle.de>
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
Cc: Stephane Alnet <alsa-dev@shimaore.net>
List-Id: alsa-devel@alsa-project.org


I botched my previous patch for the UA-5: the altsettings of the audio
interface would be ignored because bInterfaceSubClass isn't set to
USB_SUBCLASS_AUDIO_STREAMING on that device. This patch corrects this.

And some devices (e.g. the Logitech QuickCam Web) have an endpoint
with wMaxPacketSize == 0, and no class-specific descriptors in their
first altsetting (instead of no endpoints). The additional check now
suppresses an unnecessary warning message.


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.56
diff -u -r1.56 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	4 Jun 2003 12:43:55 -0000	1.56
+++ alsa-kernel/usb/usbaudio.c	19 Jun 2003 06:51:04 -0000
@@ -2163,8 +2163,10 @@
 		/* skip invalid one */
 		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
 		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
-		    altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING ||
-		    altsd->bNumEndpoints < 1)
+		    (altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING &&
+		     altsd->bInterfaceSubClass != USB_SUBCLASS_VENDOR_SPEC) ||
+		    altsd->bNumEndpoints < 1 ||
+		    get_endpoint(alts, 0)->wMaxPacketSize == 0)
 			continue;
 		/* must be isochronous */
 		if ((get_endpoint(alts, 0)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) !=
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.17
diff -u -r1.17 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	13 May 2003 10:44:09 -0000	1.17
+++ alsa-kernel/usb/usbaudio.h	19 Jun 2003 06:51:04 -0000
@@ -28,6 +28,7 @@
 #define USB_SUBCLASS_AUDIO_CONTROL	0x01
 #define USB_SUBCLASS_AUDIO_STREAMING	0x02
 #define USB_SUBCLASS_MIDI_STREAMING	0x03
+#define USB_SUBCLASS_VENDOR_SPEC	0xff

 #define USB_DT_CS_DEVICE                0x21
 #define USB_DT_CS_CONFIG                0x22




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
