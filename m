From: Jerome Forissier <jerome@taodyne.com>
Subject: [PATCH 2/3] snd_device_name_hint(): do not change the
	global error handler.
Date: Thu, 31 Jan 2013 15:47:24 +0100
Message-ID: <1359643645-33558-3-git-send-email-jerome@taodyne.com>
References: <1359643645-33558-1-git-send-email-jerome@taodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ubuntu (102.30.7.109.rev.sfr.net [109.7.30.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 141872615A1
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 15:47:34 +0100 (CET)
In-Reply-To: <1359643645-33558-1-git-send-email-jerome@taodyne.com>
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
Cc: Jerome Forissier <jerome@taodyne.com>
List-Id: alsa-devel@alsa-project.org

This is the first step towards making this function reentrant.

Signed-off-by: Jerome Forissier <jerome@taodyne.com>
---
 src/control/namehint.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 19352be..defc036 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -80,7 +80,8 @@ static void zero_handler(const char *file ATTRIBUTE_UNUSED,
 			 int line ATTRIBUTE_UNUSED,
 			 const char *function ATTRIBUTE_UNUSED,
 			 int err ATTRIBUTE_UNUSED,
-			 const char *fmt ATTRIBUTE_UNUSED, ...)
+			 const char *fmt ATTRIBUTE_UNUSED,
+			 va_list arg ATTRIBUTE_UNUSED)
 {
 }
 
@@ -212,7 +213,7 @@ static int try_config(struct hint_list *list,
 		      const char *base,
 		      const char *name)
 {
-	snd_lib_error_handler_t eh;
+	snd_local_error_handler_t eh;
 	snd_config_t *res = NULL, *cfg, *cfg1, *n;
 	snd_config_iterator_t i, next;
 	char *buf, *buf1 = NULL, *buf2;
@@ -239,10 +240,9 @@ static int try_config(struct hint_list *list,
 		sprintf(buf, "%s:CARD=%s", name, snd_ctl_card_info_get_id(list->info));
 	else
 		strcpy(buf, name);
-	eh = snd_lib_error;
-	snd_lib_error_set_handler(&zero_handler);
+	eh = snd_lib_error_set_local(&zero_handler);
 	err = snd_config_search_definition(snd_config, base, buf, &res);
-	snd_lib_error_set_handler(eh);
+	snd_lib_error_set_local(eh);
 	if (err < 0)
 		goto __skip_add;
 	cleanup_res = 1;
@@ -337,10 +337,9 @@ static int try_config(struct hint_list *list,
 		goto __ok;
 	/* find, if all parameters have a default, */
 	/* otherwise filter this definition */
-	eh = snd_lib_error;
-	snd_lib_error_set_handler(&zero_handler);
+	eh = snd_lib_error_set_local(&zero_handler);
 	err = snd_config_search_alias_hooks(snd_config, base, buf, &res);
-	snd_lib_error_set_handler(eh);
+	snd_lib_error_set_local(eh);
 	if (err < 0)
 		goto __cleanup;
 	if (snd_config_search(res, "@args", &cfg) >= 0) {
-- 
1.8.1.2
