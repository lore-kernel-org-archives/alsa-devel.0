From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/8] ASoC: Intel: Skylake: Unstatify
	skl_dsp_enable_core
Date: Fri, 11 Mar 2016 10:12:51 +0530
Message-ID: <1457671376-18667-4-git-send-email-vinod.koul@intel.com>
References: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A31B2610A6
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 05:38:58 +0100 (CET)
In-Reply-To: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

The function skl_dsp_enable_core will be called by other parts of
driver so this can no longer be a static function.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 646d10a0d176..a5267e8a96e0 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -181,7 +181,7 @@ static int skl_dsp_core_power_down(struct sst_dsp *ctx)
 			"Power down");
 }
 
-static int skl_dsp_enable_core(struct sst_dsp *ctx)
+int skl_dsp_enable_core(struct sst_dsp *ctx)
 {
 	int ret;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 676e78be0169..b6e310d49dd6 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -148,6 +148,7 @@ int skl_cldma_prepare(struct sst_dsp *ctx);
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 		struct sst_dsp_device *sst_dev, int irq);
+int skl_dsp_enable_core(struct sst_dsp *ctx);
 int skl_dsp_disable_core(struct sst_dsp *ctx);
 bool is_skl_dsp_running(struct sst_dsp *ctx);
 irqreturn_t skl_dsp_sst_interrupt(int irq, void *dev_id);
-- 
1.9.1
