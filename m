From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usbmidi.c: support for SD-20/SD-80/UA-700
Date: Thu, 15 Aug 2002 09:52:31 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208150752.g7F7qVU27686@turing.informatik.uni-halle.de>
Content-Type: text
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Index: usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.1
diff -u -r1.1 usbmidi.c
--- usb/usbmidi.c	14 Aug 2002 17:22:18 -0000	1.1
+++ usb/usbmidi.c	15 Aug 2002 07:48:59 -0000
@@ -60,10 +60,13 @@
 		"{Roland/EDIROL,SC-8820},"
 		"{Roland/EDIROL,SC-8850},"
 		"{Roland/EDIROL,SC-D70},"
+		"{Roland/EDIROL,SD-20},"
+		"{Roland/EDIROL,SD-80},"
 		"{Roland/EDIROL,SD-90},"
 		"{Roland/EDIROL,SK-500},"
 		"{Roland/EDIROL,U-8},"
 		"{Roland/EDIROL,UA-100(G)},"
+		"{Roland/EDIROL,UA-700},"
 		"{Roland/EDIROL,UM-1(S)},"
 		"{Roland/EDIROL,UM-2(E)},"
 		"{Roland/EDIROL,UM-4},"
@@ -1304,6 +1307,21 @@
 	.ifnum = 0,
 	.endpoints = {{ -1, 0x003f, 0x003f }}
 };
+static usbmidi_device_info_t snd_usbmidi_roland_sd20_info = {
+	.vendor = "EDIROL", .product = "SD-20",
+	.ifnum = 0,
+	.endpoints = {{ -1, 0x0003, 0x0007 }}
+};
+static usbmidi_device_info_t snd_usbmidi_roland_sd80_info = {
+	.vendor = "EDIROL", .product = "SD-80",
+	.ifnum = 0,
+	.endpoints = {{ -1, 0x000f, 0x000f }}
+};
+static usbmidi_device_info_t snd_usbmidi_roland_ua700_info = {
+	.vendor = "EDIROL", .product = "UA-700",
+	.ifnum = 3,
+	.endpoints = {{ -1, 0x0003, 0x0003 }}
+};
 
 #define USBMIDI_NONCOMPLIANT_DEVICE(vid, pid, name) \
 		USB_DEVICE(vid, pid), \
@@ -1329,6 +1347,9 @@
 	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0014, roland_um880) },
 	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0016, roland_sd90) },
 	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0023, roland_um550) },
+	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0027, roland_sd20) },
+	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x0029, roland_sd80) },
+	{ USBMIDI_NONCOMPLIANT_DEVICE(0x0582, 0x002b, roland_ua700) },
 	{ /* terminator */ }
 };
 



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
