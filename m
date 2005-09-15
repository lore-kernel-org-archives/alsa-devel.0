From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] au88x0: codec access procs for multiple AC97 codecs
Date: Thu, 15 Sep 2005 23:56:17 +0300
Message-ID: <20050915205617.GD27700@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org, Philipp Matthias Hahn <pmhahn@titan.lahn.de>, Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org


This modification of au88x0's AC97 codec access procedures enables to
access multiple codecs.

Tested with au8810 (secondary codec was initialized for this case),
looks safe for others as well (au88x0 guys, please comment)


Sasha.



This patch extends au88x0 AC97 codec access procedures to handle multiple
codecs properly.

Signed-off-by: Sasha Khapyorsky

Index: alsa-kernel/pci/au88x0/au8810.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8810.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8810.h
--- alsa-kernel/pci/au88x0/au8810.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8810.h	15 Sep 2005 12:23:52 -0000
@@ -178,11 +178,6 @@
 #define		EN_SPDIF	0x000c0000
 
 #define VORTEX_CODEC_CHN 	0x29080
-#define VORTEX_CODEC_WRITE	0x00800000
-#define VORTEX_CODEC_ADDSHIFT 	16
-#define VORTEX_CODEC_ADDMASK	0x7f0000	/* 0x000f0000 */
-#define VORTEX_CODEC_DATSHIFT	0
-#define VORTEX_CODEC_DATMASK	0xffff
 #define VORTEX_CODEC_IO		0x29188
 
 /* SPDIF */
Index: alsa-kernel/pci/au88x0/au8820.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8820.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8820.h
--- alsa-kernel/pci/au88x0/au8820.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8820.h	15 Sep 2005 12:23:52 -0000
@@ -162,11 +162,6 @@
 #define		EN_SPORT	0x00030000
 #define		EN_SPDIF	0x000c0000
 #define VORTEX_CODEC_CHN 0x11880
-#define VORTEX_CODEC_WRITE 0x00800000
-#define VORTEX_CODEC_ADDSHIFT 16
-#define VORTEX_CODEC_ADDMASK 0x7f0000	/* 0x000f0000 */
-#define VORTEX_CODEC_DATSHIFT 0
-#define VORTEX_CODEC_DATMASK 0xffff
 #define VORTEX_CODEC_IO 0x11988
 
 #define VORTEX_SPDIF_FLAGS		0x1005c	/* FIXME */
Index: alsa-kernel/pci/au88x0/au8830.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8830.h,v
retrieving revision 1.3
diff -u -p -r1.3 au8830.h
--- alsa-kernel/pci/au88x0/au8830.h	13 Apr 2004 15:26:27 -0000	1.3
+++ alsa-kernel/pci/au88x0/au8830.h	15 Sep 2005 12:23:52 -0000
@@ -194,11 +194,6 @@
 
 #define VORTEX_CODEC_CTRL 0x29184
 #define VORTEX_CODEC_IO 0x29188
-#define 	VORTEX_CODEC_WRITE 0x00800000
-#define 	VORTEX_CODEC_ADDSHIFT 16
-#define 	VORTEX_CODEC_ADDMASK 0x7f0000	/* 0x000f0000 */
-#define 	VORTEX_CODEC_DATSHIFT 0
-#define 	VORTEX_CODEC_DATMASK 0xffff
 
 #define VORTEX_CODEC_SPORTCTRL 0x2918c
 
Index: alsa-kernel/pci/au88x0/au88x0.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0.h,v
retrieving revision 1.11
diff -u -p -r1.11 au88x0.h
--- alsa-kernel/pci/au88x0/au88x0.h	22 Mar 2005 08:50:55 -0000	1.11
+++ alsa-kernel/pci/au88x0/au88x0.h	15 Sep 2005 12:23:52 -0000
@@ -79,6 +79,14 @@
 #define VORTEX_RESOURCE_A3D	0x00000004
 #define VORTEX_RESOURCE_LAST	0x00000005
 
+/* codec io: VORTEX_CODEC_IO bits */
+#define VORTEX_CODEC_ID_SHIFT	24
+#define VORTEX_CODEC_WRITE	0x00800000
+#define VORTEX_CODEC_ADDSHIFT 	16
+#define VORTEX_CODEC_ADDMASK	0x7f0000
+#define VORTEX_CODEC_DATSHIFT	0
+#define VORTEX_CODEC_DATMASK	0xffff
+
 /* Check for SDAC bit in "Extended audio ID" AC97 register */
 //#define VORTEX_IS_QUAD(x) (((x)->codec == NULL) ?  0 : ((x)->codec->ext_id&0x80))
 #define VORTEX_IS_QUAD(x) ((x)->isquad)
Index: alsa-kernel/pci/au88x0/au88x0_core.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_core.c,v
retrieving revision 1.11
diff -u -p -r1.11 au88x0_core.c
--- alsa-kernel/pci/au88x0/au88x0_core.c	23 Feb 2005 11:00:31 -0000	1.11
+++ alsa-kernel/pci/au88x0/au88x0_core.c	15 Sep 2005 12:23:53 -0000
@@ -2532,7 +2532,8 @@ vortex_codec_write(ac97_t * codec, unsig
 	hwwrite(card->mmio, VORTEX_CODEC_IO,
 		((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
 		((data << VORTEX_CODEC_DATSHIFT) & VORTEX_CODEC_DATMASK) |
-		VORTEX_CODEC_WRITE);
+		VORTEX_CODEC_WRITE |
+		(codec->num << VORTEX_CODEC_ID_SHIFT) );
 
 	/* Flush Caches. */
 	hwread(card->mmio, VORTEX_CODEC_IO);
@@ -2554,7 +2555,8 @@ static unsigned short vortex_codec_read(
 		}
 	}
 	/* set up read address */
-	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK);
+	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
+		(codec->num << VORTEX_CODEC_ID_SHIFT) ;
 	hwwrite(card->mmio, VORTEX_CODEC_IO, read_addr);
 
 	/* wait for address */


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
