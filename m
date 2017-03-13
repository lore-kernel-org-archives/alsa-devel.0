From: jeeja.kp@intel.com
Subject: [PATCH V2 05/10] ASoC: Intel: bxtn: Reload the
	firmware in case of D3 failure
Date: Mon, 13 Mar 2017 22:11:27 +0530
Message-ID: <1489423292-19997-6-git-send-email-jeeja.kp@intel.com>
References: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AE40266CE1
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:29:43 +0100 (CET)
In-Reply-To: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

If D3 IPC fails or times out, firmware needs to be reloaded as driver
continues the reset.
So set the fw_load flag to false to reload the firmware in D0.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 2a2bb94..600d958 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -533,10 +533,16 @@ static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 
 	ret = skl_ipc_set_dx(&skl->ipc, BXT_INSTANCE_ID,
 				BXT_BASE_FW_MODULE_ID, &dx);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(ctx->dev,
 		"Failed to set DSP to D3:core id = %d;Continue reset\n",
 		core_id);
+		/*
+		 * In case of D3 failure, re-download the firmware, so set
+		 * fw_loaded to false.
+		 */
+		skl->fw_loaded = false;
+	}
 
 	if (core_id == SKL_DSP_CORE0_ID) {
 		/* disable Interrupt */
-- 
2.5.0
