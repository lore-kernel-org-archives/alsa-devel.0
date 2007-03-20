From: Rene Herman <rene.herman@gmail.com>
Subject: s/sf.net/alsa-devel.org/
Date: Tue, 20 Mar 2007 18:07:28 +0100
Message-ID: <460014D0.9050408@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080602000209020403020301"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 69E2624748
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2007 18:08:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080602000209020403020301
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

This replaces all occurences of alsa-devel@lists.s[ource]f[orge].net 
that a simple recursive grep found in the current HG ALSA repos by 
alsa-devel@alsa-project.org.

Signed-off-by: Rene Herman <rene.herman@gmail.com>

Rene.


--------------080602000209020403020301
Content-Type: text/plain;
 name="alsa-devel_alsa-project.org.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-devel_alsa-project.org.diff"

diff -urN alsa.orig/alsa-driver/pci/bt87x.patch alsa/alsa-driver/pci/bt87x.patch
--- alsa.orig/alsa-driver/pci/bt87x.patch	2006-06-29 23:22:39.000000000 +0200
+++ alsa/alsa-driver/pci/bt87x.patch	2007-03-20 17:52:59.000000000 +0100
@@ -39,7 +39,7 @@
 +	           pci->device, subsystem_vendor, subsystem_device);
  	snd_printk(KERN_DEBUG "please mail id, board name, and, "
  		   "if it works, the correct digital_rate option to "
- 		   "<alsa-devel@lists.sf.net>\n");
+ 		   "<alsa-devel@alsa-project.org>\n");
 @@ -935,3 +948,5 @@
  
  module_init(alsa_card_bt87x_init)
diff -urN alsa.orig/alsa-kernel/Documentation/ALSA-Configuration.txt alsa/alsa-kernel/Documentation/ALSA-Configuration.txt
--- alsa.orig/alsa-kernel/Documentation/ALSA-Configuration.txt	2007-02-26 17:00:05.000000000 +0100
+++ alsa/alsa-kernel/Documentation/ALSA-Configuration.txt	2007-03-20 17:54:24.000000000 +0100
@@ -2049,4 +2049,4 @@
        https://bugtrack.alsa-project.org/bugs/
 
   ALSA Developers ML
-       mailto:alsa-devel@lists.sourceforge.net
+       mailto:alsa-devel@alsa-project.org
diff -urN alsa.orig/alsa-kernel/Documentation/Bt87x.txt alsa/alsa-kernel/Documentation/Bt87x.txt
--- alsa.orig/alsa-kernel/Documentation/Bt87x.txt	2006-06-29 23:25:22.000000000 +0200
+++ alsa/alsa-kernel/Documentation/Bt87x.txt	2007-03-20 17:55:06.000000000 +0100
@@ -36,8 +36,8 @@
 other values than the default 32000 (often it's 44100 or 64000).
 
 If you have an unknown card, please mail the ID and board name to
-<alsa-devel@lists.sf.net>, regardless of whether audio capture works or
-not, so that future versions of this driver know about your card.
+<alsa-devel@alsa-project.org>, regardless of whether audio capture works
+or not, so that future versions of this driver know about your card.
 
 
 Audio modes
diff -urN alsa.orig/alsa-kernel/pci/bt87x.c alsa/alsa-kernel/pci/bt87x.c
--- alsa.orig/alsa-kernel/pci/bt87x.c	2007-03-06 11:30:32.000000000 +0100
+++ alsa/alsa-kernel/pci/bt87x.c	2007-03-20 17:56:40.000000000 +0100
@@ -835,7 +835,7 @@
 	           pci->device, pci->subsystem_vendor, pci->subsystem_device);
 	snd_printk(KERN_DEBUG "please mail id, board name, and, "
 		   "if it works, the correct digital_rate option to "
-		   "<alsa-devel@lists.sf.net>\n");
+		   "<alsa-devel@alsa-project.org>\n");
 	return 32000; /* default rate */
 }
 
diff -urN alsa.orig/alsa-kernel/pci/cs46xx/cs46xx_lib.c alsa/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa.orig/alsa-kernel/pci/cs46xx/cs46xx_lib.c	2006-11-21 18:00:06.000000000 +0100
+++ alsa/alsa-kernel/pci/cs46xx/cs46xx_lib.c	2007-03-20 17:55:54.000000000 +0100
@@ -3107,7 +3107,7 @@
 	snd_printk(KERN_ERR "ERROR: snd-cs46xx: never read ISV3 & ISV4 from AC'97\n");
 	snd_printk(KERN_ERR "       Try reloading the ALSA driver, if you find something\n");
         snd_printk(KERN_ERR "       broken or not working on your soundcard upon\n");
-	snd_printk(KERN_ERR "       this message please report to alsa-devel@lists.sourceforge.net\n");
+	snd_printk(KERN_ERR "       this message please report to alsa-devel@alsa-project.org\n");
 
 	return -EIO;
 #endif
diff -urN alsa.orig/alsa-lib/src/conf/cards/USB-Audio.conf alsa/alsa-lib/src/conf/cards/USB-Audio.conf
--- alsa.orig/alsa-lib/src/conf/cards/USB-Audio.conf	2007-02-13 10:00:05.000000000 +0100
+++ alsa/alsa-lib/src/conf/cards/USB-Audio.conf	2007-03-20 17:57:20.000000000 +0100
@@ -9,7 +9,7 @@
 #  cards.USB-Audio.pcm.use_dmix."NoiseBlaster 3000" no
 #
 #  If your device requires such a definition to work correctly, please report it
-#  to <alsa-devel@lists.sourceforge.net>.
+#  to <alsa-devel@alsa-project.org>.
 
 
 # If a device has sample formats not supported by dmix, dmix can be disabled

--------------080602000209020403020301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080602000209020403020301--
