From: Stefan Roese <sr@denx.de>
Subject: [PATCH] ALSA: pcm: Use dma_bytes as size parameter in
	dma_mmap_coherent()
Date: Mon, 26 Mar 2018 16:10:21 +0200
Message-ID: <20180326141021.12265-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.mailbox.org (mx2.mailbox.org [80.241.60.215])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A02526708E
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 16:10:30 +0200 (CEST)
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

When trying to use the driver (e.g. aplay *.wav), the 4MiB DMA buffer
will get mmapp'ed in 16KiB chunks. But this fails with the 2nd 16KiB
area, as the page offset is outside of the VMA range (size), which is
currently used as size parameter in snd_pcm_lib_default_mmap(). By
using the DMA buffer size (dma_bytes) instead, the complete DMA buffer
can be mmapp'ed and the issue is fixed.

This issue was detected on an ARM platform (TI AM57xx) using the RME
HDSP MADI PCIe soundcard.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 77ba50ddcf9e..d18b3982548b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3422,7 +3422,7 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 					 area,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
-					 area->vm_end - area->vm_start);
+					 substream->runtime->dma_bytes);
 #endif /* CONFIG_X86 */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
-- 
2.16.3
