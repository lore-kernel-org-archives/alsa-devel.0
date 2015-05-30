From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 3/4] ASoC: Intel: check and clear runtime
	module pointer
Date: Sat, 30 May 2015 22:33:58 +0800
Message-ID: <1432996439-8052-4-git-send-email-yang.jie@intel.com>
References: <1432996439-8052-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B6382606AC
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 16:29:59 +0200 (CEST)
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

Add check runtime module pointers before freeing them, and clear
them to NULL after freed.

With this implemented, we can avoid NULL pointer dereference or
double free errors.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 23ae040..f97fa5a 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -928,10 +928,15 @@ static void hsw_pcm_free_modules(struct hsw_priv_data *pdata)
 
 	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
 		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
-		sst_hsw_runtime_module_free(pcm_data->runtime);
+		if (pcm_data->runtime){
+			sst_hsw_runtime_module_free(pcm_data->runtime);
+			pcm_data->runtime = NULL;
+		}
 	}
-	if (sst_hsw_is_module_loaded(hsw, SST_HSW_MODULE_WAVES)) {
+	if (sst_hsw_is_module_loaded(hsw, SST_HSW_MODULE_WAVES) &&
+				pdata->runtime_waves) {
 		sst_hsw_runtime_module_free(pdata->runtime_waves);
+		pdata->runtime_waves = NULL;
 	}
 }
 
-- 
1.9.1
