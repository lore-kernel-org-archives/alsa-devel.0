From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Get node id using
	helper" to the asoc tree
Date: Mon, 08 Feb 2016 18:01:35 +0000
Message-ID: <E1aSq7z-0002lu-TP@debutante>
References: <1454654950-23091-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 605682605C1
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 19:01:42 +0100 (CET)
In-Reply-To: <1454654950-23091-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Get node id using helper

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

>From 4fdf810fc5c82f57aa7c54ac9384f1201087724a Mon Sep 17 00:00:00 2001
From: "Dharageswari.R" <dharageswari.r@intel.com>
Date: Fri, 5 Feb 2016 12:19:05 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Get node id using helper

skl_setup_cpr_gateway_cfg() retrieves gateway settings which are
required for copier module configuration. For upcoming DMA
control IPC we need similar retrieval, so separate this piece into
skl_get_node_id() helper which will be common for these functions

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 4629372d7c8e..60f9fe389887 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -238,9 +238,8 @@ static void skl_copy_copier_caps(struct skl_module_cfg *mconfig,
  * Calculate the gatewat settings required for copier module, type of
  * gateway and index of gateway to use
  */
-static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
-			struct skl_module_cfg *mconfig,
-			struct skl_cpr_cfg *cpr_mconfig)
+static u32 skl_get_node_id(struct skl_sst *ctx,
+			struct skl_module_cfg *mconfig)
 {
 	union skl_connector_node_id node_id = {0};
 	union skl_ssp_dma_node ssp_node  = {0};
@@ -289,13 +288,24 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 		break;
 
 	default:
-		cpr_mconfig->gtw_cfg.node_id = SKL_NON_GATEWAY_CPR_NODE_ID;
+		node_id.val = 0xFFFFFFFF;
+		break;
+	}
+
+	return node_id.val;
+}
+
+static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
+			struct skl_module_cfg *mconfig,
+			struct skl_cpr_cfg *cpr_mconfig)
+{
+	cpr_mconfig->gtw_cfg.node_id = skl_get_node_id(ctx, mconfig);
+
+	if (cpr_mconfig->gtw_cfg.node_id == SKL_NON_GATEWAY_CPR_NODE_ID) {
 		cpr_mconfig->cpr_feature_mask = 0;
 		return;
 	}
 
-	cpr_mconfig->gtw_cfg.node_id = node_id.val;
-
 	if (SKL_CONN_SOURCE == mconfig->hw_conn_type)
 		cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->obs;
 	else
-- 
2.7.0.rc3
