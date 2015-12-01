From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support to
	configure module params" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:38 +0000
Message-ID: <E1a3tta-00064e-17@debutante>
References: <1448703121-5831-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE6426073D
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:44 +0100 (CET)
In-Reply-To: <1448703121-5831-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support to configure module params

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

>From abb740033b56a2f57582e8e26bb9ea3650b6a3cc Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Sat, 28 Nov 2015 15:01:49 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support to configure module params

This adds support to configure module parameter during module
initialization or after module init using set module param
required by the DSP firmware sequence.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 87 +++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-topology.h |  9 ++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 7a03bea48a9a..bfc138df56bc 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -314,6 +314,83 @@ static int skl_tplg_alloc_pipe_widget(struct device *dev,
 }
 
 /*
+ * some modules can have multiple params set from user control and
+ * need to be set after module is initialized. If set_param flag is
+ * set module params will be done after module is initialised.
+ */
+static int skl_tplg_set_module_params(struct snd_soc_dapm_widget *w,
+						struct skl_sst *ctx)
+{
+	int i, ret;
+	struct skl_module_cfg *mconfig = w->priv;
+	const struct snd_kcontrol_new *k;
+	struct soc_bytes_ext *sb;
+	struct skl_algo_data *bc;
+	struct skl_specific_cfg *sp_cfg;
+
+	if (mconfig->formats_config.caps_size > 0 &&
+		mconfig->formats_config.set_params) {
+		sp_cfg = &mconfig->formats_config;
+		ret = skl_set_module_params(ctx, sp_cfg->caps,
+					sp_cfg->caps_size,
+					sp_cfg->param_id, mconfig);
+		if (ret < 0)
+			return ret;
+	}
+
+	for (i = 0; i < w->num_kcontrols; i++) {
+		k = &w->kcontrol_news[i];
+		if (k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			sb = (void *) k->private_value;
+			bc = (struct skl_algo_data *)sb->dobj.private;
+
+			if (bc->set_params) {
+				ret = skl_set_module_params(ctx,
+						(u32 *)bc->params, bc->max,
+						bc->param_id, mconfig);
+				if (ret < 0)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * some module param can set from user control and this is required as
+ * when module is initailzed. if module param is required in init it is
+ * identifed by set_param flag. if set_param flag is not set, then this
+ * parameter needs to set as part of module init.
+ */
+static int skl_tplg_set_module_init_data(struct snd_soc_dapm_widget *w)
+{
+	const struct snd_kcontrol_new *k;
+	struct soc_bytes_ext *sb;
+	struct skl_algo_data *bc;
+	struct skl_module_cfg *mconfig = w->priv;
+	int i;
+
+	for (i = 0; i < w->num_kcontrols; i++) {
+		k = &w->kcontrol_news[i];
+		if (k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			sb = (struct soc_bytes_ext *)k->private_value;
+			bc = (struct skl_algo_data *)sb->dobj.private;
+
+			if (bc->set_params)
+				continue;
+
+			mconfig->formats_config.caps = (u32 *)&bc->params;
+			mconfig->formats_config.caps_size = bc->max;
+
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
  * Inside a pipe instance, we can have various modules. These modules need
  * to instantiated in DSP by invoking INIT_MODULE IPC, which is achieved by
  * skl_init_module() routine, so invoke that for all modules in a pipeline
@@ -340,9 +417,15 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		 * FE/BE params
 		 */
 		skl_tplg_update_module_params(w, ctx);
+
+		skl_tplg_set_module_init_data(w);
 		ret = skl_init_module(ctx, mconfig);
 		if (ret < 0)
 			return ret;
+
+		ret = skl_tplg_set_module_params(w, ctx);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
@@ -1215,7 +1298,9 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 		return -ENOMEM;
 
 	memcpy(mconfig->formats_config.caps, dfw_config->caps.caps,
-					 dfw_config->caps.caps_size);
+						 dfw_config->caps.caps_size);
+	mconfig->formats_config.param_id = dfw_config->caps.param_id;
+	mconfig->formats_config.set_params = dfw_config->caps.set_params;
 
 bind_event:
 	if (tplg_w->event_type == 0) {
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 0a66fab59828..51e785424a37 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -206,6 +206,8 @@ struct skl_module_pin {
 };
 
 struct skl_specific_cfg {
+	bool set_params;
+	u32 param_id;
 	u32 caps_size;
 	u32 *caps;
 };
@@ -284,6 +286,13 @@ struct skl_module_cfg {
 	struct skl_specific_cfg formats_config;
 };
 
+struct skl_algo_data {
+	u32 param_id;
+	bool set_params;
+	u32 max;
+	char *params;
+};
+
 struct skl_pipeline {
 	struct skl_pipe *pipe;
 	struct list_head node;
-- 
2.6.2
