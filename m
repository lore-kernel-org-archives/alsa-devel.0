From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH] more au88x0 eq cleanups
Date: Tue, 21 Sep 2004 08:07:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41501995.8030203@rogers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070906010206060304010501"
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
--------------070906010206060304010501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached patch does more cleanups on the eq code. Acked by Manuel.

-Jeff

--------------070906010206060304010501
Content-Type: text/x-patch;
 name="01-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-cleanup.patch"

diff -ur virgin/sound/pci/au88x0/au88x0_eq.c working/sound/pci/au88x0/au88x0_eq.c
--- virgin/sound/pci/au88x0/au88x0_eq.c	2004-09-08 14:18:17.000000000 -0400
+++ working/sound/pci/au88x0/au88x0_eq.c	2004-09-08 14:33:38.000000000 -0400
@@ -52,37 +52,33 @@
 	hwwrite(vortex->mmio, 0x2b3c8, level);
 }
 
+static inline short sign_invert(short a)
+{
+	/* -(-32768) -> -32768 so we do -(-32768) -> 32767 to make the result positive */
+	if (a == -32768)
+		return 32767;
+	else
+		return -a;
+}
+
 static void vortex_EqHw_SetLeftCoefs(vortex_t * vortex, u16 coefs[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int eax, i = 0, n /*esp2c */;
+	int i = 0, n /*esp2c */;
 
 	for (n = 0; n < eqhw->this04; n++) {
 		hwwrite(vortex->mmio, 0x2b000 + n * 0x30, coefs[i + 0]);
 		hwwrite(vortex->mmio, 0x2b004 + n * 0x30, coefs[i + 1]);
 
 		if (eqhw->this08 == 0) {
-			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, coefs[i + 2]);
-			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, coefs[i + 3]);
-			eax = coefs[i + 4];	//esp24;
+			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, coefs[i + 2] & 0xffff);
+			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, coefs[i + 3] & 0xffff);
+			hwwrite(vortex->mmio, 0x2b010 + n * 0x30, coefs[i + 4] & 0xffff);
 		} else {
-			if (coefs[2 + i] == 0x8000)
-				eax = 0x7fff;
-			else
-				eax = ~coefs[2 + i];
-			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, eax & 0xffff);
-			if (coefs[3 + i] == 0x8000)
-				eax = 0x7fff;
-			else
-				eax = ~coefs[3 + i];
-			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, eax & 0xffff);
-			if (coefs[4 + i] == 0x8000)
-				eax = 0x7fff;
-			else
-				eax = ~coefs[4 + i];
+			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, sign_invert(coefs[2 + i]) & 0xffff);
+			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, sign_invert(coefs[3 + i]) & 0xffff);
+		        hwwrite(vortex->mmio, 0x2b010 + n * 0x30, sign_invert(coefs[4 + i]) & 0xffff);
 		}
-		hwwrite(vortex->mmio, 0x2b010 + n * 0x30, eax);
-
 		i += 5;
 	}
 }
@@ -90,33 +86,21 @@
 static void vortex_EqHw_SetRightCoefs(vortex_t * vortex, u16 coefs[])
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int i = 0, n /*esp2c */, eax;
+	int i = 0, n /*esp2c */;
 
 	for (n = 0; n < eqhw->this04; n++) {
 		hwwrite(vortex->mmio, 0x2b1e0 + n * 0x30, coefs[0 + i]);
 		hwwrite(vortex->mmio, 0x2b1e4 + n * 0x30, coefs[1 + i]);
 
 		if (eqhw->this08 == 0) {
-			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, coefs[2 + i]);
-			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, coefs[3 + i]);
-			eax = coefs[4 + i];	//*esp24;
+			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, coefs[2 + i] & 0xffff);
+			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, coefs[3 + i] & 0xffff);
+			hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, coefs[4 + i] & 0xffff);
 		} else {
-			if (coefs[2 + i] == 0x8000)
-				eax = 0x7fff;
-			else
-				eax = ~(coefs[2 + i]);
-			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, eax & 0xffff);
-			if (coefs[3 + i] == 0x8000)
-				eax = 0x7fff;
-			else
-				eax = ~coefs[3 + i];
-			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, eax & 0xffff);
-			if (coefs[4 + i] == 0x8000)
-				eax = 0x7fff;
-			else
-				eax = ~coefs[4 + i];
+			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, sign_invert(coefs[2 + i]) & 0xffff);
+			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, sign_invert(coefs[3 + i]) & 0xffff);
+			hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, sign_invert(coefs[4 + i]) & 0xffff);
 		}
-		hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, eax);
 		i += 5;
 	}
 
@@ -188,22 +172,12 @@
 static void vortex_EqHw_SetBypassGain(vortex_t * vortex, u16 a, u16 b)
 {
 	eqhw_t *eqhw = &(vortex->eq.this04);
-	int eax;
-
 	if (eqhw->this08 == 0) {
 		hwwrite(vortex->mmio, 0x2b3d4, a);
 		hwwrite(vortex->mmio, 0x2b3ec, b);
 	} else {
-		if (a == 0x8000)
-			eax = 0x7fff;
-		else
-			eax = ~a;
-		hwwrite(vortex->mmio, 0x2b3d4, eax & 0xffff);
-		if (b == 0x8000)
-			eax = 0x7fff;
-		else
-			eax = ~b;
-		hwwrite(vortex->mmio, 0x2b3ec, eax & 0xffff);
+		hwwrite(vortex->mmio, 0x2b3d4, sign_invert(a) & 0xffff);
+		hwwrite(vortex->mmio, 0x2b3ec, sign_invert(b) & 0xffff);
 	}
 }
 

--------------070906010206060304010501--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
