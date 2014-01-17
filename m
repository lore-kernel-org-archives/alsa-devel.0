From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 1/2] ASoC: DPCM: make some DPCM API calls
	non static for compressed usage
Date: Fri, 17 Jan 2014 17:03:55 +0000
Message-ID: <1389978236-7589-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D948D2610D4
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 18:04:05 +0100 (CET)
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

The ASoC compressed code needs to call the internal DPCM APIs in order to
dynamically route compressed data to different DAIs.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-dpcm.h | 22 ++++++++++++++++++++++
 sound/soc/soc-pcm.c      | 29 ++++++++++++-----------------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 047d657..2883a7a 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -11,6 +11,7 @@
 #ifndef __LINUX_SND_SOC_DPCM_H
 #define __LINUX_SND_SOC_DPCM_H
 
+#include <linux/slab.h>
 #include <linux/list.h>
 #include <sound/pcm.h>
 
@@ -135,4 +136,25 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute);
 int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd);
 int soc_dpcm_runtime_update(struct snd_soc_card *);
 
+int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
+	int stream, struct snd_soc_dapm_widget_list **list_);
+int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
+	int stream, struct snd_soc_dapm_widget_list **list, int new);
+int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream);
+int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream);
+void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream);
+void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream);
+int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream);
+int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int tream);
+int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream, int cmd);
+int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream);
+int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
+	int event);
+
+static inline void dpcm_path_put(struct snd_soc_dapm_widget_list **list)
+{
+	kfree(*list);
+}
+
+
 #endif
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1534115..7023f7e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -58,7 +58,7 @@ int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 EXPORT_SYMBOL_GPL(snd_soc_set_runtime_hwparams);
 
 /* DPCM stream event, send event to FE and all active BEs. */
-static int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
+int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 	int event)
 {
 	struct snd_soc_dpcm *dpcm;
@@ -877,7 +877,7 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 }
 
 /* disconnect a BE and FE */
-static void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
+void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm, *d;
 
@@ -973,7 +973,7 @@ static int widget_in_list(struct snd_soc_dapm_widget_list *list,
 	return 0;
 }
 
-static int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
+int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 	int stream, struct snd_soc_dapm_widget_list **list_)
 {
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
@@ -995,11 +995,6 @@ static int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 	return paths;
 }
 
-static inline void dpcm_path_put(struct snd_soc_dapm_widget_list **list)
-{
-	kfree(*list);
-}
-
 static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dapm_widget_list **list_)
 {
@@ -1069,7 +1064,7 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 			continue;
 
 		/* don't connect if FE is not running */
-		if (!fe->dpcm[stream].runtime)
+		if (!fe->dpcm[stream].runtime && !fe->fe_compr)
 			continue;
 
 		/* newly connected FE and BE */
@@ -1094,7 +1089,7 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
  * Find the corresponding BE DAIs that source or sink audio to this
  * FE substream.
  */
-static int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
+int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
 	int stream, struct snd_soc_dapm_widget_list **list, int new)
 {
 	if (new)
@@ -1103,7 +1098,7 @@ static int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
 		return dpcm_prune_paths(fe, stream, list);
 }
 
-static void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
+void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
 
@@ -1141,7 +1136,7 @@ static void dpcm_be_dai_startup_unwind(struct snd_soc_pcm_runtime *fe,
 	}
 }
 
-static int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
+int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
 	int err, count = 0;
@@ -1293,7 +1288,7 @@ be_err:
 	return ret;
 }
 
-static int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
+int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
 
@@ -1354,7 +1349,7 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
+int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
 
@@ -1419,7 +1414,7 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
+int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
 	int ret;
@@ -1549,7 +1544,7 @@ static int dpcm_do_trigger(struct snd_soc_dpcm *dpcm,
 	return ret;
 }
 
-static int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
+int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			       int cmd)
 {
 	struct snd_soc_dpcm *dpcm;
@@ -1717,7 +1712,7 @@ out:
 	return ret;
 }
 
-static int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
+int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
 	int ret = 0;
-- 
1.8.3.2
