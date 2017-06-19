From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix dma buffer size
	calculation" to the asoc tree
Date: Mon, 19 Jun 2017 17:23:58 +0100
Message-ID: <E1dMzT4-0002Pd-Bc@debutante>
References: <1497267657-20359-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0738267135
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 18:24:07 +0200 (CEST)
In-Reply-To: <1497267657-20359-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ramesh Babu <ramesh.babu@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix dma buffer size calculation

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

>From f6e6ab1d16ec9dafa65557b5637f5217b32702ef Mon Sep 17 00:00:00 2001
From: Ramesh Babu <ramesh.babu@intel.com>
Date: Mon, 19 Jun 2017 11:59:20 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix dma buffer size calculation

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
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 5a465020ebd8..eca85827dbd2 100644
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
2.11.0
