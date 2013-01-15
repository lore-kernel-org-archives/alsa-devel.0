From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/20] ALSA: hda - Add snd_hda_get_int_hint()
	helper function
Date: Tue, 15 Jan 2013 12:05:46 +0100
Message-ID: <1358247947-13992-20-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DBD22265332
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id ADA16A5245
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

It'll be used in hda_generic.c, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_hwdep.c      | 20 ++++++++++++++++++++
 sound/pci/hda/hda_local.h      |  7 +++++++
 sound/pci/hda/patch_sigmatel.c | 22 ++++------------------
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 2dddf7f..ce67608 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -644,6 +644,26 @@ int snd_hda_get_bool_hint(struct hda_codec *codec, const char *key)
 }
 EXPORT_SYMBOL_HDA(snd_hda_get_bool_hint);
 
+int snd_hda_get_int_hint(struct hda_codec *codec, const char *key, int *valp)
+{
+	const char *p;
+	unsigned long val;
+	int ret;
+
+	mutex_lock(&codec->user_mutex);
+	p = snd_hda_get_hint(codec, key);
+	if (!p)
+		ret = -ENOENT;
+	else if (strict_strtoul(p, 0, &val))
+		ret = -EINVAL;
+	else {
+		*valp = val;
+		ret = 0;
+	}
+	mutex_unlock(&codec->user_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_HDA(snd_hda_get_int_hint);
 #endif /* CONFIG_SND_HDA_RECONFIG */
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index c09440d..9e6353a 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -618,6 +618,7 @@ static inline int snd_hda_hwdep_add_sysfs(struct hda_codec *codec)
 #ifdef CONFIG_SND_HDA_RECONFIG
 const char *snd_hda_get_hint(struct hda_codec *codec, const char *key);
 int snd_hda_get_bool_hint(struct hda_codec *codec, const char *key);
+int snd_hda_get_int_hint(struct hda_codec *codec, const char *key, int *valp);
 #else
 static inline
 const char *snd_hda_get_hint(struct hda_codec *codec, const char *key)
@@ -630,6 +631,12 @@ int snd_hda_get_bool_hint(struct hda_codec *codec, const char *key)
 {
 	return -ENOENT;
 }
+
+static inline
+int snd_hda_get_int_hint(struct hda_codec *codec, const char *key, int *valp)
+{
+	return -ENOENT;
+}
 #endif
 
 /*
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d3a81f1..9cc4cb9 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4295,24 +4295,10 @@ static void stac92xx_power_down(struct hda_codec *codec)
 static void stac_toggle_power_map(struct hda_codec *codec, hda_nid_t nid,
 				  int enable);
 
-static inline int get_int_hint(struct hda_codec *codec, const char *key,
-			       int *valp)
-{
-#ifdef CONFIG_SND_HDA_RECONFIG
-	const char *p;
-	mutex_lock(&codec->user_mutex);
-	p = snd_hda_get_hint(codec, key);
-	if (p) {
-		unsigned long val;
-		if (!strict_strtoul(p, 0, &val)) {
-			*valp = val;
-			mutex_unlock(&codec->user_mutex);
-			return 1;
-		}
-	}
-	mutex_unlock(&codec->user_mutex);
-#endif
-	return 0;
+static inline bool get_int_hint(struct hda_codec *codec, const char *key,
+				int *valp)
+{
+	return !snd_hda_get_int_hint(codec, key, valp);
 }
 
 /* override some hints from the hwdep entry */
-- 
1.8.1
