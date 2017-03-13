From: jeeja.kp@intel.com
Subject: [PATCH V2 04/10] ASoC: Intel: bxtn: Update DSP core
	state in D0
Date: Mon, 13 Mar 2017 22:11:26 +0530
Message-ID: <1489423292-19997-5-git-send-email-jeeja.kp@intel.com>
References: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A0EAE266CAF
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:29:40 +0100 (CET)
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

In system suspend, firmware needs to be re-downloaded as IMR is cleared.
When firmware is downloaded in D0, core state is not set to running
state causing instability with subsequent D0-D3 cycles.

So set the core state correctly during D0 and check the DSP core state
if not in reset to set the DSP to D3.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c     | 1 +
 sound/soc/intel/skylake/skl-sst-dsp.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index b34c965..2a2bb94 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -446,6 +446,7 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 				return ret;
 			}
 		}
+		skl->cores.state[core_id] = SKL_DSP_RUNNING;
 		return ret;
 	}
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index c3deefa..0833272 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -355,12 +355,13 @@ int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id)
 		ret = ctx->fw_ops.set_state_D0(ctx, core_id);
 		if (ret < 0) {
 			dev_err(ctx->dev, "unable to get core%d\n", core_id);
-			return ret;
+			goto out;
 		}
 	}
 
 	skl->cores.usage_count[core_id]++;
 
+out:
 	dev_dbg(ctx->dev, "core id %d state %d usage_count %d\n",
 			core_id, skl->cores.state[core_id],
 			skl->cores.usage_count[core_id]);
@@ -379,7 +380,8 @@ int skl_dsp_put_core(struct sst_dsp *ctx, unsigned int core_id)
 		return -EINVAL;
 	}
 
-	if (--skl->cores.usage_count[core_id] == 0) {
+	if ((--skl->cores.usage_count[core_id] == 0) &&
+		(skl->cores.state[core_id] != SKL_DSP_RESET)) {
 		ret = ctx->fw_ops.set_state_D3(ctx, core_id);
 		if (ret < 0) {
 			dev_err(ctx->dev, "unable to put core %d: %d\n",
-- 
2.5.0
