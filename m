From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ALSA: isa: gus: Fix a possible null-pointer dereference in snd_gf1_mem_xfree()
Date: Tue, 23 Jul 2019 21:40:20 +0800
Message-ID: <20190723134020.25972-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, huangfq.daxian@gmail.com, tglx@linutronix.de, allison@lohutok.net
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: alsa-devel@alsa-project.org

In snd_gf1_mem_xfree(), there is an if statement on line 72 and line 74
to check whether block->next is NULL:
    if (block->next)

When block->next is NULL, block->next is used on line 84:
    block->next->prev = block->prev;

Thus, a possible null-pointer dereference may occur in this case.

To fix this possible bug, block->next is checked before using it.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/isa/gus/gus_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index cb02d18dde60..ed6205b88057 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -81,7 +81,8 @@ int snd_gf1_mem_xfree(struct snd_gf1_mem * alloc, struct snd_gf1_mem_block * blo
 		if (block->prev)
 			block->prev->next = NULL;
 	} else {
-		block->next->prev = block->prev;
+		if (block->next)
+			block->next->prev = block->prev;
 		if (block->prev)
 			block->prev->next = block->next;
 	}
-- 
2.17.0
