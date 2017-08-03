From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add num of cores in dsp
	ops" to the asoc tree
Date: Thu, 03 Aug 2017 17:30:25 +0100
Message-ID: <E1ddJ0z-0002Zl-VX@debutante>
References: <20170802162120.8935-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 12C70267443
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:30:34 +0200 (CEST)
In-Reply-To: <20170802162120.8935-2-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add num of cores in dsp ops

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

>From 363d45385f403fdf60fe9f563ba87093289d7b35 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Wed, 2 Aug 2017 21:51:12 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add num of cores in dsp ops

Number of dsp cores may differ for different platforms hence
adding it in dsp ops.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c      | 1 -
 sound/soc/intel/skylake/skl-messages.c | 6 ++++++
 sound/soc/intel/skylake/skl-sst.c      | 2 --
 sound/soc/intel/skylake/skl.h          | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 08a2c5eb59fa..c404a42b670a 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -584,7 +584,6 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	/* set the D0i3 check */
 	skl->ipc.ops.check_dsp_lp_on = skl_ipc_check_D0i0;
 
-	skl->cores.count = 2;
 	skl->boot_complete = false;
 	init_waitqueue_head(&skl->boot_wait);
 	INIT_DELAYED_WORK(&skl->d0i3.work, bxt_set_dsp_D0i3);
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index c5b4e0a9946c..7892e445e87b 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -201,6 +201,7 @@ static struct skl_dsp_loader_ops bxt_get_loader_ops(void)
 static const struct skl_dsp_ops dsp_ops[] = {
 	{
 		.id = 0x9d70,
+		.num_cores = 2,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
 		.init_fw = skl_sst_init_fw,
@@ -208,6 +209,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 	},
 	{
 		.id = 0x9d71,
+		.num_cores = 2,
 		.loader_ops = skl_get_loader_ops,
 		.init = kbl_sst_dsp_init,
 		.init_fw = skl_sst_init_fw,
@@ -215,6 +217,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 	},
 	{
 		.id = 0x5a98,
+		.num_cores = 2,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
 		.init_fw = bxt_sst_init_fw,
@@ -222,6 +225,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 	},
 	{
 		.id = 0x3198,
+		.num_cores = 2,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
 		.init_fw = bxt_sst_init_fw,
@@ -275,6 +279,8 @@ int skl_init_dsp(struct skl *skl)
 		return ret;
 
 	skl->skl_sst->dsp_ops = ops;
+	skl->skl_sst->cores.count = ops->num_cores;
+
 	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
 
 	return ret;
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index aba9ea11ac74..fd99e74cda03 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -563,8 +563,6 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	sst->fw_ops = skl_fw_ops;
 
-	skl->cores.count = 2;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index a6b134b4c037..20017ee4685c 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -90,6 +90,7 @@ struct skl_machine_pdata {
 
 struct skl_dsp_ops {
 	int id;
+	unsigned int num_cores;
 	struct skl_dsp_loader_ops (*loader_ops)(void);
 	int (*init)(struct device *dev, void __iomem *mmio_base,
 			int irq, const char *fw_name,
-- 
2.13.2
