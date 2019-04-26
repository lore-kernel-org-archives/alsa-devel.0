From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3] sound: isa: gus: fix misuse of %x
Date: Fri, 26 Apr 2019 11:16:24 +0800
Message-ID: <20190426031625.30420-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Pointers should be printed with %p or %px rather than
cast to long type and printed with %lx.
Drop the address printing.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/isa/gus/gus_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index 4ac76f46dd76..d708ae1525e4 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -306,7 +306,7 @@ static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
 	used = 0;
 	for (block = alloc->first, i = 0; block; block = block->next, i++) {
 		used += block->size;
-		snd_iprintf(buffer, "Block %i at 0x%lx onboard 0x%x size %i (0x%x):\n", i, (long) block, block->ptr, block->size, block->size);
+		snd_iprintf(buffer, "Block %i onboard 0x%x size %i (0x%x):\n", i, block->ptr, block->size, block->size);
 		if (block->share ||
 		    block->share_id[0] || block->share_id[1] ||
 		    block->share_id[2] || block->share_id[3])
-- 
2.11.0
