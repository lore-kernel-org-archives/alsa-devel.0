From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH 3/3] ucm: fix some variable constness issues
Date: Tue, 17 Feb 2015 21:15:23 +0200
Message-ID: <1424200523-6314-4-git-send-email-tanu.kaskinen@linux.intel.com>
References: <1424200523-6314-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F126261629
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 20:15:38 +0100 (CET)
In-Reply-To: <1424200523-6314-1-git-send-email-tanu.kaskinen@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

I submitted earlier a patch that made the value parameter of
snd_use_case_get() non-const, but as that changed the public API, the
patch couldn't be accepted. This is the same patch, modifying the
internal code so that there are fewer issues with constness, but the
public API is left alone (a comment was added to the function
documentation, though, so that hopefully nobody else will try to fix
the same unfixable problem).

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
---
 include/use-case.h |  5 +++--
 src/ucm/main.c     | 29 +++++++++++++++--------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/use-case.h b/include/use-case.h
index f30168f..697377a 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -224,8 +224,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  * \param value Value pointer
  * \return Zero if success, otherwise a negative error code
  *
- * Note: String is dynamically allocated, use free() to
- * deallocate this string.
+ * Note: The returned string is dynamically allocated, use free() to
+ * deallocate this string. (Yes, the value parameter shouldn't be marked as
+ * "const", but it's too late to fix it, sorry about that.)
  *
  * Known identifiers:
  *   NULL 		- return current card
diff --git a/src/ucm/main.c b/src/ucm/main.c
index 81a0950..7e44603 100644
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
@@ -299,8 +299,8 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 		case SEQUENCE_ELEMENT_TYPE_CSET:
 		case SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE:
 			if (cdev == NULL) {
-				const char *playback_ctl = NULL;
-				const char *capture_ctl = NULL;
+				char *playback_ctl = NULL;
+				char *capture_ctl = NULL;
 
 				err = get_value3(&playback_ctl, "PlaybackCTL",
 						 value_list1,
@@ -315,7 +315,7 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 						 value_list2,
 						 value_list3);
 				if (err < 0 && err != -ENOENT) {
-					free((char *)playback_ctl);
+					free(playback_ctl);
 					uc_error("cdev is not defined!");
 					return err;
 				}
@@ -327,16 +327,16 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 				if (playback_ctl != NULL &&
 				    capture_ctl != NULL &&
 				    strcmp(playback_ctl, capture_ctl) != 0) {
-					free((char *)playback_ctl);
-					free((char *)capture_ctl);
+					free(playback_ctl);
+					free(capture_ctl);
 					uc_error("cdev is not defined!");
 					return -EINVAL;
 				}
 				if (playback_ctl != NULL) {
-					cdev = (char *)playback_ctl;
-					free((char *)capture_ctl);
+					cdev = playback_ctl;
+					free(capture_ctl);
 				} else
-					cdev = (char *)capture_ctl;
+					cdev = capture_ctl;
 			}
 			if (ctl == NULL) {
 				err = open_ctl(uc_mgr, &ctl, cdev);
@@ -1237,7 +1237,7 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
 	return err;
 }
 
-static int get_value1(const char **value, struct list_head *value_list,
+static int get_value1(char **value, struct list_head *value_list,
                       const char *identifier)
 {
         struct ucm_value *val;
@@ -1258,7 +1258,7 @@ static int get_value1(const char **value, struct list_head *value_list,
         return -ENOENT;
 }
 
-static int get_value3(const char **value,
+static int get_value3(char **value,
 		      const char *identifier,
 		      struct list_head *value_list1,
 		      struct list_head *value_list2,
@@ -1288,7 +1288,7 @@ static int get_value3(const char **value,
  */
 static int get_value(snd_use_case_mgr_t *uc_mgr,
 			const char *identifier,
-			const char **value,
+			char **value,
 			const char *mod_dev_name,
 			const char *verb_name,
 			int exact)
@@ -1419,7 +1419,8 @@ int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
 			verb = NULL;
 		}
 
-		err = get_value(uc_mgr, ident, value, mod_dev, verb, exact);
+		err = get_value(uc_mgr, ident, (char **)value, mod_dev, verb,
+		                exact);
 		if (ident != identifier)
 			free((void *)ident);
 		if (mod_dev)
-- 
1.9.3
