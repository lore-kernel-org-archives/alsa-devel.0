From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [alsa-devel] [PATCH v6 6/6] ASoC: Intel: Skylake: Add FW reply for MCLK/SCLK IPC
Date: Tue, 26 Dec 2017 22:14:56 +0530
Message-ID: <1514306696-7062-7-git-send-email-sriramx.periyasamy@intel.com>
References: <1514306696-7062-1-git-send-email-sriramx.periyasamy@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1514306696-7062-1-git-send-email-sriramx.periyasamy@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audi o <patches.audio@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

If mclk/sclk is already running, FW responds with IPC reply MCLK/SCLK
already running. Add these to the IPC reply lookup table.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 8708755a8f9a..9f3ce73593ae 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -249,6 +249,8 @@ enum skl_ipc_glb_reply {
 	IPC_GLB_REPLY_INVALID_CONFIG_DATA_LEN = 121,
 	IPC_GLB_REPLY_GATEWAY_NOT_INITIALIZED = 140,
 	IPC_GLB_REPLY_GATEWAY_NOT_EXIST = 141,
+	IPC_GLB_REPLY_SCLK_ALREADY_RUNNING = 150,
+	IPC_GLB_REPLY_MCLK_ALREADY_RUNNING = 151,
 
 	IPC_GLB_REPLY_PPL_NOT_INITIALIZED = 160,
 	IPC_GLB_REPLY_PPL_NOT_EXIST = 161,
@@ -401,6 +403,10 @@ struct skl_ipc_err_map {
 static struct skl_ipc_err_map skl_err_map[] = {
 	{"DSP out of memory", IPC_GLB_REPLY_OUT_OF_MEMORY, -ENOMEM},
 	{"DSP busy", IPC_GLB_REPLY_BUSY, -EBUSY},
+	{"SCLK already running", IPC_GLB_REPLY_SCLK_ALREADY_RUNNING,
+			IPC_GLB_REPLY_SCLK_ALREADY_RUNNING},
+	{"MCLK already running", IPC_GLB_REPLY_MCLK_ALREADY_RUNNING,
+			IPC_GLB_REPLY_MCLK_ALREADY_RUNNING},
 };
 
 static int skl_ipc_set_reply_error_code(struct sst_generic_ipc *ipc, u32 reply)
-- 
2.7.4

