From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH] [PATCH REPOST] ASoC: Intel: Atom: Fix message
	handling during drop stream
Date: Fri,  7 Oct 2016 03:38:32 -0700
Message-ID: <1475836712-16258-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id CC452266DBF
 for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2016 12:38:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vinod.koul@intel.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: Harsha Priya <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

If a stream is being dropped, the period_elapsed received then after
need not be processed. Processing of the period_elapsed message causes
a time out in drop stream response processing. This patch adds a condition
to skip period_elapsed message processing if the stream is in INIT state.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 8afa6fe..bfc8899 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -267,6 +267,9 @@ static void process_fw_async_msg(struct intel_sst_drv *sst_drv_ctx,
 				"Period elapsed rcvd for pipe id 0x%x\n",
 				pipe_id);
 			stream = &sst_drv_ctx->streams[str_id];
+			/* If stream is dropped, skip processing this message*/
+			if (stream->status == STREAM_INIT)
+				break;
 			if (stream->period_elapsed)
 				stream->period_elapsed(stream->pcm_substream);
 			if (stream->compr_cb)
-- 
1.9.1
