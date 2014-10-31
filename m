From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/3] Audio: SST: use lock when changing SST
	state.
Date: Fri, 31 Oct 2014 12:38:21 +0530
Message-ID: <1414739301-12659-4-git-send-email-vinod.koul@intel.com>
References: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D2223265554
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 08:49:25 +0100 (CET)
In-Reply-To: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Mythri P K <mythri.p.k@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Mythri P K <mythri.p.k@intel.com>

SST state change should be done under sst_lock

Signed-off-by: Mythri P K <mythri.p.k@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c     |    4 +---
 sound/soc/intel/sst/sst_ipc.c |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 7b8a110..04af246 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -463,15 +463,13 @@ static int intel_sst_runtime_resume(struct device *dev)
 	int ret = 0;
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
 
-	mutex_lock(&ctx->sst_lock);
 	if (ctx->sst_state == SST_RESET) {
 		ret = sst_load_fw(ctx);
 		if (ret) {
 			dev_err(dev, "FW download fail %d\n", ret);
-			ctx->sst_state = SST_RESET;
+			sst_set_fw_state_locked(ctx, SST_RESET);
 		}
 	}
-	mutex_unlock(&ctx->sst_lock);
 	return ret;
 }
 
diff --git a/sound/soc/intel/sst/sst_ipc.c b/sound/soc/intel/sst/sst_ipc.c
index 2126f5b..484e609 100644
--- a/sound/soc/intel/sst/sst_ipc.c
+++ b/sound/soc/intel/sst/sst_ipc.c
@@ -230,7 +230,7 @@ static void process_fw_init(struct intel_sst_drv *sst_drv_ctx,
 
 	dev_dbg(sst_drv_ctx->dev, "*** FW Init msg came***\n");
 	if (init->result) {
-		sst_drv_ctx->sst_state =  SST_RESET;
+		sst_set_fw_state_locked(sst_drv_ctx, SST_RESET);
 		dev_err(sst_drv_ctx->dev, "FW Init failed, Error %x\n",
 				init->result);
 		retval = init->result;
-- 
1.7.0.4
