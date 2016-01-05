From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix the memory leak" to
	the asoc tree
Date: Tue, 05 Jan 2016 12:33:09 +0000
Message-ID: <E1aGQnV-0007Tu-V4@debutante>
References: <1451994364-29338-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B32326070C
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 13:33:19 +0100 (CET)
In-Reply-To: <1451994364-29338-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix the memory leak

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

>From d8018361b58bb7b9a2a657104e54c33c2ef1439d Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 5 Jan 2016 17:16:04 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix the memory leak

This provide the fix for firmware memory by freeing the pointer in driver
remove where it is safe to do so

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 ++
 sound/soc/intel/skylake/skl.c          | 4 ++++
 sound/soc/intel/skylake/skl.h          | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a7854c8fc523..ad4d0f82603e 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1248,5 +1248,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 	skl->resource.max_mcps = SKL_MAX_MCPS;
 	skl->resource.max_mem = SKL_FW_MAX_MEM;
 
+	skl->tplg = fw;
+
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 5319529aedf7..caa69c4598a6 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
+#include <linux/firmware.h>
 #include <sound/pcm.h>
 #include "skl.h"
 
@@ -520,6 +521,9 @@ static void skl_remove(struct pci_dev *pci)
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct skl *skl = ebus_to_skl(ebus);
 
+	if (skl->tplg)
+		release_firmware(skl->tplg);
+
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
 	pci_dev_put(pci);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index dd2e79ae45a8..a0709e344d44 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -68,6 +68,8 @@ struct skl {
 	struct skl_dsp_resource resource;
 	struct list_head ppl_list;
 	struct list_head dapm_path_list;
+
+	const struct firmware *tplg;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.6.2
