From: jeeja.kp@intel.com
Subject: [PATCH V2 03/10] ASoC: Intel: bxtn: Disable interrupt
	when DSP is in D3
Date: Mon, 13 Mar 2017 22:11:25 +0530
Message-ID: <1489423292-19997-4-git-send-email-jeeja.kp@intel.com>
References: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id F119B266CB8
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:29:36 +0100 (CET)
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

When DSP is in D3, no interrupts are expected, so disable
interrupt while entering D3.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index d3be1be..b34c965 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -537,6 +537,11 @@ static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 		"Failed to set DSP to D3:core id = %d;Continue reset\n",
 		core_id);
 
+	if (core_id == SKL_DSP_CORE0_ID) {
+		/* disable Interrupt */
+		skl_ipc_op_int_disable(ctx);
+		skl_ipc_int_disable(ctx);
+	}
 	ret = skl_dsp_disable_core(ctx, core_mask);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Failed to disable core %d\n", ret);
-- 
2.5.0
