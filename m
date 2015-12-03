From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 07/12] ASoC: Intel: Skylake: read params
	from DSP if module is on
Date: Thu,  3 Dec 2015 23:29:56 +0530
Message-ID: <1449165601-11226-8-git-send-email-vinod.koul@intel.com>
References: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DE14C2606CF
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 18:57:22 +0100 (CET)
In-Reply-To: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Omair M Abdullah <omair.m.abdullah@intel.com>

If a module is ON then we should read the module parameters from
DSP rather than driver cached values

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 13 +++++++++++++
 sound/soc/intel/skylake/skl-topology.c |  7 +++++++
 sound/soc/intel/skylake/skl-topology.h |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index a91161be7f5d..46310d9ac008 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -927,3 +927,16 @@ int skl_set_module_params(struct skl_sst *ctx, u32 *params, int size,
 
 	return skl_ipc_set_large_config(&ctx->ipc, &msg, params);
 }
+
+int skl_get_module_params(struct skl_sst *ctx, u32 *params, int size,
+			  u32 param_id, struct skl_module_cfg *mcfg)
+{
+	struct skl_ipc_large_config_msg msg;
+
+	msg.module_id = mcfg->id.module_id;
+	msg.instance_id = mcfg->id.instance_id;
+	msg.param_data_size = size;
+	msg.large_param_id = param_id;
+
+	return skl_ipc_get_large_config(&ctx->ipc, &msg, params);
+}
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index d5919d75fee4..5fb56cb168da 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -908,6 +908,13 @@ static int skl_tplg_tlv_control_get(struct snd_kcontrol *kcontrol,
 	struct soc_bytes_ext *sb =
 			(struct soc_bytes_ext *)kcontrol->private_value;
 	struct skl_algo_data *bc = (struct skl_algo_data *)sb->dobj.private;
+	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
+	struct skl_module_cfg *mconfig = w->priv;
+	struct skl *skl = get_skl_ctx(w->dapm->dev);
+
+	if (w->power)
+		skl_get_module_params(skl->skl_sst, (u32 *)bc->params,
+				      bc->max, bc->param_id, mconfig);
 
 	if (bc->params) {
 		if (copy_to_user(data, &bc->param_id, sizeof(u32)))
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 6ba0bdc7753c..9aa2a2b6598a 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -342,6 +342,8 @@ int skl_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
 
 int skl_set_module_params(struct skl_sst *ctx, u32 *params, int size,
 			u32 param_id, struct skl_module_cfg *mcfg);
+int skl_get_module_params(struct skl_sst *ctx, u32 *params, int size,
+			  u32 param_id, struct skl_module_cfg *mcfg);
 
 enum skl_bitdepth skl_get_bit_depth(int params);
 #endif
-- 
1.9.1
