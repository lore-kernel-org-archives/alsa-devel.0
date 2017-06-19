From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 2/3] ASoC: Intel: Skylake: Fix dma buffer
	size calculation
Date: Mon, 19 Jun 2017 11:59:20 +0530
Message-ID: <1497853761-4778-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1497853761-4778-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FEF6266F04
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 08:44:23 +0200 (CEST)
In-Reply-To: <1497853761-4778-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

DMA buffer size for gateway copier will be calculated based on:

For host DMA copier:
Input buffer size (ibs) for output direction (playback)
Output buffer size (obs) for input direction (capture)

For link DMA copier:
IBS for input direction (capture)
OBS for output direction (playback)

Update the driver to use the above.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ab1adc0c9cc3..7063b451b109 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -507,6 +507,8 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_cpr_cfg *cpr_mconfig)
 {
+	u32 dma_io_buf;
+
 	cpr_mconfig->gtw_cfg.node_id = skl_get_node_id(ctx, mconfig);
 
 	if (cpr_mconfig->gtw_cfg.node_id == SKL_NON_GATEWAY_CPR_NODE_ID) {
@@ -514,10 +516,29 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 		return;
 	}
 
-	if (SKL_CONN_SOURCE == mconfig->hw_conn_type)
-		cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->obs;
-	else
-		cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->ibs;
+	switch (mconfig->hw_conn_type) {
+	case SKL_CONN_SOURCE:
+		if (mconfig->dev_type == SKL_DEVICE_HDAHOST)
+			dma_io_buf =  mconfig->ibs;
+		else
+			dma_io_buf =  mconfig->obs;
+		break;
+
+	case SKL_CONN_SINK:
+		if (mconfig->dev_type == SKL_DEVICE_HDAHOST)
+			dma_io_buf =  mconfig->obs;
+		else
+			dma_io_buf =  mconfig->ibs;
+		break;
+
+	default:
+		dev_warn(ctx->dev, "wrong connection type: %d\n",
+				mconfig->hw_conn_type);
+		return;
+	}
+
+	cpr_mconfig->gtw_cfg.dma_buffer_size =
+				mconfig->dma_buffer_size * dma_io_buf;
 
 	cpr_mconfig->cpr_feature_mask = 0;
 	cpr_mconfig->gtw_cfg.config_length  = 0;
-- 
1.9.1
