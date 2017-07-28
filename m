From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 2/4] ASoC: Intel: bxtn: Remove code loader
	reference in cleanup
Date: Fri, 28 Jul 2017 16:12:14 +0530
Message-ID: <20170728104216.26859-2-guneshwor.o.singh@intel.com>
References: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id EFCF22676E1
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 12:42:50 +0200 (CEST)
In-Reply-To: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Dronamraju Santosh P K <santosh.pavan.kumarx.dronamraju@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dronamraju Santosh P K <santosh.pavan.kumarx.dronamraju@intel.com>

Since Broxton does not use code loader DMA, remove code loader cleanup
in its dsp cleanup routine. Remove the iounmap too as it is done in
skl_free_dsp().

Signed-off-by: Dronamraju Santosh P K <santosh.pavan.kumarx.dronamraju@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index cf11b84888b9..08a2c5eb59fa 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -629,11 +629,6 @@ void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 		release_firmware(ctx->dsp->fw);
 	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
-	ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
-
-	if (ctx->dsp->addr.lpe)
-		iounmap(ctx->dsp->addr.lpe);
-
 	ctx->dsp->ops->free(ctx->dsp);
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_cleanup);
-- 
2.13.0
