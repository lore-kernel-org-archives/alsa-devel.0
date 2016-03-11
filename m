From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/8] ASoC: Intel: Skylake: Move Skylake dsp ops
	& loader ops
Date: Fri, 11 Mar 2016 10:12:53 +0530
Message-ID: <1457671376-18667-6-git-send-email-vinod.koul@intel.com>
References: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CDBBC2606A9
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 05:39:04 +0100 (CET)
In-Reply-To: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The code loading for Skylake and other platforms is different, so
add a dsp_ops and a loader_ops which can be defined for each
platform.

Move the dsp init, cleanup and loader ops (alloc and free dma) to
these ops

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 62 +++++++++++++++++++++++++++++-----
 sound/soc/intel/skylake/skl.h          | 12 ++++++-
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 737934cc620d..79c5089b85d6 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -72,17 +72,47 @@ static void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable)
 	skl_ipc_set_large_config(&ctx->ipc, &msg, (u32 *)&mask);
 }
 
+static struct skl_dsp_loader_ops skl_get_loader_ops(void)
+{
+	struct skl_dsp_loader_ops loader_ops;
+
+	memset(&loader_ops, 0, sizeof(struct skl_dsp_loader_ops));
+
+	loader_ops.alloc_dma_buf = skl_alloc_dma_buf;
+	loader_ops.free_dma_buf = skl_free_dma_buf;
+
+	return loader_ops;
+};
+
+static const struct skl_dsp_ops dsp_ops[] = {
+	{
+		.id = 0x9d70,
+		.loader_ops = skl_get_loader_ops,
+		.init = skl_sst_dsp_init,
+		.cleanup = skl_sst_dsp_cleanup
+	},
+};
+
+static int skl_get_dsp_ops(int pci_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dsp_ops); i++) {
+		if (dsp_ops[i].id == pci_id)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 int skl_init_dsp(struct skl *skl)
 {
 	void __iomem *mmio_base;
 	struct hdac_ext_bus *ebus = &skl->ebus;
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	int irq = bus->irq;
 	struct skl_dsp_loader_ops loader_ops;
-	int ret;
-
-	loader_ops.alloc_dma_buf = skl_alloc_dma_buf;
-	loader_ops.free_dma_buf = skl_free_dma_buf;
+	int irq = bus->irq;
+	int ret, index;
 
 	/* enable ppcap interrupt */
 	snd_hdac_ext_bus_ppcap_enable(&skl->ebus, true);
@@ -95,8 +125,14 @@ int skl_init_dsp(struct skl *skl)
 		return -ENXIO;
 	}
 
-	ret = skl_sst_dsp_init(bus->dev, mmio_base, irq,
+	index  = skl_get_dsp_ops(skl->pci->device);
+	if (index  < 0)
+		return -EINVAL;
+
+	loader_ops = dsp_ops[index].loader_ops();
+	ret = dsp_ops[index].init(bus->dev, mmio_base, irq,
 			skl->fw_name, loader_ops, &skl->skl_sst);
+
 	if (ret < 0)
 		return ret;
 
@@ -106,18 +142,26 @@ int skl_init_dsp(struct skl *skl)
 	return ret;
 }
 
-void skl_free_dsp(struct skl *skl)
+int skl_free_dsp(struct skl *skl)
 {
 	struct hdac_ext_bus *ebus = &skl->ebus;
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct skl_sst *ctx =  skl->skl_sst;
+	struct skl_sst *ctx = skl->skl_sst;
+	int index;
 
 	/* disable  ppcap interrupt */
 	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, false);
 
-	skl_sst_dsp_cleanup(bus->dev, ctx);
+	index = skl_get_dsp_ops(skl->pci->device);
+	if (index  < 0)
+		return -EIO;
+
+	dsp_ops[index].cleanup(bus->dev, ctx);
+
 	if (ctx->dsp->addr.lpe)
 		iounmap(ctx->dsp->addr.lpe);
+
+	return 0;
 }
 
 int skl_suspend_dsp(struct skl *skl)
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 1ca1911f1587..39e16fa7a92b 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -90,6 +90,16 @@ struct skl_dma_params {
 	u8 stream_tag;
 };
 
+struct skl_dsp_ops {
+	int id;
+	struct skl_dsp_loader_ops (*loader_ops)(void);
+	int (*init)(struct device *dev, void __iomem *mmio_base,
+			int irq, const char *fw_name,
+			struct skl_dsp_loader_ops loader_ops,
+			struct skl_sst **skl_sst);
+	void (*cleanup)(struct device *dev, struct skl_sst *ctx);
+};
+
 int skl_platform_unregister(struct device *dev);
 int skl_platform_register(struct device *dev);
 
@@ -100,7 +110,7 @@ struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 
 int skl_nhlt_update_topology_bin(struct skl *skl);
 int skl_init_dsp(struct skl *skl);
-void skl_free_dsp(struct skl *skl);
+int skl_free_dsp(struct skl *skl);
 int skl_suspend_dsp(struct skl *skl);
 int skl_resume_dsp(struct skl *skl);
 #endif /* __SOUND_SOC_SKL_H */
-- 
1.9.1
