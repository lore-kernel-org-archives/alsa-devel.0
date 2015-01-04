From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Don't change offset of block
	allocator during fixed allocate
Date: Sun,  4 Jan 2015 09:15:04 +0800
Message-ID: <1420334104-3341-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B42B326058D
 for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2015 02:13:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The offset of block allocator, ba->offset, should not be changed during
fixed address allocating, for the caller may treat it as the offset of
allocated memory and use it. In the case that we allocate more than 1
blocks, we should make sure this offset is correct.

Here introduces a temp allocator for the later continuous allocating.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-firmware.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 50d6925..a2ae2c5 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -707,6 +707,7 @@ static int block_alloc_fixed(struct sst_dsp *dsp, struct sst_block_allocator *ba
 	struct list_head *block_list)
 {
 	struct sst_mem_block *block, *tmp;
+	struct sst_block_allocator ba_tmp = *ba;
 	u32 end = ba->offset + ba->size, block_end;
 	int err;
 
@@ -731,9 +732,9 @@ static int block_alloc_fixed(struct sst_dsp *dsp, struct sst_block_allocator *ba
 		if (ba->offset >= block->offset && ba->offset < block_end) {
 
 			/* align ba to block boundary */
-			ba->size -= block_end - ba->offset;
-			ba->offset = block_end;
-			err = block_alloc_contiguous(dsp, ba, block_list);
+			ba_tmp.size -= block_end - ba->offset;
+			ba_tmp.offset = block_end;
+			err = block_alloc_contiguous(dsp, &ba_tmp, block_list);
 			if (err < 0)
 				return -ENOMEM;
 
@@ -768,10 +769,10 @@ static int block_alloc_fixed(struct sst_dsp *dsp, struct sst_block_allocator *ba
 			list_move(&block->list, &dsp->used_block_list);
 			list_add(&block->module_list, block_list);
 			/* align ba to block boundary */
-			ba->size -= block_end - ba->offset;
-			ba->offset = block_end;
+			ba_tmp.size -= block_end - ba->offset;
+			ba_tmp.offset = block_end;
 
-			err = block_alloc_contiguous(dsp, ba, block_list);
+			err = block_alloc_contiguous(dsp, &ba_tmp, block_list);
 			if (err < 0)
 				return -ENOMEM;
 
-- 
1.9.1
