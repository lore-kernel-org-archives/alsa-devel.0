From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 1/7] ASoC: Intel: Make ADSP memory block
	allocation more generic
Date: Tue, 28 Oct 2014 17:37:12 +0000
Message-ID: <1414517838-16210-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 34DA7265D62
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 18:38:54 +0100 (CET)
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

Current block allocation is tied to block type and requestor type. Make the
allocation more generic by removing the struct module parameter and adding
a generic block allocator structure. Also pass in the list that the blocks
have to be added too in order to remove dependence on block requestor type.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-dsp.c |  24 ++-
 sound/soc/intel/sst-dsp-priv.h     |  83 +++++-----
 sound/soc/intel/sst-firmware.c     | 317 +++++++++++++++++++++++++------------
 sound/soc/intel/sst-haswell-dsp.c  |  41 ++---
 4 files changed, 288 insertions(+), 177 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-dsp.c b/sound/soc/intel/sst-baytrail-dsp.c
index fc58876..5a9e567 100644
--- a/sound/soc/intel/sst-baytrail-dsp.c
+++ b/sound/soc/intel/sst-baytrail-dsp.c
@@ -67,17 +67,12 @@ static int sst_byt_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 {
 	struct dma_block_info *block;
 	struct sst_module *mod;
-	struct sst_module_data block_data;
 	struct sst_module_template template;
 	int count;
 
 	memset(&template, 0, sizeof(template));
 	template.id = module->type;
 	template.entry = module->entry_point;
-	template.p.type = SST_MEM_DRAM;
-	template.p.data_type = SST_DATA_P;
-	template.s.type = SST_MEM_DRAM;
-	template.s.data_type = SST_DATA_S;
 
 	mod = sst_module_new(fw, &template, NULL);
 	if (mod == NULL)
@@ -94,19 +89,19 @@ static int sst_byt_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 
 		switch (block->type) {
 		case SST_BYT_IRAM:
-			block_data.offset = block->ram_offset +
+			mod->offset = block->ram_offset +
 					    dsp->addr.iram_offset;
-			block_data.type = SST_MEM_IRAM;
+			mod->type = SST_MEM_IRAM;
 			break;
 		case SST_BYT_DRAM:
-			block_data.offset = block->ram_offset +
+			mod->offset = block->ram_offset +
 					    dsp->addr.dram_offset;
-			block_data.type = SST_MEM_DRAM;
+			mod->type = SST_MEM_DRAM;
 			break;
 		case SST_BYT_CACHE:
-			block_data.offset = block->ram_offset +
+			mod->offset = block->ram_offset +
 					    (dsp->addr.fw_ext - dsp->addr.lpe);
-			block_data.type = SST_MEM_CACHE;
+			mod->type = SST_MEM_CACHE;
 			break;
 		default:
 			dev_err(dsp->dev, "wrong ram type 0x%x in block0x%x\n",
@@ -114,11 +109,10 @@ static int sst_byt_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 			return -EINVAL;
 		}
 
-		block_data.size = block->size;
-		block_data.data_type = SST_DATA_M;
-		block_data.data = (void *)block + sizeof(*block);
+		mod->size = block->size;
+		mod->data = (void *)block + sizeof(*block);
 
-		sst_module_insert_fixed_block(mod, &block_data);
+		sst_module_alloc_blocks(mod);
 
 		block = (void *)block + sizeof(*block) + block->size;
 	}
diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index ffb308b..f58a049 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -84,15 +84,6 @@ struct sst_mailbox {
 };
 
 /*
- * Audio DSP Firmware data types.
- */
-enum sst_data_type {
-	SST_DATA_M	= 0, /* module block data */
-	SST_DATA_P	= 1, /* peristant data (text, data) */
-	SST_DATA_S	= 2, /* scratch data (usually buffers) */
-};
-
-/*
  * Audio DSP memory block types.
  */
 enum sst_mem_type {
@@ -125,23 +116,6 @@ struct sst_fw {
 };
 
 /*
- * Audio DSP Generic Module data.
- *
- * This is used to dsecribe any sections of persistent (text and data) and
- * scratch (buffers) of module data in ADSP memory space.
- */
-struct sst_module_data {
-
-	enum sst_mem_type type;		/* destination memory type */
-	enum sst_data_type data_type;	/* type of module data */
-
-	u32 size;		/* size in bytes */
-	int32_t offset;		/* offset in FW file */
-	u32 data_offset;	/* offset in ADSP memory space */
-	void *data;		/* module data */
-};
-
-/*
  * Audio DSP Generic Module Template.
  *
  * Used to define and register a new FW module. This data is extracted from
@@ -150,15 +124,42 @@ struct sst_module_data {
 struct sst_module_template {
 	u32 id;
 	u32 entry;			/* entry point */
-	struct sst_module_data s;	/* scratch data */
-	struct sst_module_data p;	/* peristant data */
+	u32 scratch_size;
+	u32 persistent_size;
+};
+
+/*
+ * Block Allocator - Used to allocate blocks of DSP memory.
+ */
+struct sst_block_allocator {
+	u32 id;
+	u32 offset;
+	int size;
+	enum sst_mem_type type;
+};
+
+/*
+ * Runtime Module Instance - A module object can be instanciated multiple
+ * times within the DSP FW.
+ */
+struct sst_module_runtime {
+	struct sst_dsp *dsp;
+	int id;
+	struct sst_module *module;	/* parent module we belong too */
+
+	u32 persistent_offset;		/* private memory size */
+	void *private;
+
+	struct list_head list;
+	struct list_head block_list;	/* list of blocks used */
 };
 
 /*
  * Audio DSP Generic Module.
  *
  * Each Firmware file can consist of 1..N modules. A module can span multiple
- * ADSP memory blocks. The simplest FW will be a file with 1 module.
+ * ADSP memory blocks. The simplest FW will be a file with 1 module. A module
+ * can be instanciated multiple times in the DSP.
  */
 struct sst_module {
 	struct sst_dsp *dsp;
@@ -167,10 +168,13 @@ struct sst_module {
 	/* module configuration */
 	u32 id;
 	u32 entry;			/* module entry point */
-	u32 offset;			/* module offset in firmware file */
+	s32 offset;			/* module offset in firmware file */
 	u32 size;			/* module size */
-	struct sst_module_data s;	/* scratch data */
-	struct sst_module_data p;	/* peristant data */
+	u32 scratch_size;		/* global scratch memory required */
+	u32 persistent_size;		/* private memory required */
+	enum sst_mem_type type;		/* destination memory type */
+	u32 data_offset;		/* offset in ADSP memory space */
+	void *data;			/* module data */
 
 	/* runtime */
 	u32 usage_count;		/* can be unloaded if count == 0 */
@@ -180,6 +184,7 @@ struct sst_module {
 	struct list_head block_list;	/* Module list of blocks in use */
 	struct list_head list;		/* DSP list of modules */
 	struct list_head list_fw;	/* FW list of modules */
+	struct list_head runtime_list;	/* list of runtime module objects*/
 };
 
 /*
@@ -208,7 +213,6 @@ struct sst_mem_block {
 	struct sst_block_ops *ops;	/* block operations, if any */
 
 	/* block status */
-	enum sst_data_type data_type;	/* data type held in this block */
 	u32 bytes_used;			/* bytes in use by modules */
 	void *private;			/* generic core does not touch this */
 	int users;			/* number of modules using this block */
@@ -290,19 +294,20 @@ void sst_fw_unload(struct sst_fw *sst_fw);
 /* Create/Free firmware modules */
 struct sst_module *sst_module_new(struct sst_fw *sst_fw,
 	struct sst_module_template *template, void *private);
-void sst_module_free(struct sst_module *sst_module);
-int sst_module_insert(struct sst_module *sst_module);
-int sst_module_remove(struct sst_module *sst_module);
-int sst_module_insert_fixed_block(struct sst_module *module,
-	struct sst_module_data *data);
+void sst_module_free(struct sst_module *module);
 struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id);
 
 /* allocate/free pesistent/scratch memory regions managed by drv */
 struct sst_module *sst_mem_block_alloc_scratch(struct sst_dsp *dsp);
 void sst_mem_block_free_scratch(struct sst_dsp *dsp,
 	struct sst_module *scratch);
-int sst_block_module_remove(struct sst_module *module);
+int sst_module_alloc_blocks(struct sst_module *module);
+int sst_module_free_blocks(struct sst_module *module);
 
+/* generic block allocation */
+int sst_alloc_blocks(struct sst_dsp *dsp, struct sst_block_allocator *ba,
+	struct list_head *block_list);
+int sst_free_blocks(struct sst_dsp *dsp, struct list_head *block_list);
 /* Register the DSPs memory blocks - would be nice to read from ACPI */
 struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
 	u32 size, enum sst_mem_type type, struct sst_block_ops *ops, u32 index,
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index cf3d199..ca90278 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -30,7 +30,7 @@
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
 
-static void block_module_remove(struct sst_module *module);
+#define SST_HSW_BLOCK_ANY	0xffffffff
 
 static inline void sst_memcpy32(volatile void __iomem *dest, void *src, u32 bytes)
 {
@@ -38,6 +38,65 @@ static inline void sst_memcpy32(volatile void __iomem *dest, void *src, u32 byte
 	__iowrite32_copy((void *)dest, src, bytes/4);
 }
 
+
+/* remove module from memory - callers hold locks */
+static void block_list_remove(struct sst_dsp *dsp,
+	struct list_head *block_list)
+{
+	struct sst_mem_block *block, *tmp;
+	int err;
+
+	/* disable each block  */
+	list_for_each_entry(block, block_list, module_list) {
+
+		if (block->ops && block->ops->disable) {
+			err = block->ops->disable(block);
+			if (err < 0)
+				dev_err(dsp->dev,
+					"error: cant disable block %d:%d\n",
+					block->type, block->index);
+		}
+	}
+
+	/* mark each block as free */
+	list_for_each_entry_safe(block, tmp, block_list, module_list) {
+		list_del(&block->module_list);
+		list_move(&block->list, &dsp->free_block_list);
+		dev_dbg(dsp->dev, "block freed %d:%d at offset 0x%x\n",
+			block->type, block->index, block->offset);
+	}
+}
+
+/* prepare the memory block to receive data from host - callers hold locks */
+static int block_list_prepare(struct sst_dsp *dsp,
+	struct list_head *block_list)
+{
+	struct sst_mem_block *block;
+	int ret = 0;
+
+	/* enable each block so that's it'e ready for data */
+	list_for_each_entry(block, block_list, module_list) {
+
+		if (block->ops && block->ops->enable) {
+			ret = block->ops->enable(block);
+			if (ret < 0) {
+				dev_err(dsp->dev,
+					"error: cant disable block %d:%d\n",
+					block->type, block->index);
+				goto err;
+			}
+		}
+	}
+	return ret;
+
+err:
+	list_for_each_entry(block, block_list, module_list) {
+		if (block->ops && block->ops->disable)
+			block->ops->disable(block);
+	}
+	return ret;
+}
+
 /* create new generic firmware object */
 struct sst_fw *sst_fw_new(struct sst_dsp *dsp, 
 	const struct firmware *fw, void *private)
@@ -199,73 +258,122 @@ void sst_module_free(struct sst_module *sst_module)
 }
 EXPORT_SYMBOL_GPL(sst_module_free);
 
-static struct sst_mem_block *find_block(struct sst_dsp *dsp, int type,
-	u32 offset)
+struct sst_module_runtime *sst_module_runtime_new(struct sst_module *module,
+	int id, void *private)
+{
+	struct sst_dsp *dsp = module->dsp;
+	struct sst_module_runtime *runtime;
+
+	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
+	if (runtime == NULL)
+		return NULL;
+
+	runtime->id = id;
+	runtime->dsp = dsp;
+	runtime->module = module;
+	INIT_LIST_HEAD(&runtime->block_list);
+
+	mutex_lock(&dsp->mutex);
+	list_add(&runtime->list, &module->runtime_list);
+	mutex_unlock(&dsp->mutex);
+
+	return runtime;
+}
+EXPORT_SYMBOL_GPL(sst_module_runtime_new);
+
+void sst_module_runtime_free(struct sst_module_runtime *runtime)
+{
+	struct sst_dsp *dsp = runtime->dsp;
+
+	mutex_lock(&dsp->mutex);
+	list_del(&runtime->list);
+	mutex_unlock(&dsp->mutex);
+
+	kfree(runtime);
+}
+EXPORT_SYMBOL_GPL(sst_module_runtime_free);
+
+static struct sst_mem_block *find_block(struct sst_dsp *dsp,
+	struct sst_block_allocator *ba)
 {
 	struct sst_mem_block *block;
 
 	list_for_each_entry(block, &dsp->free_block_list, list) {
-		if (block->type == type && block->offset == offset)
+		if (block->type == ba->type && block->offset == ba->offset)
 			return block;
 	}
 
 	return NULL;
 }
 
-static int block_alloc_contiguous(struct sst_module *module,
-	struct sst_module_data *data, u32 offset, int size)
+/* Block allocator must be on block boundary */
+static int block_alloc_contiguous(struct sst_dsp *dsp,
+	struct sst_block_allocator *ba, struct list_head *block_list)
 {
 	struct list_head tmp = LIST_HEAD_INIT(tmp);
-	struct sst_dsp *dsp = module->dsp;
 	struct sst_mem_block *block;
+	u32 block_start = SST_HSW_BLOCK_ANY;
+	int size = ba->size, offset = ba->offset;
+
+	while (ba->size > 0) {
 
-	while (size > 0) {
-		block = find_block(dsp, data->type, offset);
+		block = find_block(dsp, ba);
 		if (!block) {
 			list_splice(&tmp, &dsp->free_block_list);
+
+			ba->size = size;
+			ba->offset = offset;
 			return -ENOMEM;
 		}
 
 		list_move_tail(&block->list, &tmp);
-		offset += block->size;
-		size -= block->size;
+		ba->offset += block->size;
+		ba->size -= block->size;
 	}
+	ba->size = size;
+	ba->offset = offset;
+
+	list_for_each_entry(block, &tmp, list) {
+
+		if (block->offset < block_start)
+			block_start = block->offset;
 
-	list_for_each_entry(block, &tmp, list)
-		list_add(&block->module_list, &module->block_list);
+		list_add(&block->module_list, block_list);
+
+		dev_dbg(dsp->dev, "block allocated %d:%d at offset 0x%x\n",
+			block->type, block->index, block->offset);
+	}
 
 	list_splice(&tmp, &dsp->used_block_list);
 	return 0;
 }
 
-/* allocate free DSP blocks for module data - callers hold locks */
-static int block_alloc(struct sst_module *module,
-	struct sst_module_data *data)
+/* allocate first free DSP blocks for data - callers hold locks */
+static int block_alloc(struct sst_dsp *dsp, struct sst_block_allocator *ba,
+	struct list_head *block_list)
 {
-	struct sst_dsp *dsp = module->dsp;
 	struct sst_mem_block *block, *tmp;
 	int ret = 0;
 
-	if (data->size == 0)
+	if (ba->size == 0)
 		return 0;
 
 	/* find first free whole blocks that can hold module */
 	list_for_each_entry_safe(block, tmp, &dsp->free_block_list, list) {
 
 		/* ignore blocks with wrong type */
-		if (block->type != data->type)
+		if (block->type != ba->type)
 			continue;
 
-		if (data->size > block->size)
+		if (ba->size > block->size)
 			continue;
 
-		data->offset = block->offset;
-		block->data_type = data->data_type;
-		block->bytes_used = data->size % block->size;
-		list_add(&block->module_list, &module->block_list);
+		ba->offset = block->offset;
+		block->bytes_used = ba->size % block->size;
+		list_add(&block->module_list, block_list);
 		list_move(&block->list, &dsp->used_block_list);
-		dev_dbg(dsp->dev, " *module %d added block %d:%d\n",
-			module->id, block->type, block->index);
+		dev_dbg(dsp->dev, "block allocated %d:%d at offset 0x%x\n",
+			block->type, block->index, block->offset);
 		return 0;
 	}
 
@@ -273,15 +381,19 @@ static int block_alloc(struct sst_module *module,
 	list_for_each_entry_safe(block, tmp, &dsp->free_block_list, list) {
 
 		/* ignore blocks with wrong type */
-		if (block->type != data->type)
+		if (block->type != ba->type)
 			continue;
 
 		/* do we span > 1 blocks */
-		if (data->size > block->size) {
-			ret = block_alloc_contiguous(module, data,
-				block->offset, data->size);
+		if (ba->size > block->size) {
+
+			/* align ba to block boundary */
+			ba->offset = block->offset;
+
+			ret = block_alloc_contiguous(dsp, ba, block_list);
 			if (ret == 0)
 				return ret;
+
 		}
 	}
 
@@ -289,93 +401,74 @@ static int block_alloc(struct sst_module *module,
 	return -ENOMEM;
 }
 
-/* remove module from memory - callers hold locks */
-static void block_module_remove(struct sst_module *module)
+int sst_alloc_blocks(struct sst_dsp *dsp, struct sst_block_allocator *ba,
+	struct list_head *block_list)
 {
-	struct sst_mem_block *block, *tmp;
-	struct sst_dsp *dsp = module->dsp;
-	int err;
+	int ret;
 
-	/* disable each block  */
-	list_for_each_entry(block, &module->block_list, module_list) {
+	dev_dbg(dsp->dev, "block request 0x%x bytes at offset 0x%x type %d\n",
+		ba->size, ba->offset, ba->type);
 
-		if (block->ops && block->ops->disable) {
-			err = block->ops->disable(block);
-			if (err < 0)
-				dev_err(dsp->dev,
-					"error: cant disable block %d:%d\n",
-					block->type, block->index);
-		}
-	}
+	mutex_lock(&dsp->mutex);
 
-	/* mark each block as free */
-	list_for_each_entry_safe(block, tmp, &module->block_list, module_list) {
-		list_del(&block->module_list);
-		list_move(&block->list, &dsp->free_block_list);
+	ret = block_alloc(dsp, ba, block_list);
+	if (ret < 0) {
+		dev_err(dsp->dev, "error: can't alloc blocks %d\n", ret);
+		goto out;
 	}
-}
-
-/* prepare the memory block to receive data from host - callers hold locks */
-static int block_module_prepare(struct sst_module *module)
-{
-	struct sst_mem_block *block;
-	int ret = 0;
 
-	/* enable each block so that's it'e ready for module P/S data */
-	list_for_each_entry(block, &module->block_list, module_list) {
+	/* prepare DSP blocks for module usage */
+	ret = block_list_prepare(dsp, block_list);
+	if (ret < 0)
+		dev_err(dsp->dev, "error: prepare failed\n");
 
-		if (block->ops && block->ops->enable) {
-			ret = block->ops->enable(block);
-			if (ret < 0) {
-				dev_err(module->dsp->dev,
-					"error: cant disable block %d:%d\n",
-					block->type, block->index);
-				goto err;
-			}
-		}
-	}
+out:
+	mutex_unlock(&dsp->mutex);
 	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_alloc_blocks);
 
-err:
-	list_for_each_entry(block, &module->block_list, module_list) {
-		if (block->ops && block->ops->disable)
-			block->ops->disable(block);
-	}
-	return ret;
+int sst_free_blocks(struct sst_dsp *dsp, struct list_head *block_list)
+{
+	mutex_lock(&dsp->mutex);
+	block_list_remove(dsp, block_list);
+	mutex_unlock(&dsp->mutex);
+	return 0;
 }
+EXPORT_SYMBOL_GPL(sst_free_blocks);
 
 /* allocate memory blocks for static module addresses - callers hold locks */
-static int block_alloc_fixed(struct sst_module *module,
-	struct sst_module_data *data)
+static int block_alloc_fixed(struct sst_dsp *dsp, struct sst_block_allocator *ba,
+	struct list_head *block_list)
 {
-	struct sst_dsp *dsp = module->dsp;
 	struct sst_mem_block *block, *tmp;
-	u32 end = data->offset + data->size, block_end;
+	u32 end = ba->offset + ba->size, block_end;
 	int err;
 
 	/* only IRAM/DRAM blocks are managed */
-	if (data->type != SST_MEM_IRAM && data->type != SST_MEM_DRAM)
+	if (ba->type != SST_MEM_IRAM && ba->type != SST_MEM_DRAM)
 		return 0;
 
 	/* are blocks already attached to this module */
-	list_for_each_entry_safe(block, tmp, &module->block_list, module_list) {
+	list_for_each_entry_safe(block, tmp, block_list, module_list) {
 
-		/* force compacting mem blocks of the same data_type */
-		if (block->data_type != data->data_type)
+		/* ignore blocks with wrong type */
+		if (block->type != ba->type)
 			continue;
 
 		block_end = block->offset + block->size;
 
 		/* find block that holds section */
-		if (data->offset >= block->offset && end < block_end)
+		if (ba->offset >= block->offset && end <= block_end)
 			return 0;
 
 		/* does block span more than 1 section */
-		if (data->offset >= block->offset && data->offset < block_end) {
+		if (ba->offset >= block->offset && ba->offset < block_end) {
 
-			err = block_alloc_contiguous(module, data,
-				block->offset + block->size,
-				data->size - block->size);
+			/* align ba to block boundary */
+			ba->size -= block_end - ba->offset;
+			ba->offset = block_end;
+			err = block_alloc_contiguous(dsp, ba, block_list);
 			if (err < 0)
 				return -ENOMEM;
 
@@ -388,53 +481,67 @@ static int block_alloc_fixed(struct sst_module *module,
 	list_for_each_entry_safe(block, tmp, &dsp->free_block_list, list) {
 		block_end = block->offset + block->size;
 
+		/* ignore blocks with wrong type */
+		if (block->type != ba->type)
+			continue;
+
 		/* find block that holds section */
-		if (data->offset >= block->offset && end < block_end) {
+		if (ba->offset >= block->offset && end <= block_end) {
 
 			/* add block */
-			block->data_type = data->data_type;
 			list_move(&block->list, &dsp->used_block_list);
-			list_add(&block->module_list, &module->block_list);
+			list_add(&block->module_list, block_list);
+			dev_dbg(dsp->dev, "block allocated %d:%d at offset 0x%x\n",
+				block->type, block->index, block->offset);
 			return 0;
 		}
 
 		/* does block span more than 1 section */
-		if (data->offset >= block->offset && data->offset < block_end) {
+		if (ba->offset >= block->offset && ba->offset < block_end) {
+
+			/* align ba to block boundary */
+			ba->offset = block->offset;
 
-			err = block_alloc_contiguous(module, data,
-				block->offset, data->size);
+			err = block_alloc_contiguous(dsp, ba, block_list);
 			if (err < 0)
 				return -ENOMEM;
 
 			return 0;
 		}
-
 	}
 
 	return -ENOMEM;
 }
 
 /* Load fixed module data into DSP memory blocks */
-int sst_module_insert_fixed_block(struct sst_module *module,
-	struct sst_module_data *data)
+int sst_module_alloc_blocks(struct sst_module *module)
 {
 	struct sst_dsp *dsp = module->dsp;
+	struct sst_fw *sst_fw = module->sst_fw;
+	struct sst_block_allocator ba;
 	int ret;
 
+	ba.size = module->size;
+	ba.type = module->type;
+	ba.offset = module->offset;
+
+	dev_dbg(dsp->dev, "block request 0x%x bytes at offset 0x%x type %d\n",
+		ba.size, ba.offset, ba.type);
+
 	mutex_lock(&dsp->mutex);
 
 	/* alloc blocks that includes this section */
-	ret = block_alloc_fixed(module, data);
+	ret = block_alloc_fixed(dsp, &ba, &module->block_list);
 	if (ret < 0) {
 		dev_err(dsp->dev,
 			"error: no free blocks for section at offset 0x%x size 0x%x\n",
-			data->offset, data->size);
+			module->offset, module->size);
 		mutex_unlock(&dsp->mutex);
 		return -ENOMEM;
 	}
 
 	/* prepare DSP blocks for module copy */
-	ret = block_module_prepare(module);
+	ret = block_list_prepare(dsp, &module->block_list);
 	if (ret < 0) {
 		dev_err(dsp->dev, "error: fw module prepare failed\n");
 		goto err;
@@ -447,19 +554,23 @@ int sst_module_insert_fixed_block(struct sst_module *module,
 	return ret;
 
 err:
-	block_module_remove(module);
+	block_list_remove(dsp, &module->block_list);
 	mutex_unlock(&dsp->mutex);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(sst_module_insert_fixed_block);
+EXPORT_SYMBOL_GPL(sst_module_alloc_blocks);
 
 /* Unload entire module from DSP memory */
-int sst_block_module_remove(struct sst_module *module)
+int sst_module_free_blocks(struct sst_module *module)
 {
 	struct sst_dsp *dsp = module->dsp;
 
 	mutex_lock(&dsp->mutex);
-	block_module_remove(module);
+	block_list_remove(dsp, &module->block_list);
+	mutex_unlock(&dsp->mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_module_free_blocks);
 	mutex_unlock(&dsp->mutex);
 	return 0;
 }
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 4b6c163..22cc697 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -86,9 +86,8 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 {
 	struct dma_block_info *block;
 	struct sst_module *mod;
-	struct sst_module_data block_data;
 	struct sst_module_template template;
-	int count;
+	int count, ret;
 	void __iomem *ram;
 
 	/* TODO: allowed module types need to be configurable */
@@ -109,13 +108,9 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 
 	memset(&template, 0, sizeof(template));
 	template.id = module->type;
-	template.entry = module->entry_point;
-	template.p.size = module->info.persistent_size;
-	template.p.type = SST_MEM_DRAM;
-	template.p.data_type = SST_DATA_P;
-	template.s.size = module->info.scratch_size;
-	template.s.type = SST_MEM_DRAM;
-	template.s.data_type = SST_DATA_S;
+	template.entry = module->entry_point - 4;
+	template.persistent_size = module->info.persistent_size;
+	template.scratch_size = module->info.scratch_size;
 
 	mod = sst_module_new(fw, &template, NULL);
 	if (mod == NULL)
@@ -135,14 +130,14 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 		switch (block->type) {
 		case SST_HSW_IRAM:
 			ram = dsp->addr.lpe;
-			block_data.offset =
+			mod->offset =
 				block->ram_offset + dsp->addr.iram_offset;
-			block_data.type = SST_MEM_IRAM;
+			mod->type = SST_MEM_IRAM;
 			break;
 		case SST_HSW_DRAM:
 			ram = dsp->addr.lpe;
-			block_data.offset = block->ram_offset;
-			block_data.type = SST_MEM_DRAM;
+			mod->offset = block->ram_offset;
+			mod->type = SST_MEM_DRAM;
 			break;
 		default:
 			dev_err(dsp->dev, "error: bad type 0x%x for block 0x%x\n",
@@ -151,20 +146,26 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 			return -EINVAL;
 		}
 
-		block_data.size = block->size;
-		block_data.data_type = SST_DATA_M;
-		block_data.data = (void *)block + sizeof(*block);
-		block_data.data_offset = block_data.data - fw->dma_buf;
+		mod->size = block->size;
+		mod->data = (void *)block + sizeof(*block);
+		mod->data_offset = mod->data - fw->dma_buf;
 
-		dev_dbg(dsp->dev, "copy firmware block %d type 0x%x "
+		dev_dbg(dsp->dev, "module block %d type 0x%x "
 			"size 0x%x ==> ram %p offset 0x%x\n",
-			count, block->type, block->size, ram,
+			count, mod->type, block->size, ram,
 			block->ram_offset);
 
-		sst_module_insert_fixed_block(mod, &block_data);
+		ret = sst_module_alloc_blocks(mod);
+		if (ret < 0) {
+			dev_err(dsp->dev, "error: could not allocate blocks for module %d\n",
+				count);
+			sst_module_free(mod);
+			return ret;
+		}
 
 		block = (void *)block + sizeof(*block) + block->size;
 	}
+
 	return 0;
 }
 
-- 
1.9.1
