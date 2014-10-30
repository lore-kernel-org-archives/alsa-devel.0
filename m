From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/9] ASoC: Intel: move the driver context
	allocation to routine
Date: Thu, 30 Oct 2014 16:21:47 +0530
Message-ID: <1414666312-4657-5-git-send-email-vinod.koul@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DB0B1265325
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:39 +0100 (CET)
In-Reply-To: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

This will be used by APCI code as well, so moving to common routine helps

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 7c9c65a..cbbe9a7 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -230,6 +230,20 @@ static void sst_init_locks(struct intel_sst_drv *ctx)
 	spin_lock_init(&ctx->block_lock);
 }
 
+int sst_alloc_drv_context(struct intel_sst_drv **ctx,
+		struct device *dev, unsigned int dev_id)
+{
+	*ctx = devm_kzalloc(dev, sizeof(struct intel_sst_drv), GFP_KERNEL);
+	if (!(*ctx))
+		return -ENOMEM;
+
+	(*ctx)->dev = dev;
+	(*ctx)->dev_id = dev_id;
+
+	return 0;
+}
+
+
 /*
 * intel_sst_probe - PCI probe function
 *
@@ -247,12 +261,11 @@ static int intel_sst_probe(struct pci_dev *pci,
 	int ddr_base;
 
 	dev_dbg(&pci->dev, "Probe for DID %x\n", pci->device);
-	sst_drv_ctx = devm_kzalloc(&pci->dev, sizeof(*sst_drv_ctx), GFP_KERNEL);
-	if (!sst_drv_ctx)
-		return -ENOMEM;
 
-	sst_drv_ctx->dev = &pci->dev;
-	sst_drv_ctx->dev_id = pci->device;
+	ret = sst_alloc_drv_context(&sst_drv_ctx, &pci->dev, pci->device);
+	if (ret < 0)
+		return ret;
+
 	if (!sst_pdata)
 		return -EINVAL;
 
-- 
1.7.0.4
