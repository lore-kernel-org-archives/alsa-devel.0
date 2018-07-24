From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/6] ASoC: Intel: Haswell: fix endianness
	handling
Date: Tue, 24 Jul 2018 16:12:44 -0500
Message-ID: <20180724211248.29427-3-pierre-louis.bossart@linux.intel.com>
References: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DB94B267711
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 23:12:59 +0200 (CEST)
In-Reply-To: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Make all Sparse warnings go away by using le16/32_to_cpu.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/haswell/sst-haswell-dsp.c | 53 +++++++++++++++++--------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-dsp.c b/sound/soc/intel/haswell/sst-haswell-dsp.c
index b2bec36d074c..a28220e67cdf 100644
--- a/sound/soc/intel/haswell/sst-haswell-dsp.c
+++ b/sound/soc/intel/haswell/sst-haswell-dsp.c
@@ -93,29 +93,31 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 	struct sst_module_template template;
 	int count, ret;
 	void __iomem *ram;
+	int type = le16_to_cpu(module->type);
+	int entry_point = le32_to_cpu(module->entry_point);
 
 	/* TODO: allowed module types need to be configurable */
-	if (module->type != SST_HSW_MODULE_BASE_FW
-		&& module->type != SST_HSW_MODULE_PCM_SYSTEM
-		&& module->type != SST_HSW_MODULE_PCM
-		&& module->type != SST_HSW_MODULE_PCM_REFERENCE
-		&& module->type != SST_HSW_MODULE_PCM_CAPTURE
-		&& module->type != SST_HSW_MODULE_WAVES
-		&& module->type != SST_HSW_MODULE_LPAL)
+	if (type != SST_HSW_MODULE_BASE_FW &&
+	    type != SST_HSW_MODULE_PCM_SYSTEM &&
+	    type != SST_HSW_MODULE_PCM &&
+	    type != SST_HSW_MODULE_PCM_REFERENCE &&
+	    type != SST_HSW_MODULE_PCM_CAPTURE &&
+	    type != SST_HSW_MODULE_WAVES &&
+	    type != SST_HSW_MODULE_LPAL)
 		return 0;
 
 	dev_dbg(dsp->dev, "new module sign 0x%s size 0x%x blocks 0x%x type 0x%x\n",
 		module->signature, module->mod_size,
-		module->blocks, module->type);
-	dev_dbg(dsp->dev, " entrypoint 0x%x\n", module->entry_point);
+		module->blocks, type);
+	dev_dbg(dsp->dev, " entrypoint 0x%x\n", entry_point);
 	dev_dbg(dsp->dev, " persistent 0x%x scratch 0x%x\n",
 		module->info.persistent_size, module->info.scratch_size);
 
 	memset(&template, 0, sizeof(template));
-	template.id = module->type;
-	template.entry = module->entry_point - 4;
-	template.persistent_size = module->info.persistent_size;
-	template.scratch_size = module->info.scratch_size;
+	template.id = type;
+	template.entry = entry_point - 4;
+	template.persistent_size = le32_to_cpu(module->info.persistent_size);
+	template.scratch_size = le32_to_cpu(module->info.scratch_size);
 
 	mod = sst_module_new(fw, &template, NULL);
 	if (mod == NULL)
@@ -123,26 +125,26 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 
 	block = (void *)module + sizeof(*module);
 
-	for (count = 0; count < module->blocks; count++) {
+	for (count = 0; count < le32_to_cpu(module->blocks); count++) {
 
-		if (block->size <= 0) {
+		if (le32_to_cpu(block->size) <= 0) {
 			dev_err(dsp->dev,
 				"error: block %d size invalid\n", count);
 			sst_module_free(mod);
 			return -EINVAL;
 		}
 
-		switch (block->type) {
+		switch (le32_to_cpu(block->type)) {
 		case SST_HSW_IRAM:
 			ram = dsp->addr.lpe;
-			mod->offset =
-				block->ram_offset + dsp->addr.iram_offset;
+			mod->offset = le32_to_cpu(block->ram_offset) +
+				dsp->addr.iram_offset;
 			mod->type = SST_MEM_IRAM;
 			break;
 		case SST_HSW_DRAM:
 		case SST_HSW_REGS:
 			ram = dsp->addr.lpe;
-			mod->offset = block->ram_offset;
+			mod->offset = le32_to_cpu(block->ram_offset);
 			mod->type = SST_MEM_DRAM;
 			break;
 		default:
@@ -152,7 +154,7 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 			return -EINVAL;
 		}
 
-		mod->size = block->size;
+		mod->size = le32_to_cpu(block->size);
 		mod->data = (void *)block + sizeof(*block);
 		mod->data_offset = mod->data - fw->dma_buf;
 
@@ -169,7 +171,8 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 			return ret;
 		}
 
-		block = (void *)block + sizeof(*block) + block->size;
+		block = (void *)block + sizeof(*block) +
+			le32_to_cpu(block->size);
 	}
 	mod->state = SST_MODULE_STATE_LOADED;
 
@@ -188,7 +191,8 @@ static int hsw_parse_fw_image(struct sst_fw *sst_fw)
 
 	/* verify FW */
 	if ((strncmp(header->signature, SST_HSW_FW_SIGN, 4) != 0) ||
-		(sst_fw->size != header->file_size + sizeof(*header))) {
+	    (sst_fw->size !=
+	     le32_to_cpu(header->file_size) + sizeof(*header))) {
 		dev_err(dsp->dev, "error: invalid fw sign/filesize mismatch\n");
 		return -EINVAL;
 	}
@@ -199,7 +203,7 @@ static int hsw_parse_fw_image(struct sst_fw *sst_fw)
 
 	/* parse each module */
 	module = (void *)sst_fw->dma_buf + sizeof(*header);
-	for (count = 0; count < header->modules; count++) {
+	for (count = 0; count < le32_to_cpu(header->modules); count++) {
 
 		/* module */
 		ret = hsw_parse_module(dsp, sst_fw, module);
@@ -207,7 +211,8 @@ static int hsw_parse_fw_image(struct sst_fw *sst_fw)
 			dev_err(dsp->dev, "error: invalid module %d\n", count);
 			return ret;
 		}
-		module = (void *)module + sizeof(*module) + module->mod_size;
+		module = (void *)module + sizeof(*module) +
+			le32_to_cpu(module->mod_size);
 	}
 
 	return 0;
-- 
2.14.1
