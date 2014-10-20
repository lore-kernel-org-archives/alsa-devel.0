From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/5] ASoC: intel: explain why block not found
	isn't error always
Date: Mon, 20 Oct 2014 15:29:07 +0530
Message-ID: <1413799148-6368-5-git-send-email-vinod.koul@intel.com>
References: <1413799148-6368-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 05901260589
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 12:36:20 +0200 (CEST)
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

The IPC blocking can be error when we don't find block or a short message,
explain that by adding a comment about this scenario

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_ipc.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst_ipc.c b/sound/soc/intel/sst/sst_ipc.c
index 41a2b41..fbda009 100644
--- a/sound/soc/intel/sst/sst_ipc.c
+++ b/sound/soc/intel/sst/sst_ipc.c
@@ -54,6 +54,21 @@ struct sst_block *sst_create_block(struct intel_sst_drv *ctx,
 	return msg;
 }
 
+/*
+ * while handling the interrupts, we need to check for message status and
+ * then if we are blocking for a message
+ *
+ * here we are unblocking the blocked ones, this is based on id we have
+ * passed and search that for block threads.
+ * We will not find block in two cases
+ *  a) when its small message and block in not there, so sliently ignore
+ *  them
+ *  b) when we are actually not able to find the block (bug perhpas)
+ *
+ *  Since we have bit of small messages we can spam kernel log with err
+ *  print on above so need to keep as debug prints which should be enabled
+ *  via dybnamic debug while debuuging IPC issues
+ */
 int sst_wake_up_block(struct intel_sst_drv *ctx, int result,
 		u32 drv_id, u32 ipc, void *data, u32 size)
 {
-- 
1.7.0.4
