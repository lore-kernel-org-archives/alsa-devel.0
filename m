From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 5/5] ASoC: Intel: Skylake: Disable clock and
	power gating during fw/lib download
Date: Sat, 27 Jan 2018 09:50:25 +0530
Message-ID: <20180127042025.22042-6-guneshwor.o.singh@intel.com>
References: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 254C7266FEE
 for <alsa-devel@alsa-project.org>; Sat, 27 Jan 2018 05:21:44 +0100 (CET)
In-Reply-To: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

In order to achieve better DMA performance and reduce download time for
firmware and library, it is recommended to disable dynamic clock and
power gating. In some scenarios, DMA may wait to accumulate more data and
last chunk of data never gets completed if dynamic clock and power
gating is kept enabled.

This patch adds support to disable/enable dynamic clock and power gating
and use it during firmware and library download.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c |  7 ++++++-
 sound/soc/intel/skylake/skl-pcm.c      |  7 ++++++-
 sound/soc/intel/skylake/skl-sst-ipc.h  |  3 +++
 sound/soc/intel/skylake/skl.c          | 21 +++++++++++++++++++++
 sound/soc/intel/skylake/skl.h          |  4 ++++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 8cbf080c38b3..80e448e11bd7 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -417,11 +417,16 @@ int skl_resume_dsp(struct skl *skl)
 	if (skl->skl_sst->is_first_boot == true)
 		return 0;
 
-	/* disable dynamic clock gating during fw and lib download */
+	/*
+	 * disable dynamic clock and power gating during firmware
+	 * and library download
+	 */
 	ctx->enable_miscbdcge(ctx->dev, false);
+	ctx->clock_power_gating(ctx->dev, false);
 
 	ret = skl_dsp_wake(ctx->dsp);
 	ctx->enable_miscbdcge(ctx->dev, true);
+	ctx->clock_power_gating(ctx->dev, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 91d858e25fce..df824224261e 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1356,11 +1356,16 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 			return -EIO;
 		}
 
-		/* disable dynamic clock gating during fw and lib download */
+		/*
+		 * disable dynamic clock and power gating during firmware
+		 * and library download
+		 */
 		skl->skl_sst->enable_miscbdcge(platform->dev, false);
+		skl->skl_sst->clock_power_gating(platform->dev, false);
 
 		ret = ops->init_fw(platform->dev, skl->skl_sst);
 		skl->skl_sst->enable_miscbdcge(platform->dev, true);
+		skl->skl_sst->clock_power_gating(platform->dev, true);
 		if (ret < 0) {
 			dev_err(platform->dev, "Failed to boot first fw: %d\n", ret);
 			return ret;
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 55f2d2ce09df..f74f040dfd83 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -118,6 +118,9 @@ struct skl_sst {
 	struct skl_d0i3_data d0i3;
 
 	const struct skl_dsp_ops *dsp_ops;
+
+	/* Callback to update dynamic clock and power gating registers */
+	void (*clock_power_gating)(struct device *dev, bool enable);
 };
 
 struct skl_ipc_init_instance_msg {
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 9668ef529d12..15b8aea4c573 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -94,6 +94,26 @@ static void skl_enable_miscbdcge(struct device *dev, bool enable)
 	update_pci_dword(pci, AZX_PCIREG_CGCTL, AZX_CGCTL_MISCBDCGE_MASK, val);
 }
 
+static void skl_clock_power_gating(struct device *dev, bool enable)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	u32 val;
+
+	/* update PDCGE bit of CGCTL register */
+	val = enable ? AZX_CGCTL_ADSPDCGE : 0;
+	update_pci_dword(pci, AZX_PCIREG_CGCTL, AZX_CGCTL_ADSPDCGE, val);
+
+	/* update L1SEN bit of EM2 register */
+	val = enable ? AZX_REG_VS_EM2_L1SEN : 0;
+	snd_hdac_chip_updatel(bus, VS_EM2, AZX_REG_VS_EM2_L1SEN, val);
+
+	/* update ADSPPGD bit of PGCTL register */
+	val = enable ? 0 : AZX_PGCTL_ADSPPGD;
+	update_pci_dword(pci, AZX_PCIREG_PGCTL, AZX_PGCTL_ADSPPGD, val);
+}
+
 /*
  * While performing reset, controller may not come back properly causing
  * issues, so recommendation is to set CGCTL.MISCBDCGE to 0 then do reset
@@ -921,6 +941,7 @@ static int skl_probe(struct pci_dev *pci,
 			goto out_nhlt_free;
 		}
 		skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
+		skl->skl_sst->clock_power_gating = skl_clock_power_gating;
 	}
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(ebus);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 9b1e9199fa18..d14b7544bfb6 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -33,12 +33,16 @@
 
 #define AZX_PCIREG_PGCTL		0x44
 #define AZX_PGCTL_LSRMD_MASK		(1 << 4)
+#define AZX_PGCTL_ADSPPGD		BIT(2)
 #define AZX_PCIREG_CGCTL		0x48
 #define AZX_CGCTL_MISCBDCGE_MASK	(1 << 6)
+#define AZX_CGCTL_ADSPDCGE		BIT(1)
 /* D0I3C Register fields */
 #define AZX_REG_VS_D0I3C_CIP      0x1 /* Command in progress */
 #define AZX_REG_VS_D0I3C_I3       0x4 /* D0i3 enable */
 
+#define AZX_REG_VS_EM2_L1SEN		BIT(13)
+
 struct skl_dsp_resource {
 	u32 max_mcps;
 	u32 max_mem;
-- 
2.16.1
