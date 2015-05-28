From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: remove unused function
	hsw_pcm_free_modules()
Date: Thu, 28 May 2015 22:51:54 +0800
Message-ID: <1432824714-26686-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A7712604EB
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 16:47:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Remove the unused function hsw_pcm_free_modules() to fix the
compling warning:

sound/soc/intel/haswell/sst-haswell-pcm.c:923:13:
 warning: 'sw_pcm_free_modules' defined but not used
 [-Wunused-function]
 static void hsw_pcm_free_modules(struct hsw_priv_data *pdata)

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index bd96629..1557e37 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -920,21 +920,6 @@ err:
 	return -ENODEV;
 }
 
-static void hsw_pcm_free_modules(struct hsw_priv_data *pdata)
-{
-	struct sst_hsw *hsw = pdata->hsw;
-	struct hsw_pcm_data *pcm_data;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
-		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
-		sst_hsw_runtime_module_free(pcm_data->runtime);
-	}
-	if (sst_hsw_is_module_loaded(hsw, SST_HSW_MODULE_WAVES)) {
-		sst_hsw_runtime_module_free(pdata->runtime_waves);
-	}
-}
-
 static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
-- 
1.9.1
