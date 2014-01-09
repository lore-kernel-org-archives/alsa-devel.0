From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: Merge memalloc code into snd-pcm
	module
Date: Thu,  9 Jan 2014 10:14:54 +0100
Message-ID: <1389258894-27940-2-git-send-email-tiwai@suse.de>
References: <1389258894-27940-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E78C26515C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 10:14:55 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0F61EAC43
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 09:14:55 +0000 (UTC)
In-Reply-To: <1389258894-27940-1-git-send-email-tiwai@suse.de>
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

Instead of keeping a separate snd-page-alloc module, merge into the
core snd-pcm module, as we don't need to keep it as an individual
module due to the drop of page reservation.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/Makefile   | 10 ++++------
 sound/core/memalloc.c | 10 ----------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/core/Makefile b/sound/core/Makefile
index 5e890cfed423..394a38909f6b 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -10,14 +10,12 @@ snd-$(CONFIG_SND_VMASTER) += vmaster.o
 snd-$(CONFIG_SND_KCTL_JACK) += ctljack.o
 snd-$(CONFIG_SND_JACK)	  += jack.o
 
-snd-pcm-objs := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
-		pcm_memory.o
+snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
+		pcm_memory.o memalloc.o
+snd-pcm-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
 
 snd-pcm-dmaengine-objs := pcm_dmaengine.o
 
-snd-page-alloc-y := memalloc.o
-snd-page-alloc-$(CONFIG_SND_DMA_SGBUF) += sgbuf.o
-
 snd-rawmidi-objs  := rawmidi.o
 snd-timer-objs    := timer.o
 snd-hrtimer-objs  := hrtimer.o
@@ -31,7 +29,7 @@ obj-$(CONFIG_SND_HWDEP)		+= snd-hwdep.o
 obj-$(CONFIG_SND_TIMER)		+= snd-timer.o
 obj-$(CONFIG_SND_HRTIMER)	+= snd-hrtimer.o
 obj-$(CONFIG_SND_RTCTIMER)	+= snd-rtctimer.o
-obj-$(CONFIG_SND_PCM)		+= snd-pcm.o snd-page-alloc.o
+obj-$(CONFIG_SND_PCM)		+= snd-pcm.o
 obj-$(CONFIG_SND_DMAENGINE_PCM)	+= snd-pcm-dmaengine.o
 obj-$(CONFIG_SND_RAWMIDI)	+= snd-rawmidi.o
 
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index e568c14ca88d..4595f93d151e 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -21,22 +21,12 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
-#include <asm/uaccess.h>
 #include <linux/dma-mapping.h>
 #include <linux/genalloc.h>
-#include <linux/moduleparam.h>
 #include <sound/memalloc.h>
 
-
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>");
-MODULE_DESCRIPTION("Memory allocator for ALSA system.");
-MODULE_LICENSE("GPL");
-
-
 /*
  *
  *  Generic memory allocators
-- 
1.8.5.2
