From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] README updates
Date: Wed, 7 Apr 2004 23:46:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040407214631.GA15356@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Index: alsa-firmware/mixartloader/README
===================================================================
RCS file: /cvsroot/alsa/alsa-firmware/mixartloader/README,v
retrieving revision 1.1
diff -u -r1.1 README
--- alsa-firmware/mixartloader/README	8 Jan 2004 14:46:20 -0000	1.1
+++ alsa-firmware/mixartloader/README	7 Apr 2004 21:21:26 -0000
@@ -1,5 +1,5 @@
-GENRAL
-======
+GENERAL
+=======
 
 This directory contains the firmware data files for mixartloader
 utility in alsa-tools package.  Install this with the same prefix
Index: alsa-firmware/usx2yloader/README
===================================================================
RCS file: /cvsroot/alsa/alsa-firmware/usx2yloader/README,v
retrieving revision 1.1
diff -u -r1.1 README
--- alsa-firmware/usx2yloader/README	8 Jan 2004 14:46:20 -0000	1.1
+++ alsa-firmware/usx2yloader/README	7 Apr 2004 21:21:34 -0000
@@ -1,5 +1,5 @@
-GENRAL
-======
+GENERAL
+=======
 
 This directory contains the firmware data files for usx2yloader
 utility in alsa-tools package.  Install this with the same prefix
Index: alsa-tools/usx2yloader/README
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/README,v
retrieving revision 1.2
diff -u -r1.2 README
--- alsa-tools/usx2yloader/README	25 Nov 2003 17:13:40 -0000	1.2
+++ alsa-tools/usx2yloader/README	7 Apr 2004 21:21:47 -0000
@@ -7,36 +7,37 @@
 
 Usx2yloader is a helper program to load the 2nd Phase firmware binaries
 onto the Tascam USX2Y USB soundcards.
-It has proven to work so far only for the US428.
-US122 & US224 will hopefully follow.
-The snd-usb-us428 module requires this program.
+It has proven to work so far for the US122, US224 and US428.
+The snd-usb-usx2y module requires this program.
 
 
-US428 initialisation outlined
+USX2Y initialisation outlined
 =============================
 
 A.  Phase 1
-A.1.  US428 is plugged to the PC and powered on.
+A.1.  USx2y is plugged to the PC and powered on.
       This makes the kernel see a new USB-device with the Vendor/Product
-      ID 0x1604/0x8000.
+      ID 0x1604/0x8000 (US428), 0x1604/0x8004 (US224) or 0x1604/0x8006 
+      (US122).
       The kernel reacts by starting the usb-hotplug script.
 A.2.  The usb-hotplug script starts the executable fxload,
-      which transfers the EZUSB firmware to the US428.
-A.3.  The US428 disconnects itself from the USB-Bus and ... (see Phase 2).
+      which transfers the EZUSB firmware to the USx2y.
+A.3.  The USx2y disconnects itself from the USB-Bus and ... (see Phase 2).
 
 B.  Phase 2
-B.1.  The US428 reintroduces itself as USB-device with the Vendor/Product
-      ID 0x1604/0x8001.
-      The kernel reacts by loading the module snd-usb-us428, if it is not
+B.1.  The USx2y reintroduces itself as USB-device with the Vendor/Product
+      ID 0x1604/0x8001 (US428), 0x1604/0x8005 (US224) or 0x1604/0x8007
+      (US122)
+      The kernel reacts by loading the module snd-usb-usx2y, if it is not
       already loaded.
-B.2   The module snd-usb-us428 "takes" the US428 as its device and sets up
+B.2   The module snd-usb-usx2y "takes" the USx2y as its device and sets up
       a "hardware dependent interface".
       (The module doesn't create any pcm nor midi devices now.)
 B.3   Subsequently the kernel starts the usb-hotplug script, which launches
       usx2yloader.
-B.4   usx2yloader transfers the 2nd Phase firmware binary to the US428 by means
+B.4   usx2yloader transfers the 2nd Phase firmware binary to the USx2y by means
       of the "hardware dependent interface". When this transfer finishes,
-      the snd-usb-us428 module creates the pcm- and midi-devices.
+      the snd-usb-usx2y module creates the pcm- and midi-devices.
       Initialisation is complete.
 
 
@@ -63,7 +64,7 @@
  - tascam_fw
  - tascam_fpga
 and the Firmwarefiles.
-You also need hotplug to be installed.
+You also need fxload and hotplug to be installed.
 
 
 FIRMWAREFILES


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
