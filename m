From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to set Non gateway
	copier cfg" to the asoc tree
Date: Sat, 24 Oct 2015 02:47:42 +0900
Message-ID: <E1ZpgRK-0006T0-HE@finisterre>
References: <1445536362-26670-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B22822651AA
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:47:53 +0200 (CEST)
In-Reply-To: <1445536362-26670-9-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Dharageswari.R" <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to set Non gateway copier cfg

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

>From bfa764accdea017b1c557f43fa5f2c77a0dc3b15 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 22 Oct 2015 23:22:41 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to set Non gateway copier cfg

If copier instance is connected to a DMA gateway then driver
needs to configure the gateway configuration otherwise set
it to invalid.
This patch sets the non gateway copier node value to invalid.

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c       | 8 +++++++-
 sound/soc/intel/skylake/skl-tplg-interface.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index a1001a6..50a1095 100644
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
index d14f7fe..718d3d5 100644
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
2.6.1
