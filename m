From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] UCM: get: Implement 'exact' value retrieval
Date: Mon,  6 Jun 2011 14:16:57 -0600
Message-ID: <1307391417-3199-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E2882243E9
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 22:17:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

[=]<NAME>[/[<modifier>|</device>][/<verb>]]
- value identifier <NAME>
- Search starts at given modifier or device if any,
    else at a verb
- Search starts at given verb if any,
    else current verb
- Searches modifier/device, then verb, then defaults
- Specify a leading "=" to search only the exact
  device/modifier/verb specified, and not search
  through each object in turn.
- Examples:
    "PlaybackPCM/Play Music"
    "CapturePCM/SPDIF"
  From ValueDefaults only:
    "=Variable"
  From current active verb:
    "=Variable//"
  From verb "Verb":
    "=Variable//Verb"
  From "Modifier" in current active verb:
    "=Variable/Modifier/"
  From "Modifier" in "Verb":
    "=Variable/Modifier/Verb"

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/use-case.h |   30 +++++++++++---
 src/ucm/main.c     |  110 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 104 insertions(+), 36 deletions(-)

diff --git a/include/use-case.h b/include/use-case.h
index b346877..c37c842 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -230,12 +230,30 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *   NULL 		- return current card
  *   _verb		- return current verb
  *
- *   <NAME>[/<modifier>|</device>]
- *			- value identifier <NAME> for
- *			  given modifier or device
- * 			- Examples: "PlaybackPCM/Play Music",
- *				    "CapturePCM/SPDIF"
- * 
+ *   [=]<NAME>[/[<modifier>|</device>][/<verb>]]
+ *                      - value identifier <NAME>
+ *                      - Search starts at given modifier or device if any,
+ *                          else at a verb
+ *                      - Search starts at given verb if any,
+ *                          else current verb
+ *                      - Searches modifier/device, then verb, then defaults
+ *                      - Specify a leading "=" to search only the exact
+ *                        device/modifier/verb specified, and not search
+ *                        through each object in turn.
+ *                      - Examples:
+ *                          "PlaybackPCM/Play Music"
+ *                          "CapturePCM/SPDIF"
+ *                        From ValueDefaults only:
+ *                          "=Variable"
+ *                        From current active verb:
+ *                          "=Variable//"
+ *                        From verb "Verb":
+ *                          "=Variable//Verb"
+ *                        From "Modifier" in current active verb:
+ *                          "=Variable/Modifier/"
+ *                        From "Modifier" in "Verb":
+ *                          "=Variable/Modifier/Verb"
+ *
  * Recommended names for values:
  *   TQ			- Tone Quality
  *   PlaybackPCM	- full PCM playback device name
diff --git a/src/ucm/main.c b/src/ucm/main.c
index 13ea1ed..8e9a85d 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1174,35 +1174,60 @@ static int get_value3(const char **value,
 static int get_value(snd_use_case_mgr_t *uc_mgr,
 			const char *identifier,
 			const char **value,
-			const char *item)
+			const char *mod_dev_name,
+			const char *verb_name,
+			int exact)
 {
+	struct use_case_verb *verb;
 	struct use_case_modifier *mod;
 	struct use_case_device *dev;
 	int err;
 
-	if (!uc_mgr->active_verb)
-		return -ENOENT;
-
-	if (item != NULL) {
-		mod = find_modifier(uc_mgr, uc_mgr->active_verb, item, 0);
-		if (mod != NULL) {
-			err = get_value1(value, &mod->value_list, identifier);
-			if (err >= 0 || err != -ENOENT)
-				return err;
+	if (mod_dev_name || verb_name || !exact) {
+		if (verb_name && strlen(verb_name)) {
+			verb = find_verb(uc_mgr, verb_name);
+		} else {
+			verb = uc_mgr->active_verb;
 		}
-		dev = find_device(uc_mgr, uc_mgr->active_verb, item, 0);
-		if (dev != NULL) {
-			err = get_value1(value, &dev->value_list, identifier);
+		if (verb) {
+			if (mod_dev_name) {
+				mod = find_modifier(uc_mgr, verb,
+						    mod_dev_name, 0);
+				if (mod) {
+					err = get_value1(value,
+							 &mod->value_list,
+							 identifier);
+					if (err >= 0 || err != -ENOENT)
+						return err;
+				}
+
+				dev = find_device(uc_mgr, verb,
+						  mod_dev_name, 0);
+				if (dev) {
+					err = get_value1(value,
+							 &dev->value_list,
+							 identifier);
+					if (err >= 0 || err != -ENOENT)
+						return err;
+				}
+
+				if (exact)
+					return -ENOENT;
+			}
+
+			err = get_value1(value, &verb->value_list, identifier);
 			if (err >= 0 || err != -ENOENT)
 				return err;
 		}
+
+		if (exact)
+			return -ENOENT;
 	}
-	err = get_value1(value, &uc_mgr->active_verb->value_list, identifier);
-	if (err >= 0 || err != -ENOENT)
-		return err;
+
 	err = get_value1(value, &uc_mgr->value_list, identifier);
 	if (err >= 0 || err != -ENOENT)
 		return err;
+
 	return -ENOENT;
 }
 
@@ -1220,7 +1245,9 @@ int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
 		     const char *identifier,
 		     const char **value)
 {
-        char *str, *str1;
+	const char *slash1, *slash2, *mod_dev_after;
+	const char *ident, *mod_dev, *verb;
+	int exact = 0;
         int err;
 
 	pthread_mutex_lock(&uc_mgr->mutex);
@@ -1246,19 +1273,42 @@ int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
 		err = -ENOENT;
 		goto __end;
         } else {
-                str1 = strchr(identifier, '/');
-                if (str1) {
-                        str = strdup(str1 + 1);
-                	if (str == NULL) {
-                  		err = -ENOMEM;
-                		goto __end;
-                        }
-                } else {
-                        str = NULL;
-                }
-                err = get_value(uc_mgr, identifier, value, str);
-                if (str)
-                        free(str);
+		if (identifier[0] == '=') {
+			exact = 1;
+			identifier++;
+		}
+
+		slash1 = strchr(identifier, '/');
+		if (slash1) {
+			ident = strndup(identifier, slash1 - identifier);
+
+			slash2 = strchr(slash1 + 1, '/');
+			if (slash2) {
+				mod_dev_after = slash2;
+				verb = slash2 + 1;
+			}
+			else {
+				mod_dev_after = slash1 + strlen(slash1);
+				verb = NULL;
+			}
+
+			if (mod_dev_after == slash1 + 1)
+				mod_dev = NULL;
+			else
+				mod_dev = strndup(slash1 + 1,
+						  mod_dev_after - (slash1 + 1));
+		}
+		else {
+			ident = identifier;
+			mod_dev = NULL;
+			verb = NULL;
+		}
+
+		err = get_value(uc_mgr, ident, value, mod_dev, verb, exact);
+		if (ident != identifier)
+			free((void *)ident);
+		if (mod_dev)
+			free((void *)mod_dev);
         }
       __end:
 	pthread_mutex_unlock(&uc_mgr->mutex);
-- 
1.7.0.4
