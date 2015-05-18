From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/8] ASoC: Intel: Initialize max mailbox size
	for haswell
Date: Mon, 18 May 2015 16:56:00 +0530
Message-ID: <1431948361-12756-8-git-send-email-vinod.koul@intel.com>
References: <1431948361-12756-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DC722606CA
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 13:25:20 +0200 (CEST)
In-Reply-To: <1431948361-12756-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 6304e4bfccd6..f95f271aab0c 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2127,6 +2127,9 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	ipc->ops.reply_msg_match = hsw_reply_msg_match;
 	ipc->ops.is_dsp_busy = hsw_is_dsp_busy;
 
+	ipc->tx_data_max_size = IPC_MAX_MAILBOX_BYTES;
+	ipc->rx_data_max_size = IPC_MAX_MAILBOX_BYTES;
+
 	ret = sst_ipc_init(ipc);
 	if (ret != 0)
 		goto ipc_init_err;
-- 
1.9.1
