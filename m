From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove driver debugfs
	exit" to the asoc tree
Date: Mon, 03 Jul 2017 16:51:09 +0100
Message-ID: <E1dS3cz-0002hv-Bw@debutante>
References: <20170703082447.2304-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF534266BC2
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 17:51:30 +0200 (CEST)
In-Reply-To: <20170703082447.2304-2-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Julia Lawall <julia.lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Remove driver debugfs exit

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7d3d6e0645dd3689e625161b9e312108e66b2b51 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 3 Jul 2017 13:54:47 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove driver debugfs exit

For driver debugfs, debugfs_remove_recursive() is called which is not
needed as it is already done in ASoC core debugfs. And a device managed
memory need not be freed explicitly as device core frees it up. So
remove unnecessary skl_debugfs_exit().

Fixes: 5cdf6c09ca9d ASoC: ("Intel: Skylake: Add debugfs support")
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.1
