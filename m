From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH 1/6] au88x0: add resetup dma
Date: Sun, 24 Oct 2004 18:09:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041024220909.15687.40786.20603@pluton>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from simmts12-srv.bellnexxia.net (simmts12.bellnexxia.net [206.47.199.141])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E38DC283
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2004 00:09:18 +0200 (MEST)
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

Add adbdma_resetup for refreshing the hw page table on pcm start

Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>

diff -ur 2.6.10-alsa/sound/pci/au88x0/au88x0_core.c 2.6.10-resetup/sound/pci/au88x0/au88x0_core.c
--- 2.6.10-alsa/sound/pci/au88x0/au88x0_core.c	2004-10-23 16:37:21 -0400
+++ 2.6.10-resetup/sound/pci/au88x0/au88x0_core.c	2004-10-24 17:58:42 -0400
@@ -1223,6 +1223,33 @@
 	return delta;
 }
 
+
+static void vortex_adbdma_resetup(vortex_t *vortex, int adbdma) {
+	stream_t *dma = &vortex->dma_adb[adbdma];
+	int p, pp, i;
+
+	/* refresh hw page table */
+	for (i=0 ; i < 4 && i < dma->nr_periods; i++) {
+		/* p: audio buffer page index */
+		p = dma->period_virt + i;
+		if (p >= dma->nr_periods)
+			p -= dma->nr_periods;
+		/* pp: hardware DMA page index. */
+		pp = dma->period_real + i;
+		if (dma->nr_periods < 4) {
+			if (pp >= dma->nr_periods)
+				pp -= dma->nr_periods;
+		}
+		else {
+			if (pp >= 4)
+				pp -= 4;
+		}
+		hwwrite(vortex->mmio, VORTEX_ADBDMA_BUFBASE+(((adbdma << 2)+pp) << 2), snd_sgbuf_get_addr(dma->sgbuf, dma->period_bytes * p));
+		/* Force write thru cache. */
+		hwread(vortex->mmio, VORTEX_ADBDMA_BUFBASE + (((adbdma << 2)+pp) << 2));
+	}
+}
+
 static int inline vortex_adbdma_getlinearpos(vortex_t * vortex, int adbdma)
 {
 	stream_t *dma = &vortex->dma_adb[adbdma];
diff -ur 2.6.10-alsa/sound/pci/au88x0/au88x0.h 2.6.10-resetup/sound/pci/au88x0/au88x0.h
--- 2.6.10-alsa/sound/pci/au88x0/au88x0.h	2004-10-23 16:37:21 -0400
+++ 2.6.10-resetup/sound/pci/au88x0/au88x0.h	2004-10-24 18:00:01 -0400
@@ -208,6 +208,7 @@
 static void vortex_adbdma_pausefifo(vortex_t * vortex, int adbdma);
 static void vortex_adbdma_resumefifo(vortex_t * vortex, int adbdma);
 static int inline vortex_adbdma_getlinearpos(vortex_t * vortex, int adbdma);
+static void vortex_adbdma_resetup(vortex_t *vortex, int adbdma);
 
 #ifndef CHIP_AU8810
 static void vortex_wtdma_startfifo(vortex_t * vortex, int wtdma);
diff -ur 2.6.10-alsa/sound/pci/au88x0/au88x0_pcm.c 2.6.10-resetup/sound/pci/au88x0/au88x0_pcm.c
--- 2.6.10-alsa/sound/pci/au88x0/au88x0_pcm.c	2004-10-23 16:37:21 -0400
+++ 2.6.10-resetup/sound/pci/au88x0/au88x0_pcm.c	2004-10-24 17:57:48 -0400
@@ -313,8 +313,10 @@
 		// do something to start the PCM engine
 		//printk(KERN_INFO "vortex: start %d\n", dma);
 		stream->fifo_enabled = 1;
-		if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT)
+		if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT) {
+			vortex_adbdma_resetup(chip, dma);
 			vortex_adbdma_startfifo(chip, dma);
+		}
 #ifndef CHIP_AU8810
 		else {
 			printk(KERN_INFO "vortex: wt start %d\n", dma);


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
