From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/8] ALSA: core: Don't ignore errors at
	creating proc files
Date: Thu, 23 Apr 2015 16:49:28 +0200
Message-ID: <1429800570-10153-7-git-send-email-tiwai@suse.de>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8740D265A55
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 273D9AD5A
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

We ignore the errors at creating proc files in many places.  But they
should be rather treated seriously.

Also, by assuring the error handling, we can get rid of superfluous
snd_info_free_entry() calls as they will be removed by the parent in
the caller side.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c         | 15 ++++++---------
 sound/core/init.c         | 16 +++++++---------
 sound/core/seq/seq_info.c | 17 ++++++++++++++---
 sound/core/sound.c        | 12 ++++--------
 sound/core/sound_oss.c    | 10 ++++------
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 339f90a3aa29..4169062fabf5 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -482,10 +482,11 @@ int __init snd_info_init(void)
 	if (!snd_seq_root)
 		goto error;
 #endif
-	snd_info_version_init();
-	snd_minor_info_init();
-	snd_minor_info_oss_init();
-	snd_card_info_init();
+	if (snd_info_version_init() < 0 ||
+	    snd_minor_info_init() < 0 ||
+	    snd_minor_info_oss_init() < 0 ||
+	    snd_card_info_init() < 0)
+		goto error;
 	return 0;
 
  error:
@@ -847,11 +848,7 @@ static int __init snd_info_version_init(void)
 	if (entry == NULL)
 		return -ENOMEM;
 	entry->c.text.read = snd_info_version_read;
-	if (snd_info_register(entry) < 0) {
-		snd_info_free_entry(entry);
-		return -ENOMEM;
-	}
-	return 0;
+	return snd_info_register(entry); /* freed in error path */
 }
 
 #endif /* CONFIG_PROC_FS */
diff --git a/sound/core/init.c b/sound/core/init.c
index 0af34fac0499..769a783757ff 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -853,18 +853,16 @@ int __init snd_card_info_init(void)
 	if (! entry)
 		return -ENOMEM;
 	entry->c.text.read = snd_card_info_read;
-	if (snd_info_register(entry) < 0) {
-		snd_info_free_entry(entry);
-		return -ENOMEM;
-	}
+	if (snd_info_register(entry) < 0)
+		return -ENOMEM; /* freed in error path */
 
 #ifdef MODULE
 	entry = snd_info_create_module_entry(THIS_MODULE, "modules", NULL);
-	if (entry) {
-		entry->c.text.read = snd_card_module_info_read;
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
-	}
+	if (!entry)
+		return -ENOMEM;
+	entry->c.text.read = snd_card_module_info_read;
+	if (snd_info_register(entry) < 0)
+		return -ENOMEM; /* freed in error path */
 #endif
 
 	return 0;
diff --git a/sound/core/seq/seq_info.c b/sound/core/seq/seq_info.c
index acf7769419f0..d3c65e780e9e 100644
--- a/sound/core/seq/seq_info.c
+++ b/sound/core/seq/seq_info.c
@@ -51,6 +51,13 @@ create_info_entry(char *name, void (*read)(struct snd_info_entry *,
 	return entry;
 }
 
+static void free_info_entries(void)
+{
+	snd_info_free_entry(queues_entry);
+	snd_info_free_entry(clients_entry);
+	snd_info_free_entry(timer_entry);
+}
+
 /* create all our /proc entries */
 int __init snd_seq_info_init(void)
 {
@@ -59,14 +66,18 @@ int __init snd_seq_info_init(void)
 	clients_entry = create_info_entry("clients",
 					  snd_seq_info_clients_read);
 	timer_entry = create_info_entry("timer", snd_seq_info_timer_read);
+	if (!queues_entry || !clients_entry || !timer_entry)
+		goto error;
 	return 0;
+
+ error:
+	free_info_entries();
+	return -ENOMEM;
 }
 
 int __exit snd_seq_info_done(void)
 {
-	snd_info_free_entry(queues_entry);
-	snd_info_free_entry(clients_entry);
-	snd_info_free_entry(timer_entry);
+	free_info_entries();
 	return 0;
 }
 #endif
diff --git a/sound/core/sound.c b/sound/core/sound.c
index d584944c8fe5..8fc402e4ff35 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -386,14 +386,10 @@ int __init snd_minor_info_init(void)
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_module_entry(THIS_MODULE, "devices", NULL);
-	if (entry) {
-		entry->c.text.read = snd_minor_info_read;
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			entry = NULL;
-		}
-	}
-	return 0;
+	if (!entry)
+		return -ENOMEM;
+	entry->c.text.read = snd_minor_info_read;
+	return snd_info_register(entry); /* freed in error path */
 }
 #endif /* CONFIG_PROC_FS */
 
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 5fc3c6534225..56d2f409f1ef 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -260,12 +260,10 @@ int __init snd_minor_info_oss_init(void)
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_module_entry(THIS_MODULE, "devices", snd_oss_root);
-	if (entry) {
-		entry->c.text.read = snd_minor_info_oss_read;
-		if (snd_info_register(entry) < 0)
-			snd_info_free_entry(entry);
-	}
-	return 0;
+	if (!entry)
+		return -ENOMEM;
+	entry->c.text.read = snd_minor_info_oss_read;
+	return snd_info_register(entry); /* freed in error path */
 }
 #endif /* CONFIG_PROC_FS */
 
-- 
2.3.5
