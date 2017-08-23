From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to free dsp
	resource on ipc_init failure" to the asoc tree
Date: Wed, 23 Aug 2017 12:24:41 +0100
Message-ID: <E1dkTm5-0007AG-SS@debutante>
References: <1503400553-15377-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63D3A267258
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:24:46 +0200 (CEST)
In-Reply-To: <1503400553-15377-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to free dsp resource on ipc_init failure

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

>From 3b3011adada3bba47c56c205634e1b32512e0c7c Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 22 Aug 2017 16:45:50 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to free dsp resource on ipc_init
 failure

For some dsp init error path, irq and few more resources are not freed.
This results in oops. So, fix it by freeing up the resources on ipc_init
failure.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 4 +++-
 sound/soc/intel/skylake/cnl-sst.c | 4 +++-
 sound/soc/intel/skylake/skl-sst.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 5e1ac99ffa8b..4524211960e4 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -582,8 +582,10 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
 	ret = skl_ipc_init(dev, skl);
-	if (ret)
+	if (ret) {
+		skl_dsp_free(sst);
 		return ret;
+	}
 
 	/* set the D0i3 check */
 	skl->ipc.ops.check_dsp_lp_on = skl_ipc_check_D0i0;
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 48ef04d5da89..387de388ce29 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -450,8 +450,10 @@ int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 			     CNL_ADSP_W1_SZ);
 
 	ret = cnl_ipc_init(dev, cnl);
-	if (ret)
+	if (ret) {
+		skl_dsp_free(sst);
 		return ret;
+	}
 
 	cnl->boot_complete = false;
 	init_waitqueue_head(&cnl->boot_wait);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index a7ad734f591d..a436abf2fe3f 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -562,8 +562,10 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
 	ret = skl_ipc_init(dev, skl);
-	if (ret)
+	if (ret) {
+		skl_dsp_free(sst);
 		return ret;
+	}
 
 	sst->fw_ops = skl_fw_ops;
 
-- 
2.14.1
