From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 5/9] ASoC: Intel: Skylake: Move platform
	specific init to platform dsp_init()
Date: Wed,  2 Aug 2017 21:51:16 +0530
Message-ID: <20170802162120.8935-6-guneshwor.o.singh@intel.com>
References: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D3013267356
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 18:25:38 +0200 (CEST)
In-Reply-To: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
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

Move ipc_init() from helper function to respective platform's dsp_init()
as ipc_init() per platform can be different.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c       | 4 ++++
 sound/soc/intel/skylake/skl-sst-utils.c | 6 +-----
 sound/soc/intel/skylake/skl-sst.c       | 4 ++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index c404a42b670a..71042aceb25f 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -581,6 +581,10 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
+	ret = skl_ipc_init(dev, skl);
+	if (ret)
+		return ret;
+
 	/* set the D0i3 check */
 	skl->ipc.ops.check_dsp_lp_on = skl_ipc_check_D0i0;
 
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 81ee251881b4..369ef7ce981c 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -368,7 +368,6 @@ int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 {
 	struct skl_sst *skl;
 	struct sst_dsp *sst;
-	int ret;
 
 	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
 	if (skl == NULL)
@@ -388,15 +387,12 @@ int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 	sst->dsp_ops = dsp_ops;
 	init_waitqueue_head(&skl->mod_load_wait);
 	INIT_LIST_HEAD(&sst->module_list);
-	ret = skl_ipc_init(dev, skl);
-	if (ret)
-		return ret;
 
 	skl->is_first_boot = true;
 	if (dsp)
 		*dsp = skl;
 
-	return ret;
+	return 0;
 }
 
 int skl_prepare_lib_load(struct skl_sst *skl, struct skl_lib_info *linfo,
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index fd99e74cda03..6cc586d3f03b 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -561,6 +561,10 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
+	ret = skl_ipc_init(dev, skl);
+	if (ret)
+		return ret;
+
 	sst->fw_ops = skl_fw_ops;
 
 	return 0;
-- 
2.13.0
