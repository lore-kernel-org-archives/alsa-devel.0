From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/10] ALSA: emu10k1: Fix/cleanup ifdef
	CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:09 +0200
Message-ID: <1432879571-3359-9-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8885E2666D7
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 33D9FAD58
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

Build emuproc.o conditionally and drop the unneeded ifdefs.
Some are replaced with the new CONFIG_SND_PROC_FS.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/Makefile       | 3 ++-
 sound/pci/emu10k1/emu10k1_main.c | 2 +-
 sound/pci/emu10k1/emuproc.c      | 2 --
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/pci/emu10k1/Makefile b/sound/pci/emu10k1/Makefile
index fc5591e7777e..29b44ca27010 100644
--- a/sound/pci/emu10k1/Makefile
+++ b/sound/pci/emu10k1/Makefile
@@ -5,7 +5,8 @@
 
 snd-emu10k1-objs := emu10k1.o emu10k1_main.o \
 		    irq.o memory.o voice.o emumpu401.o emupcm.o io.o \
-		    emuproc.o emumixer.o emufx.o timer.o p16v.o
+		    emumixer.o emufx.o timer.o p16v.o
+snd-emu10k1-$(CONFIG_SND_PROC_FS) += emuproc.o
 snd-emu10k1-synth-objs := emu10k1_synth.o emu10k1_callback.o emu10k1_patch.o
 snd-emu10k1x-objs := emu10k1x.o
 
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 54219fd662a1..28e2f8b42f5e 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -2063,7 +2063,7 @@ int snd_emu10k1_create(struct snd_card *card,
 	if (err < 0)
 		goto error;
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	snd_emu10k1_proc_init(emu);
 #endif
 
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index 53745f4c2bf5..cf05229b569b 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -34,7 +34,6 @@
 #include <sound/emu10k1.h>
 #include "p16v.h"
 
-#ifdef CONFIG_PROC_FS
 static void snd_emu10k1_proc_spdif_status(struct snd_emu10k1 * emu,
 					  struct snd_info_buffer *buffer,
 					  char *title,
@@ -656,4 +655,3 @@ int snd_emu10k1_proc_init(struct snd_emu10k1 *emu)
 	}
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
-- 
2.4.2
