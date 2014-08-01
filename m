From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Delete message when IPC timeout
	occurs
Date: Fri,  1 Aug 2014 23:08:38 +0800
Message-ID: <1406905718-31142-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9876F265474
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 17:07:41 +0200 (CEST)
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

This fixes a bug where we dont delete the current message when an
IPC message timeout occurs.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 96373ab..5a607ab 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -502,6 +502,7 @@ static int tx_wait_done(struct sst_hsw *hsw, struct ipc_message *msg,
 		ipc_shim_dbg(hsw, "message timeout");
 
 		trace_ipc_error("error message timeout for", msg->header);
+		list_del(&msg->list);
 		ret = -ETIMEDOUT;
 	} else {
 
-- 
1.8.3.2
