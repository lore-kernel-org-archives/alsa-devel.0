From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 01/11] ASoC: Intel: Skylake: Fix updown mixer
	module format
Date: Tue,  7 Nov 2017 16:16:16 +0530
Message-ID: <20171107104626.25800-2-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A382126736D
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:02 +0100 (CET)
In-Reply-To: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

DSP expects length of the coefficient for updown mixer module to be 8.
So fix the max coefficient length and since we are using default values
for coefficient select which is zero, we need not explicitly initialize
it.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 8 --------
 sound/soc/intel/skylake/skl-topology.h | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index f637829833e6..49e6a4d7adfc 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -707,18 +707,10 @@ static void skl_set_updown_mixer_format(struct skl_sst *ctx,
 	struct skl_module *module = mconfig->module;
 	struct skl_module_iface *iface = &module->formats[mconfig->fmt_idx];
 	struct skl_module_fmt *fmt = &iface->outputs[0].fmt;
-	int i = 0;
 
 	skl_set_base_module_format(ctx,	mconfig,
 		(struct skl_base_cfg *)mixer_mconfig);
 	mixer_mconfig->out_ch_cfg = fmt->ch_cfg;
-
-	/* Select F/W default coefficient */
-	mixer_mconfig->coeff_sel = 0x0;
-
-	/* User coeff, don't care since we are selecting F/W defaults */
-	for (i = 0; i < UP_DOWN_MIXER_MAX_COEFF; i++)
-		mixer_mconfig->coeff[i] = 0xDEADBEEF;
 }
 
 /*
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index d116599bfdd7..28316cb4f36f 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -34,7 +34,7 @@
 #define MAX_FIXED_DMIC_PARAMS_SIZE 727
 
 /* Maximum number of coefficients up down mixer module */
-#define UP_DOWN_MIXER_MAX_COEFF		6
+#define UP_DOWN_MIXER_MAX_COEFF		8
 
 #define MODULE_MAX_IN_PINS	8
 #define MODULE_MAX_OUT_PINS	8
-- 
2.14.2
