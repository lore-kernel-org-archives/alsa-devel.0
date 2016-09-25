From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update to use instance
	ids generated" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:37 -0700
Message-ID: <E1bo2ST-00030a-Ti@finisterre>
References: <1472042001-9582-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 64B612665B1
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 07:58:52 +0200 (CEST)
In-Reply-To: <1472042001-9582-9-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Update to use instance ids generated

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

>From 5e8f0ee46de46e709e19675726a46cf5838b9bca Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Thu, 22 Sep 2016 14:00:40 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update to use instance ids generated

Post bind parameters of KPB module contains the instance id's of
neighbouring modules in the sink path

Now that module instance ids are generated dynamically we need to update
these parameters as well, so use the table created and update the ids

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c       |  2 ++
 sound/soc/intel/skylake/skl-topology.c       | 22 ++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h       | 10 ++++++++++
 sound/soc/intel/skylake/skl-tplg-interface.h |  3 ++-
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ac0c58e170c3..805b7f2173f3 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -680,6 +680,7 @@ static u16 skl_get_module_param_size(struct skl_sst *ctx,
 		return param_size;
 
 	case SKL_MODULE_TYPE_BASE_OUTFMT:
+	case SKL_MODULE_TYPE_KPB:
 		return sizeof(struct skl_base_outfmt_cfg);
 
 	default:
@@ -733,6 +734,7 @@ static int skl_set_module_format(struct skl_sst *ctx,
 		break;
 
 	case SKL_MODULE_TYPE_BASE_OUTFMT:
+	case SKL_MODULE_TYPE_KPB:
 		skl_set_base_outfmt_format(ctx, module_config, *param_data);
 		break;
 
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b6fc374f38b5..e48f872505b1 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -607,6 +607,26 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int skl_fill_sink_instance_id(struct skl_sst *ctx,
+				struct skl_algo_data *alg_data)
+{
+	struct skl_kpb_params *params = (struct skl_kpb_params *)alg_data->params;
+	struct skl_mod_inst_map *inst;
+	int i, pvt_id;
+
+	inst = params->map;
+
+	for (i = 0; i < params->num_modules; i++) {
+		pvt_id = skl_get_pvt_instance_id_map(ctx,
+					inst->mod_id, inst->inst_id);
+		if (pvt_id < 0)
+			return -EINVAL;
+		inst->inst_id = pvt_id;
+		inst++;
+	}
+	return 0;
+}
+
 /*
  * Some modules require params to be set after the module is bound to
  * all pins connected.
@@ -655,6 +675,8 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 			bc = (struct skl_algo_data *)sb->dobj.private;
 
 			if (bc->set_params == SKL_PARAM_BIND) {
+				if (mconfig->m_type == SKL_MODULE_TYPE_KPB)
+					skl_fill_sink_instance_id(ctx, bc);
 				ret = skl_set_module_params(ctx,
 						(u32 *)bc->params, bc->max,
 						bc->param_id, mconfig);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index def03912b1bd..a519360f42a6 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -215,6 +215,16 @@ struct skl_module_fmt {
 
 struct skl_module_cfg;
 
+struct skl_mod_inst_map {
+	u16 mod_id;
+	u16 inst_id;
+};
+
+struct skl_kpb_params {
+	u32 num_modules;
+	struct skl_mod_inst_map map[0];
+};
+
 struct skl_module_inst_id {
 	int module_id;
 	u32 instance_id;
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index e208724f9db3..2f6281e056d6 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -80,7 +80,8 @@ enum skl_module_type {
 	SKL_MODULE_TYPE_UPDWMIX,
 	SKL_MODULE_TYPE_SRCINT,
 	SKL_MODULE_TYPE_ALGO,
-	SKL_MODULE_TYPE_BASE_OUTFMT
+	SKL_MODULE_TYPE_BASE_OUTFMT,
+	SKL_MODULE_TYPE_KPB,
 };
 
 enum skl_core_affinity {
-- 
2.9.3
