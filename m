From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 6/7] ASoC: Intel: Add runtime module lookup
	API call
Date: Tue, 28 Oct 2014 17:37:17 +0000
Message-ID: <1414517838-16210-6-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1414517838-16210-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 88C79265D6C
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 18:38:55 +0100 (CET)
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

Add an API to allow quick lookup of runtime modules based on ID.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-firmware.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index b27d385..692a6ae 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -1158,6 +1158,26 @@ struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id)
 }
 EXPORT_SYMBOL_GPL(sst_module_get_from_id);
 
+struct sst_module_runtime *sst_module_runtime_get_from_id(
+	struct sst_module *module, u32 id)
+{
+	struct sst_module_runtime *runtime;
+	struct sst_dsp *dsp = module->dsp;
+
+	mutex_lock(&dsp->mutex);
+
+	list_for_each_entry(runtime, &module->runtime_list, list) {
+		if (runtime->id == id) {
+			mutex_unlock(&dsp->mutex);
+			return runtime;
+		}
+	}
+
+	mutex_unlock(&dsp->mutex);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(sst_module_runtime_get_from_id);
+
 /* returns block address in DSP address space */
 u32 sst_dsp_get_offset(struct sst_dsp *dsp, u32 offset,
 	enum sst_mem_type type)
-- 
1.9.1
