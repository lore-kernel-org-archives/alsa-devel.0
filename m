From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 1/4] Revert "ASoC: Intel: remove unused
	function hsw_pcm_free_modules()"
Date: Sat, 30 May 2015 22:33:56 +0800
Message-ID: <1432996439-8052-2-git-send-email-yang.jie@intel.com>
References: <1432996439-8052-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 99EBE26063F
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 16:29:57 +0200 (CEST)
In-Reply-To: <1432996439-8052-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This reverts commit 506c148ee5e1bfb836116353305927ca4c21a23e.

We still need this hsw_pcm_free_modules(), we plan to remove the
runtime modules at both fw_unload(D0->D3) and snd_soc_sst_haswell_pcm
module removing.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 1557e37..bd96629 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -920,6 +920,21 @@ err:
 	return -ENODEV;
 }
 
+static void hsw_pcm_free_modules(struct hsw_priv_data *pdata)
+{
+	struct sst_hsw *hsw = pdata->hsw;
+	struct hsw_pcm_data *pcm_data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
+		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
+		sst_hsw_runtime_module_free(pcm_data->runtime);
+	}
+	if (sst_hsw_is_module_loaded(hsw, SST_HSW_MODULE_WAVES)) {
+		sst_hsw_runtime_module_free(pdata->runtime_waves);
+	}
+}
+
 static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
-- 
1.9.1
