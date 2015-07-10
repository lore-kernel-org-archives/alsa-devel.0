From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Skylake: Print error code in
	IPC for SKL
Date: Fri, 10 Jul 2015 22:18:45 +0530
Message-ID: <1436546926-17263-8-git-send-email-vinod.koul@intel.com>
References: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A2FEE266660
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 18:47:16 +0200 (CEST)
In-Reply-To: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Omair M Abdullah <omair.m.abdullah@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Omair M Abdullah <omair.m.abdullah@intel.com>

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index c0d092861337..937a0a3a63a0 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -362,6 +362,12 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 		break;
 	}
 
+	if (reply != IPC_GLB_REPLY_SUCCESS) {
+		dev_err(ipc->dev, "ipc FW reply: reply=%d", reply);
+		dev_err(ipc->dev, "FW Error Code: %u\n",
+			ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+	}
+
 	list_del(&msg->list);
 	sst_ipc_tx_msg_reply_complete(ipc, msg);
 }
-- 
1.9.1
