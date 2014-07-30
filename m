From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Add notification trace for reset.
Date: Wed, 30 Jul 2014 20:09:47 +0800
Message-ID: <1406722187-8076-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A4AEB2608D3
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:08:49 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add trace notification of IPC stream reset.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 96373ab..436c2fa 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -687,7 +687,9 @@ static void hsw_stream_update(struct sst_hsw *hsw, struct ipc_message *msg)
 	switch (stream_msg) {
 	case IPC_STR_STAGE_MESSAGE:
 	case IPC_STR_NOTIFICATION:
+		break;
 	case IPC_STR_RESET:
+		trace_ipc_notification("stream reset", stream->reply.stream_hw_id);
 		break;
 	case IPC_STR_PAUSE:
 		stream->running = false;
-- 
1.8.3.2
