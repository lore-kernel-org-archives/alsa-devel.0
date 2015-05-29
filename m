From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/10] ALSA: cs46xx: Fix old ifdef
	CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:08 +0200
Message-ID: <1432879571-3359-8-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D7092666DB
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3DDAAAD5C
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

Replaced with the new CONFIG_SND_PROC_FS.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cs46xx/cs46xx_lib.c       | 4 ++--
 sound/pci/cs46xx/cs46xx_lib.h       | 4 ++--
 sound/pci/cs46xx/dsp_spos.c         | 4 ++--
 sound/pci/cs46xx/dsp_spos_scb_lib.c | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 8d74004b1ed2..2a9f4a345171 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2816,7 +2816,7 @@ int snd_cs46xx_gameport(struct snd_cs46xx *chip) { return -ENOSYS; }
 static inline void snd_cs46xx_remove_gameport(struct snd_cs46xx *chip) { }
 #endif /* CONFIG_GAMEPORT */
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  *  proc interface
  */
@@ -2865,7 +2865,7 @@ static int snd_cs46xx_proc_done(struct snd_cs46xx *chip)
 #endif
 	return 0;
 }
-#else /* !CONFIG_PROC_FS */
+#else /* !CONFIG_SND_PROC_FS */
 #define snd_cs46xx_proc_init(card, chip)
 #define snd_cs46xx_proc_done(chip)
 #endif
diff --git a/sound/pci/cs46xx/cs46xx_lib.h b/sound/pci/cs46xx/cs46xx_lib.h
index 86f14620f817..bdf4114167ea 100644
--- a/sound/pci/cs46xx/cs46xx_lib.h
+++ b/sound/pci/cs46xx/cs46xx_lib.h
@@ -95,7 +95,7 @@ int cs46xx_dsp_resume(struct snd_cs46xx * chip);
 #endif
 struct dsp_symbol_entry *cs46xx_dsp_lookup_symbol (struct snd_cs46xx * chip, char * symbol_name,
 						   int symbol_type);
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip);
 int cs46xx_dsp_proc_done (struct snd_cs46xx *chip);
 #else
@@ -118,7 +118,7 @@ int cs46xx_dsp_disable_adc_capture (struct snd_cs46xx *chip);
 int cs46xx_poke_via_dsp (struct snd_cs46xx *chip, u32 address, u32 data);
 struct dsp_scb_descriptor * cs46xx_dsp_create_scb (struct snd_cs46xx *chip, char * name,
 						   u32 * scb_data, u32 dest);
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 void cs46xx_dsp_proc_free_scb_desc (struct dsp_scb_descriptor * scb);
 void cs46xx_dsp_proc_register_scb_desc (struct snd_cs46xx *chip,
 					struct dsp_scb_descriptor * scb);
diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index 5c99efb004c0..d2951ed4bf71 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -476,7 +476,7 @@ cs46xx_dsp_lookup_symbol (struct snd_cs46xx * chip, char * symbol_name, int symb
 }
 
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static struct dsp_symbol_entry *
 cs46xx_dsp_lookup_symbol_addr (struct snd_cs46xx * chip, u32 address, int symbol_type)
 {
@@ -929,7 +929,7 @@ int cs46xx_dsp_proc_done (struct snd_cs46xx *chip)
 
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 static void _dsp_create_task_tree (struct snd_cs46xx *chip, u32 * task_data,
 				   u32  dest, int size)
diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index 2c90c0bded69..7488e1b7a770 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -67,7 +67,7 @@ static void remove_symbol (struct snd_cs46xx * chip, struct dsp_symbol_entry * s
 
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static void cs46xx_dsp_proc_scb_info_read (struct snd_info_entry *entry,
 					   struct snd_info_buffer *buffer)
 {
@@ -228,7 +228,7 @@ void cs46xx_dsp_remove_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor *
 }
 
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 void cs46xx_dsp_proc_free_scb_desc (struct dsp_scb_descriptor * scb)
 {
 	if (scb->proc_info) {
@@ -285,7 +285,7 @@ out:
 		scb->proc_info = entry;
 	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 static struct dsp_scb_descriptor * 
 _dsp_create_generic_scb (struct snd_cs46xx *chip, char * name, u32 * scb_data, u32 dest,
-- 
2.4.2
