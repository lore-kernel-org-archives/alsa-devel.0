From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/2] ASoC: Intel: Skylake: Use UUID in
	binary format
Date: Thu, 21 Apr 2016 11:45:22 +0530
Message-ID: <1461219323-1036-2-git-send-email-vinod.koul@intel.com>
References: <1461219323-1036-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 77F19265162
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:10:49 +0200 (CEST)
In-Reply-To: <1461219323-1036-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

To avoid complex string manipulations with UUID in canonical
form, use UUID in binary format.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h        | 2 +-
 sound/soc/intel/skylake/skl-sst.c            | 9 ++++++---
 sound/soc/intel/skylake/skl-topology.c       | 6 ++----
 sound/soc/intel/skylake/skl-topology.h       | 2 +-
 sound/soc/intel/skylake/skl-tplg-interface.h | 2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index ff31e6615251..deabe7308d3b 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -118,7 +118,7 @@ struct skl_dsp_fw_ops {
 	int (*set_state_D0)(struct sst_dsp *ctx);
 	int (*set_state_D3)(struct sst_dsp *ctx);
 	unsigned int (*get_fw_errcode)(struct sst_dsp *ctx);
-	int (*load_mod)(struct sst_dsp *ctx, u16 mod_id, char *mod_name);
+	int (*load_mod)(struct sst_dsp *ctx, u16 mod_id, u8 *mod_name);
 	int (*unload_mod)(struct sst_dsp *ctx, u16 mod_id);
 
 };
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 348a734f8e24..bec4a7c486fd 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/uuid.h>
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
 #include "../common/sst-ipc.h"
@@ -304,14 +305,16 @@ static int skl_transfer_module(struct sst_dsp *ctx,
 	return ret;
 }
 
-static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, char *guid)
+static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, u8 *guid)
 {
 	struct skl_module_table *module_entry = NULL;
 	int ret = 0;
 	char mod_name[64]; /* guid str = 32 chars + 4 hyphens */
+	uuid_le *uuid_mod;
 
-	snprintf(mod_name, sizeof(mod_name), "%s%s%s",
-			"intel/dsp_fw_", guid, ".bin");
+	uuid_mod = (uuid_le *)guid;
+	snprintf(mod_name, sizeof(mod_name), "%s%pUL%s",
+				"intel/dsp_fw_", uuid_mod, ".bin");
 
 	module_entry = skl_module_get_from_id(ctx, mod_id);
 	if (module_entry == NULL) {
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 1f4fe0e05292..3e036b0349b9 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1583,6 +1583,8 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 		return -ENOMEM;
 
 	w->priv = mconfig;
+	memcpy(&mconfig->guid, &dfw_config->uuid, 16);
+
 	mconfig->id.module_id = dfw_config->module_id;
 	mconfig->id.instance_id = dfw_config->instance_id;
 	mconfig->mcps = dfw_config->max_mcps;
@@ -1612,10 +1614,6 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	mconfig->time_slot = dfw_config->time_slot;
 	mconfig->formats_config.caps_size = dfw_config->caps.caps_size;
 
-	if (dfw_config->is_loadable)
-		memcpy(mconfig->guid, dfw_config->uuid,
-					ARRAY_SIZE(dfw_config->uuid));
-
 	mconfig->m_in_pin = devm_kzalloc(bus->dev, (mconfig->max_in_queue) *
 						sizeof(*mconfig->m_in_pin),
 						GFP_KERNEL);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index d2d923002d5c..e4b399cd7868 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -281,7 +281,7 @@ enum skl_module_state {
 };
 
 struct skl_module_cfg {
-	char guid[SKL_UUID_STR_SZ];
+	u8 guid[16];
 	struct skl_module_inst_id id;
 	u8 domain;
 	bool homogenous_inputs;
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 1db88a63ac17..a32e5e9cc530 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -181,7 +181,7 @@ struct skl_dfw_pipe {
 } __packed;
 
 struct skl_dfw_module {
-	char uuid[SKL_UUID_STR_SZ];
+	u8 uuid[16];
 
 	u16 module_id;
 	u16 instance_id;
-- 
1.9.1
