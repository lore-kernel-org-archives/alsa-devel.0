From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: read params from DSP if
	module is on" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:24 +0000
Message-ID: <E1a6NfY-00042b-0m@debutante>
References: <1449165601-11226-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ABF34260592
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:29 +0100 (CET)
In-Reply-To: <1449165601-11226-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Omair M Abdullah <omair.m.abdullah@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: read params from DSP if module is on

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

>From 7d9f29119d3e4db6ae817881d8e305650424032c Mon Sep 17 00:00:00 2001
From: Omair M Abdullah <omair.m.abdullah@intel.com>
Date: Thu, 3 Dec 2015 23:29:56 +0530
Subject: [PATCH] ASoC: Intel: Skylake: read params from DSP if module is on

If a module is ON then we should read the module parameters from
DSP rather than driver cached values

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index eb31235f7040..b824450edcb4 100644
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
2.6.2
