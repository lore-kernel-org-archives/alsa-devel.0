From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH 2/6] au88x0: fix is-quad oops
Date: Sun, 24 Oct 2004 18:09:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041024220924.15687.42884.89608@pluton>
References: <20041024220909.15687.40786.20603@pluton>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from simmts12-srv.bellnexxia.net (simmts12.bellnexxia.net [206.47.199.141])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AD135283
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2004 00:09:23 +0200 (MEST)
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

Fixes an oops on module removal caused by dereferencing the codec pointer.
This is not the best solution, but it is the easiest and fixes things for
now.

Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>

diff -ur 2.6.10-resetup/sound/pci/au88x0/au88x0.h working/sound/pci/au88x0/au88x0.h
--- 2.6.10-resetup/sound/pci/au88x0/au88x0.h	2004-10-23 21:01:38 -0400
+++ working/sound/pci/au88x0/au88x0.h	2004-10-23 21:03:07 -0400
@@ -80,7 +80,8 @@
 #define VORTEX_RESOURCE_LAST	0x00000005
 
 /* Check for SDAC bit in "Extended audio ID" AC97 register */
-#define VORTEX_IS_QUAD(x) ((x->codec == NULL) ?  0 : (x->codec->ext_id&0x80))
+//#define VORTEX_IS_QUAD(x) (((x)->codec == NULL) ?  0 : ((x)->codec->ext_id&0x80))
+#define VORTEX_IS_QUAD(x) ((x)->isquad)
 /* Check if chip has bug. */
 #define IS_BAD_CHIP(x) (\
 	(x->rev == 0xfe && x->device == PCI_DEVICE_ID_AUREAL_VORTEX_2) || \
@@ -164,6 +165,8 @@
 	int xt_mode;		/* 1: speakers, 0:headphones. */
 #endif
 
+	int isquad;		/* cache of extended ID codec flag. */
+
 	/* Gameport stuff. */
 	struct gameport *gameport;
 
diff -ur 2.6.10-resetup/sound/pci/au88x0/au88x0.h.orig working/sound/pci/au88x0/au88x0.h.orig
--- 2.6.10-resetup/sound/pci/au88x0/au88x0.h.orig	2004-10-23 16:37:21 -0400
+++ working/sound/pci/au88x0/au88x0.h.orig	2004-10-23 21:01:38 -0400
@@ -208,6 +208,7 @@
 static void vortex_adbdma_pausefifo(vortex_t * vortex, int adbdma);
 static void vortex_adbdma_resumefifo(vortex_t * vortex, int adbdma);
 static int inline vortex_adbdma_getlinearpos(vortex_t * vortex, int adbdma);
+void vortex_adbdma_resetup(vortex_t *vortex, int adbdma);
 
 #ifndef CHIP_AU8810
 static void vortex_wtdma_startfifo(vortex_t * vortex, int wtdma);
diff -ur 2.6.10-resetup/sound/pci/au88x0/au88x0_mixer.c working/sound/pci/au88x0/au88x0_mixer.c
--- 2.6.10-resetup/sound/pci/au88x0/au88x0_mixer.c	2004-10-23 16:37:21 -0400
+++ working/sound/pci/au88x0/au88x0_mixer.c	2004-10-23 21:03:07 -0400
@@ -26,5 +26,7 @@
 	memset(&ac97, 0, sizeof(ac97));
 	// Intialize AC97 codec stuff.
 	ac97.private_data = vortex;
-	return snd_ac97_mixer(pbus, &ac97, &vortex->codec);
+	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
+	vortex->isquad = ((vortex->codec == NULL) ?  0 : (vortex->codec->ext_id&0x80));
+	return err;
 }


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
