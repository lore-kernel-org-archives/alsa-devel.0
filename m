From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add mic-select module
	type" to the asoc tree
Date: Tue, 06 Jun 2017 20:05:38 +0100
Message-ID: <E1dIJnO-00074i-NK@debutante>
References: <1495768803-24217-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1145F266FEC
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 21:05:46 +0200 (CEST)
In-Reply-To: <1495768803-24217-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, "Kranthikumar,
 GudishaX" <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add mic-select module type

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From db6879efb9d1d48ff9c2bd49dde05ecf757d73cf Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Wed, 31 May 2017 10:30:24 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add mic-select module type

mic-select module is a DSP module, which is used to select one or more
input channels.

This patch adds mic-select module type.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c       | 2 ++
 sound/soc/intel/skylake/skl-tplg-interface.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ab1adc0c9cc3..5a465020ebd8 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -707,6 +707,7 @@ static u16 skl_get_module_param_size(struct skl_sst *ctx,
 		return param_size;
 
 	case SKL_MODULE_TYPE_BASE_OUTFMT:
+	case SKL_MODULE_TYPE_MIC_SELECT:
 	case SKL_MODULE_TYPE_KPB:
 		return sizeof(struct skl_base_outfmt_cfg);
 
@@ -761,6 +762,7 @@ static int skl_set_module_format(struct skl_sst *ctx,
 		break;
 
 	case SKL_MODULE_TYPE_BASE_OUTFMT:
+	case SKL_MODULE_TYPE_MIC_SELECT:
 	case SKL_MODULE_TYPE_KPB:
 		skl_set_base_outfmt_format(ctx, module_config, *param_data);
 		break;
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 7a2febf99019..c22517bd2161 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -82,6 +82,7 @@ enum skl_module_type {
 	SKL_MODULE_TYPE_ALGO,
 	SKL_MODULE_TYPE_BASE_OUTFMT,
 	SKL_MODULE_TYPE_KPB,
+	SKL_MODULE_TYPE_MIC_SELECT,
 };
 
 enum skl_core_affinity {
-- 
2.11.0
