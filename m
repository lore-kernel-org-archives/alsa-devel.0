From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 4/5] ASoC: Intel: Add dummy read for SRAM block
	enable
Date: Mon, 14 Jul 2014 16:37:54 +0800
Message-ID: <1405327075-27831-5-git-send-email-yang.jie@intel.com>
References: <1405327075-27831-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id E09F72617AB
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 10:38:38 +0200 (CEST)
In-Reply-To: <1405327075-27831-1-git-send-email-yang.jie@intel.com>
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Add dummy read after each block enable, to workaround
SRAM write missing bytes issue.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-dsp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index f4276fb..cc58b31 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -381,6 +381,17 @@ static u32 hsw_block_get_bit(struct sst_mem_block *block)
 	return bit;
 }
 
+/*dummy read a SRAM block.*/
+static void sst_mem_block_dummy_read(struct sst_mem_block *block)
+{
+	u32 size;
+	u8 tmp_buf[4];
+	struct sst_dsp *sst = block->dsp;
+
+	size = block->size > 4 ? 4 : block->size;
+	memcpy_fromio(tmp_buf, sst->addr.lpe + block->offset, size);
+}
+
 /* enable 32kB memory block - locks held by caller */
 static int hsw_block_enable(struct sst_mem_block *block)
 {
@@ -400,6 +411,8 @@ static int hsw_block_enable(struct sst_mem_block *block)
 	/* wait 18 DSP clock ticks */
 	udelay(10);
 
+	/*add a dummy read before the SRAM block is written, otherwise the writing may miss bytes sometimes.*/
+	sst_mem_block_dummy_read(block);
 	return 0;
 }
 
-- 
1.8.3.2
