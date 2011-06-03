From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 4/5] UCM: Allow querying of {Supported,
	Conflicting}Devices
Date: Fri,  3 Jun 2011 14:56:33 -0600
Message-ID: <1307134594-32176-4-git-send-email-swarren@nvidia.com>
References: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6330A10393D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 22:56:47 +0200 (CEST)
In-Reply-To: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
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

At any time, one can query:

_supporteddevs/<modifier>|<device>/<verb>
_conflictingdevs/<modifier>|<device>/<verb>

If a verb is current, one can query:

_supporteddevs/<modifier>|<device>
_conflictingdevs/<modifier>|<device>

Note that at most one of the supported/conflicting devs lists has
any entries, and when neither is present, all devices are supported.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/use-case.h |    5 ++
 src/ucm/main.c     |  106 +++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 97 insertions(+), 14 deletions(-)

diff --git a/include/use-case.h b/include/use-case.h
index cb3176e..b346877 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -205,6 +205,11 @@ int snd_use_case_free_list(const char *list[], int items);
  *   _enadevs		- get list of enabled devices
  *   _enamods		- get list of enabled modifiers
  *
+ *   _supporteddevs/<modifier>|<device>[/<verb>]   - list of supported devices
+ *   _conflictingdevs/<modifier>|<device>[/<verb>] - list of conflicting devices
+ *   Note that at most one of the supported/conflicting devs lists has
+ *   any entries, and when neither is present, all devices are supported.
+ *
  */
 int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
                           const char *identifier,
diff --git a/src/ucm/main.c b/src/ucm/main.c
index d319160..db71f03 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -515,11 +515,10 @@ static inline int is_device_supported(snd_use_case_mgr_t *uc_mgr,
  * \return structure on success, otherwise a NULL (not found)
  */
 static inline struct use_case_device *
-        find_device(snd_use_case_mgr_t *uc_mgr, const char *device_name,
-		    int check_supported)
+        find_device(snd_use_case_mgr_t *uc_mgr, struct use_case_verb *verb,
+		    const char *device_name, int check_supported)
 {
 	struct use_case_device *device;
-	struct use_case_verb *verb = uc_mgr->active_verb;
 	struct list_head *pos;
 
 	list_for_each(pos, &verb->device_list) {
@@ -544,11 +543,10 @@ static inline struct use_case_device *
  * \return structure on success, otherwise a NULL (not found)
  */
 static struct use_case_modifier *
-        find_modifier(snd_use_case_mgr_t *uc_mgr, const char *modifier_name,
-		      int check_supported)
+        find_modifier(snd_use_case_mgr_t *uc_mgr, struct use_case_verb *verb,
+		      const char *modifier_name, int check_supported)
 {
 	struct use_case_modifier *modifier;
-	struct use_case_verb *verb = uc_mgr->active_verb;
 	struct list_head *pos;
 
 	list_for_each(pos, &verb->modifier_list) {
@@ -857,6 +855,82 @@ static int get_modifier_list(snd_use_case_mgr_t *uc_mgr, const char **list[],
                          name, comment);
 }
 
+/**
+ * \brief Get list of supported/conflicting devices
+ * \param list Returned list
+ * \param name Name of modifier or verb to query
+ * \param type Type of device list entries to return
+ * \return Number of list entries if success, otherwise a negative error code
+ */
+static int get_supcon_device_list(snd_use_case_mgr_t *uc_mgr,
+				  const char **list[], char *name,
+				  enum dev_list_type type)
+{
+	char *str;
+	struct use_case_verb *verb;
+	struct use_case_modifier *modifier;
+	struct use_case_device *device;
+
+	if (!name)
+		return -ENOENT;
+
+	str = strchr(name, '/');
+	if (str) {
+		*str = '\0';
+		verb = find_verb(uc_mgr, str + 1);
+	}
+	else {
+		verb = uc_mgr->active_verb;
+	}
+	if (!verb)
+		return -ENOENT;
+
+	modifier = find_modifier(uc_mgr, verb, name, 0);
+	if (modifier) {
+		if (modifier->dev_list.type != type)
+			return 0;
+		return get_list(&modifier->dev_list.list, list,
+				struct dev_list_node, list,
+				name);
+	}
+
+	device = find_device(uc_mgr, verb, name, 0);
+	if (device) {
+		if (device->dev_list.type != type)
+			return 0;
+		return get_list(&device->dev_list.list, list,
+				struct dev_list_node, list,
+				name);
+	}
+
+	return -ENOENT;
+
+}
+
+/**
+ * \brief Get list of supported devices
+ * \param list Returned list
+ * \param name Name of verb or modifier to query
+ * \return Number of list entries if success, otherwise a negative error code
+ */
+static int get_supported_device_list(snd_use_case_mgr_t *uc_mgr,
+				     const char **list[], char *name)
+{
+	return get_supcon_device_list(uc_mgr, list, name, DEVLIST_SUPPORTED);
+}
+
+/**
+ * \brief Get list of conflicting devices
+ * \param list Returned list
+ * \param name Name of verb or modifier to query
+ * \return Number of list entries if success, otherwise a negative error code
+ */
+static int get_conflicting_device_list(snd_use_case_mgr_t *uc_mgr,
+				       const char **list[], char *name)
+{
+	return get_supcon_device_list(uc_mgr, list, name, DEVLIST_CONFLICTING);
+}
+
 struct myvalue {
         struct list_head list;
         char *value;
@@ -1032,6 +1106,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
           		err = get_device_list(uc_mgr, list, str);
                 else if (check_identifier(identifier, "_modifiers"))
                         err = get_modifier_list(uc_mgr, list, str);
+                else if (check_identifier(identifier, "_supporteddevs"))
+                        err = get_supported_device_list(uc_mgr, list, str);
+                else if (check_identifier(identifier, "_conflictingdevs"))
+                        err = get_conflicting_device_list(uc_mgr, list, str);
 		else if (identifier[0] == '_')
 			err = -ENOENT;
                 else
@@ -1103,13 +1181,13 @@ static int get_value(snd_use_case_mgr_t *uc_mgr,
 	int err;
 
 	if (item != NULL) {
-		mod = find_modifier(uc_mgr, item, 0);
+		mod = find_modifier(uc_mgr, uc_mgr->active_verb, item, 0);
 		if (mod != NULL) {
 			err = get_value1(value, &mod->value_list, identifier);
 			if (err >= 0 || err != -ENOENT)
 				return err;
 		}
-		dev = find_device(uc_mgr, item, 0);
+		dev = find_device(uc_mgr, uc_mgr->active_verb, item, 0);
 		if (dev != NULL) {
 			err = get_value1(value, &dev->value_list, identifier);
 			if (err >= 0 || err != -ENOENT)
@@ -1339,7 +1417,7 @@ static int set_device_user(snd_use_case_mgr_t *uc_mgr,
 
         if (uc_mgr->active_verb == NULL)
                 return -ENOENT;
-        device = find_device(uc_mgr, device_name, 1);
+        device = find_device(uc_mgr, uc_mgr->active_verb, device_name, 1);
         if (device == NULL)
                 return -ENOENT;
         return set_device(uc_mgr, device, enable);
@@ -1354,7 +1432,7 @@ static int set_modifier_user(snd_use_case_mgr_t *uc_mgr,
         if (uc_mgr->active_verb == NULL)
                 return -ENOENT;
 
-        modifier = find_modifier(uc_mgr, modifier_name, 1);
+        modifier = find_modifier(uc_mgr, uc_mgr->active_verb, modifier_name, 1);
         if (modifier == NULL)
                 return -ENOENT;
         return set_modifier(uc_mgr, modifier, enable);
@@ -1379,11 +1457,11 @@ static int switch_device(snd_use_case_mgr_t *uc_mgr,
                 uc_error("error: device %s already enabled", new_device);
                 return -EINVAL;
         }
-        xold = find_device(uc_mgr, old_device, 1);
+        xold = find_device(uc_mgr, uc_mgr->active_verb, old_device, 1);
         if (xold == NULL)
                 return -ENOENT;
         list_del(&xold->active_list);
-        xnew = find_device(uc_mgr, new_device, 1);
+        xnew = find_device(uc_mgr, uc_mgr->active_verb, new_device, 1);
         list_add_tail(&xold->active_list, &uc_mgr->active_devices);
         if (xnew == NULL)
                 return -ENOENT;
@@ -1433,10 +1511,10 @@ static int switch_modifier(snd_use_case_mgr_t *uc_mgr,
                 uc_error("error: modifier %s already enabled", new_modifier);
                 return -EINVAL;
         }
-        xold = find_modifier(uc_mgr, old_modifier, 1);
+        xold = find_modifier(uc_mgr, uc_mgr->active_verb, old_modifier, 1);
         if (xold == NULL)
                 return -ENOENT;
-        xnew = find_modifier(uc_mgr, new_modifier, 1);
+        xnew = find_modifier(uc_mgr, uc_mgr->active_verb, new_modifier, 1);
         if (xnew == NULL)
                 return -ENOENT;
         err = 0;
-- 
1.7.0.4
