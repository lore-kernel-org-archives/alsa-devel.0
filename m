From: "Patel, Chintan M" <chintan.m.patel@intel.com>
Subject: RE: [alsa-devel] [PATCH v5 5/6] ASoC: Intel: Skylake: Make DSP
 replies        more human readable
Date: Tue, 12 Dec 2017 18:27:07 +0000
Message-ID: <074180B186AC2945B61C466FE6C478304ADE8101@ORSMSX103.amr.corp.intel.com>
References: <1512978390-8848-1-git-send-email-sriramx.periyasamy@intel.com>
 <1512978390-8848-6-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1512978390-8848-6-git-send-email-sriramx.periyasamy@intel.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Prusty, Subhransu S" <subhransu.s.prusty@intel.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

I would also suggest to make similar changes for FW error code, since it doesn't give any clue what does FW error code indicates.

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Sriram Periyasamy
Sent: Sunday, December 10, 2017 11:46 PM
To: ALSA ML <alsa-devel@alsa-project.org>; Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>; Periyasamy, SriramX <sriramx.periyasamy@intel.com>; mturquette@baylibre.com; sboyd@codeaurora.org; Patches Audio <patches.audio@intel.com>; Liam Girdwood <liam.r.girdwood@linux.intel.com>; Koul, Vinod <vinod.koul@intel.com>; Prusty, Subhransu S <subhransu.s.prusty@intel.com>; linux-clk@vger.kernel.org
Subject: [alsa-devel] [PATCH v5 5/6] ASoC: Intel: Skylake: Make DSP replies more human readable

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Add more meaning to the IPC replies for easy debugging. Replace the switch case with a lookup table to lookup for the IPC replies and print in human readable form.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 44 ++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 5234fafb758a..8708755a8f9a 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -392,18 +392,43 @@ int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
 	return 0;
 }
 
-static int skl_ipc_set_reply_error_code(u32 reply)
+struct skl_ipc_err_map {
+	const char *msg;
+	enum skl_ipc_glb_reply reply;
+	int err;
+};
+
+static struct skl_ipc_err_map skl_err_map[] = {
+	{"DSP out of memory", IPC_GLB_REPLY_OUT_OF_MEMORY, -ENOMEM},
+	{"DSP busy", IPC_GLB_REPLY_BUSY, -EBUSY}, };
+
+static int skl_ipc_set_reply_error_code(struct sst_generic_ipc *ipc, 
+u32 reply)
 {
-	switch (reply) {
-	case IPC_GLB_REPLY_OUT_OF_MEMORY:
-		return -ENOMEM;
+	int i;
 
-	case IPC_GLB_REPLY_BUSY:
-		return -EBUSY;
+	for (i = 0; i < ARRAY_SIZE(skl_err_map); i++) {
+		if (skl_err_map[i].reply == reply)
+			break;
+	}
 
-	default:
+	if (i == ARRAY_SIZE(skl_err_map)) {
+		dev_err(ipc->dev, "ipc FW reply: %d FW Error Code: %u\n",
+				reply,
+				ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
 		return -EINVAL;
 	}
+
+	if (skl_err_map[i].err < 0)
+		dev_err(ipc->dev, "ipc FW reply: %s FW Error Code: %u\n",
+				skl_err_map[i].msg,
+				ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+	else
+		dev_info(ipc->dev, "ipc FW reply: %s FW Error Code: %u\n",
+				skl_err_map[i].msg,
+				ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+
+	return skl_err_map[i].err;
 }
 
 void skl_ipc_process_reply(struct sst_generic_ipc *ipc, @@ -441,10 +466,7 @@ void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 
 		}
 	} else {
-		msg->errno = skl_ipc_set_reply_error_code(reply);
-		dev_err(ipc->dev, "ipc FW reply: reply=%d\n", reply);
-		dev_err(ipc->dev, "FW Error Code: %u\n",
-			ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+		msg->errno = skl_ipc_set_reply_error_code(ipc, reply);
 		switch (IPC_GLB_NOTIFY_MSG_TYPE(header.primary)) {
 		case IPC_GLB_LOAD_MULTIPLE_MODS:
 		case IPC_GLB_LOAD_LIBRARY:
--
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
