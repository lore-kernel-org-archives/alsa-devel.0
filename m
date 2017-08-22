From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/4] ASoC: Intel: Skylake: Fix to free
	resources for dsp_init failure
Date: Tue, 22 Aug 2017 16:45:51 +0530
Message-ID: <1503400553-15377-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 08F022675B4
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:33:13 +0200 (CEST)
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

unmap mmio and free memory resources if dsp_init fails.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index bfb3332a77ca..f0f11f597b21 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -277,8 +277,10 @@ int skl_init_dsp(struct skl *skl)
 	}
 
 	ops = skl_get_dsp_ops(skl->pci->device);
-	if (!ops)
-		return -EIO;
+	if (!ops) {
+		goto unmap_mmio;
+		ret = -EIO;
+	}
 
 	loader_ops = ops->loader_ops();
 	ret = ops->init(bus->dev, mmio_base, irq,
@@ -286,25 +288,35 @@ int skl_init_dsp(struct skl *skl)
 				&skl->skl_sst);
 
 	if (ret < 0)
-		return ret;
+		goto unmap_mmio;
 
 	skl->skl_sst->dsp_ops = ops;
 	cores = &skl->skl_sst->cores;
 	cores->count = ops->num_cores;
 
 	cores->state = kcalloc(cores->count, sizeof(*cores->state), GFP_KERNEL);
-	if (!cores->state)
-		return -ENOMEM;
+	if (!cores->state) {
+		ret = -ENOMEM;
+		goto unmap_mmio;
+	}
 
 	cores->usage_count = kcalloc(cores->count, sizeof(*cores->usage_count),
 				     GFP_KERNEL);
 	if (!cores->usage_count) {
-		kfree(cores->state);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_core_state;
 	}
 
 	dev_dbg(bus->dev, "dsp registration status=%d\n", ret);
 
+	return 0;
+
+free_core_state:
+	kfree(cores->state);
+
+unmap_mmio:
+	iounmap(mmio_base);
+
 	return ret;
 }
 
-- 
1.9.1
