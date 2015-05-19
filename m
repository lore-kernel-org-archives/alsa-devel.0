From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/8] ASoC: Intel: Move the busy check to ops
	for HSW
Date: Tue, 19 May 2015 15:00:35 +0530
Message-ID: <1432027840-18711-4-git-send-email-vinod.koul@intel.com>
References: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 311932650F5
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 11:29:51 +0200 (CEST)
In-Reply-To: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 324eceb07b25..6304e4bfccd6 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2098,6 +2098,14 @@ static u64 hsw_reply_msg_match(u64 header, u64 *mask)
 	return header;
 }
 
+static bool hsw_is_dsp_busy(struct sst_dsp *dsp)
+{
+	u64 ipcx;
+
+	ipcx = sst_dsp_shim_read_unlocked(dsp, SST_IPCX);
+	return (ipcx & (SST_IPCX_BUSY | SST_IPCX_DONE));
+}
+
 int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 {
 	struct sst_hsw_ipc_fw_version version;
@@ -2117,6 +2125,7 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	ipc->ops.shim_dbg = hsw_shim_dbg;
 	ipc->ops.tx_data_copy = hsw_tx_data_copy;
 	ipc->ops.reply_msg_match = hsw_reply_msg_match;
+	ipc->ops.is_dsp_busy = hsw_is_dsp_busy;
 
 	ret = sst_ipc_init(ipc);
 	if (ret != 0)
-- 
1.9.1
