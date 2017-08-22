From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 1/4] ASoC: Intel: Skylake: Fix to free dsp
	resource on ipc_init failure
Date: Tue, 22 Aug 2017 16:45:50 +0530
Message-ID: <1503400553-15377-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A6F83267578
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:33:11 +0200 (CEST)
In-Reply-To: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

For some dsp init error path, irq and few more resources are not freed.
This results in oops. So, fix it by freeing up the resources on ipc_init
failure.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 4 +++-
 sound/soc/intel/skylake/cnl-sst.c | 4 +++-
 sound/soc/intel/skylake/skl-sst.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 71042aceb25f..88b8de342f31 100644
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
index 7dcfe66a20e2..76ef1e40a50e 100644
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
index 6cc586d3f03b..a6bcc0e6788f 100644
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
1.9.1
