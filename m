From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH 3/3] ucm: fix inappropriate use of const
Date: Tue, 10 Feb 2015 22:42:34 +0200
Message-ID: <1423600954-8751-4-git-send-email-tanu.kaskinen@linux.intel.com>
References: <1423600954-8751-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DC8EE26057A
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 21:42:45 +0100 (CET)
In-Reply-To: <1423600954-8751-1-git-send-email-tanu.kaskinen@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The caller is expected to free the string returned by
snd_use_case_get(), but for some reason the string is marked as const,
so the caller is forced to do type casting to get rid of compiler
warnings. I don't see any reason for using const in snd_use_case_get(),
so let's remove that.

This will cause warnings in application code, if applications
currently pass const variables to the function, which they very likely
do. I don't know if that's acceptable. If not, then it's too late to
fix this bug...
---
 include/use-case.h |  2 +-
 src/ucm/main.c     | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/use-case.h b/include/use-case.h
index f30168f..28d786f 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -286,7 +286,7 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  */
 int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                      const char *identifier,
-                     const char **value);
+                     char **value);
 
 /**
  * \brief Get current - integer
diff --git a/src/ucm/main.c b/src/ucm/main.c
index 62bc374..8fbf94f 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -40,9 +40,9 @@
  * misc
  */
 
-static int get_value1(const char **value, struct list_head *value_list,
+static int get_value1(char **value, struct list_head *value_list,
                       const char *identifier);
-static int get_value3(const char **value,
+static int get_value3(char **value,
 		      const char *identifier,
 		      struct list_head *value_list1,
 		      struct list_head *value_list2,
@@ -299,7 +299,7 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 		case SEQUENCE_ELEMENT_TYPE_CSET:
 		case SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE:
 			if (cdev == NULL) {
-				const char *cdev1 = NULL, *cdev2 = NULL;
+				char *cdev1 = NULL, *cdev2 = NULL;
 				err = get_value3(&cdev1, "PlaybackCTL",
 						 value_list1,
 						 value_list2,
@@ -313,7 +313,7 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 						 value_list2,
 						 value_list3);
 				if (err < 0 && err != ENOENT) {
-					free((char *)cdev1);
+					free(cdev1);
 					uc_error("cdev is not defined!");
 					return err;
 				}
@@ -327,11 +327,11 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
                                  * before calling open_ctl()). */
 				if (cdev1 == NULL || cdev2 == NULL ||
                                     strcmp(cdev1, cdev2) == 0) {
-					cdev = (char *)cdev1;
-					free((char *)cdev2);
+					cdev = cdev1;
+					free(cdev2);
 				} else {
-					free((char *)cdev1);
-					free((char *)cdev2);
+					free(cdev1);
+					free(cdev2);
 				}
 			}
 			if (ctl == NULL) {
@@ -1233,7 +1233,7 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
 	return err;
 }
 
-static int get_value1(const char **value, struct list_head *value_list,
+static int get_value1(char **value, struct list_head *value_list,
                       const char *identifier)
 {
         struct ucm_value *val;
@@ -1254,7 +1254,7 @@ static int get_value1(const char **value, struct list_head *value_list,
         return -ENOENT;
 }
 
-static int get_value3(const char **value,
+static int get_value3(char **value,
 		      const char *identifier,
 		      struct list_head *value_list1,
 		      struct list_head *value_list2,
@@ -1284,7 +1284,7 @@ static int get_value3(const char **value,
  */
 static int get_value(snd_use_case_mgr_t *uc_mgr,
 			const char *identifier,
-			const char **value,
+			char **value,
 			const char *mod_dev_name,
 			const char *verb_name,
 			int exact)
@@ -1354,7 +1354,7 @@ static int get_value(snd_use_case_mgr_t *uc_mgr,
  */      
 int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
 		     const char *identifier,
-		     const char **value)
+		     char **value)
 {
 	const char *slash1, *slash2, *mod_dev_after;
 	const char *ident, *mod_dev, *verb;
-- 
1.9.3
