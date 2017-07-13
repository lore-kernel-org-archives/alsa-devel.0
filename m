From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: Skylake: fix type in debug message
Date: Fri, 14 Jul 2017 00:04:06 +0100
Message-ID: <20170713230406.15854-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DD23F2672A8
 for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2017 01:04:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Dharageswari R <dharageswari.r@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Jayachandran B <jayachandran.b@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to typo in debug message, dst_instacne should be
dst_instance

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index fb2f1f603f3c..c5b4e0a9946c 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -950,7 +950,7 @@ static void skl_dump_bind_info(struct skl_sst *ctx, struct skl_module_cfg
 {
 	dev_dbg(ctx->dev, "%s: src module_id = %d  src_instance=%d\n",
 		__func__, src_module->id.module_id, src_module->id.pvt_id);
-	dev_dbg(ctx->dev, "%s: dst_module=%d dst_instacne=%d\n", __func__,
+	dev_dbg(ctx->dev, "%s: dst_module=%d dst_instance=%d\n", __func__,
 		 dst_module->id.module_id, dst_module->id.pvt_id);
 
 	dev_dbg(ctx->dev, "src_module state = %d dst module state = %d\n",
-- 
2.11.0
