From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v2 7/7] ASoC: Intel: Skylake: Update module id
	in pin connections
Date: Wed, 23 Aug 2017 19:33:54 +0530
Message-ID: <20170823140354.792-8-guneshwor.o.singh@intel.com>
References: <20170823140354.792-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E44226779B
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 16:04:24 +0200 (CEST)
In-Reply-To: <20170823140354.792-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Each module's id comes from the topology and gets updated in the
driver. This patch updates the input and output pin connections of
each module by matching the uuid for each module.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c      | 41 +++++++++++++++++++++++++++++++---
 sound/soc/intel/skylake/skl-topology.h |  1 +
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index a756882b9029..2b1e513b1680 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1220,8 +1220,11 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
 {
 	struct skl_sst *ctx = skl->skl_sst;
+	struct skl_module_inst_id *pin_id;
+	uuid_le *uuid_mod, *uuid_tplg;
+	struct skl_module *skl_module;
 	struct uuid_module *module;
-	uuid_le *uuid_mod;
+	int i, ret = -EIO;
 
 	uuid_mod = (uuid_le *)mconfig->guid;
 
@@ -1235,11 +1238,43 @@ static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
 			mconfig->id.module_id = module->id;
 			if (mconfig->module)
 				mconfig->module->loadable = module->is_loadable;
-			return 0;
+			ret = 0;
+			break;
 		}
 	}
 
-	return -EIO;
+	if (ret)
+		return ret;
+
+	uuid_mod = &module->uuid;
+	ret = -EIO;
+	for (i = 0; i < skl->nr_modules; i++) {
+		skl_module = skl->modules[i];
+		uuid_tplg = &skl_module->uuid;
+		if (!uuid_le_cmp(*uuid_mod, *uuid_tplg)) {
+			mconfig->module = skl_module;
+			ret = 0;
+			break;
+		}
+	}
+	if (skl->nr_modules && ret)
+		return ret;
+
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		for (i = 0; i < MAX_IN_QUEUE; i++) {
+			pin_id = &mconfig->m_in_pin[i].id;
+			if (!uuid_le_cmp(pin_id->mod_uuid, module->uuid))
+				pin_id->module_id = module->id;
+		}
+
+		for (i = 0; i < MAX_OUT_QUEUE; i++) {
+			pin_id = &mconfig->m_out_pin[i].id;
+			if (!uuid_le_cmp(pin_id->mod_uuid, module->uuid))
+				pin_id->module_id = module->id;
+		}
+	}
+
+	return 0;
 }
 
 static int skl_populate_modules(struct skl *skl)
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 6f76b69b041e..a2db3ab525e7 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -222,6 +222,7 @@ struct skl_kpb_params {
 };
 
 struct skl_module_inst_id {
+	uuid_le mod_uuid;
 	int module_id;
 	u32 instance_id;
 	int pvt_id;
-- 
2.14.1
