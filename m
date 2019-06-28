From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 27/27] sound: ppc: remove unneeded memset after dma_alloc_coherent
Date: Fri, 28 Jun 2019 10:50:54 +0800
Message-ID: <20190628025055.16242-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh@kernel.org>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Fontana <rfontana@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/ppc/pmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 1b11e53f6a62..1ab12f4f8631 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -56,7 +56,6 @@ static int snd_pmac_dbdma_alloc(struct snd_pmac *chip, struct pmac_dbdma *rec, i
 	if (rec->space == NULL)
 		return -ENOMEM;
 	rec->size = size;
-	memset(rec->space, 0, rsize);
 	rec->cmds = (void __iomem *)DBDMA_ALIGN(rec->space);
 	rec->addr = rec->dma_base + (unsigned long)((char *)rec->cmds - (char *)rec->space);
 
-- 
2.11.0
