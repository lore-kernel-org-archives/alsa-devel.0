From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix parameter overwrite
	for KPB Module" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:18 +0000
Message-ID: <E1coDQE-0002C3-QG@debutante>
References: <1488910446-26415-11-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F26F267044
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:28 +0100 (CET)
In-Reply-To: <1488910446-26415-11-git-send-email-jeeja.kp@intel.com>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, "Kranthikumar, ,
 GudishaX" <gudishax.kranthikumar@intel.com>, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix parameter overwrite for KPB Module

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

>From bf3e5ef5d549f650c13bef2b2192057cfef33d38 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Mon, 13 Mar 2017 22:11:32 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix parameter overwrite for KPB Module

KPB module default parameter were overwritten by the dynamic instance
id once use case is executed. This will cause module crash from
subsequent execution of use case as the updated parameters are used.

So instead of over writing the default parameter, make a copy and
update the module parameter and use this in IPC message.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Kranthikumar, GudishaX <gudishax.kranthikumar@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 47 +++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index d4058d2a8023..c6bd4bb49ec0 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -678,26 +678,29 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
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
@@ -714,6 +717,7 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 	struct soc_bytes_ext *sb;
 	struct skl_algo_data *bc;
 	struct skl_specific_cfg *sp_cfg;
+	u32 *params;
 
 	/*
 	 * check all out/in pins are in bind state.
@@ -746,11 +750,18 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
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
2.11.0
