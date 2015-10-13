From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 2/2] ASoC: soc-compress: split soc-compress
	to a module
Date: Tue, 13 Oct 2015 17:11:04 +0800
Message-ID: <1444727464-10385-3-git-send-email-yang.jie@intel.com>
References: <1444727464-10385-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D528261AD0
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 11:05:24 +0200 (CEST)
In-Reply-To: <1444727464-10385-1-git-send-email-yang.jie@intel.com>
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

Split soc-compress into a separate module so we only compile/load
it when it's needed.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/Makefile       |  5 ++---
 sound/soc/soc-compress.c |  9 +++++++++
 sound/soc/soc-dapm.c     |  1 +
 sound/soc/soc-pcm.c      | 13 +++++++++++++
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index a3a1505..dacddf4 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,9 +1,8 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
 snd-soc-core-objs += soc-pcm.o soc-io.o soc-devres.o soc-ops.o
 
-ifneq ($(CONFIG_SND_SOC_COMPRESS),)
-snd-soc-core-objs += soc-compress.o
-endif
+snd-soc-compress-objs := soc-compress.o
+obj-$(CONFIG_SND_SOC_COMPRESS) += snd-soc-compress.o
 
 ifneq ($(CONFIG_SND_SOC_TOPOLOGY),)
 snd-soc-core-objs += soc-topology.o
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index a672d9c..28bb1b2 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/module.h>
 #include <sound/core.h>
 #include <sound/compress_params.h>
 #include <sound/compress_driver.h>
@@ -704,3 +705,11 @@ compr_err:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(soc_new_compress);
+
+/* Module information */
+MODULE_AUTHOR("Namarta Kohli <namartax.kohli@intel.com>");
+MODULE_AUTHOR("Ramesh Babu K V <ramesh.babu@linux.intel.com>");
+MODULE_AUTHOR("Vinod Koul <vinod.koul@linux.intel.com>");
+MODULE_DESCRIPTION("ALSA SoC Compress");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:soc-compress");
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ff8bda4..9e32151 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3896,6 +3896,7 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	soc_dapm_stream_event(rtd, stream, event);
 	mutex_unlock(&card->dapm_mutex);
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);
 
 /**
  * snd_soc_dapm_enable_pin_unlocked - enable pin.
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3173958..517a9d4 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -86,6 +86,7 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 		rtd->codec_dais[i]->component->active++;
 	}
 }
+EXPORT_SYMBOL_GPL(snd_soc_runtime_activate);
 
 /**
  * snd_soc_runtime_deactivate() - Decrement active count for PCM runtime components
@@ -121,6 +122,7 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
 		rtd->codec_dais[i]->active--;
 	}
 }
+EXPORT_SYMBOL_GPL(snd_soc_runtime_deactivate);
 
 /**
  * snd_soc_runtime_ignore_pmdown_time() - Check whether to ignore the power down delay
@@ -144,6 +146,7 @@ bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
 
 	return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
 }
+EXPORT_SYMBOL_GPL(snd_soc_runtime_ignore_pmdown_time);
 
 /**
  * snd_soc_set_runtime_hwparams - set the runtime hardware parameters
@@ -188,6 +191,7 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dpcm_dapm_stream_event);
 
 static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
 					struct snd_soc_dai *soc_dai)
@@ -1209,6 +1213,7 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 		kfree(dpcm);
 	}
 }
+EXPORT_SYMBOL_GPL(dpcm_be_disconnect);
 
 /* get BE for DAI widget and stream */
 static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
@@ -1293,6 +1298,7 @@ int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 
 	return paths;
 }
+EXPORT_SYMBOL_GPL(dpcm_path_get);
 
 static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dapm_widget_list **list_)
@@ -1405,6 +1411,7 @@ int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
 	else
 		return dpcm_prune_paths(fe, stream, list);
 }
+EXPORT_SYMBOL_GPL(dpcm_process_paths);
 
 void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 {
@@ -1414,6 +1421,7 @@ void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 		dpcm->be->dpcm[stream].runtime_update =
 						SND_SOC_DPCM_UPDATE_NO;
 }
+EXPORT_SYMBOL_GPL(dpcm_clear_pending_state);
 
 static void dpcm_be_dai_startup_unwind(struct snd_soc_pcm_runtime *fe,
 	int stream)
@@ -1530,6 +1538,7 @@ unwind:
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(dpcm_be_dai_startup);
 
 static void dpcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 				 struct snd_soc_pcm_stream *stream,
@@ -1693,6 +1702,7 @@ int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dpcm_be_dai_shutdown);
 
 static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 {
@@ -1758,6 +1768,7 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dpcm_be_dai_hw_free);
 
 static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 {
@@ -1865,6 +1876,7 @@ unwind:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dpcm_be_dai_hw_params);
 
 static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
@@ -2134,6 +2146,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dpcm_be_dai_prepare);
 
 static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 {
-- 
1.9.1
