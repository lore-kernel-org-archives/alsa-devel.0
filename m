From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 12/35] ASoC: Intel: Skylake: Reuse sst_dsp_free
Date: Thu, 22 Aug 2019 21:04:02 +0200
Message-ID: <20190822190425.23001-13-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DB69F803F3
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:00 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Skylake is sst_dsp descendant. Rather than bypassing framework's flow,
embrace it. sst_dsp_free invokes sst specific handler internally so
nothing is missed.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/cnl-sst-dsp.c | 1 -
 sound/soc/intel/skylake/skl-sst-dsp.c | 1 -
 sound/soc/intel/skylake/skl-sst.c     | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.c b/sound/soc/intel/skylake/cnl-sst-dsp.c
index 189c1c7086e3..48b465939ef8 100644
--- a/sound/soc/intel/skylake/cnl-sst-dsp.c
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.c
@@ -215,7 +215,6 @@ void cnl_dsp_free(struct sst_dsp *dsp)
 	sst_ipc_fini(&skl->ipc);
 	cnl_ipc_int_disable(dsp);
 
-	free_irq(dsp->irq, dsp);
 	cnl_dsp_disable_core(dsp, SKL_DSP_CORE0_MASK);
 }
 EXPORT_SYMBOL_GPL(cnl_dsp_free);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 348e69226e46..1c4ecbcd7db7 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -468,7 +468,6 @@ void skl_dsp_free(struct sst_dsp *dsp)
 	sst_ipc_fini(&skl->ipc);
 	skl_ipc_int_disable(dsp);
 
-	free_irq(dsp->irq, dsp);
 	skl_dsp_disable_core(dsp, SKL_DSP_CORE0_MASK);
 }
 EXPORT_SYMBOL_GPL(skl_dsp_free);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 72ee3d8a1d7d..e55523826346 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -622,7 +622,7 @@ void skl_sst_dsp_cleanup(struct skl_dev *skl)
 	skl_clear_module_table(dsp);
 
 	skl_freeup_uuid_list(skl);
-	dsp->ops->free(dsp);
+	sst_dsp_free(dsp);
 
 	if (skl->boot_complete && dsp->cl_dev.bufsize) {
 		dsp->cl_dev.ops.cl_cleanup_controller(dsp);
-- 
2.17.1
