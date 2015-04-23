From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/8] ALSA: core: Clean up OSS proc file
	management
Date: Thu, 23 Apr 2015 16:49:30 +0200
Message-ID: <1429800570-10153-9-git-send-email-tiwai@suse.de>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C8EE265AA1
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2EDA9AD76
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

A few minor cleanups:
- Move the call of snd_info_minor_register() into snd_info_init() so
  that we can call all proc-related stuff in a shot
- Add missing __init prefix to snd_info_minor_register()
- Return an error properly from snd_oss_info_register()
- Drop snd_info_minor_unregister() that is superfluous now

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/info.h  |  4 +---
 sound/core/info.c     |  3 ++-
 sound/core/info_oss.c | 25 +++++++------------------
 sound/core/sound.c    |  2 --
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index 3e2fda3c75ee..16269951bafc 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -94,10 +94,8 @@ struct snd_info_entry {
 
 #if defined(CONFIG_SND_OSSEMUL) && defined(CONFIG_PROC_FS)
 int snd_info_minor_register(void);
-int snd_info_minor_unregister(void);
 #else
-#define snd_info_minor_register() /* NOP */
-#define snd_info_minor_unregister() /* NOP */
+#define snd_info_minor_register()	0
 #endif
 
 
diff --git a/sound/core/info.c b/sound/core/info.c
index f8bdd9b6f322..c8a413d6cc9b 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -479,7 +479,8 @@ int __init snd_info_init(void)
 	if (snd_info_version_init() < 0 ||
 	    snd_minor_info_init() < 0 ||
 	    snd_minor_info_oss_init() < 0 ||
-	    snd_card_info_init() < 0)
+	    snd_card_info_init() < 0 ||
+	    snd_info_minor_register() < 0)
 		goto error;
 	return 0;
 
diff --git a/sound/core/info_oss.c b/sound/core/info_oss.c
index bd4d2c6233c2..1478c8dfd473 100644
--- a/sound/core/info_oss.c
+++ b/sound/core/info_oss.c
@@ -35,7 +35,6 @@
 
 static DEFINE_MUTEX(strings);
 static char *snd_sndstat_strings[SNDRV_CARDS][SNDRV_OSS_INFO_DEV_COUNT];
-static struct snd_info_entry *snd_sndstat_proc_entry;
 
 int snd_oss_info_register(int dev, int num, char *string)
 {
@@ -110,25 +109,15 @@ static void snd_sndstat_proc_read(struct snd_info_entry *entry,
 	snd_sndstat_show_strings(buffer, "Mixers", SNDRV_OSS_INFO_DEV_MIXERS);
 }
 
-int snd_info_minor_register(void)
+int __init snd_info_minor_register(void)
 {
 	struct snd_info_entry *entry;
 
 	memset(snd_sndstat_strings, 0, sizeof(snd_sndstat_strings));
-	if ((entry = snd_info_create_module_entry(THIS_MODULE, "sndstat", snd_oss_root)) != NULL) {
-		entry->c.text.read = snd_sndstat_proc_read;
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			entry = NULL;
-		}
-	}
-	snd_sndstat_proc_entry = entry;
-	return 0;
-}
-
-int snd_info_minor_unregister(void)
-{
-	snd_info_free_entry(snd_sndstat_proc_entry);
-	snd_sndstat_proc_entry = NULL;
-	return 0;
+	entry = snd_info_create_module_entry(THIS_MODULE, "sndstat",
+					     snd_oss_root);
+	if (!entry)
+		return -ENOMEM;
+	entry->c.text.read = snd_sndstat_proc_read;
+	return snd_info_register(entry); /* freed in error path */
 }
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 8fc402e4ff35..e5d37bd7c226 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -409,7 +409,6 @@ static int __init alsa_sound_init(void)
 		unregister_chrdev(major, "alsa");
 		return -ENOMEM;
 	}
-	snd_info_minor_register();
 #ifndef MODULE
 	pr_info("Advanced Linux Sound Architecture Driver Initialized.\n");
 #endif
@@ -418,7 +417,6 @@ static int __init alsa_sound_init(void)
 
 static void __exit alsa_sound_exit(void)
 {
-	snd_info_minor_unregister();
 	snd_info_done();
 	unregister_chrdev(major, "alsa");
 }
-- 
2.3.5
