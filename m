From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Add support for Audigy2LS on MSI motherboard.
Date: Sun, 13 Feb 2005 00:45:58 +0000
Message-ID: <420EA346.5030100@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080307020800050808040404"
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AE5CE202
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2005 01:45:59 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.42)
	id 1D07tf-000KZP-9s
	for alsa-devel@alsa-project.org; Sun, 13 Feb 2005 00:45:59 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080307020800050808040404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes Bug #0901
Signed off by: James Courtier-Dutton <James@superbug.demon.co.uk>

--------------080307020800050808040404
Content-Type: text/plain;
 name="ca0106-msi-audigyls-fix.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ca0106-msi-audigyls-fix.diff.txt"

Index: alsa-driver/alsa-kernel/pci/ca0106/ca0106_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ca0106/ca0106_main.c,v
retrieving revision 1.3
diff -u -r1.3 ca0106_main.c
--- alsa-driver/alsa-kernel/pci/ca0106/ca0106_main.c	4 Jan 2005 13:55:46 -0000	1.3
+++ alsa-driver/alsa-kernel/pci/ca0106/ca0106_main.c	13 Feb 2005 00:25:42 -0000
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
- *  Version: 0.0.21
+ *  Version: 0.0.22
  *
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
@@ -75,6 +75,8 @@
  *  0.0.21
  *    Add 4 capture channels. (SPDIF only comes in on channel 0. )
  *    Add SPDIF capture using optional digital I/O module for SB Live 24bit. (Analog capture does not yet work.)
+ *  0.0.22
+ *    Add support for MSI Audigy2LS. From kiksen, bug #0901.
  *
  *  BUGS:
  *    Some stability problems when unloading the snd-ca0106 kernel module.
@@ -169,6 +171,7 @@
 	 { 0x10051102, "AudigyLS [SB0310b]"} , /* Unknown AudigyLS that also says SB0310 on it */
 	 { 0x10061102, "Live! 7.1 24bit [SB0410]"} , /* New Sound Blaster Live! 7.1 24bit. This does not have an AC97. 53SB041000001 */
 	 { 0x10071102, "Live! 7.1 24bit [SB0413]"} , /* New Dell Sound Blaster Live! 7.1 24bit. This does not have an AC97.  */
+	 { 0x10091462, "Live! by MSI [SB0438]"}, /* MSI SB Audigy2LS without AC97 */
 	 { 0, "AudigyLS [Unknown]" }
 };
 
@@ -1133,7 +1136,9 @@
         snd_ca0106_ptr_write(chip, CAPTURE_SOURCE, 0x0, 0x333300e4); /* Select MIC, Line in, TAD in, AUX in */
 	chip->capture_source = 3; /* Set CAPTURE_SOURCE */
 
-        if ((chip->serial == 0x10061102) || (chip->serial == 0x10071102) ) { /* The SB0410 and SB0413 use GPIO differently. */
+        if ((chip->serial == 0x10061102) || 
+	    (chip->serial == 0x10071102) ||
+	    (chip->serial == 0x10091462)) { /* The SB0410 and SB0413 use GPIO differently. */
 		/* FIXME: Still need to find out what the other GPIO bits do. E.g. For digital spdif out. */
 		outl(0x0, chip->port+GPIO);
 		//outl(0x00f0e000, chip->port+GPIO); /* Analog */
@@ -1200,7 +1205,9 @@
 		snd_card_free(card);
 		return err;
 	}
-        if ((chip->serial != 0x10061102) && (chip->serial != 0x10071102) ) { /* The SB0410 and SB0413 do not have an ac97 chip. */
+        if ((chip->serial != 0x10061102) && 
+	    (chip->serial != 0x10071102) && 
+	    (chip->serial != 0x10091462) ) { /* The SB0410 and SB0413 do not have an ac97 chip. */
 		if ((err = snd_ca0106_ac97(chip)) < 0) {
 			snd_card_free(card);
 			return err;

--------------080307020800050808040404--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
