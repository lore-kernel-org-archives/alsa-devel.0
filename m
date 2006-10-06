From: Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] RFC - add prealloc_max proc file
Date: Fri, 6 Oct 2006 10:27:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610061026300.8573@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E014199
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 10:27:59 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	6EC3999562 for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 10:27:59 +0200 (MEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	38AE0E9481 for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 10:27:59 +0200 (CEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

	I would like to propose to add prealloc_max proc file to give a 
hint, what's the maximum allowed DMA buffer size in bytes:

diff -r 1551b696524c core/pcm_memory.c
--- a/core/pcm_memory.c	Fri Oct 06 09:34:20 2006 +0200
+++ b/core/pcm_memory.c	Fri Oct 06 10:26:15 2006 +0200
@@ -101,6 +101,8 @@ int snd_pcm_lib_preallocate_free(struct 
 {
 	snd_pcm_lib_preallocate_dma_free(substream);
 #ifdef CONFIG_SND_VERBOSE_PROCFS
+	snd_info_free_entry(substream->proc_prealloc_max_entry);
+	substream->proc_prealloc_max_entry = NULL;
 	snd_info_free_entry(substream->proc_prealloc_entry);
 	substream->proc_prealloc_entry = NULL;
 #endif
@@ -139,6 +141,18 @@ static void snd_pcm_lib_preallocate_proc
 {
 	struct snd_pcm_substream *substream = entry->private_data;
 	snd_iprintf(buffer, "%lu\n", (unsigned long) substream->dma_buffer.bytes / 1024);
+}
+
+/*
+ * read callback for prealloc_max proc file
+ *
+ * prints the maximum allowed size in kB.
+ */
+static void snd_pcm_lib_preallocate_max_proc_read(struct snd_info_entry *entry,
+						  struct snd_info_buffer *buffer)
+{
+	struct snd_pcm_substream *substream = entry->private_data;
+	snd_iprintf(buffer, "%lu\n", (unsigned long) substream->dma_max / 1024);
 }
 
 /*
@@ -203,6 +217,15 @@ static inline void preallocate_info_init
 		}
 	}
 	substream->proc_prealloc_entry = entry;
+	if ((entry = snd_info_create_card_entry(substream->pcm->card, "prealloc_max", substream->proc_root)) != NULL) {
+		entry->c.text.read = snd_pcm_lib_preallocate_max_proc_read;
+		entry->private_data = substream;
+		if (snd_info_register(entry) < 0) {
+			snd_info_free_entry(entry);
+			entry = NULL;
+		}
+	}
+	substream->proc_prealloc_max_entry = entry;
 }
 
 #else /* !CONFIG_SND_VERBOSE_PROCFS */
diff -r 1551b696524c include/pcm.h
--- a/include/pcm.h	Fri Oct 06 09:34:20 2006 +0200
+++ b/include/pcm.h	Fri Oct 06 10:26:15 2006 +0200
@@ -383,6 +383,7 @@ struct snd_pcm_substream {
 	struct snd_info_entry *proc_sw_params_entry;
 	struct snd_info_entry *proc_status_entry;
 	struct snd_info_entry *proc_prealloc_entry;
+	struct snd_info_entry *proc_prealloc_max_entry;
 #endif
 	/* misc flags */
 	unsigned int hw_opened: 1;

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
