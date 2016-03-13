From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Move Skylake dsp ops &
	loader ops" to the asoc tree
Date: Sun, 13 Mar 2016 15:14:59 +0700
Message-ID: <E1af1Ax-0004H7-Qj@finisterre>
References: <1457671376-18667-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 53678260511
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:11 +0100 (CET)
In-Reply-To: <1457671376-18667-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Move Skylake dsp ops & loader ops

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

>From bc23ca35cfb18b0a98afa42de1df1efc7e2e9f8f Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 11 Mar 2016 10:12:53 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Move Skylake dsp ops & loader ops

The code loading for Skylake and other platforms is different, so
add a dsp_ops and a loader_ops which can be defined for each
platform.

Move the dsp init, cleanup and loader ops (alloc and free dma) to
these ops

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.7.0
