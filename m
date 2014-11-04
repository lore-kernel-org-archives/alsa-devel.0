From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: pcm: Add xrun_injection proc entry
Date: Tue,  4 Nov 2014 14:28:16 +0100
Message-ID: <1415107696-17123-6-git-send-email-tiwai@suse.de>
References: <1415107696-17123-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 020F226152E
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 14:28:19 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6420EAD55
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 13:28:19 +0000 (UTC)
In-Reply-To: <1415107696-17123-1-git-send-email-tiwai@suse.de>
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

This patch adds a new proc entry for PCM substreams to inject an
XRUN.  When a PCM substream is running and any value is written to its
xrun_injection proc file, the driver triggers XRUN.  This is a useful
feature for debugging XRUN and error handling code paths.

Note that this entry is enabled only when CONFIG_SND_PCM_XRUN_DEBUG is
set.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/Procfile.txt |  4 ++++
 include/sound/pcm.h                   |  3 +++
 sound/core/pcm.c                      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/sound/alsa/Procfile.txt b/Documentation/sound/alsa/Procfile.txt
index cfc49567b9dc..7f8a0d325905 100644
--- a/Documentation/sound/alsa/Procfile.txt
+++ b/Documentation/sound/alsa/Procfile.txt
@@ -133,6 +133,10 @@ card*/pcm*/sub*/sw_params
 card*/pcm*/sub*/prealloc
 	The buffer pre-allocation information.
 
+card*/pcm*/sub*/xrun_injection
+	Triggers an XRUN to the running stream when any value is
+	written to this proc file.  Used for fault injection.
+	This entry is write-only.
 
 AC97 Codec Information
 ----------------------
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 29eb09ef2969..0b8daeed0a33 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -416,7 +416,10 @@ struct snd_pcm_substream {
 	struct snd_info_entry *proc_status_entry;
 	struct snd_info_entry *proc_prealloc_entry;
 	struct snd_info_entry *proc_prealloc_max_entry;
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
+	struct snd_info_entry *proc_xrun_injection_entry;
 #endif
+#endif /* CONFIG_SND_VERBOSE_PROCFS */
 	/* misc flags */
 	unsigned int hw_opened: 1;
 };
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 31acc3df62cd..8f624b7af0ca 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -483,6 +483,19 @@ static void snd_pcm_substream_proc_status_read(struct snd_info_entry *entry,
 }
 
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
+static void snd_pcm_xrun_injection_write(struct snd_info_entry *entry,
+					 struct snd_info_buffer *buffer)
+{
+	struct snd_pcm_substream *substream = entry->private_data;
+	struct snd_pcm_runtime *runtime;
+
+	snd_pcm_stream_lock_irq(substream);
+	runtime = substream->runtime;
+	if (runtime && runtime->status->state == SNDRV_PCM_STATE_RUNNING)
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+	snd_pcm_stream_unlock_irq(substream);
+}
+
 static void snd_pcm_xrun_debug_read(struct snd_info_entry *entry,
 				    struct snd_info_buffer *buffer)
 {
@@ -614,6 +627,22 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 	}
 	substream->proc_status_entry = entry;
 
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
+	entry = snd_info_create_card_entry(card, "xrun_injection",
+					   substream->proc_root);
+	if (entry) {
+		entry->private_data = substream;
+		entry->c.text.read = NULL;
+		entry->c.text.write = snd_pcm_xrun_injection_write;
+		entry->mode = S_IFREG | S_IWUSR;
+		if (snd_info_register(entry) < 0) {
+			snd_info_free_entry(entry);
+			entry = NULL;
+		}
+	}
+	substream->proc_xrun_injection_entry = entry;
+#endif /* CONFIG_SND_PCM_XRUN_DEBUG */
+
 	return 0;
 }
 
@@ -627,6 +656,10 @@ static int snd_pcm_substream_proc_done(struct snd_pcm_substream *substream)
 	substream->proc_sw_params_entry = NULL;
 	snd_info_free_entry(substream->proc_status_entry);
 	substream->proc_status_entry = NULL;
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
+	snd_info_free_entry(substream->proc_xrun_injection_entry);
+	substream->proc_xrun_injection_entry = NULL;
+#endif
 	snd_info_free_entry(substream->proc_root);
 	substream->proc_root = NULL;
 	return 0;
-- 
2.1.3
