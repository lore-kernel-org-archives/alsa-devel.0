From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 35/35] sound/soc/intel: Use kmemdup rather than duplicating its implementation
Date: Thu,  4 Jul 2019 00:32:51 +0800
Message-ID: <20190703163251.1075-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: alsa-devel@alsa-project.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)
  - Split into two patches

 sound/soc/intel/atom/sst/sst_loader.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index ce11c36848c4..cc95af35c060 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -288,14 +288,13 @@ static int sst_cache_and_parse_fw(struct intel_sst_drv *sst,
 {
 	int retval = 0;
 
-	sst->fw_in_mem = kzalloc(fw->size, GFP_KERNEL);
+	sst->fw_in_mem = kmemdup(fw->data, fw->size, GFP_KERNEL);
 	if (!sst->fw_in_mem) {
 		retval = -ENOMEM;
 		goto end_release;
 	}
 	dev_dbg(sst->dev, "copied fw to %p", sst->fw_in_mem);
 	dev_dbg(sst->dev, "phys: %lx", (unsigned long)virt_to_phys(sst->fw_in_mem));
-	memcpy(sst->fw_in_mem, fw->data, fw->size);
 	retval = sst_parse_fw_memcpy(sst, fw->size, &sst->memcpy_list);
 	if (retval) {
 		dev_err(sst->dev, "Failed to parse fw\n");
-- 
2.11.0
