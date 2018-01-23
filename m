From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: emu10k1: Replace GFP_ATOMIC with GFP_KERNEL in synth_alloc_pages
Date: Tue, 23 Jan 2018 17:37:48 +0800
Message-ID: <1516700268-26923-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: alsa-devel@alsa-project.org

The function synth_alloc_pages is not called in atomic context.
Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/pci/emu10k1/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index 4f1f69b..a4dbae1 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -477,7 +477,7 @@ static int synth_alloc_pages(struct snd_emu10k1 *emu, struct snd_emu10k1_memblk
 			if (p)
 				__free_page(p);
 			/* try to allocate from <16MB zone */
-			p = alloc_page(GFP_ATOMIC | GFP_DMA |
+			p = alloc_page(GFP_KERNEL | GFP_DMA |
 				       __GFP_NORETRY | /* no OOM-killer */
 				       __GFP_NOWARN);
 		}
-- 
1.7.9.5
