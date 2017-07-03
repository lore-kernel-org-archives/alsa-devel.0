From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Skylake: Remove driver
	debugfs exit
Date: Mon,  3 Jul 2017 13:54:47 +0530
Message-ID: <20170703082447.2304-2-guneshwor.o.singh@intel.com>
References: <20170703082447.2304-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EE3B266884
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 10:25:54 +0200 (CEST)
In-Reply-To: <20170703082447.2304-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

For driver debugfs, debugfs_remove_recursive() is called which is not
needed as it is already done in ASoC core debugfs. And a device managed
memory need not be freed explicitly as device core frees it up. So
remove unnecessary skl_debugfs_exit().

Fixes: 5cdf6c09ca9d ASoC: ("Intel: Skylake: Add debugfs support")
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-debug.c | 8 --------
 sound/soc/intel/skylake/skl.c       | 1 -
 sound/soc/intel/skylake/skl.h       | 3 ---
 3 files changed, 12 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 34d06abbf796..dc20d91f62e6 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -259,11 +259,3 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
 	debugfs_remove_recursive(d->fs);
 	return NULL;
 }
-
-void skl_debugfs_exit(struct skl_debug *d)
-{
-	debugfs_remove_recursive(d->fs);
-
-	kfree(d);
-
-}
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 410ce83f4a49..334917ee41cf 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -866,7 +866,6 @@ static void skl_remove(struct pci_dev *pci)
 	/* codec removal, invoke bus_device_remove */
 	snd_hdac_ext_bus_device_remove(ebus);
 
-	skl_debugfs_exit(skl->debugfs);
 	skl->debugfs = NULL;
 	skl_platform_unregister(&pci->dev);
 	skl_free_dsp(skl);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 14e7778d7f80..a6b134b4c037 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -125,7 +125,6 @@ struct skl_module_cfg;
 
 #ifdef CONFIG_DEBUG_FS
 struct skl_debug *skl_debugfs_init(struct skl *skl);
-void skl_debugfs_exit(struct skl_debug *d);
 void skl_debug_init_module(struct skl_debug *d,
 			struct snd_soc_dapm_widget *w,
 			struct skl_module_cfg *mconfig);
@@ -134,8 +133,6 @@ static inline struct skl_debug *skl_debugfs_init(struct skl *skl)
 {
 	return NULL;
 }
-static inline void skl_debugfs_exit(struct skl_debug *d)
-{}
 static inline void skl_debug_init_module(struct skl_debug *d,
 					 struct snd_soc_dapm_widget *w,
 					 struct skl_module_cfg *mconfig)
-- 
2.13.0
