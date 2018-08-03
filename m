From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: isa: Remove empty init and exit
Date: Fri,  3 Aug 2018 16:33:35 +0200
Message-ID: <20180803143338.5363-4-tiwai@suse.de>
References: <20180803143338.5363-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B3F62677A8
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 16:33:43 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1C5ECAE59
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
 sound/isa/es1688/es1688_lib.c | 16 ----------------
 sound/isa/gus/gus_main.c      | 16 ----------------
 sound/isa/sb/sb16_csp.c       | 16 ----------------
 sound/isa/sb/sb16_main.c      | 16 ----------------
 sound/isa/sb/sb8_main.c       | 16 ----------------
 sound/isa/sb/sb_common.c      | 16 ----------------
 sound/isa/wss/wss_lib.c       | 16 ----------------
 7 files changed, 112 deletions(-)

diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index f9c0662e9a22..50cdce0e8946 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -1029,19 +1029,3 @@ EXPORT_SYMBOL(snd_es1688_mixer_write);
 EXPORT_SYMBOL(snd_es1688_create);
 EXPORT_SYMBOL(snd_es1688_pcm);
 EXPORT_SYMBOL(snd_es1688_mixer);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_es1688_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_es1688_exit(void)
-{
-}
-
-module_init(alsa_es1688_init)
-module_exit(alsa_es1688_exit)
diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index 3cf9b13c780a..3b8a0c880db5 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -465,19 +465,3 @@ EXPORT_SYMBOL(snd_gf1_mem_alloc);
 EXPORT_SYMBOL(snd_gf1_mem_xfree);
 EXPORT_SYMBOL(snd_gf1_mem_free);
 EXPORT_SYMBOL(snd_gf1_mem_lock);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_gus_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_gus_exit(void)
-{
-}
-
-module_init(alsa_gus_init)
-module_exit(alsa_gus_exit)
diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index b9d67a7065cd..bf3db0d2ea12 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -1185,19 +1185,3 @@ static void info_read(struct snd_info_entry *entry, struct snd_info_buffer *buff
 /* */
 
 EXPORT_SYMBOL(snd_sb_csp_new);
-
-/*
- * INIT part
- */
-
-static int __init alsa_sb_csp_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_sb_csp_exit(void)
-{
-}
-
-module_init(alsa_sb_csp_init)
-module_exit(alsa_sb_csp_exit)
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 11ed4a6e5bf1..37e6ce7b0b13 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -900,19 +900,3 @@ EXPORT_SYMBOL(snd_sb16dsp_pcm);
 EXPORT_SYMBOL(snd_sb16dsp_get_pcm_ops);
 EXPORT_SYMBOL(snd_sb16dsp_configure);
 EXPORT_SYMBOL(snd_sb16dsp_interrupt);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_sb16_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_sb16_exit(void)
-{
-}
-
-module_init(alsa_sb16_init)
-module_exit(alsa_sb16_exit)
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 80e7dcaa551f..481797744b3c 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -621,19 +621,3 @@ EXPORT_SYMBOL(snd_sb8dsp_interrupt);
   /* sb8_midi.c */
 EXPORT_SYMBOL(snd_sb8dsp_midi_interrupt);
 EXPORT_SYMBOL(snd_sb8dsp_midi);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_sb8_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_sb8_exit(void)
-{
-}
-
-module_init(alsa_sb8_init)
-module_exit(alsa_sb8_exit)
diff --git a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
index 787a4ade4afd..90b254aaef74 100644
--- a/sound/isa/sb/sb_common.c
+++ b/sound/isa/sb/sb_common.c
@@ -305,19 +305,3 @@ EXPORT_SYMBOL(snd_sbmixer_add_ctl);
 EXPORT_SYMBOL(snd_sbmixer_suspend);
 EXPORT_SYMBOL(snd_sbmixer_resume);
 #endif
-
-/*
- *  INIT part
- */
-
-static int __init alsa_sb_common_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_sb_common_exit(void)
-{
-}
-
-module_init(alsa_sb_common_init)
-module_exit(alsa_sb_common_exit)
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index d23cc8abe1ef..32453f81b95a 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -2279,19 +2279,3 @@ const struct snd_pcm_ops *snd_wss_get_pcm_ops(int direction)
 		&snd_wss_playback_ops : &snd_wss_capture_ops;
 }
 EXPORT_SYMBOL(snd_wss_get_pcm_ops);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_wss_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_wss_exit(void)
-{
-}
-
-module_init(alsa_wss_init);
-module_exit(alsa_wss_exit);
-- 
2.18.0
