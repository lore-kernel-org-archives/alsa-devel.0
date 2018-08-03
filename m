From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: synth: Remove empty init and exit
Date: Fri,  3 Aug 2018 16:33:38 +0200
Message-ID: <20180803143338.5363-7-tiwai@suse.de>
References: <20180803143338.5363-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5CF2677CD
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 16:33:45 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3614FAF9D
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 14:33:43 +0000 (UTC)
In-Reply-To: <20180803143338.5363-1-tiwai@suse.de>
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

For a sake of code simplification, remove the init and the exit
entries that do nothing.

Notes for readers: actually it's OK to remove *both* init and exit,
but not OK to remove the exit entry.  By removing only the exit while
keeping init, the module becomes permanently loaded; i.e. you cannot
unload it any longer!

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/synth/emux/emux.c | 17 -----------------
 sound/synth/util_mem.c  | 16 ----------------
 2 files changed, 33 deletions(-)

diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index b840ff2dcfbb..64f3141a3e1b 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -163,20 +163,3 @@ int snd_emux_free(struct snd_emux *emu)
 }
 
 EXPORT_SYMBOL(snd_emux_free);
-
-
-/*
- *  INIT part
- */
-
-static int __init alsa_emux_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_emux_exit(void)
-{
-}
-
-module_init(alsa_emux_init)
-module_exit(alsa_emux_exit)
diff --git a/sound/synth/util_mem.c b/sound/synth/util_mem.c
index 8e34bc4e07ec..4bd1e98200d2 100644
--- a/sound/synth/util_mem.c
+++ b/sound/synth/util_mem.c
@@ -193,19 +193,3 @@ EXPORT_SYMBOL(snd_util_mem_avail);
 EXPORT_SYMBOL(__snd_util_mem_alloc);
 EXPORT_SYMBOL(__snd_util_mem_free);
 EXPORT_SYMBOL(__snd_util_memblk_new);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_util_mem_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_util_mem_exit(void)
-{
-}
-
-module_init(alsa_util_mem_init)
-module_exit(alsa_util_mem_exit)
-- 
2.18.0
