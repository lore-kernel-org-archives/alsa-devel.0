From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 8/9] ASoC: Intel: Skylake: Fix to set Non
	gateway copier cfg
Date: Thu, 22 Oct 2015 23:22:41 +0530
Message-ID: <1445536362-26670-9-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CA8D22667D7
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:53:46 +0200 (CEST)
In-Reply-To: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Dharageswari.R" <dharageswari.r@intel.com>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

If copier instance is connected to a DMA gateway then driver
needs to configure the gateway configuration otherwise set
it to invalid.
This patch sets the non gateway copier node value to invalid.

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c       | 8 +++++++-
 sound/soc/intel/skylake/skl-tplg-interface.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index a1001a686aa9..50a109503a3f 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -321,6 +321,7 @@ static void skl_copy_copier_caps(struct skl_module_cfg *mconfig,
 			(mconfig->formats_config.caps_size) / 4;
 }
 
+#define SKL_NON_GATEWAY_CPR_NODE_ID 0xFFFFFFFF
 /*
  * Calculate the gatewat settings required for copier module, type of
  * gateway and index of gateway to use
@@ -367,13 +368,18 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 		node_id.node.vindex = params->link_dma_id;
 		break;
 
-	default:
+	case SKL_DEVICE_HDAHOST:
 		node_id.node.dma_type =
 			(SKL_CONN_SOURCE == mconfig->hw_conn_type) ?
 			SKL_DMA_HDA_HOST_OUTPUT_CLASS :
 			SKL_DMA_HDA_HOST_INPUT_CLASS;
 		node_id.node.vindex = params->host_dma_id;
 		break;
+
+	default:
+		cpr_mconfig->gtw_cfg.node_id = SKL_NON_GATEWAY_CPR_NODE_ID;
+		cpr_mconfig->cpr_feature_mask = 0;
+		return;
 	}
 
 	cpr_mconfig->gtw_cfg.node_id = node_id.val;
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index d14f7fe64aa8..718d3d5df9a8 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -106,6 +106,7 @@ enum skl_dev_type {
 	SKL_DEVICE_I2S = 0x2,
 	SKL_DEVICE_SLIMBUS = 0x3,
 	SKL_DEVICE_HDALINK = 0x4,
+	SKL_DEVICE_HDAHOST = 0x5,
 	SKL_DEVICE_NONE
 };
 
-- 
1.9.1
