From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 4/7] ASoC: Intel: Add runtime module support.
Date: Mon, 20 Oct 2014 15:06:49 +0100
Message-ID: <1413814012-5619-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 979E426653E
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 16:07:46 +0200 (CEST)
In-Reply-To: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add support for runtime module objects that can be created for every FW
module that is parsed from the FW file. This gives a 1:N mapping between
the FW module from file and the runtime instantiations of that module.

We also need to make sure we remove every module and runtime module when
we unload the FW.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp-priv.h    |  26 ++++-
 sound/soc/intel/sst-firmware.c    | 228 ++++++++++++++++++++++++++++++++++----
 sound/soc/intel/sst-haswell-ipc.c |  52 ++++++---
 sound/soc/intel/sst-haswell-ipc.h |   6 +
 sound/soc/intel/sst-haswell-pcm.c |  56 ++++++++++
 5 files changed, 330 insertions(+), 38 deletions(-)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index 92fd7f0..2a9f0ff 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -152,7 +152,7 @@ struct sst_module_runtime {
 	int id;
 	struct sst_module *module;	/* parent module we belong too */
 
-	u32 persistent_offset;		/* private memory size */
+	u32 persistent_offset;		/* private memory offset */
 	void *private;
 
 	struct list_head list;
@@ -160,6 +160,16 @@ struct sst_module_runtime {
 };
 
 /*
+ * Runtime Module Context - The runtime context must be manually stored by the
+ * driver prior to enter S3 and restored after leaving S3. This should really be
+ * part of the memory context saved by the enter D3 message IPC ???
+ */
+struct sst_module_runtime_context {
+	dma_addr_t dma_buffer;
+	u32 *buffer;
+};
+
+/*
  * Audio DSP Generic Module.
  *
  * Each Firmware file can consist of 1..N modules. A module can span multiple
@@ -309,6 +319,20 @@ struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id);
 int sst_module_alloc_blocks(struct sst_module *module);
 int sst_module_free_blocks(struct sst_module *module);
 
+/* Create/Free firmware module runtime instances */
+struct sst_module_runtime *sst_module_runtime_new(struct sst_module *module,
+	int id, void *private);
+void sst_module_runtime_free(struct sst_module_runtime *runtime);
+struct sst_module_runtime *sst_module_runtime_get_from_id(
+	struct sst_module *module, u32 id);
+int sst_module_runtime_alloc_blocks(struct sst_module_runtime *runtime,
+	int offset);
+int sst_module_runtime_free_blocks(struct sst_module_runtime *runtime);
+int sst_module_runtime_save(struct sst_module_runtime *runtime,
+	struct sst_module_runtime_context *context);
+int sst_module_runtime_restore(struct sst_module_runtime *runtime,
+	struct sst_module_runtime_context *context);
+
 /* generic block allocation */
 int sst_alloc_blocks(struct sst_dsp *dsp, struct sst_block_allocator *ba,
 	struct list_head *block_list);
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 1de3f33..b36843e 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -170,21 +170,37 @@ EXPORT_SYMBOL_GPL(sst_fw_reload);
 
 void sst_fw_unload(struct sst_fw *sst_fw)
 {
-        struct sst_dsp *dsp = sst_fw->dsp;
-        struct sst_module *module, *tmp;
+	struct sst_dsp *dsp = sst_fw->dsp;
+	struct sst_module *module, *mtmp;
+	struct sst_module_runtime *runtime, *rtmp;
+
+	dev_dbg(dsp->dev, "unloading firmware\n");
+
+	mutex_lock(&dsp->mutex);
 
-        dev_dbg(dsp->dev, "unloading firmware\n");
+	/* check module by module */
+	list_for_each_entry_safe(module, mtmp, &dsp->module_list, list) {
+		if (module->sst_fw == sst_fw) {
 
-        mutex_lock(&dsp->mutex);
-        list_for_each_entry_safe(module, tmp, &dsp->module_list, list) {
-                if (module->sst_fw == sst_fw) {
-                        block_module_remove(module);
-                        list_del(&module->list);
-                        kfree(module);
-                }
-        }
+			/* remove runtime modules */
+			list_for_each_entry_safe(runtime, rtmp, &module->runtime_list, list) {
 
-        mutex_unlock(&dsp->mutex);
+				block_list_remove(dsp, &runtime->block_list);
+				list_del(&runtime->list);
+				kfree(runtime);
+			}
+
+			/* now remove the module */
+			block_list_remove(dsp, &module->block_list);
+			list_del(&module->list);
+			kfree(module);
+		}
+	}
+
+	/* remove all scratch blocks */
+	block_list_remove(dsp, &dsp->scratch_block_list);
+
+	mutex_unlock(&dsp->mutex);
 }
 EXPORT_SYMBOL_GPL(sst_fw_unload);
 
@@ -238,6 +254,7 @@ struct sst_module *sst_module_new(struct sst_fw *sst_fw,
 	sst_module->persistent_size = template->persistent_size;
 
 	INIT_LIST_HEAD(&sst_module->block_list);
+	INIT_LIST_HEAD(&sst_module->runtime_list);
 
 	mutex_lock(&dsp->mutex);
 	list_add(&sst_module->list, &dsp->module_list);
@@ -573,10 +590,169 @@ int sst_module_free_blocks(struct sst_module *module)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sst_module_free_blocks);
+
+int sst_module_runtime_alloc_blocks(struct sst_module_runtime *runtime,
+	int offset)
+{
+	struct sst_dsp *dsp = runtime->dsp;
+	struct sst_module *module = runtime->module;
+	struct sst_block_allocator ba;
+	int ret;
+
+	if (module->persistent_size == 0)
+		return 0;
+
+	ba.size = module->persistent_size;
+	ba.type = SST_MEM_DRAM;
+
+	mutex_lock(&dsp->mutex);
+
+	/* do we need to allocate at a fixed address ? */
+	if (offset != 0) {
+
+		ba.offset = offset;
+
+		dev_dbg(dsp->dev, "persistent fixed block request 0x%x bytes type %d offset 0x%x\n",
+			ba.size, ba.type, ba.offset);
+
+		/* alloc blocks that includes this section */
+		ret = block_alloc_fixed(dsp, &ba, &runtime->block_list);
+
+	} else {
+		dev_dbg(dsp->dev, "persistent block request 0x%x bytes type %d\n",
+			ba.size, ba.type);
+
+		/* alloc blocks that includes this section */
+		ret = block_alloc(dsp, &ba, &runtime->block_list);
+	}
+	if (ret < 0) {
+		dev_err(dsp->dev,
+		"error: no free blocks for runtime module size 0x%x\n",
+			module->persistent_size);
+		mutex_unlock(&dsp->mutex);
+		return -ENOMEM;
+	}
+	runtime->persistent_offset = ba.offset;
+
+	/* prepare DSP blocks for module copy */
+	ret = block_list_prepare(dsp, &runtime->block_list);
+	if (ret < 0) {
+		dev_err(dsp->dev, "error: runtime block prepare failed\n");
+		goto err;
+	}
+
+	mutex_unlock(&dsp->mutex);
+	return ret;
+
+err:
+	block_list_remove(dsp, &module->block_list);
+	mutex_unlock(&dsp->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_module_runtime_alloc_blocks);
+
+int sst_module_runtime_free_blocks(struct sst_module_runtime *runtime)
+{
+	struct sst_dsp *dsp = runtime->dsp;
+
+	mutex_lock(&dsp->mutex);
+	block_list_remove(dsp, &runtime->block_list);
 	mutex_unlock(&dsp->mutex);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sst_block_module_remove);
+EXPORT_SYMBOL_GPL(sst_module_runtime_free_blocks);
+
+int sst_module_runtime_save(struct sst_module_runtime *runtime,
+	struct sst_module_runtime_context *context)
+{
+	struct sst_dsp *dsp = runtime->dsp;
+	struct sst_module *module = runtime->module;
+	int ret = 0;
+
+	dev_dbg(dsp->dev, "saving runtime %d memory at 0x%x size 0x%x\n",
+		runtime->id, runtime->persistent_offset,
+		module->persistent_size);
+
+	context->buffer = dma_alloc_coherent(dsp->dma_dev,
+		module->persistent_size,
+		&context->dma_buffer, GFP_DMA | GFP_KERNEL);
+	if (!context->buffer) {
+		dev_err(dsp->dev, "error: DMA context alloc failed\n");
+		return -ENOMEM;
+	}
+
+	mutex_lock(&dsp->mutex);
+
+	if (dsp->fw_use_dma) {
+
+		ret = sst_dsp_dma_get_channel(dsp, 0);
+		if (ret < 0)
+			goto err;
+
+		ret = sst_dsp_dma_copyfrom(dsp, context->dma_buffer,
+			dsp->addr.lpe_base + runtime->persistent_offset,
+			module->persistent_size);
+		sst_dsp_dma_put_channel(dsp);
+		if (ret < 0) {
+			dev_err(dsp->dev, "error: context copy failed\n");
+			goto err;
+		}
+	} else
+		sst_memcpy32(context->buffer, dsp->addr.lpe +
+			runtime->persistent_offset,
+			module->persistent_size);
+
+err:
+	mutex_unlock(&dsp->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_module_runtime_save);
+
+int sst_module_runtime_restore(struct sst_module_runtime *runtime,
+	struct sst_module_runtime_context *context)
+{
+	struct sst_dsp *dsp = runtime->dsp;
+	struct sst_module *module = runtime->module;
+	int ret = 0;
+
+	dev_dbg(dsp->dev, "restoring runtime %d memory at 0x%x size 0x%x\n",
+		runtime->id, runtime->persistent_offset,
+		module->persistent_size);
+
+	mutex_lock(&dsp->mutex);
+
+	if (!context->buffer) {
+		dev_info(dsp->dev, "no context buffer need to restore!\n");
+		goto err;
+	}
+
+	if (dsp->fw_use_dma) {
+
+		ret = sst_dsp_dma_get_channel(dsp, 0);
+		if (ret < 0)
+			goto err;
+
+		ret = sst_dsp_dma_copyto(dsp,
+			dsp->addr.lpe_base + runtime->persistent_offset,
+			context->dma_buffer, module->persistent_size);
+		sst_dsp_dma_put_channel(dsp);
+		if (ret < 0) {
+			dev_err(dsp->dev, "error: module copy failed\n");
+			goto err;
+		}
+	} else
+		sst_memcpy32(dsp->addr.lpe + runtime->persistent_offset,
+			context->buffer, module->persistent_size);
+
+	dma_free_coherent(dsp->dma_dev, module->persistent_size,
+				context->buffer, context->dma_buffer);
+	context->buffer = NULL;
+
+err:
+	mutex_unlock(&dsp->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_module_runtime_restore);
 
 /* register a DSP memory block for use with FW based modules */
 struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
@@ -655,16 +831,30 @@ int sst_block_alloc_scratch(struct sst_dsp *dsp)
 		return 0;
 	}
 
+	/* allocate blocks for module scratch buffers */
+	dev_dbg(dsp->dev, "allocating scratch blocks\n");
+
 	ba.size = dsp->scratch_size;
 	ba.type = SST_MEM_DRAM;
-	ba.offset = 0;
 
-	dev_dbg(dsp->dev, "block request 0x%x bytes type %d\n",
-		ba.size, ba.type);
+	/* do we need to allocate at fixed offset */
+	if (dsp->scratch_offset != 0) {
 
-	/* allocate blocks for module scratch buffers */
-	dev_dbg(dsp->dev, "allocating scratch blocks\n");
-	ret = block_alloc(dsp, &ba, &dsp->scratch_block_list);
+		dev_dbg(dsp->dev, "block request 0x%x bytes type %d at 0x%x\n",
+			ba.size, ba.type, ba.offset);
+
+		ba.offset = dsp->scratch_offset;
+
+		/* alloc blocks that includes this section */
+		ret = block_alloc_fixed(dsp, &ba, &dsp->scratch_block_list);
+
+	} else {
+		dev_dbg(dsp->dev, "block request 0x%x bytes type %d\n",
+			ba.size, ba.type);
+
+		ba.offset = 0;
+		ret = block_alloc(dsp, &ba, &dsp->scratch_block_list);
+	}
 	if (ret < 0) {
 		dev_err(dsp->dev, "error: can't alloc scratch blocks\n");
 		mutex_unlock(&dsp->mutex);
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 0b093d4..62daa97 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1673,32 +1673,48 @@ int sst_hsw_dx_set_state(struct sst_hsw *hsw,
 	dev_dbg(hsw->dev, "ipc: got %d entry numbers for state %d\n",
 		dx->entries_no, state);
 
-	memcpy(&hsw->dx, dx, sizeof(*dx));
-	return 0;
+	return ret;
 }
 
-/* Used to save state into hsw->dx_reply */
-int sst_hsw_dx_get_state(struct sst_hsw *hsw, u32 item,
-	u32 *offset, u32 *size, u32 *source)
+struct sst_module_runtime *sst_hsw_runtime_module_create(struct sst_hsw *hsw,
+	int mod_id, int offset)
 {
-	struct sst_hsw_ipc_dx_memory_item *dx_mem;
-	struct sst_hsw_ipc_dx_reply *dx_reply;
-	int entry_no;
+	struct sst_dsp *dsp = hsw->dsp;
+	struct sst_module *module;
+	struct sst_module_runtime *runtime;
+	int err;
 
-	dx_reply = &hsw->dx;
-	entry_no = dx_reply->entries_no;
+	module = sst_module_get_from_id(dsp, mod_id);
+	if (module == NULL) {
+		dev_err(dsp->dev, "error: failed to get module %d for pcm\n",
+			mod_id);
+		return NULL;
+	}
 
-	trace_ipc_request("PM get Dx state", entry_no);
+	runtime = sst_module_runtime_new(module, mod_id, NULL);
+	if (runtime == NULL) {
+		dev_err(dsp->dev, "error: failed to create module %d runtime\n",
+			mod_id);
+		return NULL;
+	}
 
-	if (item >= entry_no)
-		return -EINVAL;
+	err = sst_module_runtime_alloc_blocks(runtime, offset);
+	if (err < 0) {
+		dev_err(dsp->dev, "error: failed to alloc blocks for module %d runtime\n",
+			mod_id);
+		sst_module_runtime_free(runtime);
+		return NULL;
+	}
 
-	dx_mem = &dx_reply->mem_info[item];
-	*offset = dx_mem->offset;
-	*size = dx_mem->size;
-	*source = dx_mem->source;
+	dev_dbg(dsp->dev, "runtime id %d created for module %d\n", runtime->id,
+		mod_id);
+	return runtime;
+}
 
-	return 0;
+void sst_hsw_runtime_module_free(struct sst_module_runtime *runtime)
+{
+	sst_module_runtime_free_blocks(runtime);
+	sst_module_runtime_free(runtime);
 }
 
 static int msg_empty_list_init(struct sst_hsw *hsw)
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index f20c1d9..f474f99 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -40,6 +40,7 @@ struct sst_hsw_stream;
 struct sst_hsw_log_stream;
 struct sst_pdata;
 struct sst_module;
+struct sst_module_runtime;
 extern struct sst_ops haswell_ops;
 
 /* Stream Allocate Path ID */
@@ -487,4 +488,9 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata);
 void sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata);
 struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw);
 
+/* runtime module management */
+struct sst_module_runtime *sst_hsw_runtime_module_create(struct sst_hsw *hsw,
+	int mod_id, int offset);
+void sst_hsw_runtime_module_free(struct sst_module_runtime *runtime);
+
 #endif
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 32a6470..3690cf7 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -89,10 +89,16 @@ static const struct snd_pcm_hardware hsw_pcm_hardware = {
 	.buffer_bytes_max	= HSW_PCM_PERIODS_MAX * PAGE_SIZE,
 };
 
+struct hsw_pcm_module_map {
+	int dai_id;
+	enum sst_hsw_module_id mod_id;
+};
+
 /* private data for each PCM DSP stream */
 struct hsw_pcm_data {
 	int dai_id;
 	struct sst_hsw_stream *stream;
+	struct sst_module_runtime *runtime;
 	u32 volume[2];
 	struct snd_pcm_substream *substream;
 	struct snd_compr_stream *cstream;
@@ -654,6 +660,53 @@ static struct snd_pcm_ops hsw_pcm_ops = {
 	.page		= snd_pcm_sgbuf_ops_page,
 };
 
+/* static mappings between PCMs and modules - may be dynamic in future */
+static struct hsw_pcm_module_map mod_map[] = {
+	{0, SST_HSW_MODULE_PCM_SYSTEM},		/* "System Pin" */
+	{1, SST_HSW_MODULE_PCM},		/* "Offload0 Pin" */
+	{2, SST_HSW_MODULE_PCM},		/* "Offload1 Pin" */
+	{3, SST_HSW_MODULE_PCM_REFERENCE},	/* "Loopback Pin" */
+	{4, SST_HSW_MODULE_PCM_CAPTURE},	/* "Capture Pin" */
+};
+
+static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
+{
+	struct sst_hsw *hsw = pdata->hsw;
+	struct hsw_pcm_data *pcm_data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
+		pcm_data = &pdata->pcm[i];
+
+		pcm_data->runtime = sst_hsw_runtime_module_create(hsw,
+			mod_map[i].mod_id);
+		if (pcm_data->runtime == NULL)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (--i; i >= 0; i--) {
+		pcm_data = &pdata->pcm[i];
+		sst_hsw_runtime_module_free(pcm_data->runtime);
+	}
+
+	return -ENODEV;
+}
+
+static void hsw_pcm_free_modules(struct hsw_priv_data *pdata)
+{
+	struct hsw_pcm_data *pcm_data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
+		pcm_data = &pdata->pcm[i];
+
+		sst_hsw_runtime_module_free(pcm_data->runtime);
+	}
+}
+
 static void hsw_pcm_free(struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_free_for_all(pcm);
@@ -797,6 +850,9 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 		}
 	}
 
+	/* allocate runtime modules */
+	hsw_pcm_create_modules(priv_data);
+
 	return 0;
 
 err:
-- 
1.9.1
