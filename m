From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: au88xx: Add fall-through annotations
Date: Thu,  4 Oct 2018 20:12:34 +0200
Message-ID: <20181004181234.21152-6-tiwai@suse.de>
References: <20181004181234.21152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B25872678AC
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:12:37 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1F6CCB04D
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 18:12:36 +0000 (UTC)
In-Reply-To: <20181004181234.21152-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, add the "fall through" annotation in au88xx driver.

Although the usages in both both functions vortex_adbdma_setbuffers()
and vortex_wtdma_setbuffers() look a bit suspicious, we keep the
behavior as before, just to be safer.  If it were broken, we should
have already received bug reports.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/au88x0/au88x0_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index 2e5b460a847c..96ece1a71cf1 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -1115,6 +1115,7 @@ vortex_adbdma_setbuffers(vortex_t * vortex, int adbdma,
 		hwwrite(vortex->mmio,
 			VORTEX_ADBDMA_BUFBASE + (adbdma << 4) + 0xc,
 			snd_pcm_sgbuf_get_addr(dma->substream, psize * 3));
+		/* fall through */
 		/* 3 pages */
 	case 3:
 		dma->cfg0 |= 0x12000000;
@@ -1122,12 +1123,14 @@ vortex_adbdma_setbuffers(vortex_t * vortex, int adbdma,
 		hwwrite(vortex->mmio,
 			VORTEX_ADBDMA_BUFBASE + (adbdma << 4) + 0x8,
 			snd_pcm_sgbuf_get_addr(dma->substream, psize * 2));
+		/* fall through */
 		/* 2 pages */
 	case 2:
 		dma->cfg0 |= 0x88000000 | 0x44000000 | 0x10000000 | (psize - 1);
 		hwwrite(vortex->mmio,
 			VORTEX_ADBDMA_BUFBASE + (adbdma << 4) + 0x4,
 			snd_pcm_sgbuf_get_addr(dma->substream, psize));
+		/* fall through */
 		/* 1 page */
 	case 1:
 		dma->cfg0 |= 0x80000000 | 0x40000000 | ((psize - 1) << 0xc);
@@ -1390,17 +1393,20 @@ vortex_wtdma_setbuffers(vortex_t * vortex, int wtdma,
 		dma->cfg1 |= 0x88000000 | 0x44000000 | 0x30000000 | (psize-1);
 		hwwrite(vortex->mmio, VORTEX_WTDMA_BUFBASE + (wtdma << 4) + 0xc,
 			snd_pcm_sgbuf_get_addr(dma->substream, psize * 3));
+		/* fall through */
 		/* 3 pages */
 	case 3:
 		dma->cfg0 |= 0x12000000;
 		dma->cfg1 |= 0x80000000 | 0x40000000 | ((psize-1) << 0xc);
 		hwwrite(vortex->mmio, VORTEX_WTDMA_BUFBASE + (wtdma << 4)  + 0x8,
 			snd_pcm_sgbuf_get_addr(dma->substream, psize * 2));
+		/* fall through */
 		/* 2 pages */
 	case 2:
 		dma->cfg0 |= 0x88000000 | 0x44000000 | 0x10000000 | (psize-1);
 		hwwrite(vortex->mmio, VORTEX_WTDMA_BUFBASE + (wtdma << 4) + 0x4,
 			snd_pcm_sgbuf_get_addr(dma->substream, psize));
+		/* fall through */
 		/* 1 page */
 	case 1:
 		dma->cfg0 |= 0x80000000 | 0x40000000 | ((psize-1) << 0xc);
-- 
2.18.0
