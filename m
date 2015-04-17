From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 9/9] ASoC: hda: Export API to change DSP power
	state
Date: Fri, 17 Apr 2015 18:46:07 +0530
Message-ID: <1429276567-29007-10-git-send-email-vinod.koul@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E8BB2659BC
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:36 +0200 (CEST)
In-Reply-To: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
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
 sound/soc/hda/intel/soc-hda-sst-dsp.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/hda/intel/soc-hda-sst-dsp.c b/sound/soc/hda/intel/soc-hda-sst-dsp.c
index b133c63a0c20..4d4d01b496b3 100644
--- a/sound/soc/hda/intel/soc-hda-sst-dsp.c
+++ b/sound/soc/hda/intel/soc-hda-sst-dsp.c
@@ -480,6 +480,20 @@ int ssth_dsp_free0(struct ssth_lib *dsp)
 }
 EXPORT_SYMBOL_GPL(ssth_dsp_free0);
 
+int ssth_dsp_set_power_state(struct ssth_lib *ctx, int state)
+{
+	int ret = 0;
+
+	if (state == SST_DSP_POWER_D0)
+		ret = ctx->ops.set_state_D0(ctx);
+	else if (state == SST_DSP_POWER_D3)
+		ret = ctx->ops.set_state_D3(ctx);
+	else
+		dev_err(ctx->dev, "Power State=%x not supported", state);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ssth_dsp_set_power_state);
+
 bool ssth_dsp_is_running(struct ssth_lib *ctx)
 {
 	bool ret = 0;
-- 
1.7.9.5
