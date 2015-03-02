From: han.lu@intel.com
Subject: [PATCH 2/8] ASoC: Intel: add function to load sound
	effect module waves
Date: Mon,  2 Mar 2015 15:36:12 +0800
Message-ID: <1425281778-17513-2-git-send-email-han.lu@intel.com>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 026A926058E
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 08:38:08 +0100 (CET)
In-Reply-To: <1425281778-17513-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Try to load module waves and allocate runtime blocks for it if the firmware
image of module waves exists.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 8ad733b..b3e957d 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -100,6 +100,7 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 		&& module->type != SST_HSW_MODULE_PCM
 		&& module->type != SST_HSW_MODULE_PCM_REFERENCE
 		&& module->type != SST_HSW_MODULE_PCM_CAPTURE
+		&& module->type != SST_HSW_MODULE_WAVES
 		&& module->type != SST_HSW_MODULE_LPAL)
 		return 0;
 
@@ -139,6 +140,7 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 			mod->type = SST_MEM_IRAM;
 			break;
 		case SST_HSW_DRAM:
+		case SST_HSW_REGS:
 			ram = dsp->addr.lpe;
 			mod->offset = block->ram_offset;
 			mod->type = SST_MEM_DRAM;
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index cbd8c00..711439e 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1896,11 +1896,27 @@ void sst_hsw_init_module_state(struct sst_hsw *hsw)
 	/* the base fw contains several modules */
 	for (id = SST_HSW_MODULE_BASE_FW; id < SST_HSW_MAX_MODULE_ID; id++) {
 		module = sst_module_get_from_id(hsw->dsp, id);
-		if (module)
-			module->state = SST_MODULE_STATE_ACTIVE;
+		if (module) {
+			/* module waves is active only after being enabled */
+			if (id == SST_HSW_MODULE_WAVES)
+				module->state = SST_MODULE_STATE_INITIALIZED;
+			else
+				module->state = SST_MODULE_STATE_ACTIVE;
+		}
 	}
 }
 
+bool sst_hsw_is_module_loaded(struct sst_hsw *hsw, u32 module_id)
+{
+	struct sst_module *module;
+
+	module = sst_module_get_from_id(hsw->dsp, module_id);
+	if (module == NULL || module->state == SST_MODULE_STATE_UNLOADED)
+		return false;
+	else
+		return true;
+}
+
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name)
 {
@@ -2023,6 +2039,9 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	if (ret < 0)
 		goto fw_err;
 
+	/* try to load module waves */
+	sst_hsw_module_load(hsw, SST_HSW_MODULE_WAVES, 0, "intel/IntcPP01.bin");
+
 	/* allocate scratch mem regions */
 	ret = sst_block_alloc_scratch(hsw->dsp);
 	if (ret < 0)
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index e071b3a..208724b 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -469,6 +469,7 @@ struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw);
 
 /* fw module function */
 void sst_hsw_init_module_state(struct sst_hsw *hsw);
+bool sst_hsw_is_module_loaded(struct sst_hsw *hsw, u32 module_id);
 
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name);
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 7e21e8f..a604cc4 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -807,6 +807,17 @@ static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
 			pcm_data->runtime->persistent_offset;
 	}
 
+	/* create runtime blocks for module waves */
+	if (sst_hsw_is_module_loaded(hsw, SST_HSW_MODULE_WAVES)) {
+		pcm_data = &pdata->pcm[HSW_PCM_COUNT-1][0];
+		pcm_data->runtime = sst_hsw_runtime_module_create(hsw,
+			SST_HSW_MODULE_WAVES, pcm_data->persistent_offset);
+		if (pcm_data->runtime == NULL)
+			goto err;
+		pcm_data->persistent_offset =
+			pcm_data->runtime->persistent_offset;
+	}
+
 	return 0;
 
 err:
@@ -820,12 +831,16 @@ err:
 
 static void hsw_pcm_free_modules(struct hsw_priv_data *pdata)
 {
+	struct sst_hsw *hsw = pdata->hsw;
 	struct hsw_pcm_data *pcm_data;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
 		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
-
+		sst_hsw_runtime_module_free(pcm_data->runtime);
+	}
+	if (sst_hsw_is_module_loaded(hsw, SST_HSW_MODULE_WAVES)) {
+		pcm_data = &pdata->pcm[HSW_PCM_COUNT-1][0];
 		sst_hsw_runtime_module_free(pcm_data->runtime);
 	}
 }
@@ -984,7 +999,9 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 	}
 
 	/* allocate runtime modules */
-	hsw_pcm_create_modules(priv_data);
+	ret = hsw_pcm_create_modules(priv_data);
+	if (ret < 0)
+		goto err;
 
 	/* enable runtime PM with auto suspend */
 	pm_runtime_set_autosuspend_delay(platform->dev,
-- 
1.9.1
