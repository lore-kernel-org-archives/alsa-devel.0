From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/7] ASoC: Intel: Skylake: Get node id using
	helper
Date: Fri,  5 Feb 2016 12:19:05 +0530
Message-ID: <1454654950-23091-3-git-send-email-vinod.koul@intel.com>
References: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D7BF26500A
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:45:48 +0100 (CET)
In-Reply-To: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Dharageswari.R" <dharageswari.r@intel.com>, tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: "Dharageswari.R" <dharageswari.r@intel.com>

skl_setup_cpr_gateway_cfg() retrieves gateway settings which are
required for copier module configuration. For upcoming DMA
control IPC we need similar retrieval, so separate this piece into
skl_get_node_id() helper which will be common for these functions

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
1.9.1
