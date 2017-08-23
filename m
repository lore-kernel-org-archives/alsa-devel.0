From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to free resources
	for dsp_init failure" to the asoc tree
Date: Wed, 23 Aug 2017 12:24:38 +0100
Message-ID: <E1dkTm2-00079L-SH@debutante>
References: <1503400553-15377-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BE60A267234
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:24:47 +0200 (CEST)
In-Reply-To: <1503400553-15377-3-git-send-email-subhransu.s.prusty@intel.com>
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

   ASoC: Intel: Skylake: Fix to free resources for dsp_init failure

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

>From f77d443c4c299aff5ad9c74811dd063f4d8bebcf Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 22 Aug 2017 16:45:51 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to free resources for dsp_init
 failure

unmap mmio and free memory resources if dsp_init fails.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
