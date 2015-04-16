From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [RFC 3/4] ASoC: topology: Add topology support to ASoC
 core and DAPM.
Date: Thu, 16 Apr 2015 21:48:41 +0100
Message-ID: <1429217321.7100.21.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A1A22652CF
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 22:48:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, "Koul,
 Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Add dynamic object support to ASoC kcontrols, widgets, components and
cards. Remove all dynamic objects on sound card removal and DAPM free.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-dapm.h |  2 ++
 include/sound/soc.h      | 11 +++++++++++
 sound/soc/soc-core.c     |  4 ++++
 sound/soc/soc-dapm.c     |  4 ++++
 4 files changed, 21 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3263e36..8d28b36 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -15,6 +15,7 @@
 
 #include <linux/types.h>
 #include <sound/control.h>
+#include <sound/soc-topology.h>
 #include <sound/asoc.h>
 
 struct device;
@@ -533,6 +534,7 @@ struct snd_soc_dapm_widget {
 	int num_kcontrols;
 	const struct snd_kcontrol_new *kcontrol_news;
 	struct snd_kcontrol **kcontrols;
+	struct snd_soc_dobj dobj;
 
 	/* widget input and outputs */
 	struct list_head sources;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0d1ade1..e7bc994 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -27,6 +27,7 @@
 #include <sound/compress_driver.h>
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
+#include <sound/soc-topology.h>
 
 /*
  * Convenience kcontrol builders
@@ -753,6 +754,9 @@ struct snd_soc_component {
 
 	struct mutex io_mutex;
 
+	/* attached dynamic objects */
+	struct list_head dobj_list;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_root;
 #endif
@@ -1088,6 +1092,9 @@ struct snd_soc_card {
 	struct list_head dapm_list;
 	struct list_head dapm_dirty;
 
+	/* attached dynamic objects */
+	struct list_head dobj_list;
+
 	/* Generic DAPM context for the card */
 	struct snd_soc_dapm_context dapm;
 	struct snd_soc_dapm_stats dapm_stats;
@@ -1147,6 +1154,7 @@ struct soc_mixer_control {
 	unsigned int sign_bit;
 	unsigned int invert:1;
 	unsigned int autodisable:1;
+	struct snd_soc_dobj dobj;
 };
 
 struct soc_bytes {
@@ -1157,6 +1165,8 @@ struct soc_bytes {
 
 struct soc_bytes_ext {
 	int max;
+	struct snd_soc_dobj dobj;
+
 	/* used for TLV byte control */
 	int (*get)(unsigned int __user *bytes, unsigned int size);
 	int (*put)(const unsigned int __user *bytes, unsigned int size);
@@ -1177,6 +1187,7 @@ struct soc_enum {
 	unsigned int mask;
 	const char * const *texts;
 	const unsigned int *values;
+	struct snd_soc_dobj dobj;
 };
 
 /**
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9dfa2e2..3a6ae19 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -40,6 +40,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dpcm.h>
+#include <sound/soc-topology.h>
 #include <sound/initval.h>
 
 #define CREATE_TRACE_POINTS
@@ -2434,6 +2435,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		card->rtd_aux[i].card = card;
 
 	INIT_LIST_HEAD(&card->dapm_dirty);
+	INIT_LIST_HEAD(&card->dobj_list);
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
@@ -2748,6 +2750,7 @@ static void snd_soc_component_add_unlocked(struct snd_soc_component *component)
 	}
 
 	list_add(&component->list, &component_list);
+	INIT_LIST_HEAD(&component->dobj_list);
 }
 
 static void snd_soc_component_add(struct snd_soc_component *component)
@@ -2824,6 +2827,7 @@ void snd_soc_unregister_component(struct device *dev)
 	return;
 
 found:
+	snd_soc_tplg_component_remove(cmpnt, SND_SOC_TPLG_ID_ALL);
 	snd_soc_component_del_unlocked(cmpnt);
 	mutex_unlock(&client_mutex);
 	snd_soc_component_cleanup(cmpnt);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 86d350a..c768e02 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -41,6 +41,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-topology.h>
 #include <sound/initval.h>
 
 #include <trace/events/asoc.h>
@@ -2165,6 +2166,9 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 		list_for_each_entry_safe(p, next_p, &w->sinks, list_source)
 			dapm_free_path(p);
 
+		/* check and free and dynamic widget kcontrols */
+		snd_soc_tplg_widget_remove(w);
+
 		kfree(w->kcontrols);
 		kfree(w->name);
 		kfree(w);
-- 
2.1.0
