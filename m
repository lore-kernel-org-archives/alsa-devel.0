From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 1/5] ASoC: Intel: Add persistent area alloc
Date: Mon, 14 Jul 2014 16:37:51 +0800
Message-ID: <1405327075-27831-2-git-send-email-yang.jie@intel.com>
References: <1405327075-27831-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A43326157F
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 10:38:36 +0200 (CEST)
In-Reply-To: <1405327075-27831-1-git-send-email-yang.jie@intel.com>
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Allocate persistent SRAM blocks for each firmware module.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-dsp-priv.h    |  2 ++
 sound/soc/intel/sst-firmware.c    | 52 +++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst-haswell-dsp.c |  7 +++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index 3c0cbba..f96c1c5 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -301,6 +301,8 @@ struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id);
 struct sst_module *sst_mem_block_alloc_scratch(struct sst_dsp *dsp);
 void sst_mem_block_free_scratch(struct sst_dsp *dsp,
 	struct sst_module *scratch);
+int sst_module_alloc_persistent(struct sst_dsp *dsp, struct sst_module *module);
+void sst_module_free_persistent(struct sst_dsp *dsp, struct sst_module *module);
 int sst_block_module_remove(struct sst_module *module);
 
 /* Register the DSPs memory blocks - would be nice to read from ACPI */
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 8349df5..8ab5ce8 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -845,6 +845,58 @@ void sst_mem_block_free_scratch(struct sst_dsp *dsp,
 }
 EXPORT_SYMBOL_GPL(sst_mem_block_free_scratch);
 
+/* allocate persistent buffer blocks for given module
+ creates new sst_module to represent persistent memory alocation of requestor.
+*/
+int sst_module_alloc_persistent(struct sst_dsp *dsp, struct sst_module *module)
+{
+	int ret = 0;
+	struct sst_module_data *persistent = &module->p;
+
+	mutex_lock(&dsp->mutex);
+
+	dev_dbg(dsp->dev, "persistent buffer required for mod id %d is %d bytes\n",
+		module->id, persistent->size);
+
+	ret = block_alloc(module, persistent);
+
+	if (ret < 0) {
+		dev_err(dsp->dev, "error: can't alloc persistent blocks for mod id %d\n",
+			module->id);
+		goto out;
+	}
+	dev_dbg(dsp->dev, "module %d persistent area allocated %dB at 0x%x\n",
+		module->id, persistent->size, persistent->offset);
+
+	/* prepare DSP blocks for persistent module usage */
+	ret = block_module_prepare(module);
+	if (ret < 0) {
+		dev_err(dsp->dev, "error: persistent module prepare failed\n");
+		goto out;
+	}
+
+out:
+	mutex_unlock(&dsp->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_module_alloc_persistent);
+
+void sst_module_free_persistent(struct sst_dsp *dsp, struct sst_module *persistent)
+{
+	struct sst_mem_block *block, *tmp;
+
+	dev_dbg(dsp->dev, "module %d persistent released", persistent->id);
+
+	mutex_lock(&dsp->mutex);
+
+	list_for_each_entry_safe(block, tmp, &persistent->block_list, module_list)
+		list_del(&block->module_list);
+
+	mutex_unlock(&dsp->mutex);
+
+}
+EXPORT_SYMBOL_GPL(sst_module_free_persistent);
+
 /* get a module from it's unique ID */
 struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id)
 {
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 535f517..48ddff3 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -168,6 +168,11 @@ static int hsw_parse_module(struct sst_dsp *dsp, struct sst_fw *fw,
 
 		block = (void *)block + sizeof(*block) + block->size;
 	}
+
+	/*allocate persistent memory if needed*/
+	if (mod->p.size > 0)
+		return sst_module_alloc_persistent(dsp, mod);
+
 	return 0;
 }
 
@@ -207,7 +212,7 @@ static int hsw_parse_fw_image(struct sst_fw *sst_fw)
 		module = (void *)module + sizeof(*module) + module->mod_size;
 	}
 
-	/* allocate persistent/scratch mem regions */
+	/* allocate scratch mem regions */
 	scratch = sst_mem_block_alloc_scratch(dsp);
 	if (scratch == NULL)
 		return -ENOMEM;
-- 
1.8.3.2
