From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: core: Fix randconfig build wrt
	CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:04:07 +0200
Message-ID: <1432879447-3299-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EB5A26666B
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:04:09 +0200 (CEST)
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
Cc: Jim Davis <jim.epost@gmail.com>
List-Id: alsa-devel@alsa-project.org

There are a few leftover CONFIG_PROC_FS forgotten to replace with
CONFIG_SND_PROC_FS.

Fixes: cd6a65036f0e ('ALSA: replace CONFIG_PROC_FS with CONFIG_SND_PROC_FS')
Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/Makefile     | 2 +-
 sound/core/seq/seq_device.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/Makefile b/sound/core/seq/Makefile
index b29ffe835205..b65fa5a1943b 100644
--- a/sound/core/seq/Makefile
+++ b/sound/core/seq/Makefile
@@ -7,7 +7,7 @@ snd-seq-device-objs := seq_device.o
 snd-seq-objs := seq.o seq_lock.o seq_clientmgr.o seq_memory.o seq_queue.o \
                 seq_fifo.o seq_prioq.o seq_timer.o \
                 seq_system.o seq_ports.o
-snd-seq-$(CONFIG_PROC_FS) += seq_info.o
+snd-seq-$(CONFIG_SND_PROC_FS) += seq_info.o
 snd-seq-midi-objs := seq_midi.o
 snd-seq-midi-emul-objs := seq_midi_emul.o
 snd-seq-midi-event-objs := seq_midi_event.o
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 288af56a43cd..c4acf17e9f5e 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(snd_seq_driver_unregister);
 
 static int __init seq_dev_proc_init(void)
 {
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	info_entry = snd_info_create_module_entry(THIS_MODULE, "drivers",
 						  snd_seq_root);
 	if (info_entry == NULL)
@@ -305,7 +305,7 @@ static void __exit alsa_seq_device_exit(void)
 #ifdef CONFIG_MODULES
 	cancel_work_sync(&autoload_work);
 #endif
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	snd_info_free_entry(info_entry);
 #endif
 	bus_unregister(&snd_seq_bus_type);
-- 
2.4.2
