From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 2/7] ASoC: Intel: update scratch allocator
	to use generic block allocator
Date: Tue, 28 Oct 2014 17:37:13 +0000
Message-ID: <1414517838-16210-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1414517838-16210-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0553C265A58
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 18:38:52 +0100 (CET)
In-Reply-To: <1414517838-16210-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

Update the scratch allocator to use the generic block allocator and calculate
total scratch buffer size.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp-priv.h    | 15 ++++---
 sound/soc/intel/sst-dsp.c         |  1 +
 sound/soc/intel/sst-firmware.c    | 87 +++++++++++++++++----------------------
 sound/soc/intel/sst-haswell-dsp.c | 10 +----
 sound/soc/intel/sst-haswell-ipc.c |  6 ---
 sound/soc/intel/sst-haswell-ipc.h |  2 -
 6 files changed, 51 insertions(+), 70 deletions(-)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index f58a049..4c91449 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -257,6 +257,11 @@ struct sst_dsp {
 	struct list_head module_list;
 	struct list_head fw_list;
 
+	/* scratch buffer */
+	struct list_head scratch_block_list;
+	u32 scratch_offset;
+	u32 scratch_size;
+
 	/* platform data */
 	struct sst_pdata *pdata;
 
@@ -296,11 +301,6 @@ struct sst_module *sst_module_new(struct sst_fw *sst_fw,
 	struct sst_module_template *template, void *private);
 void sst_module_free(struct sst_module *module);
 struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id);
-
-/* allocate/free pesistent/scratch memory regions managed by drv */
-struct sst_module *sst_mem_block_alloc_scratch(struct sst_dsp *dsp);
-void sst_mem_block_free_scratch(struct sst_dsp *dsp,
-	struct sst_module *scratch);
 int sst_module_alloc_blocks(struct sst_module *module);
 int sst_module_free_blocks(struct sst_module *module);
 
@@ -308,6 +308,11 @@ int sst_module_free_blocks(struct sst_module *module);
 int sst_alloc_blocks(struct sst_dsp *dsp, struct sst_block_allocator *ba,
 	struct list_head *block_list);
 int sst_free_blocks(struct sst_dsp *dsp, struct list_head *block_list);
+
+/* scratch allocation */
+int sst_block_alloc_scratch(struct sst_dsp *dsp);
+void sst_block_free_scratch(struct sst_dsp *dsp);
+
 /* Register the DSPs memory blocks - would be nice to read from ACPI */
 struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
 	u32 size, enum sst_mem_type type, struct sst_block_ops *ops, u32 index,
diff --git a/sound/soc/intel/sst-dsp.c b/sound/soc/intel/sst-dsp.c
index cd23060..372c4b8 100644
--- a/sound/soc/intel/sst-dsp.c
+++ b/sound/soc/intel/sst-dsp.c
@@ -352,6 +352,7 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
 	INIT_LIST_HEAD(&sst->free_block_list);
 	INIT_LIST_HEAD(&sst->module_list);
 	INIT_LIST_HEAD(&sst->fw_list);
+	INIT_LIST_HEAD(&sst->scratch_block_list);
 
 	/* Initialise SST Audio DSP */
 	if (sst->ops->init) {
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index ca90278..fa91b3d 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -627,80 +627,69 @@ void sst_mem_block_unregister_all(struct sst_dsp *dsp)
 EXPORT_SYMBOL_GPL(sst_mem_block_unregister_all);
 
 /* allocate scratch buffer blocks */
-struct sst_module *sst_mem_block_alloc_scratch(struct sst_dsp *dsp)
+int sst_block_alloc_scratch(struct sst_dsp *dsp)
 {
-	struct sst_module *sst_module, *scratch;
-	struct sst_mem_block *block, *tmp;
-	u32 block_size;
-	int ret = 0;
-
-	scratch = kzalloc(sizeof(struct sst_module), GFP_KERNEL);
-	if (scratch == NULL)
-		return NULL;
+	struct sst_module *module;
+	struct sst_block_allocator ba;
+	int ret;
 
 	mutex_lock(&dsp->mutex);
 
 	/* calculate required scratch size */
-	list_for_each_entry(sst_module, &dsp->module_list, list) {
-		if (scratch->s.size < sst_module->s.size)
-			scratch->s.size = sst_module->s.size;
+	dsp->scratch_size = 0;
+	list_for_each_entry(module, &dsp->module_list, list) {
+		dev_dbg(dsp->dev, "module %d scratch req 0x%x bytes\n",
+			module->id, module->scratch_size);
+		if (dsp->scratch_size < module->scratch_size)
+			dsp->scratch_size = module->scratch_size;
 	}
 
-	dev_dbg(dsp->dev, "scratch buffer required is %d bytes\n",
-		scratch->s.size);
+	dev_dbg(dsp->dev, "scratch buffer required is 0x%x bytes\n",
+		dsp->scratch_size);
 
-	/* init scratch module */
-	scratch->dsp = dsp;
-	scratch->s.type = SST_MEM_DRAM;
-	scratch->s.data_type = SST_DATA_S;
-	INIT_LIST_HEAD(&scratch->block_list);
+	if (dsp->scratch_size == 0) {
+		dev_info(dsp->dev, "no modules need scratch buffer\n");
+		mutex_unlock(&dsp->mutex);
+		return 0;
+	}
 
-	/* check free blocks before looking at used blocks for space */
-	if (!list_empty(&dsp->free_block_list))
-		block = list_first_entry(&dsp->free_block_list,
-			struct sst_mem_block, list);
-	else
-		block = list_first_entry(&dsp->used_block_list,
-			struct sst_mem_block, list);
-	block_size = block->size;
+	ba.size = dsp->scratch_size;
+	ba.type = SST_MEM_DRAM;
+	ba.offset = 0;
+
+	dev_dbg(dsp->dev, "block request 0x%x bytes type %d\n",
+		ba.size, ba.type);
 
 	/* allocate blocks for module scratch buffers */
 	dev_dbg(dsp->dev, "allocating scratch blocks\n");
-	ret = block_alloc(scratch, &scratch->s);
+	ret = block_alloc(dsp, &ba, &dsp->scratch_block_list);
 	if (ret < 0) {
 		dev_err(dsp->dev, "error: can't alloc scratch blocks\n");
-		goto err;
+		mutex_unlock(&dsp->mutex);
+		return ret;
 	}
 
-	/* assign the same offset of scratch to each module */
-	list_for_each_entry(sst_module, &dsp->module_list, list)
-		sst_module->s.offset = scratch->s.offset;
-
-	mutex_unlock(&dsp->mutex);
-	return scratch;
+	ret = block_list_prepare(dsp, &dsp->scratch_block_list);
+	if (ret < 0) {
+		dev_err(dsp->dev, "error: scratch block prepare failed\n");
+		return ret;
+	}
 
-err:
-	list_for_each_entry_safe(block, tmp, &scratch->block_list, module_list)
-		list_del(&block->module_list);
+	/* assign the same offset of scratch to each module */
+	dsp->scratch_offset = ba.offset;
 	mutex_unlock(&dsp->mutex);
-	return NULL;
+	return dsp->scratch_size;
 }
-EXPORT_SYMBOL_GPL(sst_mem_block_alloc_scratch);
+EXPORT_SYMBOL_GPL(sst_block_alloc_scratch);
 
 /* free all scratch blocks */
-void sst_mem_block_free_scratch(struct sst_dsp *dsp,
-	struct sst_module *scratch)
+void sst_block_free_scratch(struct sst_dsp *dsp)
 {
-	struct sst_mem_block *block, *tmp;
-
 	mutex_lock(&dsp->mutex);
-
-	list_for_each_entry_safe(block, tmp, &scratch->block_list, module_list)
-		list_del(&block->module_list);
-
+	block_list_remove(dsp, &dsp->scratch_block_list);
 	mutex_unlock(&dsp->mutex);
 }
-EXPORT_SYMBOL_GPL(sst_mem_block_free_scratch);
+EXPORT_SYMBOL_GPL(sst_block_free_scratch);
 
 /* get a module from it's unique ID */
 struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id)
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 22cc697..7f239d0 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -172,10 +172,8 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 static int hsw_parse_fw_image(struct sst_fw *sst_fw)
 {
 	struct fw_header *header;
-	struct sst_module *scratch;
 	struct fw_module_header *module;
 	struct sst_dsp *dsp = sst_fw->dsp;
-	struct sst_hsw *hsw = sst_fw->private;
 	int ret, count;
 
 	/* Read the header information from the data pointer */
@@ -205,12 +203,8 @@ static int hsw_parse_fw_image(struct sst_fw *sst_fw)
 		module = (void *)module + sizeof(*module) + module->mod_size;
 	}
 
-	/* allocate persistent/scratch mem regions */
-	scratch = sst_mem_block_alloc_scratch(dsp);
-	if (scratch == NULL)
-		return -ENOMEM;
-
-	sst_hsw_set_scratch_module(hsw, scratch);
+	/* allocate scratch mem regions */
+	sst_block_alloc_scratch(dsp);
 
 	return 0;
 }
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 4799768..0b093d4 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1718,12 +1718,6 @@ static int msg_empty_list_init(struct sst_hsw *hsw)
 	return 0;
 }
 
-void sst_hsw_set_scratch_module(struct sst_hsw *hsw,
-	struct sst_module *scratch)
-{
-	hsw->scratch = scratch;
-}
-
 struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw)
 {
 	return hsw->dsp;
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 063dd6b..f20c1d9 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -486,7 +486,5 @@ int sst_hsw_dx_get_state(struct sst_hsw *hsw, u32 item,
 int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata);
 void sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata);
 struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw);
-void sst_hsw_set_scratch_module(struct sst_hsw *hsw,
-	struct sst_module *scratch);
 
 #endif
-- 
1.9.1
