From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: initial scalar variable ba
Date: Wed,  4 Feb 2015 20:23:13 +0800
Message-ID: <1423052593-23796-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A6AEB2614F4
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 13:21:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Reported by Coverity: CID 1267985 CID 1267986

Fix these two Defects: Uninitialized scalar variable.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-firmware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index a2ae2c5..5f71ef6 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -791,6 +791,7 @@ int sst_module_alloc_blocks(struct sst_module *module)
 	struct sst_block_allocator ba;
 	int ret;
 
+	memset(&ba, 0, sizeof(ba));
 	ba.size = module->size;
 	ba.type = module->type;
 	ba.offset = module->offset;
@@ -864,6 +865,7 @@ int sst_module_runtime_alloc_blocks(struct sst_module_runtime *runtime,
 	if (module->persistent_size == 0)
 		return 0;
 
+	memset(&ba, 0, sizeof(ba));
 	ba.size = module->persistent_size;
 	ba.type = SST_MEM_DRAM;
 
-- 
1.9.1
