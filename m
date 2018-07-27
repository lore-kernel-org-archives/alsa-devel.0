From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2] ALSA: memalloc: declare
	snd_sgbuf_aligned_pages() unconditionally
Date: Fri, 27 Jul 2018 11:28:05 -0500
Message-ID: <20180727162805.20785-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D7BBA267759
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 18:28:24 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Make this helper inline function available for all platforms. This
helps solve 0-day compilation issues when CONFIG_SND_DMA_SGBUF is not
defined.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
v2: add <asm/page.h> to solve compilation issue on ALPHA reported by 0-day

 include/sound/memalloc.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 9c3db3dce32b..67561b997915 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -24,6 +24,8 @@
 #ifndef __SOUND_MEMALLOC_H
 #define __SOUND_MEMALLOC_H
 
+#include <asm/page.h>
+
 struct device;
 
 /*
@@ -67,6 +69,14 @@ struct snd_dma_buffer {
 	void *private_data;	/* private for allocator; don't touch */
 };
 
+/*
+ * return the pages matching with the given byte size
+ */
+static inline unsigned int snd_sgbuf_aligned_pages(size_t size)
+{
+	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+}
+
 #ifdef CONFIG_SND_DMA_SGBUF
 /*
  * Scatter-Gather generic device pages
@@ -90,14 +100,6 @@ struct snd_sg_buf {
 	struct device *dev;
 };
 
-/*
- * return the pages matching with the given byte size
- */
-static inline unsigned int snd_sgbuf_aligned_pages(size_t size)
-{
-	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-}
-
 /*
  * return the physical address at the corresponding offset
  */
-- 
2.14.1
