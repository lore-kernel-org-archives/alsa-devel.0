From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH 4/6] au88x0: sign_invert cleanup
Date: Sun, 24 Oct 2004 18:09:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041024220939.15687.67664.75443@pluton>
References: <20041024220909.15687.40786.20603@pluton>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from simmts12-srv.bellnexxia.net (simmts12.bellnexxia.net [206.47.199.141])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9580A283
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2004 00:09:38 +0200 (MEST)
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

Remove unecessary ' & 0xffff'ing of the result of sign_invert

diff -ur set-levels/sound/pci/au88x0/au88x0_eq.c working/sound/pci/au88x0/au88x0_eq.c
--- set-levels/sound/pci/au88x0/au88x0_eq.c	2004-10-23 21:04:05 -0400
+++ working/sound/pci/au88x0/au88x0_eq.c	2004-10-23 21:05:16 -0400
@@ -54,7 +54,7 @@
 	hwwrite(vortex->mmio, 0x2b3c8, level);
 }
 
-static inline short sign_invert(short a)
+static inline u16 sign_invert(u16 a)
 {
 	/* -(-32768) -> -32768 so we do -(-32768) -> 32767 to make the result positive */
 	if (a == -32768)
@@ -73,13 +73,13 @@
 		hwwrite(vortex->mmio, 0x2b004 + n * 0x30, coefs[i + 1]);
 
 		if (eqhw->this08 == 0) {
-			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, coefs[i + 2] & 0xffff);
-			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, coefs[i + 3] & 0xffff);
-			hwwrite(vortex->mmio, 0x2b010 + n * 0x30, coefs[i + 4] & 0xffff);
+			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, coefs[i + 2]);
+			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, coefs[i + 3]);
+			hwwrite(vortex->mmio, 0x2b010 + n * 0x30, coefs[i + 4]);
 		} else {
-			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, sign_invert(coefs[2 + i]) & 0xffff);
-			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, sign_invert(coefs[3 + i]) & 0xffff);
-		        hwwrite(vortex->mmio, 0x2b010 + n * 0x30, sign_invert(coefs[4 + i]) & 0xffff);
+			hwwrite(vortex->mmio, 0x2b008 + n * 0x30, sign_invert(coefs[2 + i]));
+			hwwrite(vortex->mmio, 0x2b00c + n * 0x30, sign_invert(coefs[3 + i]));
+		        hwwrite(vortex->mmio, 0x2b010 + n * 0x30, sign_invert(coefs[4 + i]));
 		}
 		i += 5;
 	}
@@ -95,13 +95,13 @@
 		hwwrite(vortex->mmio, 0x2b1e4 + n * 0x30, coefs[1 + i]);
 
 		if (eqhw->this08 == 0) {
-			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, coefs[2 + i] & 0xffff);
-			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, coefs[3 + i] & 0xffff);
-			hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, coefs[4 + i] & 0xffff);
+			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, coefs[2 + i]);
+			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, coefs[3 + i]);
+			hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, coefs[4 + i]);
 		} else {
-			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, sign_invert(coefs[2 + i]) & 0xffff);
-			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, sign_invert(coefs[3 + i]) & 0xffff);
-			hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, sign_invert(coefs[4 + i]) & 0xffff);
+			hwwrite(vortex->mmio, 0x2b1e8 + n * 0x30, sign_invert(coefs[2 + i]));
+			hwwrite(vortex->mmio, 0x2b1ec + n * 0x30, sign_invert(coefs[3 + i]));
+			hwwrite(vortex->mmio, 0x2b1f0 + n * 0x30, sign_invert(coefs[4 + i]));
 		}
 		i += 5;
 	}
@@ -178,8 +178,8 @@
 		hwwrite(vortex->mmio, 0x2b3d4, a);
 		hwwrite(vortex->mmio, 0x2b3ec, b);
 	} else {
-		hwwrite(vortex->mmio, 0x2b3d4, sign_invert(a) & 0xffff);
-		hwwrite(vortex->mmio, 0x2b3ec, sign_invert(b) & 0xffff);
+		hwwrite(vortex->mmio, 0x2b3d4, sign_invert(a));
+		hwwrite(vortex->mmio, 0x2b3ec, sign_invert(b));
 	}
 }
 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
