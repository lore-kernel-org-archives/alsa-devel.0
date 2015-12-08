From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix module init data
	correctly" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:26 +0000
Message-ID: <E1a6Nfa-000440-Qm@debutante>
References: <1448703121-5831-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 91C1A2606C3
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:32 +0100 (CET)
In-Reply-To: <1448703121-5831-11-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix module init data correctly

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

>From 4ced182763286a7c26cf671b27d1ddd58cf6cec8 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 3 Dec 2015 23:29:53 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix module init data correctly

Module initialization parameter data can be set by
     - INIT_INSTANCE IPC by using the default value
     - SET_PARAMS immediately after INIT_INSTANCE
     - SET_PARAMS data from kcontrol values set
this patch add param type to identify the parameters
has to be sent to DSP.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c       |  6 +++---
 sound/soc/intel/skylake/skl-topology.h       |  4 ++--
 sound/soc/intel/skylake/skl-tplg-interface.h | 16 +++++++++++-----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index be02214e80db..eb31235f7040 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -331,7 +331,7 @@ static int skl_tplg_set_module_params(struct snd_soc_dapm_widget *w,
 	struct skl_specific_cfg *sp_cfg;
 
 	if (mconfig->formats_config.caps_size > 0 &&
-		mconfig->formats_config.set_params) {
+		mconfig->formats_config.set_params == SKL_PARAM_SET) {
 		sp_cfg = &mconfig->formats_config;
 		ret = skl_set_module_params(ctx, sp_cfg->caps,
 					sp_cfg->caps_size,
@@ -346,7 +346,7 @@ static int skl_tplg_set_module_params(struct snd_soc_dapm_widget *w,
 			sb = (void *) k->private_value;
 			bc = (struct skl_algo_data *)sb->dobj.private;
 
-			if (bc->set_params) {
+			if (bc->set_params == SKL_PARAM_SET) {
 				ret = skl_set_module_params(ctx,
 						(u32 *)bc->params, bc->max,
 						bc->param_id, mconfig);
@@ -379,7 +379,7 @@ static int skl_tplg_set_module_init_data(struct snd_soc_dapm_widget *w)
 			sb = (struct soc_bytes_ext *)k->private_value;
 			bc = (struct skl_algo_data *)sb->dobj.private;
 
-			if (bc->set_params)
+			if (bc->set_params != SKL_PARAM_INIT)
 				continue;
 
 			mconfig->formats_config.caps = (u32 *)&bc->params;
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 349f2a3b6613..6ba0bdc7753c 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -211,7 +211,7 @@ struct skl_module_pin {
 };
 
 struct skl_specific_cfg {
-	bool set_params;
+	u32 set_params;
 	u32 param_id;
 	u32 caps_size;
 	u32 *caps;
@@ -294,7 +294,7 @@ struct skl_module_cfg {
 
 struct skl_algo_data {
 	u32 param_id;
-	bool set_params;
+	u32 set_params;
 	u32 max;
 	char *params;
 };
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 626b148317fe..c9ae010b3cc8 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -141,6 +141,12 @@ enum module_pin_type {
 	SKL_PIN_TYPE_HETEROGENEOUS,
 };
 
+enum skl_module_param_type {
+	SKL_PARAM_DEFAULT = 0,
+	SKL_PARAM_INIT,
+	SKL_PARAM_SET
+};
+
 struct skl_dfw_module_pin {
 	u16 module_id;
 	u16 instance_id;
@@ -158,8 +164,8 @@ struct skl_dfw_module_fmt {
 } __packed;
 
 struct skl_dfw_module_caps {
-	u32 set_params:1;
-	u32 rsvd:31;
+	u32 set_params:2;
+	u32 rsvd:30;
 	u32 param_id;
 	u32 caps_size;
 	u32 caps[HDA_SST_CFG_MAX];
@@ -214,10 +220,10 @@ struct skl_dfw_module {
 } __packed;
 
 struct skl_dfw_algo_data {
-	u32 set_params:1;
-	u32 rsvd:31;
-	u32 max;
+	u32 set_params:2;
+	u32 rsvd:30;
 	u32 param_id;
+	u32 max;
 	char params[0];
 } __packed;
 
-- 
2.6.2
