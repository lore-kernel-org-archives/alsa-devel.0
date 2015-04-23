From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ALSA: core: Remove superfluous exit calls
	for proc entries
Date: Thu, 23 Apr 2015 16:49:27 +0200
Message-ID: <1429800570-10153-6-git-send-email-tiwai@suse.de>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 59089262607
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 20C37AD50
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

Since each proc entry is freed automatically by the parent, we don't
have to take care of its life cycle any longer.  This allows us to
reduce a few more lines of codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h   |  4 ----
 sound/core/info.c      |  3 ---
 sound/core/init.c      | 17 -----------------
 sound/core/sound.c     | 10 ----------
 sound/core/sound_oss.c | 14 +-------------
 5 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index b12931f513f4..cdfecafff0f4 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -224,16 +224,13 @@ void *snd_lookup_oss_minor_data(unsigned int minor, int type);
 #endif
 
 int snd_minor_info_init(void);
-int snd_minor_info_done(void);
 
 /* sound_oss.c */
 
 #ifdef CONFIG_SND_OSSEMUL
 int snd_minor_info_oss_init(void);
-int snd_minor_info_oss_done(void);
 #else
 static inline int snd_minor_info_oss_init(void) { return 0; }
-static inline int snd_minor_info_oss_done(void) { return 0; }
 #endif
 
 /* memory.c */
@@ -262,7 +259,6 @@ int snd_card_free_when_closed(struct snd_card *card);
 void snd_card_set_id(struct snd_card *card, const char *id);
 int snd_card_register(struct snd_card *card);
 int snd_card_info_init(void);
-int snd_card_info_done(void);
 int snd_card_add_dev_attr(struct snd_card *card,
 			  const struct attribute_group *group);
 int snd_component_add(struct snd_card *card, const char *component);
diff --git a/sound/core/info.c b/sound/core/info.c
index 55c626eeb061..339f90a3aa29 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -495,9 +495,6 @@ int __init snd_info_init(void)
 
 int __exit snd_info_done(void)
 {
-	snd_card_info_done();
-	snd_minor_info_oss_done();
-	snd_minor_info_done();
 	snd_info_free_entry(snd_proc_root);
 	return 0;
 }
diff --git a/sound/core/init.c b/sound/core/init.c
index 04734e047bfe..0af34fac0499 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -783,8 +783,6 @@ int snd_card_register(struct snd_card *card)
 EXPORT_SYMBOL(snd_card_register);
 
 #ifdef CONFIG_PROC_FS
-static struct snd_info_entry *snd_card_info_entry;
-
 static void snd_card_info_read(struct snd_info_entry *entry,
 			       struct snd_info_buffer *buffer)
 {
@@ -810,7 +808,6 @@ static void snd_card_info_read(struct snd_info_entry *entry,
 }
 
 #ifdef CONFIG_SND_OSSEMUL
-
 void snd_card_info_read_oss(struct snd_info_buffer *buffer)
 {
 	int idx, count;
@@ -832,7 +829,6 @@ void snd_card_info_read_oss(struct snd_info_buffer *buffer)
 #endif
 
 #ifdef MODULE
-static struct snd_info_entry *snd_card_module_info_entry;
 static void snd_card_module_info_read(struct snd_info_entry *entry,
 				      struct snd_info_buffer *buffer)
 {
@@ -861,7 +857,6 @@ int __init snd_card_info_init(void)
 		snd_info_free_entry(entry);
 		return -ENOMEM;
 	}
-	snd_card_info_entry = entry;
 
 #ifdef MODULE
 	entry = snd_info_create_module_entry(THIS_MODULE, "modules", NULL);
@@ -869,23 +864,11 @@ int __init snd_card_info_init(void)
 		entry->c.text.read = snd_card_module_info_read;
 		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-		else
-			snd_card_module_info_entry = entry;
 	}
 #endif
 
 	return 0;
 }
-
-int __exit snd_card_info_done(void)
-{
-	snd_info_free_entry(snd_card_info_entry);
-#ifdef MODULE
-	snd_info_free_entry(snd_card_module_info_entry);
-#endif
-	return 0;
-}
-
 #endif /* CONFIG_PROC_FS */
 
 /**
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 5fc93d00572a..d584944c8fe5 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -334,9 +334,6 @@ EXPORT_SYMBOL(snd_unregister_device);
 /*
  *  INFO PART
  */
-
-static struct snd_info_entry *snd_minor_info_entry;
-
 static const char *snd_device_type_name(int type)
 {
 	switch (type) {
@@ -396,13 +393,6 @@ int __init snd_minor_info_init(void)
 			entry = NULL;
 		}
 	}
-	snd_minor_info_entry = entry;
-	return 0;
-}
-
-int __exit snd_minor_info_done(void)
-{
-	snd_info_free_entry(snd_minor_info_entry);
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 573a65eb2b79..5fc3c6534225 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -214,9 +214,6 @@ EXPORT_SYMBOL(snd_unregister_oss_device);
  */
 
 #ifdef CONFIG_PROC_FS
-
-static struct snd_info_entry *snd_minor_info_oss_entry;
-
 static const char *snd_oss_device_type_name(int type)
 {
 	switch (type) {
@@ -265,18 +262,9 @@ int __init snd_minor_info_oss_init(void)
 	entry = snd_info_create_module_entry(THIS_MODULE, "devices", snd_oss_root);
 	if (entry) {
 		entry->c.text.read = snd_minor_info_oss_read;
-		if (snd_info_register(entry) < 0) {
+		if (snd_info_register(entry) < 0)
 			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
-	snd_minor_info_oss_entry = entry;
-	return 0;
-}
-
-int __exit snd_minor_info_oss_done(void)
-{
-	snd_info_free_entry(snd_minor_info_oss_entry);
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
-- 
2.3.5
