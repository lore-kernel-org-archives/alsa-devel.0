From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/5] ASoC: intel: log an error on double free
Date: Mon, 20 Oct 2014 15:29:05 +0530
Message-ID: <1413799148-6368-3-git-send-email-vinod.koul@intel.com>
References: <1413799148-6368-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6CD2605C1
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 12:36:16 +0200 (CEST)
In-Reply-To: <1413799148-6368-1-git-send-email-vinod.koul@intel.com>
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

the stream context should be freed only once on stream cleanup. If we ever
hit a chance that stream context is getting double freed, though not an
cause of panic as memory allocator can deal with this, we should still log
this to help in finding issues and debugging

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index aadb0db..423c5ff 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -55,6 +55,8 @@ int free_stream_context(struct intel_sst_drv *ctx, unsigned int str_id)
 		if (ret)
 			sst_clean_stream(&ctx->streams[str_id]);
 		return ret;
+	} else {
+		dev_err(ctx->dev, "we tried to free stream context %d which was freed!!!", str_id);
 	}
 	return ret;
 }
-- 
1.7.0.4
