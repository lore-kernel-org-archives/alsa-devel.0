From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH 1/2] au88x0 eq cleanups
Date: Thu, 05 Aug 2004 22:00:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4112E63E.1050102@rogers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010306090107010300030408"
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
--------------010306090107010300030408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Cleans up the equalizer code by converting some loops to proper for
loops and fixes the conditions for looping.

Approved by Manuel Jander.

-Jeff


--------------010306090107010300030408
Content-Type: text/x-patch;
 name="vortex-convert-to-for-loops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vortex-convert-to-for-loops.patch"

diff -urN linux-2.6.7-rc1/sound/pci/au88x0/au88x0_eq.c linux-2.6.7-rc1-vortex/sound/pci/au88x0/au88x0_eq.c
--- linux-2.6.7-rc1/sound/pci/au88x0/au88x0_eq.c	2004-05-09 22:33:19.000000000 -0400
+++ linux-2.6.7-rc1-vortex/sound/pci/au88x0/au88x0_eq.c	2004-06-27 19:54:30.000000000 -0400
@@ -50,12 +50,9 @@
 static void vortex_EqHw_SetLeftCoefs(vortex_t * vortex, u16 a[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int eax, i = 0, n /*esp2c */  = 0;
+	int eax, i = 0, n /*esp2c */;
 
-	if (eqhw->this04 <= n)
-		return;
-
-	do {
+	for (n = 0; n < eqhw->this04; n++) {
 		hwwrite(vortex->mmio, 0x2b000 + n * 0x30, a[i + 0]);
 		hwwrite(vortex->mmio, 0x2b004 + n * 0x30, a[i + 1]);
 
@@ -81,21 +78,16 @@
 		}
 		hwwrite(vortex->mmio, 0x2b010 + n * 0x30, eax);
 
-		n++;
 		i += 5;
 	}
-	while (n < eqhw->this04);
 }
 
 static void vortex_EqHw_SetRightCoefs(vortex_t * vortex, u16 a[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int i = 0, n /*esp2c */  = 0, eax;
-
-	if (eqhw->this04 <= n)
-		return;
+	int i = 0, n /*esp2c */, eax;
 
-	do {
+	for (n = 0; n < eqhw->this04; n++) {
 		hwwrite(vortex->mmio, 0x2b1e0 + n * 0x30, a[0 + i]);
 		hwwrite(vortex->mmio, 0x2b1e4 + n * 0x30, a[1 + i]);
 
@@ -121,54 +113,42 @@
 		}
 		hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, eax);
 		i += 5;
-		n++;
 	}
-	while (n < eqhw->this04);
 
 }
 
 static void vortex_EqHw_SetLeftStates(vortex_t * vortex, u16 a[], u16 b[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int i = 0, ebx = 0;
+	int i = 0, ebx = 0;
 
 	hwwrite(vortex->mmio, 0x2b3fc, a[0]);
 	hwwrite(vortex->mmio, 0x2b400, a[1]);
 
-	if (eqhw->this04 < 0)
-		return;
-
-	do {
+	for (ebx = 0; ebx < eqhw->this04; ebx++) {
 		hwwrite(vortex->mmio, 0x2b014 + (i * 0xc), b[i]);
 		hwwrite(vortex->mmio, 0x2b018 + (i * 0xc), b[1 + i]);
 		hwwrite(vortex->mmio, 0x2b01c + (i * 0xc), b[2 + i]);
 		hwwrite(vortex->mmio, 0x2b020 + (i * 0xc), b[3 + i]);
 		i += 4;
-		ebx++;
 	}
-	while (eqhw->this04 > ebx);
 }
 
 static void vortex_EqHw_SetRightStates(vortex_t * vortex, u16 a[], u16 b[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int i = 0, ebx = 0;
+	int i = 0, ebx = 0;
 
 	hwwrite(vortex->mmio, 0x2b404, a[0]);
 	hwwrite(vortex->mmio, 0x2b408, a[1]);
 
-	if (eqhw->this04 < 0)
-		return;
-
-	do {
+	for (ebx = 0; ebx < eqhw->this04; ebx++) {
 		hwwrite(vortex->mmio, 0x2b1f4 + (i * 0xc), b[i]);
 		hwwrite(vortex->mmio, 0x2b1f8 + (i * 0xc), b[1 + i]);
 		hwwrite(vortex->mmio, 0x2b1fc + (i * 0xc), b[2 + i]);
 		hwwrite(vortex->mmio, 0x2b200 + (i * 0xc), b[3 + i]);
 		i += 4;
-		ebx++;
 	}
-	while (ebx < eqhw->this04);
 }
 
 #if 0
@@ -260,60 +240,41 @@
 static void vortex_EqHw_SetLeftGainsTarget(vortex_t * vortex, u16 a[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int ebx = 0;
+	int ebx;
 
-	if (eqhw->this04 < 0)
-		return;
-	do {
+	for (ebx = 0; ebx < eqhw->this04; ebx++) {
 		hwwrite(vortex->mmio, 0x2b02c + ebx * 0x30, a[ebx]);
-		ebx++;
 	}
-	while (ebx < eqhw->this04);
 }
 
 static void vortex_EqHw_SetRightGainsTarget(vortex_t * vortex, u16 a[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int ebx = 0;
-
-	if (eqhw->this04 < 0)
-		return;
+	int ebx;
 
-	do {
+	for (ebx = 0; ebx < eqhw->this04; ebx++) {
 		hwwrite(vortex->mmio, 0x2b20c + ebx * 0x30, a[ebx]);
-		ebx++;
 	}
-	while (ebx < eqhw->this04);
 }
 
 static void vortex_EqHw_SetLeftGainsCurrent(vortex_t * vortex, u16 a[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int ebx = 0;
-
-	if (eqhw->this04 < 0)
-		return;
+	int ebx;
 
-	do {
+	for (ebx = 0; ebx < eqhw->this04; ebx++) {
 		hwwrite(vortex->mmio, 0x2b028 + ebx * 0x30, a[ebx]);
-		ebx++;
 	}
-	while (ebx < eqhw->this04);
 }
 
 static void vortex_EqHw_SetRightGainsCurrent(vortex_t * vortex, u16 a[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int ebx = 0;
-
-	if (eqhw->this04 < 0)
-		return;
+	int ebx;
 
-	do {
+	for (ebx = 0; ebx < eqhw->this04; ebx++) {
 		hwwrite(vortex->mmio, 0x2b208 + ebx * 0x30, a[ebx]);
-		ebx++;
 	}
-	while (ebx < eqhw->this04);
 }
 
 #if 0
@@ -384,26 +345,17 @@
 	eqhw_t *eqhw = &(vortex->eq.this04);
 	int ebx;
 
-	if (eqhw->this04 < 0)
-		return;
-
-	ebx = 0;
-	do {
+	for (ebx = 0; ebx < eqhw->this04; ebx++) {
 		hwwrite(vortex->mmio, 0x2b024 + ebx * 0x30, a[ebx]);
-		ebx++;
 	}
-	while (ebx < eqhw->this04);
 
 	hwwrite(vortex->mmio, 0x2b3cc, a[eqhw->this04]);
 	hwwrite(vortex->mmio, 0x2b3d8, a[eqhw->this04 + 1]);
 
-	ebx = 0;
-	do {
+	for (ebx = 0; ebx < eqhw->this04; ebx++) {
 		hwwrite(vortex->mmio, 0x2b204 + ebx * 0x30,
 			a[ebx + (eqhw->this04 + 2)]);
-		ebx++;
 	}
-	while (ebx < eqhw->this04);
 
 	hwwrite(vortex->mmio, 0x2b3e4, a[2 + (eqhw->this04 * 2)]);
 	hwwrite(vortex->mmio, 0x2b3f0, a[3 + (eqhw->this04 * 2)]);

--------------010306090107010300030408--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
