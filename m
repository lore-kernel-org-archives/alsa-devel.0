From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/3] ASoC: Intel: mrfld: Fix runtime pm
	calls in sst_open_pcm_stream
Date: Fri, 31 Oct 2014 12:38:19 +0530
Message-ID: <1414739301-12659-2-git-send-email-vinod.koul@intel.com>
References: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 720B9265617
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 08:49:19 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

It's already done in open/close.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index 183b1eb..4187057 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -163,16 +163,11 @@ static int sst_open_pcm_stream(struct device *dev,
 	if (!str_param)
 		return -EINVAL;
 
-	retval = pm_runtime_get_sync(ctx->dev);
-	if (retval < 0)
-		return retval;
 	retval = sst_get_stream(ctx, str_param);
-	if (retval > 0) {
+	if (retval > 0)
 		ctx->stream_cnt++;
-	} else {
+	else
 		dev_err(ctx->dev, "sst_get_stream returned err %d\n", retval);
-		sst_pm_runtime_put(ctx);
-	}
 
 	return retval;
 }
@@ -212,7 +207,8 @@ put:
 	stream->period_elapsed = NULL;
 	ctx->stream_cnt--;
 
-	sst_pm_runtime_put(ctx);
+	if (retval)
+		dev_err(ctx->dev, "free stream returned err %d\n", retval);
 
 	dev_dbg(ctx->dev, "Exit\n");
 	return 0;
-- 
1.7.0.4
