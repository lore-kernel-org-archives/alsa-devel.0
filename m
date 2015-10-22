From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/9] ASoC: Intel: Skylake: Update for ssp node
	index in copier cfg
Date: Thu, 22 Oct 2015 23:22:38 +0530
Message-ID: <1445536362-26670-6-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CAEB0260618
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:53:21 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

DSP firmware has interface change for SSP node index structure.
New FW interface removes the dual_mono field and adds 4 bits for
TDM slot group index. This patch updates the ssp dma to align with
the DSP firmware structure.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 7 ++++---
 sound/soc/intel/skylake/skl-topology.h | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 826d4fd8930a..77c0736d3c9e 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -303,6 +303,7 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 			struct skl_cpr_cfg *cpr_mconfig)
 {
 	union skl_connector_node_id node_id = {0};
+	union skl_ssp_dma_node ssp_node  = {0};
 	struct skl_pipe_params *params = mconfig->pipe->p_params;
 
 	switch (mconfig->dev_type) {
@@ -320,9 +321,9 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 			(SKL_CONN_SOURCE == mconfig->hw_conn_type) ?
 			SKL_DMA_I2S_LINK_OUTPUT_CLASS :
 			SKL_DMA_I2S_LINK_INPUT_CLASS;
-		node_id.node.vindex = params->host_dma_id +
-					 (mconfig->time_slot << 1) +
-					 (mconfig->vbus_id << 3);
+		ssp_node.dma_node.time_slot_index = mconfig->time_slot;
+		ssp_node.dma_node.i2s_instance = mconfig->vbus_id;
+		node_id.node.vindex = ssp_node.val;
 		break;
 
 	case SKL_DEVICE_DMIC:
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 0c83dc3ea3e2..2399535a196a 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -153,8 +153,7 @@ enum skl_dma_type {
 union skl_ssp_dma_node {
 	u8 val;
 	struct {
-		u8 dual_mono:1;
-		u8 time_slot:3;
+		u8 time_slot_index:4;
 		u8 i2s_instance:4;
 	} dma_node;
 };
-- 
1.9.1
