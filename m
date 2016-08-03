From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda: Fix krealloc() with __GFP_ZERO usage
Date: Wed,  3 Aug 2016 15:38:52 +0200
Message-ID: <20160803133852.25741-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D359D269D4F
 for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2016 15:38:53 +0200 (CEST)
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
Cc: Joe Perches <joe@perches.com>
List-Id: alsa-devel@alsa-project.org

krealloc() doesn't work always properly with __GFP_ZERO flag as
expected.  For clearing the reallocated area, we need to clear
explicitly instead.

Reported-by: Joe Perches <joe@perches.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/array.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/hda/array.c b/sound/hda/array.c
index 516795baa7db..5dfa610e4471 100644
--- a/sound/hda/array.c
+++ b/sound/hda/array.c
@@ -21,13 +21,15 @@ void *snd_array_new(struct snd_array *array)
 		return NULL;
 	if (array->used >= array->alloced) {
 		int num = array->alloced + array->alloc_align;
+		int oldsize = array->alloced * array->elem_size;
 		int size = (num + 1) * array->elem_size;
 		void *nlist;
 		if (snd_BUG_ON(num >= 4096))
 			return NULL;
-		nlist = krealloc(array->list, size, GFP_KERNEL | __GFP_ZERO);
+		nlist = krealloc(array->list, size, GFP_KERNEL);
 		if (!nlist)
 			return NULL;
+		memset(nlist + oldsize, 0, size - oldsize);
 		array->list = nlist;
 		array->alloced = num;
 	}
-- 
2.9.2
