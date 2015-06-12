From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: Intel: Fixed incorrect sst pcm_delay
Date: Thu, 11 Jun 2015 22:17:57 -0700
Message-ID: <1434086277-9881-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A4DF7266640
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 07:18:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, sathya.prakash.m.r@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch corrected pcm_delay calculation in BSW sst driver

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/atom/sst/sst_drv_interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 7b50a9d..620da1d 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -533,7 +533,7 @@ static inline int sst_calc_tstamp(struct intel_sst_drv *ctx,
 
 	info->buffer_ptr = pointer_samples / substream->runtime->channels;
 
-	info->pcm_delay = delay_frames / substream->runtime->channels;
+	info->pcm_delay = delay_frames;
 	dev_dbg(ctx->dev, "buffer ptr %llu pcm_delay rep: %llu\n",
 			info->buffer_ptr, info->pcm_delay);
 	return 0;
-- 
1.7.9.5
