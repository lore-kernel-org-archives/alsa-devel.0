From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH 2/2] au88x0 eq cleanups
Date: Thu, 05 Aug 2004 22:01:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4112E672.40808@rogers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020804050604080100050404"
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

This is a multi-part message in MIME format.
--------------020804050604080100050404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

some other misc eq cleanups

-Jeff


--------------020804050604080100050404
Content-Type: text/x-patch;
 name="vortex-eq-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vortex-eq-cleanup.patch"

diff -ur linux-2.6.7-rc1-bk5-build-test/sound/pci/au88x0/au88x0_eq.c linux-2.6.7-rc1-bk5-build-test2/sound/pci/au88x0/au88x0_eq.c
--- linux-2.6.7-rc1-bk5-build-test/sound/pci/au88x0/au88x0_eq.c	2004-07-17 12:56:02.000000000 -0400
+++ linux-2.6.7-rc1-bk5-build-test2/sound/pci/au88x0/au88x0_eq.c	2004-07-17 12:54:13.000000000 -0400
@@ -40,41 +40,46 @@
 #include "au88x0_eq.h"
 #include "au88x0_eqdata.c"
 
+#define VORTEX_EQ_BASE	 0x2b000
+#define VORTEX_EQ_DEST   (VORTEX_EQ_BASE + 0x410)
+#define VORTEX_EQ_SOURCE (VORTEX_EQ_BASE + 0x430)
+#define VORTEX_EQ_CTRL   (VORTEX_EQ_BASE + 0x440)
+
 /* CEqHw.s */
-static void vortex_EqHw_SetTimeConsts(vortex_t * vortex, u16 a, u16 b)
+static void vortex_EqHw_SetTimeConsts(vortex_t * vortex, u16 gain, u16 level)
 {
-	hwwrite(vortex->mmio, 0x2b3c4, a);
-	hwwrite(vortex->mmio, 0x2b3c8, b);
+	hwwrite(vortex->mmio, 0x2b3c4, gain);
+	hwwrite(vortex->mmio, 0x2b3c8, level);
 }
 
-static void vortex_EqHw_SetLeftCoefs(vortex_t * vortex, u16 a[])
+static void vortex_EqHw_SetLeftCoefs(vortex_t * vortex, u16 coefs[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
 	int eax, i = 0, n /*esp2c */;
 
 	for (n = 0; n < eqhw->this04; n++) {
-		hwwrite(vortex->mmio, 0x2b000 + n * 0x30, a[i + 0]);
-		hwwrite(vortex->mmio, 0x2b004 + n * 0x30, a[i + 1]);
+		hwwrite(vortex->mmio, 0x2b000 + n * 0x30, coefs[i + 0]);
+		hwwrite(vortex->mmio, 0x2b004 + n * 0x30, coefs[i + 1]);
 
 		if (eqhw->this08 == 0) {
-			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, a[i + 2]);
-			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, a[i + 3]);
-			eax = a[i + 4];	//esp24;
+			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, coefs[i + 2]);
+			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, coefs[i + 3]);
+			eax = coefs[i + 4];	//esp24;
 		} else {
-			if (a[2 + i] == 0x8000)
+			if (coefs[2 + i] == 0x8000)
 				eax = 0x7fff;
 			else
-				eax = ~a[2 + i];
+				eax = ~coefs[2 + i];
 			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, eax & 0xffff);
-			if (a[3 + i] == 0x8000)
+			if (coefs[3 + i] == 0x8000)
 				eax = 0x7fff;
 			else
-				eax = ~a[3 + i];
+				eax = ~coefs[3 + i];
 			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, eax & 0xffff);
-			if (a[4 + i] == 0x8000)
+			if (coefs[4 + i] == 0x8000)
 				eax = 0x7fff;
 			else
-				eax = ~a[4 + i];
+				eax = ~coefs[4 + i];
 		}
 		hwwrite(vortex->mmio, 0x2b010 + n * 0x30, eax);
 
@@ -82,34 +87,34 @@
 	}
 }
 
-static void vortex_EqHw_SetRightCoefs(vortex_t * vortex, u16 a[])
+static void vortex_EqHw_SetRightCoefs(vortex_t * vortex, u16 coefs[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
 	int i = 0, n /*esp2c */, eax;
 
 	for (n = 0; n < eqhw->this04; n++) {
-		hwwrite(vortex->mmio, 0x2b1e0 + n * 0x30, a[0 + i]);
-		hwwrite(vortex->mmio, 0x2b1e4 + n * 0x30, a[1 + i]);
+		hwwrite(vortex->mmio, 0x2b1e0 + n * 0x30, coefs[0 + i]);
+		hwwrite(vortex->mmio, 0x2b1e4 + n * 0x30, coefs[1 + i]);
 
 		if (eqhw->this08 == 0) {
-			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, a[2 + i]);
-			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, a[3 + i]);
-			eax = a[4 + i];	//*esp24;
+			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, coefs[2 + i]);
+			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, coefs[3 + i]);
+			eax = coefs[4 + i];	//*esp24;
 		} else {
-			if (a[2 + i] == 0x8000)
+			if (coefs[2 + i] == 0x8000)
 				eax = 0x7fff;
 			else
-				eax = ~(a[2 + i]);
+				eax = ~(coefs[2 + i]);
 			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, eax & 0xffff);
-			if (a[3 + i] == 0x8000)
+			if (coefs[3 + i] == 0x8000)
 				eax = 0x7fff;
 			else
-				eax = ~a[3 + i];
+				eax = ~coefs[3 + i];
 			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, eax & 0xffff);
-			if (a[4 + i] == 0x8000)
+			if (coefs[4 + i] == 0x8000)
 				eax = 0x7fff;
 			else
-				eax = ~a[4 + i];
+				eax = ~coefs[4 + i];
 		}
 		hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, eax);
 		i += 5;
@@ -120,7 +125,7 @@
 static void vortex_EqHw_SetLeftStates(vortex_t * vortex, u16 a[], u16 b[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int i = 0, ebx = 0;
+	int i = 0, ebx;
 
 	hwwrite(vortex->mmio, 0x2b3fc, a[0]);
 	hwwrite(vortex->mmio, 0x2b400, a[1]);
@@ -137,7 +142,7 @@
 static void vortex_EqHw_SetRightStates(vortex_t * vortex, u16 a[], u16 b[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int i = 0, ebx = 0;
+	int i = 0, ebx;
 
 	hwwrite(vortex->mmio, 0x2b404, a[0]);
 	hwwrite(vortex->mmio, 0x2b408, a[1]);
@@ -418,12 +423,12 @@
 #endif
 static void vortex_EqHw_Enable(vortex_t * vortex)
 {
-	hwwrite(vortex->mmio, 0x2b440, 0xf001);
+	hwwrite(vortex->mmio, VORTEX_EQ_CTRL, 0xf001);
 }
 
 static void vortex_EqHw_Disable(vortex_t * vortex)
 {
-	hwwrite(vortex->mmio, 0x2b440, 0xf000);
+	hwwrite(vortex->mmio, VORTEX_EQ_CTRL, 0xf000);
 }
 
 /* Reset (zero) buffers */
@@ -431,16 +436,16 @@
 {
 	int i;
 	for (i = 0; i < 0x8; i++)
-		hwwrite(vortex->mmio, 0x2b410 + (i << 2), 0x0);
+		hwwrite(vortex->mmio, VORTEX_EQ_DEST + (i << 2), 0x0);
 	for (i = 0; i < 0x4; i++)
-		hwwrite(vortex->mmio, 0x2b430 + (i << 2), 0x0);
+		hwwrite(vortex->mmio, VORTEX_EQ_SOURCE + (i << 2), 0x0);
 }
 
 static void vortex_EqHw_ZeroA3DIO(vortex_t * vortex)
 {
 	int i;
 	for (i = 0; i < 0x4; i++)
-		hwwrite(vortex->mmio, 0x2b410 + (i << 2), 0x0);
+		hwwrite(vortex->mmio, VORTEX_EQ_DEST + (i << 2), 0x0);
 }
 
 static void vortex_EqHw_ZeroState(vortex_t * vortex)
@@ -611,11 +616,10 @@
 	if (((eq->this10) * 2 != count) || (eq->this28 == 0))
 		return 1;
 
-	if (0 < count) {
-		for (i = 0; i < count; i++) {
-			eq->this130[i] = gains[i];
-		}
+	for (i = 0; i < count; i++) {
+		eq->this130[i] = gains[i];
 	}
+	
 	if (eq->this54)
 		return 0;
 	return vortex_Eqlzr_SetAllBandsFromActiveCoeffSet(vortex);

--------------020804050604080100050404--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
