From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/10] ALSA: opl4: Fix / cleanup ifdef
	CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:04 +0200
Message-ID: <1432879571-3359-4-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E95D2666D4
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1DE32AD27
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:06:14 +0000 (UTC)
In-Reply-To: <1432879571-3359-1-git-send-email-tiwai@suse.de>
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

Some are replaced with the new ifdef CONFIG_SND_PROC_FS.  Some are
removed by building opl4_proc.o conditionally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl4/Makefile     | 3 ++-
 sound/drivers/opl4/opl4_lib.c   | 4 ----
 sound/drivers/opl4/opl4_local.h | 7 +++++--
 sound/drivers/opl4/opl4_proc.c  | 4 ----
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/drivers/opl4/Makefile b/sound/drivers/opl4/Makefile
index b94009b0b19f..c8eaa433d71a 100644
--- a/sound/drivers/opl4/Makefile
+++ b/sound/drivers/opl4/Makefile
@@ -3,7 +3,8 @@
 # Copyright (c) 2001 by Jaroslav Kysela <perex@perex.cz>
 #
 
-snd-opl4-lib-objs := opl4_lib.o opl4_mixer.o opl4_proc.o
+snd-opl4-lib-objs := opl4_lib.o opl4_mixer.o
+snd-opl4-lib-$(CONFIG_SND_PROC_FS) += opl4_proc.o
 snd-opl4-synth-objs := opl4_seq.o opl4_synth.o yrw801.o
 
 obj-$(CONFIG_SND_OPL4_LIB) += snd-opl4-lib.o
diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index 3b0ee42a5343..89c7aa04b3bc 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -176,9 +176,7 @@ static int snd_opl4_create_seq_dev(struct snd_opl4 *opl4, int seq_device)
 
 static void snd_opl4_free(struct snd_opl4 *opl4)
 {
-#ifdef CONFIG_PROC_FS
 	snd_opl4_free_proc(opl4);
-#endif
 	release_and_free_resource(opl4->res_fm_port);
 	release_and_free_resource(opl4->res_pcm_port);
 	kfree(opl4);
@@ -249,9 +247,7 @@ int snd_opl4_create(struct snd_card *card,
 	snd_opl4_enable_opl4(opl4);
 
 	snd_opl4_create_mixer(opl4);
-#ifdef CONFIG_PROC_FS
 	snd_opl4_create_proc(opl4);
-#endif
 
 #if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
 	opl4->seq_client = -1;
diff --git a/sound/drivers/opl4/opl4_local.h b/sound/drivers/opl4/opl4_local.h
index 470e5a758a02..9a41bdebce6b 100644
--- a/sound/drivers/opl4/opl4_local.h
+++ b/sound/drivers/opl4/opl4_local.h
@@ -178,7 +178,7 @@ struct snd_opl4 {
 	spinlock_t reg_lock;
 	struct snd_card *card;
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	struct snd_info_entry *proc_entry;
 	int memory_access;
 #endif
@@ -207,10 +207,13 @@ void snd_opl4_write_memory(struct snd_opl4 *opl4, const char *buf, int offset, i
 /* opl4_mixer.c */
 int snd_opl4_create_mixer(struct snd_opl4 *opl4);
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /* opl4_proc.c */
 int snd_opl4_create_proc(struct snd_opl4 *opl4);
 void snd_opl4_free_proc(struct snd_opl4 *opl4);
+#else
+static inline int snd_opl4_create_proc(struct snd_opl4 *opl4) { return 0; }
+static inline void snd_opl4_free_proc(struct snd_opl4 *opl4) {}
 #endif
 
 /* opl4_seq.c */
diff --git a/sound/drivers/opl4/opl4_proc.c b/sound/drivers/opl4/opl4_proc.c
index 9b824bfc919d..cd2c07fa2ef4 100644
--- a/sound/drivers/opl4/opl4_proc.c
+++ b/sound/drivers/opl4/opl4_proc.c
@@ -22,8 +22,6 @@
 #include <linux/export.h>
 #include <sound/info.h>
 
-#ifdef CONFIG_PROC_FS
-
 static int snd_opl4_mem_proc_open(struct snd_info_entry *entry,
 				  unsigned short mode, void **file_private_data)
 {
@@ -129,5 +127,3 @@ void snd_opl4_free_proc(struct snd_opl4 *opl4)
 {
 	snd_info_free_entry(opl4->proc_entry);
 }
-
-#endif /* CONFIG_PROC_FS */
-- 
2.4.2
