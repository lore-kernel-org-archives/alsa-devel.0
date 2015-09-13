From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: pcm: remove structure member of 'struct
	snd_pcm_hwptr_log *' type because this structure had been removed
Date: Sun, 13 Sep 2015 19:00:05 +0900
Message-ID: <1442138405-7498-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9195D260410
 for <alsa-devel@alsa-project.org>; Sun, 13 Sep 2015 12:00:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This structure was added by 4d96eb255c53 ('ALSA: pcm_lib - add possibility
to log last 10 DMA ring buffer positions') to store PCM pointers
information of latest 10 pointer movements (=XRUN_LOG_CNT). When
CONFIG_SND_PCM_XRUN_DEBUG is configured, 'struct snd_pcm_runtime' has
'hwptr_log' member with a pointer to the structure. When calling
xrun_log() in pcm_lib.c, the structure was allocated to the pointer.
When calling snd_pcm_detach_substream() in pcm.c, the allocated pointer
is released.

In f5914908a5b7 ('ALSA: pcm: Replace PCM hwptr tracking with tracepoints'),
the pointer logging is replaced with using Linux Kernel Tracepoints. The
structure was also removed, while it's just declared. The member and kfree
still remains.

This commit removes the member and related codes. I think this was
overlooked because it brings no errors/warnings to C compilers.

Fixes: f5914908a5b7 ('ALSA: pcm: Replace PCM hwptr tracking with tracepoints')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h | 6 ------
 sound/core/pcm.c    | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 691e7ee..a4fcc94 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -285,8 +285,6 @@ struct snd_pcm_hw_constraint_ranges {
 	unsigned int mask;
 };
 
-struct snd_pcm_hwptr_log;
-
 /*
  * userspace-provided audio timestamp config to kernel,
  * structure is for internal use only and filled with dedicated unpack routine
@@ -428,10 +426,6 @@ struct snd_pcm_runtime {
 	/* -- OSS things -- */
 	struct snd_pcm_oss_runtime oss;
 #endif
-
-#ifdef CONFIG_SND_PCM_XRUN_DEBUG
-	struct snd_pcm_hwptr_log *hwptr_log;
-#endif
 };
 
 struct snd_pcm_group {		/* keep linked substreams */
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 02bd969..308c9ec 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1014,9 +1014,6 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 	snd_free_pages((void*)runtime->control,
 		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control)));
 	kfree(runtime->hw_constraints.rules);
-#ifdef CONFIG_SND_PCM_XRUN_DEBUG
-	kfree(runtime->hwptr_log);
-#endif
 	kfree(runtime);
 	substream->runtime = NULL;
 	put_pid(substream->pid);
-- 
2.1.4
