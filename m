From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 2/5] ASoC: Intel: Merge wild cat point ADSP
	DRAM regions
Date: Mon, 14 Jul 2014 16:37:52 +0800
Message-ID: <1405327075-27831-3-git-send-email-yang.jie@intel.com>
References: <1405327075-27831-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id DB6392616CB
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 10:38:37 +0200 (CEST)
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

Merge D-SRAM0 D-SRAM1 D-SRAM2 to D-SRAM, for wild cat point ADSP mem regions.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-dsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 48ddff3..1b96344 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -318,9 +318,7 @@ static const struct sst_adsp_memregion lp_region[] = {
 
 /* wild cat point ADSP mem regions */
 static const struct sst_adsp_memregion wpt_region[] = {
-	{0x00000, 0x40000, 8, SST_MEM_DRAM}, /* D-SRAM0 - 8 * 32kB */
-	{0x40000, 0x80000, 8, SST_MEM_DRAM}, /* D-SRAM1 - 8 * 32kB */
-	{0x80000, 0xA0000, 4, SST_MEM_DRAM}, /* D-SRAM2 - 4 * 32kB */
+	{0x00000, 0xA0000, 20, SST_MEM_DRAM}, /* D-SRAM0,D-SRAM1,D-SRAM2 - 20 * 32kB */
 	{0xA0000, 0xF0000, 10, SST_MEM_IRAM}, /* I-SRAM - 10 * 32kB */
 };
 
-- 
1.8.3.2
