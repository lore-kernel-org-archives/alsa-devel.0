From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix default
	dma_buffer_size
Date: Fri, 30 Jun 2017 18:38:44 +0530
Message-ID: <1498828124-17671-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C9722674F0
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 15:24:04 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

If the dma_buffer_size is not defined in topology, fix it to 2ms default
value to make backward compatible.

Fixes: f6e6ab1d16ec ("ASoC: Intel: Skylake: Fix dma buffer size calculation")
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
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
1.9.1
