From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] azt3328.c and maestro3.c cleanup
Date: Tue, 18 Mar 2003 17:03:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030318160312.GA29700@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi all,

- fix typo and change comment for Inspiron's Maestro 3
- update azt3328.c to mention sound improvements with newer PCI168 revisions

Andreas Mohr

Index: alsa-driver/pci/azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/azt3328.c,v
retrieving revision 1.5
diff -u -r1.5 azt3328.c
--- alsa-driver/pci/azt3328.c	19 Feb 2003 09:34:02 -0000	1.5
+++ alsa-driver/pci/azt3328.c	18 Mar 2003 15:54:18 -0000
@@ -3,12 +3,12 @@
  *  Copyright (C) 2002 by Andreas Mohr <hw7oshyuv3001@sneakemail.com>
  *
  *  Framework borrowed from Bart Hartgers's als4000.c.
- *  Driver developed on the PCI168 AP(W) version (subsystem ID 1801),
+ *  Driver developed on PCI168 AP(W) version (PCI rev. 10, subsystem ID 1801),
  *  found in a Fujitsu-Siemens PC ("Cordant", aluminum case).
  *  Other versions are:
  *  PCI168 A(W), sub ID 1800
  *  PCI168 A/AP, sub ID 8000
- *  Please give me feedback in case you try my driver with one of these !!
+ *  Please give me feedback in case you try my driver with one of these!!
  *
  * GPL LICENSE
  *  This program is free software; you can redistribute it and/or modify
@@ -52,9 +52,14 @@
  *    required for Microsoft's logo compliance (FIXME: where ?)
  *  - PCI168 AP(W) card: power amplifier with 4 Watts/channel at 4 Ohms
  *
- *  As this card probably doesn't have a DMA FIFO buffer, it is susceptible
- *  to DMA traffic underruns (resulting in sound crackling/clicking/popping).
- *  This is the case with VIA chipsets or, in my case, an SiS735, which is
+ *  Certain PCI versions of this card are susceptible to DMA traffic underruns
+ *  in some systems (resulting in sound crackling/clicking/popping),
+ *  probably because they don't have a DMA FIFO buffer or so.
+ *  Overview (PCI ID/PCI subID/PCI rev.):
+ *  - no DMA crackling on SiS735: 0x50DC/0x1801/16
+ *  - unknown performance: 0x50DC/0x1801/10
+ *  
+ *  Crackling happens with VIA chipsets or, in my case, an SiS735, which is
  *  supposed to be very fast and supposed to get rid of crackling much
  *  better than a VIA, yet ironically I still get crackling, like many other
  *  people with the same chipset.
Index: alsa-kernel/pci/maestro3.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/maestro3.c,v
retrieving revision 1.31
diff -u -r1.31 maestro3.c
--- alsa-kernel/pci/maestro3.c	11 Feb 2003 17:11:12 -0000	1.31
+++ alsa-kernel/pci/maestro3.c	18 Mar 2003 15:54:20 -0000
@@ -941,13 +941,14 @@
 	},
 	/* Dell Inspiron 8000 */
 	{
-		.name = "Dell Insprion 8000",
+		.name = "Dell Inspiron 8000",
 		.vendor = 0x1028,
 		.device = 0x00a4,
 		.amp_gpio = -1,
 		.irda_workaround = 1,
 	},
-	/* FIXME: Inspiron 8100 and 8200 ids should be here, too */
+	/* FIXME: Inspiron 8100 id should probably be here, too
+	 * (8200 irrelevant: has intel8x0 with CS4205) */
 	/* END */
 	{ 0 }
 };

-- 
Help prevent Information Technology Fascism! - before it's too late...
http://www.againsttcpa.com


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
