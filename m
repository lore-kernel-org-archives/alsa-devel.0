From: jeeja.kp@intel.com
Subject: [PATCH 05/10] ASoC: Intel: bxtn: Reload the firmware
	in case of D3 failure
Date: Tue,  7 Mar 2017 23:44:01 +0530
Message-ID: <1488910446-26415-6-git-send-email-jeeja.kp@intel.com>
References: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E6D71267041
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 19:02:22 +0100 (CET)
In-Reply-To: <1488910446-26415-1-git-send-email-jeeja.kp@intel.com>
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
index c6f18b5..b30f887 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -515,10 +515,16 @@ static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 
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
