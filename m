From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 4/4] ASoC: Intel: Skylake: Fix DSP core ref
	count for init failure
Date: Tue, 22 Aug 2017 16:45:53 +0530
Message-ID: <1503400553-15377-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A71752675B6
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:33:14 +0200 (CEST)
In-Reply-To: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

During dsp init failure, the ref count is not incremented and dsp is
powered down. But as the skl driver calls put_core for the init failure it
decrements the dsp core ref count and ref count becomes unbalanced.

This results in dsp core powered up in further runtime suspend/resume
cycles and never powered down.

So increment the ref count before dsp core powerup and for any failure,
decrement in put_core will be balanced.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index c2ba5ff1632c..19ee1d4f3bdf 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -351,6 +351,8 @@ int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id)
 		return -EINVAL;
 	}
 
+	skl->cores.usage_count[core_id]++;
+
 	if (skl->cores.state[core_id] == SKL_DSP_RESET) {
 		ret = ctx->fw_ops.set_state_D0(ctx, core_id);
 		if (ret < 0) {
@@ -359,8 +361,6 @@ int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id)
 		}
 	}
 
-	skl->cores.usage_count[core_id]++;
-
 out:
 	dev_dbg(ctx->dev, "core id %d state %d usage_count %d\n",
 			core_id, skl->cores.state[core_id],
-- 
1.9.1
