From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: mrfld - remove non static
	definition
Date: Thu,  6 Nov 2014 19:30:43 +0530
Message-ID: <1415282443-3444-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 890FF2652F8
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 14:59:59 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

sst_save_shim64() is defined as static in code but header is non static.
Since this is not used other than file where defined remove non static
definition

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
index 3ee555e..2dcbf47 100644
--- a/sound/soc/intel/sst/sst.h
+++ b/sound/soc/intel/sst/sst.h
@@ -508,8 +508,6 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
 		size_t mbox_data_len, const void *mbox_data, void **data,
 		bool large, bool fill_dsp, bool sync, bool response);
 
-void sst_save_shim64(struct intel_sst_drv *ctx, void __iomem *shim,
-		struct sst_shim_regs64 *shim_regs);
 void sst_process_pending_msg(struct work_struct *work);
 int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx);
 void sst_init_stream(struct stream_info *stream,
-- 
1.7.0.4
