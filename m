From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/12] ASoC: Intel: Skylake: modify
	skl_get_dsp_ops()
Date: Tue, 26 Jul 2016 18:06:41 +0530
Message-ID: <1469536610-27606-4-git-send-email-vinod.koul@intel.com>
References: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8996C266993
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 14:29:45 +0200 (CEST)
In-Reply-To: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

To query the ops used for a platform, we use skl_get_dsp_ops() which return
index and then we load the ops.

Rather than this return the ops, this way it cna be used later to query the
ops in rest of the driver.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 30 ++++++++++++++++--------------
 sound/soc/intel/skylake/skl.h          |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 44ab595ce21a..25d057679f2c 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -219,16 +219,16 @@ static const struct skl_dsp_ops dsp_ops[] = {
 	},
 };
 
-static int skl_get_dsp_ops(int pci_id)
+const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dsp_ops); i++) {
 		if (dsp_ops[i].id == pci_id)
-			return i;
+			return &dsp_ops[i];
 	}
 
-	return -EINVAL;
+	return NULL;
 }
 
 int skl_init_dsp(struct skl *skl)
@@ -238,7 +238,8 @@ int skl_init_dsp(struct skl *skl)
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct skl_dsp_loader_ops loader_ops;
 	int irq = bus->irq;
-	int ret, index;
+	const struct skl_dsp_ops *ops;
+	int ret;
 
 	/* enable ppcap interrupt */
 	snd_hdac_ext_bus_ppcap_enable(&skl->ebus, true);
@@ -251,13 +252,14 @@ int skl_init_dsp(struct skl *skl)
 		return -ENXIO;
 	}
 
-	index  = skl_get_dsp_ops(skl->pci->device);
-	if (index  < 0)
-		return -EINVAL;
+	ops = skl_get_dsp_ops(skl->pci->device);
+	if (!ops)
+		return -EIO;
 
-	loader_ops = dsp_ops[index].loader_ops();
-	ret = dsp_ops[index].init(bus->dev, mmio_base, irq,
-			skl->fw_name, loader_ops, &skl->skl_sst);
+	loader_ops = ops->loader_ops();
+	ret = ops->init(bus->dev, mmio_base, irq,
+				skl->fw_name, loader_ops,
+				&skl->skl_sst);
 
 	if (ret < 0)
 		return ret;
@@ -273,16 +275,16 @@ int skl_free_dsp(struct skl *skl)
 	struct hdac_ext_bus *ebus = &skl->ebus;
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct skl_sst *ctx = skl->skl_sst;
-	int index;
+	const struct skl_dsp_ops *ops;
 
 	/* disable  ppcap interrupt */
 	snd_hdac_ext_bus_ppcap_int_enable(&skl->ebus, false);
 
-	index = skl_get_dsp_ops(skl->pci->device);
-	if (index  < 0)
+	ops = skl_get_dsp_ops(skl->pci->device);
+	if (!ops)
 		return -EIO;
 
-	dsp_ops[index].cleanup(bus->dev, ctx);
+	ops->cleanup(bus->dev, ctx);
 
 	if (ctx->dsp->addr.lpe)
 		iounmap(ctx->dsp->addr.lpe);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 9064e5b0d676..c3538f8b17d9 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -123,4 +123,5 @@ int skl_free_dsp(struct skl *skl);
 int skl_suspend_dsp(struct skl *skl);
 int skl_resume_dsp(struct skl *skl);
 void skl_cleanup_resources(struct skl *skl);
+const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id);
 #endif /* __SOUND_SOC_SKL_H */
-- 
1.9.1
