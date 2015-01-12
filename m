From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: initial stream_hw_id to invalid
	value
Date: Mon, 12 Jan 2015 17:17:34 +0800
Message-ID: <1421054254-25716-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B693C26064A
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 10:16:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The stream_hw_id for System stream is 0x0, if we use initial stream_hw_id
value 0, it may return wrong(not committed) stream when calling function
get_stream_by_id() with stream_id=0. Here initial stream_hw_id to invalid
value to fix this issue.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 5bf1404..eeef9a5 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -94,6 +94,8 @@
 /* Mailbox */
 #define IPC_MAX_MAILBOX_BYTES	256
 
+#define INVALID_STREAM_HW_ID	0xffffffff
+
 /* Global Message - Types and Replies */
 enum ipc_glb_type {
 	IPC_GLB_GET_FW_VERSION = 0,		/* Retrieves firmware version */
@@ -1208,6 +1210,7 @@ struct sst_hsw_stream *sst_hsw_stream_new(struct sst_hsw *hsw, int id,
 		return NULL;
 
 	spin_lock_irqsave(&sst->spinlock, flags);
+	stream->reply.stream_hw_id = INVALID_STREAM_HW_ID;
 	list_add(&stream->node, &hsw->stream_list);
 	stream->notify_position = notify_position;
 	stream->pdata = data;
-- 
1.9.1
