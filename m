From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: seq: Use kvmalloc() for cell pools
Date: Tue,  9 Apr 2019 19:00:16 +0200
Message-ID: <20190409170020.20685-2-tiwai@suse.de>
References: <20190409170020.20685-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61B87F89636
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:00:24 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6CC0AAF81
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:00:23 +0000 (UTC)
In-Reply-To: <20190409170020.20685-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use kvmalloc() for allocating cell pools since the pool size can be
relatively small that may be covered better by slab.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 5b0388202bac..6ea4d8a5a71e 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -24,7 +24,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
-#include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <sound/core.h>
 
 #include <sound/seq_kernel.h>
@@ -389,8 +389,8 @@ int snd_seq_pool_init(struct snd_seq_pool *pool)
 	if (snd_BUG_ON(!pool))
 		return -EINVAL;
 
-	cellptr = vmalloc(array_size(sizeof(struct snd_seq_event_cell),
-				     pool->size));
+	cellptr = kvmalloc_array(sizeof(struct snd_seq_event_cell), pool->size,
+				 GFP_KERNEL);
 	if (!cellptr)
 		return -ENOMEM;
 
@@ -398,7 +398,7 @@ int snd_seq_pool_init(struct snd_seq_pool *pool)
 	spin_lock_irqsave(&pool->lock, flags);
 	if (pool->ptr) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		vfree(cellptr);
+		kvfree(cellptr);
 		return 0;
 	}
 
@@ -456,7 +456,7 @@ int snd_seq_pool_done(struct snd_seq_pool *pool)
 	pool->total_elements = 0;
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-	vfree(ptr);
+	kvfree(ptr);
 
 	spin_lock_irqsave(&pool->lock, flags);
 	pool->closing = 0;
-- 
2.16.4
