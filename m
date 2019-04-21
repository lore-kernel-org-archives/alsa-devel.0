From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 06/06] sound: isa: gus: fix misuse of %x
Date: Sun, 21 Apr 2019 19:48:44 +0800
Message-ID: <20190421114844.20574-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Pointers should be printed with %p or %px rather than
cast to long type and printed with %lx.
Change %lx to %p to print the pointer.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/isa/gus/gus_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index 4ac76f4..63e790f 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -306,7 +306,7 @@ static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
 	used = 0;
 	for (block = alloc->first, i = 0; block; block = block->next, i++) {
 		used += block->size;
-		snd_iprintf(buffer, "Block %i at 0x%lx onboard 0x%x size %i (0x%x):\n", i, (long) block, block->ptr, block->size, block->size);
+		snd_iprintf(buffer, "Block %i at 0x%p onboard 0x%x size %i (0x%x):\n", i, block, block->ptr, block->size, block->size);
 		if (block->share ||
 		    block->share_id[0] || block->share_id[1] ||
 		    block->share_id[2] || block->share_id[3])
-- 
2.11.0
