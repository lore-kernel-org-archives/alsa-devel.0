From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 2/2] ALSA: trident: Remove unused variable in
	trident_memory.c
Date: Tue,  1 Jul 2014 10:10:30 +0530
Message-ID: <1404189630-5795-2-git-send-email-sachin.kamat@samsung.com>
References: <1404189630-5795-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EFCB2625D7
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 06:44:03 +0200 (CEST)
Received: by mail-pd0-f182.google.com with SMTP id y13so9378695pdi.41
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 21:44:02 -0700 (PDT)
In-Reply-To: <1404189630-5795-1-git-send-email-sachin.kamat@samsung.com>
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
Cc: tiwai@suse.de, spk.linux@gmail.com
List-Id: alsa-devel@alsa-project.org

'prev' is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/pci/trident/trident_memory.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/trident/trident_memory.c b/sound/pci/trident/trident_memory.c
index 3102a579660b..04c474658e3c 100644
--- a/sound/pci/trident/trident_memory.c
+++ b/sound/pci/trident/trident_memory.c
@@ -139,12 +139,11 @@ static inline void *offset_ptr(struct snd_trident *trident, int offset)
 static struct snd_util_memblk *
 search_empty(struct snd_util_memhdr *hdr, int size)
 {
-	struct snd_util_memblk *blk, *prev;
+	struct snd_util_memblk *blk;
 	int page, psize;
 	struct list_head *p;
 
 	psize = get_aligned_page(size + ALIGN_PAGE_SIZE -1);
-	prev = NULL;
 	page = 0;
 	list_for_each(p, &hdr->block) {
 		blk = list_entry(p, struct snd_util_memblk, list);
-- 
1.7.9.5
