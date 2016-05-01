From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH] conf: don't check if config files are up to
	date
Date: Sun,  1 May 2016 17:43:42 +0500
Message-ID: <1462106622-29461-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 23F542604DF
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2016 14:43:55 +0200 (CEST)
Received: by mail-wm0-f46.google.com with SMTP id a17so103916213wme.0
 for <alsa-devel@alsa-project.org>; Sun, 01 May 2016 05:43:55 -0700 (PDT)
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
Cc: tiwai@suse.de, tanuk@iki.fi, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Even if no files have been changed, the config may become outdated
due to hot-plugged devices.

Note: this patch has a huge potential to crash badly-written applications
that keep config pointers and strings for too long. But I see no other
way to support hot-pluggable devices.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=54029
Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/conf.c     | 63 ++++++++++++++++++++++++----------------------------------
 src/confmisc.c |  4 +++-
 2 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index f8b7a66..34576aa 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3661,14 +3661,15 @@ SND_DLSYM_BUILD_VERSION(snd_config_hook_load_for_all_cards, SND_CONFIG_DLSYM_VER
 #endif
 
 /** 
- * \brief Updates a configuration tree by rereading the configuration files (if needed).
+ * \brief Updates a configuration tree by rereading the configuration files.
  * \param[in,out] _top Address of the handle to the top-level node.
  * \param[in,out] _update Address of a pointer to private update information.
  * \param[in] cfgs A list of configuration file names, delimited with ':'.
  *                 If \p cfgs is \c NULL, the default global
  *                 configuration file is used.
- * \return 0 if \a _top was up to date, 1 if the configuration files
- *         have been reread, otherwise a negative error code.
+ * \return 0 if \a _top was up to date (this can happen only in previous
+ *                 ALSA-lib versions), 1 if the configuration files have been
+ *                 reread successfully, otherwise a negative error code.
  *
  * The variables pointed to by \a _top and \a _update can be initialized
  * to \c NULL before the first call to this function.  The private
@@ -3679,7 +3680,8 @@ SND_DLSYM_BUILD_VERSION(snd_config_hook_load_for_all_cards, SND_CONFIG_DLSYM_VER
  * The global configuration files are specified in the environment variable
  * \c ALSA_CONFIG_PATH.
  *
- * \warning If the configuration tree is reread, all string pointers and
+ * \warning In order to deal with hot-pluggable devices, the configuration
+ * tree is always reread, even if nothing changed. All string pointers and
  * configuration node handles previously obtained from this tree become
  * invalid.
  *
@@ -3754,35 +3756,6 @@ int snd_config_update_r(snd_config_t **_top, snd_config_update_t **_update, cons
 			local->count--;
 		}
 	}
-	if (!update)
-		goto _reread;
-	if (local->count != update->count)
-		goto _reread;
-	for (k = 0; k < local->count; ++k) {
-		struct finfo *lf = &local->finfo[k];
-		struct finfo *uf = &update->finfo[k];
-		if (strcmp(lf->name, uf->name) != 0 ||
-		    lf->dev != uf->dev ||
-		    lf->ino != uf->ino ||
-		    lf->mtime != uf->mtime)
-			goto _reread;
-	}
-	err = 0;
-
- _end:
-	if (err < 0) {
-		if (top) {
-			snd_config_delete(top);
-			*_top = NULL;
-		}
-		if (update) {
-			snd_config_update_free(update);
-			*_update = NULL;
-		}
-	}
-	if (local)
-		snd_config_update_free(local);
-	return err;
 
  _reread:
  	*_top = NULL;
@@ -3823,15 +3796,31 @@ int snd_config_update_r(snd_config_t **_top, snd_config_update_t **_update, cons
 	*_top = top;
 	*_update = local;
 	return 1;
+
+_end:
+	if (err < 0) {
+		if (top) {
+			snd_config_delete(top);
+			*_top = NULL;
+		}
+		if (update) {
+			snd_config_update_free(update);
+			*_update = NULL;
+		}
+	}
+	if (local)
+		snd_config_update_free(local);
+	return err;
 }
 
 /** 
- * \brief Updates #snd_config by rereading the global configuration files (if needed).
- * \return 0 if #snd_config was up to date, 1 if #snd_config was
- *         updated, otherwise a negative error code.
+ * \brief Updates #snd_config by rereading the global configuration files.
+ * \return 0 if #snd_config was up to date (this can happen only in previous
+ *         ALSA-lib versions), 1 if #snd_config was updated successfully,
+ *         otherwise a negative error code.
  *
  * \warning Whenever #snd_config is updated, all string pointers and
- * configuration node handles previously obtained from it may become
+ * configuration node handles previously obtained from it become
  * invalid.
  *
  * \par Errors:
diff --git a/src/confmisc.c b/src/confmisc.c
index ae0275f..8f97b72 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -599,7 +599,9 @@ static int open_ctl(long card, snd_ctl_t **ctl)
 	char name[16];
 	snprintf(name, sizeof(name), "hw:%li", card);
 	name[sizeof(name)-1] = '\0';
-	return snd_ctl_open(ctl, name, 0);
+
+	/* Take care not to update the config - we may be running hooks on pcms right now */
+	return snd_ctl_open_lconf(ctl, name, 0, snd_config);
 }
 
 #if 0
-- 
2.8.0
