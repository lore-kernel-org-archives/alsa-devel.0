From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ALSA: memalloc: declare
	snd_sgbuf_aligned_pages() unconditionally
Date: Wed, 25 Jul 2018 15:15:56 -0500
Message-ID: <20180725201556.21136-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 378FF26774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 22:16:59 +0200 (CEST)
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
 include/sound/memalloc.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 9c3db3dce32b..c669900e6cbe 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -67,6 +67,14 @@ struct snd_dma_buffer {
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
@@ -90,14 +98,6 @@ struct snd_sg_buf {
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
