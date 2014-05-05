From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Add support to unload/reload
	firmware modules.
Date: Mon,  5 May 2014 17:31:37 +0100
Message-ID: <1399307497-6238-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C038D2610D4
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 18:31:45 +0200 (CEST)
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

Add some SST API calls to unload and reload firmware modules. This can be used
by PM code to restore state and also allow modular FW to unload and release
memory blocks. 

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp-priv.h |  2 ++
 sound/soc/intel/sst-firmware.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index 4012134..ffb308b 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -284,6 +284,8 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
 	const struct firmware *fw, void *private);
 void sst_fw_free(struct sst_fw *sst_fw);
 void sst_fw_free_all(struct sst_dsp *dsp);
+int sst_fw_reload(struct sst_fw *sst_fw);
+void sst_fw_unload(struct sst_fw *sst_fw);
 
 /* Create/Free firmware modules */
 struct sst_module *sst_module_new(struct sst_fw *sst_fw,
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 928f228..5693d9a 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -30,6 +30,8 @@
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
 
+static void block_module_remove(struct sst_module *module);
+
 static void sst_memcpy32(volatile void __iomem *dest, void *src, u32 bytes)
 {
 	u32 i;
@@ -91,6 +93,42 @@ parse_err:
 }
 EXPORT_SYMBOL_GPL(sst_fw_new);
 
+int sst_fw_reload(struct sst_fw *sst_fw)
+{
+	struct sst_dsp *dsp = sst_fw->dsp;
+	int ret;
+
+	dev_dbg(dsp->dev, "reloading firmware\n");
+
+	/* call core specific FW paser to load FW data into DSP */
+	ret = dsp->ops->parse_fw(sst_fw);
+	if (ret < 0)
+		dev_err(dsp->dev, "error: parse fw failed %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_fw_reload);
+
+void sst_fw_unload(struct sst_fw *sst_fw)
+{
+        struct sst_dsp *dsp = sst_fw->dsp;
+        struct sst_module *module, *tmp;
+
+        dev_dbg(dsp->dev, "unloading firmware\n");
+
+        mutex_lock(&dsp->mutex);
+        list_for_each_entry_safe(module, tmp, &dsp->module_list, list) {
+                if (module->sst_fw == sst_fw) {
+                        block_module_remove(module);
+                        list_del(&module->list);
+                        kfree(module);
+                }
+        }
+
+        mutex_unlock(&dsp->mutex);
+}
+EXPORT_SYMBOL_GPL(sst_fw_unload);
+
 /* free single firmware object */
 void sst_fw_free(struct sst_fw *sst_fw)
 {
-- 
1.9.1
