From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/8] ALSA: core: Build conditionally and remove
	superfluous ifdefs
Date: Thu, 23 Apr 2015 16:49:29 +0200
Message-ID: <1429800570-10153-8-git-send-email-tiwai@suse.de>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BE9B265A78
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 29E6FAD6D
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 14:49:38 +0000 (UTC)
In-Reply-To: <1429800570-10153-1-git-send-email-tiwai@suse.de>
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

Minor cleanups of Makefile to build some codes conditionally so that
a few ifdefs can be reduced.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/Makefile       | 8 ++++++--
 sound/core/info.c         | 8 --------
 sound/core/info_oss.c     | 4 ----
 sound/core/seq/Makefile   | 3 ++-
 sound/core/seq/seq_info.c | 2 --
 sound/core/sound_oss.c    | 8 --------
 6 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/sound/core/Makefile b/sound/core/Makefile
index 4daf2f58261c..ae1d32b084fd 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -3,9 +3,13 @@
 # Copyright (c) 1999,2001 by Jaroslav Kysela <perex@perex.cz>
 #
 
-snd-y     := sound.o init.o memory.o info.o control.o misc.o device.o
+snd-y     := sound.o init.o memory.o control.o misc.o device.o
+ifneq ($(CONFIG_PROC_FS),)
+snd-y += info.o
+snd-$(CONFIG_SND_OSSEMUL) += info_oss.o
+endif
 snd-$(CONFIG_ISA_DMA_API) += isadma.o
-snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o info_oss.o
+snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o
 snd-$(CONFIG_SND_VMASTER) += vmaster.o
 snd-$(CONFIG_SND_KCTL_JACK) += ctljack.o
 snd-$(CONFIG_SND_JACK)	  += jack.o
diff --git a/sound/core/info.c b/sound/core/info.c
index 4169062fabf5..f8bdd9b6f322 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -33,12 +33,6 @@
 #include <linux/mutex.h>
 #include <stdarg.h>
 
-/*
- *
- */
-
-#ifdef CONFIG_PROC_FS
-
 int snd_info_check_reserved_words(const char *str)
 {
 	static char *reserved[] =
@@ -850,5 +844,3 @@ static int __init snd_info_version_init(void)
 	entry->c.text.read = snd_info_version_read;
 	return snd_info_register(entry); /* freed in error path */
 }
-
-#endif /* CONFIG_PROC_FS */
diff --git a/sound/core/info_oss.c b/sound/core/info_oss.c
index 83c29dbff9c0..bd4d2c6233c2 100644
--- a/sound/core/info_oss.c
+++ b/sound/core/info_oss.c
@@ -29,8 +29,6 @@
 #include <linux/utsname.h>
 #include <linux/mutex.h>
 
-#if defined(CONFIG_SND_OSSEMUL) && defined(CONFIG_PROC_FS)
-
 /*
  *  OSS compatible part
  */
@@ -134,5 +132,3 @@ int snd_info_minor_unregister(void)
 	snd_sndstat_proc_entry = NULL;
 	return 0;
 }
-
-#endif /* CONFIG_SND_OSSEMUL */
diff --git a/sound/core/seq/Makefile b/sound/core/seq/Makefile
index 941f64a853eb..b29ffe835205 100644
--- a/sound/core/seq/Makefile
+++ b/sound/core/seq/Makefile
@@ -6,7 +6,8 @@
 snd-seq-device-objs := seq_device.o
 snd-seq-objs := seq.o seq_lock.o seq_clientmgr.o seq_memory.o seq_queue.o \
                 seq_fifo.o seq_prioq.o seq_timer.o \
-                seq_system.o seq_ports.o seq_info.o
+                seq_system.o seq_ports.o
+snd-seq-$(CONFIG_PROC_FS) += seq_info.o
 snd-seq-midi-objs := seq_midi.o
 snd-seq-midi-emul-objs := seq_midi_emul.o
 snd-seq-midi-event-objs := seq_midi_event.o
diff --git a/sound/core/seq/seq_info.c b/sound/core/seq/seq_info.c
index d3c65e780e9e..97015447b9b3 100644
--- a/sound/core/seq/seq_info.c
+++ b/sound/core/seq/seq_info.c
@@ -27,7 +27,6 @@
 #include "seq_clientmgr.h"
 #include "seq_timer.h"
 
-#ifdef CONFIG_PROC_FS
 static struct snd_info_entry *queues_entry;
 static struct snd_info_entry *clients_entry;
 static struct snd_info_entry *timer_entry;
@@ -80,4 +79,3 @@ int __exit snd_seq_info_done(void)
 	free_info_entries();
 	return 0;
 }
-#endif
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 56d2f409f1ef..86e2d91dd375 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -19,12 +19,6 @@
  *
  */
 
-#ifdef CONFIG_SND_OSSEMUL
-
-#if !IS_ENABLED(CONFIG_SOUND)
-#error "Enable the OSS soundcore multiplexer (CONFIG_SOUND) in the kernel."
-#endif
-
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -266,5 +260,3 @@ int __init snd_minor_info_oss_init(void)
 	return snd_info_register(entry); /* freed in error path */
 }
 #endif /* CONFIG_PROC_FS */
-
-#endif /* CONFIG_SND_OSSEMUL */
-- 
2.3.5
