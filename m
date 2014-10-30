From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Fix block is enabled multiple
	times issue
Date: Thu, 30 Oct 2014 21:21:52 +0800
Message-ID: <1414675312-7667-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 701B1260602
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 14:23:08 +0100 (CET)
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

During FW parsing and loading, block_list_prepare() may
be called for each raw data block copying and this may
made the hsw_block_enable() called mutiple times, which
increase block->users many times. The result of this is
hsw_block_disable() can't power gated the related block
when trying to free the blocks during suspend, and the
power gating status also confused.

Here check the block user status, only calling enable()
for those blocks who has no user yet. Remember that
this works correctlly on current case, where there are
enough SRAM memory so different module won't share a
memory block. For further usage, we may need restructure
the struct sst_mem_block to save the module list who is
using it.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 35788ad..c451398 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -149,7 +149,7 @@ static int block_list_prepare(struct sst_dsp *dsp,
 	/* enable each block so that's it'e ready for data */
 	list_for_each_entry(block, block_list, module_list) {
 
-		if (block->ops && block->ops->enable) {
+		if (block->ops && block->ops->enable && !block->users) {
 			ret = block->ops->enable(block);
 			if (ret < 0) {
 				dev_err(dsp->dev,
-- 
1.9.1
