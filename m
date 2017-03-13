From: jeeja.kp@intel.com
Subject: [PATCH V2 10/10] ASoC: Intel: Skylake: Fix parameter
	overwrite for KPB Module
Date: Mon, 13 Mar 2017 22:11:32 +0530
Message-ID: <1489423292-19997-11-git-send-email-jeeja.kp@intel.com>
References: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C313266CCE
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:30:00 +0100 (CET)
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
Cc: Dharageswari R <dharageswari.r@intel.com>, tiwai@suse.de, "Kranthikumar,
 GudishaX" <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

KPB module default parameter were overwritten by the dynamic instance
id once use case is executed. This will cause module crash from
subsequent execution of use case as the updated parameters are used.

So instead of over writing the default parameter, make a copy and
update the module parameter and use this in IPC message.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Kranthikumar, GudishaX <gudishax.kranthikumar@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 47 +++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index f04a251..33a4e0d 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -680,26 +680,29 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int skl_fill_sink_instance_id(struct skl_sst *ctx,
-				struct skl_algo_data *alg_data)
+static int skl_fill_sink_instance_id(struct skl_sst *ctx, u32 *params,
+				int size, struct skl_module_cfg *mcfg)
 {
-	struct skl_kpb_params *params = (struct skl_kpb_params *)alg_data->params;
-	struct skl_mod_inst_map *inst;
 	int i, pvt_id;
 
-	inst = params->map;
+	if (mcfg->m_type == SKL_MODULE_TYPE_KPB) {
+		struct skl_kpb_params *kpb_params =
+				(struct skl_kpb_params *)params;
+		struct skl_mod_inst_map *inst = kpb_params->map;
 
-	for (i = 0; i < params->num_modules; i++) {
-		pvt_id = skl_get_pvt_instance_id_map(ctx,
-					inst->mod_id, inst->inst_id);
-		if (pvt_id < 0)
-			return -EINVAL;
-		inst->inst_id = pvt_id;
-		inst++;
+		for (i = 0; i < kpb_params->num_modules; i++) {
+			pvt_id = skl_get_pvt_instance_id_map(ctx, inst->mod_id,
+								inst->inst_id);
+			if (pvt_id < 0)
+				return -EINVAL;
+
+			inst->inst_id = pvt_id;
+			inst++;
+		}
 	}
+
 	return 0;
 }
-
 /*
  * Some modules require params to be set after the module is bound to
  * all pins connected.
@@ -716,6 +719,7 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 	struct soc_bytes_ext *sb;
 	struct skl_algo_data *bc;
 	struct skl_specific_cfg *sp_cfg;
+	u32 *params;
 
 	/*
 	 * check all out/in pins are in bind state.
@@ -748,11 +752,18 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 			bc = (struct skl_algo_data *)sb->dobj.private;
 
 			if (bc->set_params == SKL_PARAM_BIND) {
-				if (mconfig->m_type == SKL_MODULE_TYPE_KPB)
-					skl_fill_sink_instance_id(ctx, bc);
-				ret = skl_set_module_params(ctx,
-						(u32 *)bc->params, bc->max,
-						bc->param_id, mconfig);
+				params = kzalloc(bc->max, GFP_KERNEL);
+				if (!params)
+					return -ENOMEM;
+
+				memcpy(params, bc->params, bc->max);
+				skl_fill_sink_instance_id(ctx, params, bc->max,
+								mconfig);
+
+				ret = skl_set_module_params(ctx, params,
+						bc->max, bc->param_id, mconfig);
+				kfree(params);
+
 				if (ret < 0)
 					return ret;
 			}
-- 
2.5.0
