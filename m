From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix to use the actual
	size for TLV control
Date: Fri,  8 Jul 2016 18:15:03 +0530
Message-ID: <1467981903-29691-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 371E0266A4D
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 14:38:03 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Dharageswari R <dharageswari.r@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

DSP expects the actual length of parameters that is set through
TLV to be passed in large config set, so pass the actual size
received in tlv_control_set() instead of max size.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 13 +++++++++----
 sound/soc/intel/skylake/skl-topology.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b284b3cf5f94..cc0150fc2601 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -411,7 +411,7 @@ static int skl_tplg_set_module_params(struct snd_soc_dapm_widget *w,
 
 			if (bc->set_params == SKL_PARAM_SET) {
 				ret = skl_set_module_params(ctx,
-						(u32 *)bc->params, bc->max,
+						(u32 *)bc->params, bc->size,
 						bc->param_id, mconfig);
 				if (ret < 0)
 					return ret;
@@ -446,7 +446,7 @@ static int skl_tplg_set_module_init_data(struct snd_soc_dapm_widget *w)
 				continue;
 
 			mconfig->formats_config.caps = (u32 *)&bc->params;
-			mconfig->formats_config.caps_size = bc->max;
+			mconfig->formats_config.caps_size = bc->size;
 
 			break;
 		}
@@ -1054,7 +1054,7 @@ static int skl_tplg_tlv_control_get(struct snd_kcontrol *kcontrol,
 
 	if (w->power)
 		skl_get_module_params(skl->skl_sst, (u32 *)bc->params,
-				      bc->max, bc->param_id, mconfig);
+				      bc->size, bc->param_id, mconfig);
 
 	/* decrement size for TLV header */
 	size -= 2 * sizeof(u32);
@@ -1088,6 +1088,10 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
 	struct skl *skl = get_skl_ctx(w->dapm->dev);
 
 	if (ac->params) {
+		if (size > ac->max)
+			return -EINVAL;
+
+		ac->size = size;
 		/*
 		 * if the param_is is of type Vendor, firmware expects actual
 		 * parameter id and size from the control.
@@ -1103,7 +1107,7 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
 
 		if (w->power)
 			return skl_set_module_params(skl->skl_sst,
-						(u32 *)ac->params, ac->max,
+						(u32 *)ac->params, ac->size,
 						ac->param_id, mconfig);
 	}
 
@@ -1719,6 +1723,7 @@ static int skl_init_algo_data(struct device *dev, struct soc_bytes_ext *be,
 	ac->max = dfw_ac->max;
 	ac->param_id = dfw_ac->param_id;
 	ac->set_params = dfw_ac->set_params;
+	ac->size = dfw_ac->max;
 
 	if (ac->max) {
 		ac->params = (char *) devm_kzalloc(dev, ac->max, GFP_KERNEL);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 170d68b4e12d..22d3ef83817d 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -321,6 +321,7 @@ struct skl_algo_data {
 	u32 param_id;
 	u32 set_params;
 	u32 max;
+	u32 size;
 	char *params;
 };
 
-- 
1.9.1
