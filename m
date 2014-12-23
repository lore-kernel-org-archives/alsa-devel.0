From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: correct the fixed free block
	allocation
Date: Tue, 23 Dec 2014 09:12:45 +0800
Message-ID: <1419297165-28401-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 060B22612AD
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 02:11:47 +0100 (CET)
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

For block span more than 1 section, when allocate it from
a free block, we need allocate the remain buffers within
the block, and then continue alloc the rest of needed
size buffer.

Here also make sure this free block is moved from free
list to used list, and add it to block_list which may
be used for power gating disabling later.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-firmware.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 4a5bde9..ef2e8b5 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -763,8 +763,12 @@ static int block_alloc_fixed(struct sst_dsp *dsp, struct sst_block_allocator *ba
 		/* does block span more than 1 section */
 		if (ba->offset >= block->offset && ba->offset < block_end) {
 
+			/* add block */
+			list_move(&block->list, &dsp->used_block_list);
+			list_add(&block->module_list, block_list);
 			/* align ba to block boundary */
-			ba->offset = block->offset;
+			ba->size -= block_end - ba->offset;
+			ba->offset = block_end;
 
 			err = block_alloc_contiguous(dsp, ba, block_list);
 			if (err < 0)
-- 
1.9.1
