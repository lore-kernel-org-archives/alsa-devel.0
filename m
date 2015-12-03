From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 04/12] ASoC: Intel: Skylake: Fix module init
	data correctly
Date: Thu,  3 Dec 2015 23:29:53 +0530
Message-ID: <1449165601-11226-5-git-send-email-vinod.koul@intel.com>
References: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 399032605C1
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 18:57:15 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Module initialization parameter data can be set by
     - INIT_INSTANCE IPC by using the default value
     - SET_PARAMS immediately after INIT_INSTANCE
     - SET_PARAMS data from kcontrol values set
this patch add param type to identify the parameters
has to be sent to DSP.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c       |  6 +++---
 sound/soc/intel/skylake/skl-topology.h       |  4 ++--
 sound/soc/intel/skylake/skl-tplg-interface.h | 16 +++++++++++-----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ad1388e4f847..d5919d75fee4 100644
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
1.9.1
