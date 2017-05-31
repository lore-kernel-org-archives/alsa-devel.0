From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 1/3] ASoC: Intel: Skylake: Add mic-select
	module type
Date: Wed, 31 May 2017 10:30:24 +0530
Message-ID: <1496206826-28125-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1496206826-28125-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 87BB6266EF3
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 07:14:53 +0200 (CEST)
In-Reply-To: <1496206826-28125-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

mic-select module is a DSP module, which is used to select one or more
input channels.

This patch adds mic-select module type.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
1.9.1
