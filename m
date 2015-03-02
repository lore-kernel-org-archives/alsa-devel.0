From: han.lu@intel.com
Subject: [PATCH 1/8] ASoC: Intel: add function to load firmware
	image
Date: Mon,  2 Mar 2015 15:36:11 +0800
Message-ID: <1425281778-17513-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D0DB426058C
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 08:38:07 +0100 (CET)
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

Add a general method to load firmware image, and apply to base firmware
image loading. With the method, the driver will support loading multiple
different modules in order to support different features.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index b9da030..396d545 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -173,6 +173,16 @@ struct sst_module_runtime_context {
 };
 
 /*
+ * Audio DSP Module State
+ */
+enum sst_module_state {
+	SST_MODULE_STATE_UNLOADED = 0,	/* default state */
+	SST_MODULE_STATE_LOADED,
+	SST_MODULE_STATE_INITIALIZED,	/* and inactive */
+	SST_MODULE_STATE_ACTIVE,
+};
+
+/*
  * Audio DSP Generic Module.
  *
  * Each Firmware file can consist of 1..N modules. A module can span multiple
@@ -203,6 +213,9 @@ struct sst_module {
 	struct list_head list;		/* DSP list of modules */
 	struct list_head list_fw;	/* FW list of modules */
 	struct list_head runtime_list;	/* list of runtime module objects*/
+
+	/* state */
+	enum sst_module_state state;
 };
 
 /*
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 5f71ef6..5e58008 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -498,6 +498,7 @@ struct sst_module *sst_module_new(struct sst_fw *sst_fw,
 	sst_module->scratch_size = template->scratch_size;
 	sst_module->persistent_size = template->persistent_size;
 	sst_module->entry = template->entry;
+	sst_module->state = SST_MODULE_STATE_UNLOADED;
 
 	INIT_LIST_HEAD(&sst_module->block_list);
 	INIT_LIST_HEAD(&sst_module->runtime_list);
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 402b728..8ad733b 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -169,6 +169,7 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 
 		block = (void *)block + sizeof(*block) + block->size;
 	}
+	mod->state = SST_MODULE_STATE_LOADED;
 
 	return 0;
 }
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 863a9ca..cbd8c00 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1844,6 +1844,8 @@ int sst_hsw_dsp_runtime_resume(struct sst_hsw *hsw)
 	if (ret < 0)
 		dev_err(dev, "error: audio DSP boot failure\n");
 
+	sst_hsw_init_module_state(hsw);
+
 	ret = wait_event_timeout(hsw->boot_wait, hsw->boot_complete,
 		msecs_to_jiffies(IPC_BOOT_MSECS));
 	if (ret == 0) {
@@ -1886,6 +1888,75 @@ struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw)
 	return hsw->dsp;
 }
 
+void sst_hsw_init_module_state(struct sst_hsw *hsw)
+{
+	struct sst_module *module;
+	enum sst_hsw_module_id id;
+
+	/* the base fw contains several modules */
+	for (id = SST_HSW_MODULE_BASE_FW; id < SST_HSW_MAX_MODULE_ID; id++) {
+		module = sst_module_get_from_id(hsw->dsp, id);
+		if (module)
+			module->state = SST_MODULE_STATE_ACTIVE;
+	}
+}
+
+int sst_hsw_module_load(struct sst_hsw *hsw,
+	u32 module_id, u32 instance_id, char *name)
+{
+	int ret = 0;
+	const struct firmware *fw = NULL;
+	struct sst_fw *hsw_sst_fw;
+	struct sst_module *module;
+	struct device *dev = hsw->dev;
+	struct sst_dsp *dsp = hsw->dsp;
+
+	dev_dbg(dev, "sst_hsw_module_load id=%d, name='%s'", module_id, name);
+
+	module = sst_module_get_from_id(dsp, module_id);
+	if (module == NULL) {
+		/* loading for the first time */
+		if (module_id == SST_HSW_MODULE_BASE_FW) {
+			/* for base module: use fw requested in acpi probe */
+			fw = dsp->pdata->fw;
+			if (!fw) {
+				dev_err(dev, "request Base fw failed\n");
+				return -ENODEV;
+			}
+		} else {
+			/* try and load any other optional modules if they are
+			 * available. Use dev_info instead of dev_err in case
+			 * request firmware failed */
+			ret = request_firmware(&fw, name, dev);
+			if (ret) {
+				dev_info(dev, "fw image %s not available(%d)\n",
+						name, ret);
+				return ret;
+			}
+		}
+		hsw_sst_fw = sst_fw_new(dsp, fw, hsw);
+		if (hsw_sst_fw  == NULL) {
+			dev_err(dev, "error: failed to load firmware\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+		module = sst_module_get_from_id(dsp, module_id);
+		if (module == NULL) {
+			dev_err(dev, "error: no module %d in firmware %s\n",
+					module_id, name);
+		}
+		dev_info(dev, "firmware %s loaded successfuly\n", name);
+	} else
+		dev_info(dev, "module %d (%s) already loaded\n",
+				module_id, name);
+out:
+	/* release fw, but base fw should be released by acpi driver */
+	if (fw && module_id != SST_HSW_MODULE_BASE_FW)
+		release_firmware(fw);
+
+	return ret;
+}
+
 static struct sst_dsp_device hsw_dev = {
 	.thread = hsw_irq_thread,
 	.ops = &haswell_ops,
@@ -1947,12 +2018,10 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	/* keep the DSP in reset state for base FW loading */
 	sst_dsp_reset(hsw->dsp);
 
-	hsw->sst_fw = sst_fw_new(hsw->dsp, pdata->fw, hsw);
-	if (hsw->sst_fw == NULL) {
-		ret = -ENODEV;
-		dev_err(dev, "error: failed to load firmware\n");
+	/* load base module and other modules in base firmware image */
+	ret = sst_hsw_module_load(hsw, SST_HSW_MODULE_BASE_FW, 0, "Base");
+	if (ret < 0)
 		goto fw_err;
-	}
 
 	/* allocate scratch mem regions */
 	ret = sst_block_alloc_scratch(hsw->dsp);
@@ -1971,6 +2040,9 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 		goto boot_err;
 	}
 
+	/* init module state after boot */
+	sst_hsw_init_module_state(hsw);
+
 	/* get the FW version */
 	sst_hsw_fw_get_version(hsw, &version);
 
@@ -1986,7 +2058,7 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 
 boot_err:
 	sst_dsp_reset(hsw->dsp);
-	sst_fw_free(hsw->sst_fw);
+	sst_fw_free_all(hsw->dsp);
 fw_err:
 	dma_free_coherent(hsw->dsp->dma_dev, SST_HSW_DX_CONTEXT_SIZE,
 			hsw->dx_context, hsw->dx_context_paddr);
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 8580960..e071b3a 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -467,6 +467,12 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata);
 void sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata);
 struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw);
 
+/* fw module function */
+void sst_hsw_init_module_state(struct sst_hsw *hsw);
+
+int sst_hsw_module_load(struct sst_hsw *hsw,
+	u32 module_id, u32 instance_id, char *name);
+
 /* runtime module management */
 struct sst_module_runtime *sst_hsw_runtime_module_create(struct sst_hsw *hsw,
 	int mod_id, int offset);
-- 
1.9.1
