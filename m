From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 2/5] ASoC: intel: log an error on double free
Date: Mon, 20 Oct 2014 20:54:31 +0530
Message-ID: <1413818674-14158-3-git-send-email-vinod.koul@intel.com>
References: <1413818674-14158-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AD7862667B1
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 18:02:51 +0200 (CEST)
In-Reply-To: <1413818674-14158-1-git-send-email-vinod.koul@intel.com>
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

the stream context should be freed only once on stream cleanup. If we ever
hit a chance that stream context is getting double freed, though not an
cause of panic as memory allocator can deal with this, we should still log
this to help in finding issues and debugging

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index aadb0db..3a5e920 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -55,6 +55,8 @@ int free_stream_context(struct intel_sst_drv *ctx, unsigned int str_id)
 		if (ret)
 			sst_clean_stream(&ctx->streams[str_id]);
 		return ret;
+	} else {
+		dev_err(ctx->dev, "we tried to free stream context %d which was freed!!!\n", str_id);
 	}
 	return ret;
 }
-- 
1.7.0.4
