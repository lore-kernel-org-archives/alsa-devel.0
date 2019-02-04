From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/11] ALSA: pcm: Remove superfluous
	snd_info_register() calls
Date: Mon,  4 Feb 2019 16:20:26 +0100
Message-ID: <20190204152036.14102-2-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B1624267546
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:39 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 35146AD25
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:39 +0000 (UTC)
In-Reply-To: <20190204152036.14102-1-tiwai@suse.de>
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

The calls of snd_info_register() are superfluous and should be avoided
at the procfs creation time.  They are called at the end of the whole
initialization via snd_card_register().  This patch drops such
superfluous calls, as well as cleaning up the calls of substream proc
entries with a common helper.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c | 79 +++++++++++++++++++-------------------------------------
 1 file changed, 26 insertions(+), 53 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 4f45b3000347..a49c866541cb 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -528,18 +528,10 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 	if (!entry)
 		return -ENOMEM;
 	entry->mode = S_IFDIR | 0555;
-	if (snd_info_register(entry) < 0) {
-		snd_info_free_entry(entry);
-		return -ENOMEM;
-	}
 	pstr->proc_root = entry;
 	entry = snd_info_create_card_entry(pcm->card, "info", pstr->proc_root);
-	if (entry) {
+	if (entry)
 		snd_info_set_text_ops(entry, pstr, snd_pcm_stream_proc_info_read);
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
-	}
-
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 	entry = snd_info_create_card_entry(pcm->card, "xrun_debug",
 					   pstr->proc_root);
@@ -547,9 +539,6 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 		entry->c.text.read = snd_pcm_xrun_debug_read;
 		entry->c.text.write = snd_pcm_xrun_debug_write;
 		entry->mode |= 0200;
-		entry->private_data = pstr;
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
 	}
 #endif
 	return 0;
@@ -562,6 +551,21 @@ static int snd_pcm_stream_proc_done(struct snd_pcm_str *pstr)
 	return 0;
 }
 
+static struct snd_info_entry *
+create_substream_info_entry(struct snd_pcm_substream *substream,
+			    const char *name,
+			    void (*read)(struct snd_info_entry *,
+					 struct snd_info_buffer *))
+{
+	struct snd_info_entry *entry;
+
+	entry = snd_info_create_card_entry(substream->pcm->card, name,
+					   substream->proc_root);
+	if (entry)
+		snd_info_set_text_ops(entry, substream, read);
+	return entry;
+}
+
 static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 {
 	struct snd_info_entry *entry;
@@ -576,53 +580,22 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 	if (!entry)
 		return -ENOMEM;
 	entry->mode = S_IFDIR | 0555;
-	if (snd_info_register(entry) < 0) {
-		snd_info_free_entry(entry);
-		return -ENOMEM;
-	}
 	substream->proc_root = entry;
-	entry = snd_info_create_card_entry(card, "info", substream->proc_root);
-	if (entry) {
-		snd_info_set_text_ops(entry, substream,
-				      snd_pcm_substream_proc_info_read);
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
-	}
-	entry = snd_info_create_card_entry(card, "hw_params",
-					   substream->proc_root);
-	if (entry) {
-		snd_info_set_text_ops(entry, substream,
-				      snd_pcm_substream_proc_hw_params_read);
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
-	}
-	entry = snd_info_create_card_entry(card, "sw_params",
-					   substream->proc_root);
-	if (entry) {
-		snd_info_set_text_ops(entry, substream,
-				      snd_pcm_substream_proc_sw_params_read);
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
-	}
-	entry = snd_info_create_card_entry(card, "status",
-					   substream->proc_root);
-	if (entry) {
-		snd_info_set_text_ops(entry, substream,
-				      snd_pcm_substream_proc_status_read);
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
-	}
+
+	create_substream_info_entry(substream, "info",
+				    snd_pcm_substream_proc_info_read);
+	create_substream_info_entry(substream, "hw_params",
+				    snd_pcm_substream_proc_hw_params_read);
+	create_substream_info_entry(substream, "sw_params",
+				    snd_pcm_substream_proc_sw_params_read);
+	create_substream_info_entry(substream, "status",
+				    snd_pcm_substream_proc_status_read);
 
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
-	entry = snd_info_create_card_entry(card, "xrun_injection",
-					   substream->proc_root);
+	entry = create_substream_info_entry(substream, "xrun_injection", NULL);
 	if (entry) {
-		entry->private_data = substream;
-		entry->c.text.read = NULL;
 		entry->c.text.write = snd_pcm_xrun_injection_write;
 		entry->mode = S_IFREG | 0200;
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
 	}
 #endif /* CONFIG_SND_PCM_XRUN_DEBUG */
 
-- 
2.16.4
