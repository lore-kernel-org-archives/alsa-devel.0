From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH 3/6] au88x0: set-levels cleanup
Date: Sun, 24 Oct 2004 18:09:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041024220932.15687.4288.93778@pluton>
References: <20041024220909.15687.40786.20603@pluton>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from simmts12-srv.bellnexxia.net (simmts12.bellnexxia.net [206.47.199.141])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E372283
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2004 00:09:30 +0200 (MEST)
In-Reply-To: <20041024220909.15687.40786.20603@pluton>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: openvortex-dev@nongnu.org, Jeff Muizelaar <muizelaar@rogers.com>
List-Id: alsa-devel@alsa-project.org

Cleanup vortex_EqHw_SetLevels and add a bit of documentation

Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>

diff -ur is-quad/sound/pci/au88x0/au88x0_eq.c working/sound/pci/au88x0/au88x0_eq.c
--- is-quad/sound/pci/au88x0/au88x0_eq.c	2004-10-23 16:37:21 -0400
+++ working/sound/pci/au88x0/au88x0_eq.c	2004-10-23 21:04:05 -0400
@@ -45,6 +45,8 @@
 #define VORTEX_EQ_SOURCE (VORTEX_EQ_BASE + 0x430)
 #define VORTEX_EQ_CTRL   (VORTEX_EQ_BASE + 0x440)
 
+#define VORTEX_BAND_COEFF_SIZE 0x30
+
 /* CEqHw.s */
 static void vortex_EqHw_SetTimeConsts(vortex_t * vortex, u16 gain, u16 level)
 {
@@ -319,25 +321,27 @@
 
 #endif
 /* EQ band levels settings */
-static void vortex_EqHw_SetLevels(vortex_t * vortex, u16 a[])
+static void vortex_EqHw_SetLevels(vortex_t * vortex, u16 peaks[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int ebx;
+	int i;
 
-	for (ebx = 0; ebx < eqhw->this04; ebx++) {
-		hwwrite(vortex->mmio, 0x2b024 + ebx * 0x30, a[ebx]);
+	/* set left peaks */
+	for (i = 0; i < eqhw->this04; i++) {
+		hwwrite(vortex->mmio, 0x2b024 + i * VORTEX_BAND_COEFF_SIZE, peaks[i]);
 	}
 
-	hwwrite(vortex->mmio, 0x2b3cc, a[eqhw->this04]);
-	hwwrite(vortex->mmio, 0x2b3d8, a[eqhw->this04 + 1]);
+	hwwrite(vortex->mmio, 0x2b3cc, peaks[eqhw->this04]);
+	hwwrite(vortex->mmio, 0x2b3d8, peaks[eqhw->this04 + 1]);
 
-	for (ebx = 0; ebx < eqhw->this04; ebx++) {
-		hwwrite(vortex->mmio, 0x2b204 + ebx * 0x30,
-			a[ebx + (eqhw->this04 + 2)]);
+	/* set right peaks */
+	for (i = 0; i < eqhw->this04; i++) {
+		hwwrite(vortex->mmio, 0x2b204 + i * VORTEX_BAND_COEFF_SIZE,
+			peaks[i + (eqhw->this04 + 2)]);
 	}
 
-	hwwrite(vortex->mmio, 0x2b3e4, a[2 + (eqhw->this04 * 2)]);
-	hwwrite(vortex->mmio, 0x2b3f0, a[3 + (eqhw->this04 * 2)]);
+	hwwrite(vortex->mmio, 0x2b3e4, peaks[2 + (eqhw->this04 * 2)]);
+	hwwrite(vortex->mmio, 0x2b3f0, peaks[3 + (eqhw->this04 * 2)]);
 }
 
 #if 0


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
