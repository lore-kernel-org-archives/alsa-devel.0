From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update for ssp node
	index in copier cfg" to the asoc tree
Date: Sat, 24 Oct 2015 02:47:45 +0900
Message-ID: <E1ZpgRN-0006UT-Pv@finisterre>
References: <1445536362-26670-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7F632651CF
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:47:54 +0200 (CEST)
In-Reply-To: <1445536362-26670-6-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Update for ssp node index in copier cfg

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

>From d7b188131c4823a85d17b992083bf8a8c32a2be3 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 22 Oct 2015 23:22:38 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update for ssp node index in copier cfg

DSP firmware has interface change for SSP node index structure.
New FW interface removes the dual_mono field and adds 4 bits for
TDM slot group index. This patch updates the ssp dma to align with
the DSP firmware structure.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 7 ++++---
 sound/soc/intel/skylake/skl-topology.h | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 826d4fd..77c0736 100644
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
index 0c83dc3..2399535 100644
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
2.6.1
