From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 14/35] ASoC: Intel: Skylake: Remove
	skl_dsp_acquire_irq
Date: Thu, 22 Aug 2019 21:04:04 +0200
Message-ID: <20190822190425.23001-15-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B64AF805F9
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:03 +0200 (CEST)
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

With Skylake following the unified sst_dsp init and free flow, there is
no need for custom _acquire_irq function. Framework takes care of this
with constructor for us. Remove redundant handler.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 14 --------------
 sound/soc/intel/skylake/skl-sst-dsp.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 9d8eb1af4798..773b4b562a07 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -418,20 +418,6 @@ int skl_dsp_sleep(struct sst_dsp *ctx)
 }
 EXPORT_SYMBOL_GPL(skl_dsp_sleep);
 
-int skl_dsp_acquire_irq(struct sst_dsp *sst)
-{
-	int ret;
-
-	/* Register the ISR */
-	ret = request_threaded_irq(sst->irq, sst->ops->irq_handler,
-		sst->ops->thread_fn, IRQF_SHARED, "AudioDSP", sst);
-	if (ret)
-		dev_err(sst->dev, "unable to grab threaded IRQ %d, disabling device\n",
-			       sst->irq);
-
-	return ret;
-}
-
 void skl_dsp_free(struct sst_dsp *dsp)
 {
 	struct skl_dev *skl = dsp->thread_context;
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 1d579d59de60..45d99b6b448e 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -196,7 +196,6 @@ int skl_cldma_prepare(struct sst_dsp *ctx);
 int skl_cldma_wait_interruptible(struct sst_dsp *ctx);
 
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
-int skl_dsp_acquire_irq(struct sst_dsp *sst);
 bool is_skl_dsp_running(struct sst_dsp *ctx);
 
 unsigned int skl_dsp_get_enabled_cores(struct sst_dsp *ctx);
-- 
2.17.1
