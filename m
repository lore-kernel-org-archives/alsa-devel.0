From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix updown mixer module
	format" to the asoc tree
Date: Wed, 08 Nov 2017 21:33:46 +0000
Message-ID: <E1eCXyk-0005b8-J2@debutante>
References: <20171107104626.25800-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DD782676BF
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:35:20 +0100 (CET)
In-Reply-To: <20171107104626.25800-2-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix updown mixer module format

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3e1b96c80f1a73594b2123173c551bb0fc829b21 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Tue, 7 Nov 2017 16:16:16 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix updown mixer module format

DSP expects length of the coefficient for updown mixer module to be 8.
So fix the max coefficient length and since we are using default values
for coefficient select which is zero, we need not explicitly initialize
it.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 8 --------
 sound/soc/intel/skylake/skl-topology.h | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 89f70133c8e4..55414be23b82 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -702,18 +702,10 @@ static void skl_set_updown_mixer_format(struct skl_sst *ctx,
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
index 2717db92036b..16cea466018c 100644
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
2.15.0
