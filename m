From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2 2/4] ASoC: Intel: Use a table for ADSP SRAM
	shift
Date: Mon, 14 Jul 2014 17:11:10 +0800
Message-ID: <1405329072-28679-3-git-send-email-yang.jie@intel.com>
References: <1405329072-28679-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 846C32618F2
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 11:12:18 +0200 (CEST)
In-Reply-To: <1405329072-28679-1-git-send-email-yang.jie@intel.com>
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

Use a table for ADSP IRAM/DRAM bit shift.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-dsp.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 4720382..40bb020 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -337,21 +337,40 @@ static int hsw_acpi_resource_map(struct sst_dsp *sst, struct sst_pdata *pdata)
 	return 0;
 }
 
+struct sst_sram_shift {
+	u32 dev_id;	/* SST Device IDs  */
+	u32 iram_shift;
+	u32 dram_shift;
+};
+
+static const struct sst_sram_shift sram_shift[] = {
+	{SST_DEV_ID_LYNX_POINT, 6, 16}, /* lp */
+	{SST_DEV_ID_WILDCAT_POINT, 2, 12}, /* wpt */
+};
 static u32 hsw_block_get_bit(struct sst_mem_block *block)
 {
-	u32 bit = 0, shift = 0;
+	u32 bit = 0, shift = 0, index;
+	struct sst_dsp *sst = block->dsp;
 
-	switch (block->type) {
-	case SST_MEM_DRAM:
-		shift = 16;
-		break;
-	case SST_MEM_IRAM:
-		shift = 6;
-		break;
-	default:
-		return 0;
+	for (index = 0; index < ARRAY_SIZE(sram_shift); index++) {
+		if (sram_shift[index].dev_id == sst->id)
+			break;
 	}
 
+	if (index < ARRAY_SIZE(sram_shift)) {
+		switch (block->type) {
+		case SST_MEM_DRAM:
+			shift = sram_shift[index].dram_shift;
+			break;
+		case SST_MEM_IRAM:
+			shift = sram_shift[index].iram_shift;
+			break;
+		default:
+			shift = 0;
+		}
+	} else
+		shift = 0;
+
 	bit = 1 << (block->index + shift);
 
 	return bit;
-- 
1.8.3.2
