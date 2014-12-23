From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Store the entry_point read from
	FW file
Date: Tue, 23 Dec 2014 09:24:50 +0800
Message-ID: <1419297890-29290-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B4462612AD
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 02:23:38 +0100 (CET)
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

To enable some modules from other than base FW, according
to FW interface spec, we need pass the correct entry point
param to FW, so here store the entry_point read from FW
file for later usage.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-firmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index ef2e8b5..50d6925 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -497,6 +497,7 @@ struct sst_module *sst_module_new(struct sst_fw *sst_fw,
 	sst_module->sst_fw = sst_fw;
 	sst_module->scratch_size = template->scratch_size;
 	sst_module->persistent_size = template->persistent_size;
+	sst_module->entry = template->entry;
 
 	INIT_LIST_HEAD(&sst_module->block_list);
 	INIT_LIST_HEAD(&sst_module->runtime_list);
-- 
1.9.1
