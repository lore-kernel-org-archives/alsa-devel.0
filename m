From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] usb audio patch for new usb device.
Date: Wed, 16 Jul 2003 04:08:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F14C1A4.5020704@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040706000703000107070907"
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

This is a multi-part message in MIME format.
--------------040706000703000107070907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I attach a patch that makes alsa work better with this JustLink usb 
audio device.

See patch for details.

Cheers
James

--------------040706000703000107070907
Content-Type: text/plain;
 name="alsa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa.diff"

Index: alsa-kernel/usb/usbmixer_maps.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmixer_maps.c,v
retrieving revision 1.4
diff -u -r1.4 usbmixer_maps.c
--- alsa-kernel/usb/usbmixer_maps.c	13 May 2003 10:44:09 -0000	1.4
+++ alsa-kernel/usb/usbmixer_maps.c	16 Jul 2003 02:59:09 -0000
@@ -89,6 +89,28 @@
 	{ 0 } /* terminator */
 };
 
+/* Section "justlink_map" below added by James Courtier-Dutton <James@superbug.demon.co.uk>
+ * sourced from Maplin Electronics (http://www.maplin.co.uk), part number A56AK
+ * Part has 2 connectors that act as a single output. (TOSLINK Optical for digital out, and 3.5mm Jack for Analogue out.)
+ * The USB Mixer publishes a Microphone and extra Volume controls for it, but none exist on the device,
+ * so this map removes all unwanted sliders from alsamixer
+ */
+
+static struct usbmix_name_map justlink_map[] = {
+	/* 1: IT pcm playback */
+	/* 2: Not present */
+	{ 3, NULL}, /* IT mic (No mic input on device) */
+	/* 4: Not present */
+	/* 5: OT speacker */
+	/* 6: OT pcm capture */
+	{ 7, "Master Playback" }, /* Mute/volume for speaker */
+	{ 8, NULL }, /* Capture Switch (No capture inputs on device) */
+	{ 9, NULL }, /* Capture Mute/volume (No capture inputs on device */
+	/* 0xa: Not present */
+	/* 0xb: MU (w/o controls) */
+	{ 0xc, NULL }, /* Mic feedback Mute/volume (No capture inputs on device) */
+	{ 0 } /* terminator */
+};
 
 /*
  * Control map entries
@@ -96,6 +118,7 @@
 
 static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 	{ 0x41e, 0x3000, extigy_map },
+	{ 0xc45, 0x1158, justlink_map },
 	{ 0 } /* terminator */
 };
 

--------------040706000703000107070907--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
