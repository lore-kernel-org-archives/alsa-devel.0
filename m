From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/10] ALSA: emux: Fix/cleanup old ifdef
	CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:10 +0200
Message-ID: <1432879571-3359-10-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 898012666D9
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 36A6DAD5A
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

Build emux_proc.o and drop the unneeded ifdefs.
Replace the left CONFIG_PROC with the new CONFIG_SND_PROC_FS.

Along with this, fix the build of emux_oss.o in Makefile, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/emux_synth.h    | 2 +-
 sound/synth/emux/Makefile     | 5 +++--
 sound/synth/emux/emux.c       | 4 ----
 sound/synth/emux/emux_proc.c  | 4 ----
 sound/synth/emux/emux_voice.h | 6 +++++-
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/sound/emux_synth.h b/include/sound/emux_synth.h
index fb81f3722b6a..a0a40b74bf13 100644
--- a/include/sound/emux_synth.h
+++ b/include/sound/emux_synth.h
@@ -125,7 +125,7 @@ struct snd_emux {
 
 	struct snd_util_memhdr *memhdr;	/* memory chunk information */
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	struct snd_info_entry *proc;
 #endif
 
diff --git a/sound/synth/emux/Makefile b/sound/synth/emux/Makefile
index 328594e6152d..fb761c2c2b50 100644
--- a/sound/synth/emux/Makefile
+++ b/sound/synth/emux/Makefile
@@ -4,8 +4,9 @@
 #
 
 snd-emux-synth-objs := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
-		       emux_effect.o emux_proc.o emux_hwdep.o soundfont.o \
-		       $(if $(CONFIG_SND_SEQUENCER_OSS),emux_oss.o)
+		       emux_effect.o emux_hwdep.o soundfont.o
+snd-emux-synth-$(CONFIG_SND_PROC_FS) += emux_proc.o
+snd-emux-synth-$(CONFIG_SND_SEQUENCER_OSS) += emux_oss.o
 
 # Toplevel Module Dependencies
 obj-$(CONFIG_SND_SBAWE_SEQ) += snd-emux-synth.o
diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 49195325fdf6..9312cd8a6fdd 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -128,9 +128,7 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
 #endif
 	snd_emux_init_virmidi(emu, card);
 
-#ifdef CONFIG_PROC_FS
 	snd_emux_proc_init(emu, card, index);
-#endif
 	return 0;
 }
 
@@ -150,9 +148,7 @@ int snd_emux_free(struct snd_emux *emu)
 		del_timer(&emu->tlist);
 	spin_unlock_irqrestore(&emu->voice_lock, flags);
 
-#ifdef CONFIG_PROC_FS
 	snd_emux_proc_free(emu);
-#endif
 	snd_emux_delete_virmidi(emu);
 #ifdef CONFIG_SND_SEQUENCER_OSS
 	snd_emux_detach_seq_oss(emu);
diff --git a/sound/synth/emux/emux_proc.c b/sound/synth/emux/emux_proc.c
index 58a32a10d115..a82b4053bee8 100644
--- a/sound/synth/emux/emux_proc.c
+++ b/sound/synth/emux/emux_proc.c
@@ -24,8 +24,6 @@
 #include <sound/info.h>
 #include "emux_voice.h"
 
-#ifdef CONFIG_PROC_FS
-
 static void
 snd_emux_proc_info_read(struct snd_info_entry *entry, 
 			struct snd_info_buffer *buf)
@@ -128,5 +126,3 @@ void snd_emux_proc_free(struct snd_emux *emu)
 	snd_info_free_entry(emu->proc);
 	emu->proc = NULL;
 }
-
-#endif /* CONFIG_PROC_FS */
diff --git a/sound/synth/emux/emux_voice.h b/sound/synth/emux/emux_voice.h
index 09711f84ed30..a7073c371bcc 100644
--- a/sound/synth/emux/emux_voice.h
+++ b/sound/synth/emux/emux_voice.h
@@ -82,9 +82,13 @@ void snd_emux_init_seq_oss(struct snd_emux *emu);
 void snd_emux_detach_seq_oss(struct snd_emux *emu);
 
 /* emux_proc.c */
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 void snd_emux_proc_init(struct snd_emux *emu, struct snd_card *card, int device);
 void snd_emux_proc_free(struct snd_emux *emu);
+#else
+static inline void snd_emux_proc_init(struct snd_emux *emu,
+				      struct snd_card *card, int device) {}
+static inline void snd_emux_proc_free(struct snd_emux *emu) {}
 #endif
 
 #define STATE_IS_PLAYING(s) ((s) & SNDRV_EMUX_ST_ON)
-- 
2.4.2
