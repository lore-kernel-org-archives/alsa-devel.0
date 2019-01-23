From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Simplify proc file destruction
Date: Wed, 23 Jan 2019 18:11:04 +0100
Message-ID: <20190123171104.28402-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A352A2674AC
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 18:11:07 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B6FBDB10D
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 17:11:06 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The proc files are recursively freed by calling with the root
snd_info_entry object, so we don't have to keep each object for
releasing one by one.  Move the release of the PCM stream proc root at
the beginning, so that we can remove the redundant code and resource.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     | 11 ---------
 sound/core/pcm.c        | 66 +++++++++----------------------------------------
 sound/core/pcm_memory.c | 16 ++----------
 3 files changed, 13 insertions(+), 80 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index a20d3a48df00..eae6d2b82d7a 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -481,15 +481,6 @@ struct snd_pcm_substream {
 #endif
 #ifdef CONFIG_SND_VERBOSE_PROCFS
 	struct snd_info_entry *proc_root;
-	struct snd_info_entry *proc_info_entry;
-	struct snd_info_entry *proc_hw_params_entry;
-	struct snd_info_entry *proc_sw_params_entry;
-	struct snd_info_entry *proc_status_entry;
-	struct snd_info_entry *proc_prealloc_entry;
-	struct snd_info_entry *proc_prealloc_max_entry;
-#ifdef CONFIG_SND_PCM_XRUN_DEBUG
-	struct snd_info_entry *proc_xrun_injection_entry;
-#endif
 #endif /* CONFIG_SND_VERBOSE_PROCFS */
 	/* misc flags */
 	unsigned int hw_opened: 1;
@@ -511,10 +502,8 @@ struct snd_pcm_str {
 #endif
 #ifdef CONFIG_SND_VERBOSE_PROCFS
 	struct snd_info_entry *proc_root;
-	struct snd_info_entry *proc_info_entry;
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 	unsigned int xrun_debug;	/* 0 = disabled, 1 = verbose, 2 = stacktrace */
-	struct snd_info_entry *proc_xrun_debug_entry;
 #endif
 #endif
 	struct snd_kcontrol *chmap_kctl; /* channel-mapping controls */
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index ca1ea3cf9350..bca0bdf3e33c 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -536,12 +536,9 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 	entry = snd_info_create_card_entry(pcm->card, "info", pstr->proc_root);
 	if (entry) {
 		snd_info_set_text_ops(entry, pstr, snd_pcm_stream_proc_info_read);
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	pstr->proc_info_entry = entry;
 
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 	entry = snd_info_create_card_entry(pcm->card, "xrun_debug",
@@ -551,24 +548,15 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 		entry->c.text.write = snd_pcm_xrun_debug_write;
 		entry->mode |= 0200;
 		entry->private_data = pstr;
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	pstr->proc_xrun_debug_entry = entry;
 #endif
 	return 0;
 }
 
 static int snd_pcm_stream_proc_done(struct snd_pcm_str *pstr)
 {
-#ifdef CONFIG_SND_PCM_XRUN_DEBUG
-	snd_info_free_entry(pstr->proc_xrun_debug_entry);
-	pstr->proc_xrun_debug_entry = NULL;
-#endif
-	snd_info_free_entry(pstr->proc_info_entry);
-	pstr->proc_info_entry = NULL;
 	snd_info_free_entry(pstr->proc_root);
 	pstr->proc_root = NULL;
 	return 0;
@@ -597,45 +585,33 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 	if (entry) {
 		snd_info_set_text_ops(entry, substream,
 				      snd_pcm_substream_proc_info_read);
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	substream->proc_info_entry = entry;
 	entry = snd_info_create_card_entry(card, "hw_params",
 					   substream->proc_root);
 	if (entry) {
 		snd_info_set_text_ops(entry, substream,
 				      snd_pcm_substream_proc_hw_params_read);
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	substream->proc_hw_params_entry = entry;
 	entry = snd_info_create_card_entry(card, "sw_params",
 					   substream->proc_root);
 	if (entry) {
 		snd_info_set_text_ops(entry, substream,
 				      snd_pcm_substream_proc_sw_params_read);
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	substream->proc_sw_params_entry = entry;
 	entry = snd_info_create_card_entry(card, "status",
 					   substream->proc_root);
 	if (entry) {
 		snd_info_set_text_ops(entry, substream,
 				      snd_pcm_substream_proc_status_read);
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	substream->proc_status_entry = entry;
 
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 	entry = snd_info_create_card_entry(card, "xrun_injection",
@@ -645,40 +621,18 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 		entry->c.text.read = NULL;
 		entry->c.text.write = snd_pcm_xrun_injection_write;
 		entry->mode = S_IFREG | 0200;
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	substream->proc_xrun_injection_entry = entry;
 #endif /* CONFIG_SND_PCM_XRUN_DEBUG */
 
 	return 0;
 }
 
-static int snd_pcm_substream_proc_done(struct snd_pcm_substream *substream)
-{
-	snd_info_free_entry(substream->proc_info_entry);
-	substream->proc_info_entry = NULL;
-	snd_info_free_entry(substream->proc_hw_params_entry);
-	substream->proc_hw_params_entry = NULL;
-	snd_info_free_entry(substream->proc_sw_params_entry);
-	substream->proc_sw_params_entry = NULL;
-	snd_info_free_entry(substream->proc_status_entry);
-	substream->proc_status_entry = NULL;
-#ifdef CONFIG_SND_PCM_XRUN_DEBUG
-	snd_info_free_entry(substream->proc_xrun_injection_entry);
-	substream->proc_xrun_injection_entry = NULL;
-#endif
-	snd_info_free_entry(substream->proc_root);
-	substream->proc_root = NULL;
-	return 0;
-}
 #else /* !CONFIG_SND_VERBOSE_PROCFS */
 static inline int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr) { return 0; }
 static inline int snd_pcm_stream_proc_done(struct snd_pcm_str *pstr) { return 0; }
 static inline int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream) { return 0; }
-static inline int snd_pcm_substream_proc_done(struct snd_pcm_substream *substream) { return 0; }
 #endif /* CONFIG_SND_VERBOSE_PROCFS */
 
 static const struct attribute_group *pcm_dev_attr_groups[];
@@ -911,15 +865,17 @@ static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
 #if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	struct snd_pcm_oss_setup *setup, *setupn;
 #endif
+
+	/* free all proc files under the stream */
+	snd_pcm_stream_proc_done(pstr);
+
 	substream = pstr->substream;
 	while (substream) {
 		substream_next = substream->next;
 		snd_pcm_timer_done(substream);
-		snd_pcm_substream_proc_done(substream);
 		kfree(substream);
 		substream = substream_next;
 	}
-	snd_pcm_stream_proc_done(pstr);
 #if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	for (setup = pstr->oss.setup_list; setup; setup = setupn) {
 		setupn = setup->next;
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 4b5356a10315..9a98bc61461f 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -93,12 +93,6 @@ static void snd_pcm_lib_preallocate_dma_free(struct snd_pcm_substream *substream
 int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream)
 {
 	snd_pcm_lib_preallocate_dma_free(substream);
-#ifdef CONFIG_SND_VERBOSE_PROCFS
-	snd_info_free_entry(substream->proc_prealloc_max_entry);
-	substream->proc_prealloc_max_entry = NULL;
-	snd_info_free_entry(substream->proc_prealloc_entry);
-	substream->proc_prealloc_entry = NULL;
-#endif
 	return 0;
 }
 
@@ -203,21 +197,15 @@ static inline void preallocate_info_init(struct snd_pcm_substream *substream)
 		entry->c.text.write = snd_pcm_lib_preallocate_proc_write;
 		entry->mode |= 0200;
 		entry->private_data = substream;
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	substream->proc_prealloc_entry = entry;
 	if ((entry = snd_info_create_card_entry(substream->pcm->card, "prealloc_max", substream->proc_root)) != NULL) {
 		entry->c.text.read = snd_pcm_lib_preallocate_max_proc_read;
 		entry->private_data = substream;
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	substream->proc_prealloc_max_entry = entry;
 }
 
 #else /* !CONFIG_SND_VERBOSE_PROCFS */
-- 
2.16.4
