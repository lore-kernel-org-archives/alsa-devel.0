From: Laurence Darby <ldarby@sdf-eu.org>
Subject: vga kills the audio NO MORE !!!
Date: Sat, 14 May 2005 20:12:43 +0000 (UTC)
Message-ID: <Pine.NEB.4.62.0505141920320.23428@droog.sdf-eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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



I have a PCI trident cyberblade graphics chip, and if almost anything 
happened on screen, the audio would squeal and squawk.  I've fixed it for 
this card.  The doc at http://www.alsa-project.org/misc/vgakills.txt 
basically says to put the accelerator command queue status check back in 
to the graphics driver, which is what I've done, with some guess work 
too...

I think it slightly decreases performance, so the Xorg devs probably 
wouldn't be interested, but as it increases audio quality, I guess this is 
the place to post about it.  If there are other lists you think may be 
interested, feel free to forward it on.

You'd need to recompile all of Xorg for this, but I could post the 
compiled binary module (145Kb) too if anyone wants it.

Here's the patch against Xorg 6.8.2


--- old/xc/programs/Xserver/hw/xfree86/drivers/trident/blade_accel.c	2004-07-30 21:30:55.000000000 +0100
+++ xc/programs/Xserver/hw/xfree86/drivers/trident/blade_accel.c	2005-05-14 20:13:50.000000000 +0100
@@ -21,6 +21,8 @@
  *
  * Authors:  Alan Hourihane, <alanh@fairlite.demon.co.uk>
  * 
+ * Status check put back in by Laurence Darby, ldarby@sdf-eu.org
+ *
  * Trident Blade3D accelerated options.
  */
 /* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/trident/blade_accel.c,v 1.21 2003/10/30 13:38:01 alanh Exp $ */
@@ -41,6 +43,10 @@
 #include "xaalocal.h"
 
 static void BladeSync(ScrnInfoPtr pScrn);
+static void BladeSync_unsafe(ScrnInfoPtr pScrn);
+
+static int busy;
+
 #if 0
 static void BladeSetupForSolidLine(ScrnInfoPtr pScrn, int color,
 				int rop, unsigned int planemask);
@@ -270,6 +276,16 @@
     }
 }
 
+
+static void
+BladeSync_unsafe(ScrnInfoPtr pScrn)
+{
+	TRIDENTPtr pTrident = TRIDENTPTR(pScrn);
+	BLADEBUSY(busy);
+	while (busy != 0) { BLADEBUSY(busy); };
+}
+
+
 static void
 BladeSetupForScreenToScreenCopy(ScrnInfoPtr pScrn, 
 				int xdir, int ydir, int rop,
@@ -292,6 +308,7 @@
 	pTrident->BltScanDirection |= 1<<5;
     }
 #endif
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2148, XAAGetCopyROP(rop));
 }
 
@@ -304,6 +321,7 @@
 
     if (pTrident->Clipping) clip = 1;
 
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2144, 0xE0000000 | 1<<19 | 1<<4 | 1<<2 | pTrident->BltScanDirection | clip);
 
     if (pTrident->BltScanDirection) {
@@ -469,6 +487,7 @@
 {
     TRIDENTPtr pTrident = TRIDENTPTR(pScrn);
 
+    BladeSync_unsafe(pScrn);
     REPLICATE(color);
     BLADE_OUT(0x2160, color);
     BLADE_OUT(0x2148, XAAGetCopyROP(rop));
@@ -487,6 +506,7 @@
 {
     TRIDENTPtr pTrident = TRIDENTPTR(pScrn);
 
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2144, 0x20000000 | pTrident->BltScanDirection | 1<<19 | 1<<4 | 2<<2 | (pTrident->Clipping ? 1:0));
     BLADE_OUT(0x2108, y<<16 | x);
     BLADE_OUT(0x210C, ((y+h-1)&0xfff)<<16 | ((x+w-1)&0xfff));
@@ -538,6 +558,7 @@
     TRIDENTPtr pTrident = TRIDENTPTR(pScrn);
 
     pTrident->BltScanDirection = 0;
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2148, XAAGetCopyROP(rop));
     if (bg == -1) {
 	pTrident->BltScanDirection |= 2<<19;
@@ -567,6 +588,7 @@
     TRIDENTPtr pTrident = TRIDENTPTR(pScrn);
 
     if (skipleft) BladeSetClippingRectangle(pScrn,x+skipleft,y,(x+w-1),(y+h-1));
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2144, 0xE0000000 | pTrident->BltScanDirection | 1<<4 | (skipleft ? 1 : 0));
     BLADE_OUT(0x2108, (y&0xfff)<<16 | (x&0xfff));
     BLADE_OUT(0x210C, ((y+h-1)&0xfff)<<16 | ((x+w-1)&0xfff));
@@ -580,13 +602,14 @@
 {
     TRIDENTPtr pTrident = TRIDENTPTR(pScrn);
 
-    BladeSync(pScrn);
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2148, XAAGetPatternROP(rop));
 
     if (bg == -1) {
     REPLICATE(fg);
     BLADE_OUT(0x216C, 0x80000000 | 1<<30);
     BLADE_OUT(0x216C, 0x80000000 | 1<<28 | 1<<30);
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2170, patternx);
     BLADE_OUT(0x2170, patterny);
     BLADE_OUT(0x2174, fg);
@@ -598,6 +621,7 @@
     REPLICATE(bg);
     BLADE_OUT(0x216C, 0x80000000);
     BLADE_OUT(0x216C, 0x80000000 | 1<<28);
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2170, patternx);
     BLADE_OUT(0x2170, patterny);
     BLADE_OUT(0x2174, fg);
@@ -623,6 +647,7 @@
     int clip = 0;
 
     if (pTrident->Clipping) clip = 1;
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2144, 0x20000000 | pTrident->BltScanDirection | 7<<12 | 1<<4 | 1<<19 | 2<<2 | clip);
     BLADE_OUT(0x2108, y<<16 | x);
     BLADE_OUT(0x210C, ((y+h-1)&0xfff)<<16 | ((x+w-1)&0xfff));
@@ -677,6 +702,7 @@
 ){
     TRIDENTPtr pTrident = TRIDENTPTR(pScrn);
 
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2148, XAAGetCopyROP(rop));
     pTrident->BltScanDirection = 0;
 #if 0
@@ -696,6 +722,7 @@
     TRIDENTPtr pTrident = TRIDENTPTR(pScrn);
 
     if (skipleft) BladeSetClippingRectangle(pScrn,x+skipleft,y,(x+w-1),(y+h-1));
+    BladeSync_unsafe(pScrn);
     BLADE_OUT(0x2144, 0xE0000000 | 1<<19 | 1<<4 | pTrident->BltScanDirection | (skipleft ? 1 : 0));
     BLADE_OUT(0x2108, y<<16 | (x&0xfff));
     BLADE_OUT(0x210C, ((y+h-1)&0xfff)<<16 | ((x+w-1)&0xfff));


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
