From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix default
	dma_buffer_size" to the asoc tree
Date: Mon, 10 Jul 2017 19:41:47 +0100
Message-ID: <E1dUdcx-000097-5J@debutante>
References: <1498828124-17671-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38C7C266D49
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 20:42:00 +0200 (CEST)
In-Reply-To: <1498828124-17671-1-git-send-email-subhransu.s.prusty@intel.com>
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

   ASoC: Intel: Skylake: Fix default dma_buffer_size

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

>From 5b43af6d25461d7de293e0704d3b4631dda9b1e8 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 30 Jun 2017 18:38:44 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix default dma_buffer_size

If the dma_buffer_size is not defined in topology, fix it to 2ms default
value to make backward compatible.

Fixes: f6e6ab1d16ec ("ASoC: Intel: Skylake: Fix dma buffer size calculation")
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index eca85827dbd2..fb2f1f603f3c 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -540,6 +540,14 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 	cpr_mconfig->gtw_cfg.dma_buffer_size =
 				mconfig->dma_buffer_size * dma_io_buf;
 
+	/* fallback to 2ms default value */
+	if (!cpr_mconfig->gtw_cfg.dma_buffer_size) {
+		if (mconfig->hw_conn_type == SKL_CONN_SOURCE)
+			cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->obs;
+		else
+			cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->ibs;
+	}
+
 	cpr_mconfig->cpr_feature_mask = 0;
 	cpr_mconfig->gtw_cfg.config_length  = 0;
 
-- 
2.13.2
