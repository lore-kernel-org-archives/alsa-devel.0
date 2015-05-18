From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/8] ASoC: Intel: Initialize max mailbox size
	for baytrail
Date: Mon, 18 May 2015 16:55:59 +0530
Message-ID: <1431948361-12756-7-git-send-email-vinod.koul@intel.com>
References: <1431948361-12756-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D32592606B4
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 13:25:18 +0200 (CEST)
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
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 799b804f3e34..773a47552bdf 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -708,6 +708,8 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	ipc->ops.tx_data_copy = byt_tx_data_copy;
 	ipc->ops.reply_msg_match = byt_reply_msg_match;
 	ipc->ops.is_dsp_busy = byt_is_dsp_busy;
+	ipc->tx_data_max_size = IPC_MAX_MAILBOX_BYTES;
+	ipc->rx_data_max_size = IPC_MAX_MAILBOX_BYTES;
 
 	err = sst_ipc_init(ipc);
 	if (err != 0)
-- 
1.9.1
