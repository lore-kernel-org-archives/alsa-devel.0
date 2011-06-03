From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/5] UCM: Implement ConflictingDevices,
	add device list to devices
Date: Fri,  3 Jun 2011 14:56:31 -0600
Message-ID: <1307134594-32176-2-git-send-email-swarren@nvidia.com>
References: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C35CF244D9
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 22:56:44 +0200 (CEST)
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

Wherever SupportedDevice can appear, also allow ConflictingDevice. Only
one or the other (or neither) may be specified. When neither is
specified, allow anything. Sometimes, listing ConflictingDevices may
result in a shorter list than explicitly listing all SupportedDevices.

Add support for SupportedDevice and ConflictingDevice to SectionDevice.
This allows representing devices which are mutually exclusive, e.g. due
to a mux that switches between capturing from two different microphones,
without the possibility of mixing.

Enhance is_modifier_supported to allow ignoring SupportedDevice and
ConflictingDevice. This is useful when querying values from a
SectionModifier; there's no reason we shouldn't be able to query values
just because the current configuration would prevent enabling that
device. The new is_device_supported is implemented similarly.

Enhance switch_device to remove the old device from the current device
list before querying for the new device, and add it back immediately
afterwards. This allows the query for the new device to ignore any
conflicts caused solely by the old device.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 src/ucm/main.c      |  110 +++++++++++++++++++++++++++++++++++----------------
 src/ucm/parser.c    |   84 ++++++++++++++++++++++++++++++++------
 src/ucm/ucm_local.h |   19 +++++++-
 src/ucm/utils.c     |    9 ++--
 4 files changed, 167 insertions(+), 55 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 5acb5a8..e5d06e6 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -463,6 +463,51 @@ static inline struct use_case_verb *find_verb(snd_use_case_mgr_t *uc_mgr,
 		    verb_name);
 }
 
+static int is_devlist_supported(snd_use_case_mgr_t *uc_mgr, 
+	struct dev_list *dev_list)
+{
+	struct dev_list_node *device;
+	struct use_case_device *adev;
+	struct list_head *pos, *pos1;
+	int found_ret;
+
+	switch (dev_list->type) {
+	case DEVLIST_NONE:
+	default:
+		return 1;
+	case DEVLIST_SUPPORTED:
+		found_ret = 1;
+		break;
+	case DEVLIST_CONFLICTING:
+		found_ret = 0;
+		break;
+	}
+
+	list_for_each(pos, &dev_list->list) {
+		device = list_entry(pos, struct dev_list_node, list);
+
+		list_for_each(pos1, &uc_mgr->active_devices) {
+			adev = list_entry(pos1, struct use_case_device,
+					    active_list);
+			if (!strcmp(device->name, adev->name))
+				return found_ret;
+		}
+	}
+	return 1 - found_ret;
+}
+
+static inline int is_modifier_supported(snd_use_case_mgr_t *uc_mgr, 
+	struct use_case_modifier *modifier)
+{
+	return is_devlist_supported(uc_mgr, &modifier->dev_list);
+}
+
+static inline int is_device_supported(snd_use_case_mgr_t *uc_mgr, 
+	struct use_case_device *device)
+{
+	return is_devlist_supported(uc_mgr, &device->dev_list);
+}
+
 /**
  * \brief Find device
  * \param verb Use case verb
@@ -470,35 +515,26 @@ static inline struct use_case_verb *find_verb(snd_use_case_mgr_t *uc_mgr,
  * \return structure on success, otherwise a NULL (not found)
  */
 static inline struct use_case_device *
-        find_device(struct use_case_verb *verb,
-                      const char *device_name)
-{
-	return find(&verb->device_list,
-		    struct use_case_device, list, name,
-		    device_name);
-}
-
-static int is_modifier_supported(snd_use_case_mgr_t *uc_mgr, 
-	struct use_case_modifier *modifier)
+        find_device(snd_use_case_mgr_t *uc_mgr, const char *device_name,
+		    int check_supported)
 {
-	struct dev_list *device;
-	struct use_case_device *adev;
-	struct list_head *pos, *pos1;
+	struct use_case_device *device;
+	struct use_case_verb *verb = uc_mgr->active_verb;
+	struct list_head *pos;
 
-	list_for_each(pos, &modifier->dev_list) {
-		device = list_entry(pos, struct dev_list, list);
+	list_for_each(pos, &verb->device_list) {
+		device = list_entry(pos, struct use_case_device, list);
 
-		list_for_each(pos1, &uc_mgr->active_devices) {
-			adev = list_entry(pos1, struct use_case_device,
-					    active_list);
+		if (strcmp(device_name, device->name))
+			continue;
 
-			if (strcmp(adev->name, device->name))
-				continue;
+		if (check_supported &&
+		    !is_device_supported(uc_mgr, device))
+			continue;
 
-			return 1;
-		}
+		return device;
 	}
-	return 0;
+	return NULL;
 }
 
 /**
@@ -508,7 +544,8 @@ static int is_modifier_supported(snd_use_case_mgr_t *uc_mgr,
  * \return structure on success, otherwise a NULL (not found)
  */
 static struct use_case_modifier *
-        find_modifier(snd_use_case_mgr_t *uc_mgr, const char *modifier_name)
+        find_modifier(snd_use_case_mgr_t *uc_mgr, const char *modifier_name,
+		      int check_supported)
 {
 	struct use_case_modifier *modifier;
 	struct use_case_verb *verb = uc_mgr->active_verb;
@@ -520,8 +557,11 @@ static struct use_case_modifier *
 		if (strcmp(modifier->name, modifier_name))
 			continue;
 
-		if (is_modifier_supported(uc_mgr, modifier))
-			return modifier;
+		if (check_supported &&
+		    !is_modifier_supported(uc_mgr, modifier))
+			continue;
+
+		return modifier;
 	}
 	return NULL;
 }
@@ -1061,13 +1101,13 @@ static int get_value(snd_use_case_mgr_t *uc_mgr,
 	int err;
 
 	if (item != NULL) {
-		mod = find_modifier(uc_mgr, item);
+		mod = find_modifier(uc_mgr, item, 0);
 		if (mod != NULL) {
 			err = get_value1(value, &mod->value_list, identifier);
 			if (err >= 0 || err != -ENOENT)
 				return err;
 		}
-		dev = find_device(uc_mgr->active_verb, item);
+		dev = find_device(uc_mgr, item, 0);
 		if (dev != NULL) {
 			err = get_value1(value, &dev->value_list, identifier);
 			if (err >= 0 || err != -ENOENT)
@@ -1286,7 +1326,7 @@ static int set_device_user(snd_use_case_mgr_t *uc_mgr,
 
         if (uc_mgr->active_verb == NULL)
                 return -ENOENT;
-        device = find_device(uc_mgr->active_verb, device_name);
+        device = find_device(uc_mgr, device_name, 1);
         if (device == NULL)
                 return -ENOENT;
         return set_device(uc_mgr, device, enable);
@@ -1301,7 +1341,7 @@ static int set_modifier_user(snd_use_case_mgr_t *uc_mgr,
         if (uc_mgr->active_verb == NULL)
                 return -ENOENT;
 
-        modifier = find_modifier(uc_mgr, modifier_name);
+        modifier = find_modifier(uc_mgr, modifier_name, 1);
         if (modifier == NULL)
                 return -ENOENT;
         return set_modifier(uc_mgr, modifier, enable);
@@ -1326,10 +1366,12 @@ static int switch_device(snd_use_case_mgr_t *uc_mgr,
                 uc_error("error: device %s already enabled", new_device);
                 return -EINVAL;
         }
-        xold = find_device(uc_mgr->active_verb, old_device);
+        xold = find_device(uc_mgr, old_device, 1);
         if (xold == NULL)
                 return -ENOENT;
-        xnew = find_device(uc_mgr->active_verb, new_device);
+        list_del(&xold->active_list);
+        xnew = find_device(uc_mgr, new_device, 1);
+        list_add_tail(&xold->active_list, &uc_mgr->active_devices);
         if (xnew == NULL)
                 return -ENOENT;
         err = 0;
@@ -1378,10 +1420,10 @@ static int switch_modifier(snd_use_case_mgr_t *uc_mgr,
                 uc_error("error: modifier %s already enabled", new_modifier);
                 return -EINVAL;
         }
-        xold = find_modifier(uc_mgr, old_modifier);
+        xold = find_modifier(uc_mgr, old_modifier, 1);
         if (xold == NULL)
                 return -ENOENT;
-        xnew = find_modifier(uc_mgr, new_modifier);
+        xnew = find_modifier(uc_mgr, new_modifier, 1);
         if (xnew == NULL)
                 return -ENOENT;
         err = 0;
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index b0bebe0..23b67bc 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -180,18 +180,25 @@ static int strip_legacy_dev_index(char *name)
 }
 
 /*
- * Parse transition
+ * Parse device list
  */
-static int parse_supported_device(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
-				  struct list_head *dlist,
-				  snd_config_t *cfg)
+static int parse_device_list(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
+			     struct dev_list *dev_list,
+			     enum dev_list_type type,
+			     snd_config_t *cfg)
 {
-	struct dev_list *sdev;
+	struct dev_list_node *sdev;
 	const char *id;
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	int err;
 
+	if (dev_list->type != DEVLIST_NONE) {
+		uc_error("error: multiple supported or"
+			" conflicting device lists");
+		return -EEXIST;
+	}
+
 	if (snd_config_get_id(cfg, &id) < 0)
 		return -EINVAL;
 
@@ -206,7 +213,7 @@ static int parse_supported_device(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
 		if (snd_config_get_id(n, &id) < 0)
 			return -EINVAL;
 
-		sdev = calloc(1, sizeof(struct dev_list));
+		sdev = calloc(1, sizeof(struct dev_list_node));
 		if (sdev == NULL)
 			return -ENOMEM;
 		err = parse_string(n, &sdev->name);
@@ -220,8 +227,11 @@ static int parse_supported_device(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
 			free(sdev);
 			return err;
 		}
-		list_add(&sdev->list, dlist);
+		list_add(&sdev->list, &dev_list->list);
 	}
+
+	dev_list->type = type;
+
 	return 0;
 }
 
@@ -413,11 +423,17 @@ static int parse_value(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
  *	SectionModifier."Capture Voice" {
  *
  *		Comment "Record voice call"
+ *
  *		SupportedDevice [
  *			"x"
  *			"y"
  *		]
  *
+ *		ConflictingDevice [
+ *			"x"
+ *			"y"
+ *		]
+ *
  *		EnableSequence [
  *			....
  *		]
@@ -439,6 +455,9 @@ static int parse_value(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
  *		}
  *
  *	 }
+ *
+ * SupportedDevice and ConflictingDevice cannot be specified together.
+ * Both are optional.
  */
 static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 		snd_config_t *cfg,
@@ -469,7 +488,7 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 	INIT_LIST_HEAD(&modifier->enable_list);
 	INIT_LIST_HEAD(&modifier->disable_list);
 	INIT_LIST_HEAD(&modifier->transition_list);
-	INIT_LIST_HEAD(&modifier->dev_list);
+	INIT_LIST_HEAD(&modifier->dev_list.list);
 	INIT_LIST_HEAD(&modifier->value_list);
 	list_add_tail(&modifier->list, &verb->modifier_list);
 	modifier->name = strdup(name);
@@ -490,7 +509,8 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 		}
 
 		if (strcmp(id, "SupportedDevice") == 0) {
-			err = parse_supported_device(uc_mgr, &modifier->dev_list, n);
+			err = parse_device_list(uc_mgr, &modifier->dev_list,
+						DEVLIST_SUPPORTED, n);
 			if (err < 0) {
 				uc_error("error: failed to parse supported"
 					" device list");
@@ -498,6 +518,16 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 			}
 		}
 
+		if (strcmp(id, "ConflictingDevice") == 0) {
+			err = parse_device_list(uc_mgr, &modifier->dev_list,
+						DEVLIST_CONFLICTING, n);
+			if (err < 0) {
+				uc_error("error: failed to parse conflicting"
+					" device list");
+				return err;
+			}
+		}
+
 		if (strcmp(id, "EnableSequence") == 0) {
 			err = parse_sequence(uc_mgr, &modifier->enable_list, n);
 			if (err < 0) {
@@ -538,11 +568,6 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 		}
 	}
 
-	if (list_empty(&modifier->dev_list)) {
-		uc_error("error: %s: modifier missing supported device sequence", modifier->name);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -553,6 +578,16 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
  *SectionDevice."Headphones" {
  *	Comment "Headphones connected to 3.5mm jack"
  *
+ *	upportedDevice [
+ *		"x"
+ *		"y"
+ *	]
+ *
+ *	ConflictingDevice [
+ *		"x"
+ *		"y"
+ *	]
+ *
  *	EnableSequence [
  *		....
  *	]
@@ -599,6 +634,7 @@ static int parse_device(snd_use_case_mgr_t *uc_mgr,
 	INIT_LIST_HEAD(&device->enable_list);
 	INIT_LIST_HEAD(&device->disable_list);
 	INIT_LIST_HEAD(&device->transition_list);
+	INIT_LIST_HEAD(&device->dev_list.list);
 	INIT_LIST_HEAD(&device->value_list);
 	list_add_tail(&device->list, &verb->device_list);
 	device->name = strdup(name);
@@ -618,6 +654,26 @@ static int parse_device(snd_use_case_mgr_t *uc_mgr,
 			continue;
 		}
 
+		if (strcmp(id, "SupportedDevice") == 0) {
+			err = parse_device_list(uc_mgr, &device->dev_list,
+						DEVLIST_SUPPORTED, n);
+			if (err < 0) {
+				uc_error("error: failed to parse supported"
+					" device list");
+				return err;
+			}
+		}
+
+		if (strcmp(id, "ConflictingDevice") == 0) {
+			err = parse_device_list(uc_mgr, &device->dev_list,
+						DEVLIST_CONFLICTING, n);
+			if (err < 0) {
+				uc_error("error: failed to parse conflicting"
+					" device list");
+				return err;
+			}
+		}
+
 		if (strcmp(id, "EnableSequence") == 0) {
 			uc_dbg("EnableSequence");
 			err = parse_sequence(uc_mgr, &device->enable_list, n);
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 2ceceaa..0522bf5 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -76,11 +76,21 @@ struct transition_sequence {
 /*
  * Modifier Supported Devices.
  */
-struct dev_list {
+enum dev_list_type {
+	DEVLIST_NONE,
+	DEVLIST_SUPPORTED,
+	DEVLIST_CONFLICTING
+};
+
+struct dev_list_node {
 	struct list_head list;
 	char *name;
 };
 
+struct dev_list {
+	enum dev_list_type type;
+	struct list_head list;
+};
 
 /*
  * Describes a Use Case Modifier and it's enable and disable sequences.
@@ -100,8 +110,8 @@ struct use_case_modifier {
 	/* modifier transition list */
 	struct list_head transition_list;
 
-	/* list of supported devices per modifier */
-	struct list_head dev_list;
+	/* list of devices supported or conflicting */
+	struct dev_list dev_list;
 
 	/* values */
 	struct list_head value_list;
@@ -125,6 +135,9 @@ struct use_case_device {
 	/* device transition list */
 	struct list_head transition_list;
 
+	/* list of devices supported or conflicting */
+	struct dev_list dev_list;
+
 	/* value list */
 	struct list_head value_list;
 };
diff --git a/src/ucm/utils.c b/src/ucm/utils.c
index 85549e1..45307b0 100644
--- a/src/ucm/utils.c
+++ b/src/ucm/utils.c
@@ -99,13 +99,13 @@ void uc_mgr_free_value(struct list_head *base)
 	}
 }
 
-void uc_mgr_free_dev_list(struct list_head *base)
+void uc_mgr_free_dev_list(struct dev_list *dev_list)
 {
 	struct list_head *pos, *npos;
-	struct dev_list *dlist;
+	struct dev_list_node *dlist;
 	
-	list_for_each_safe(pos, npos, base) {
-		dlist = list_entry(pos, struct dev_list, list);
+	list_for_each_safe(pos, npos, &dev_list->list) {
+		dlist = list_entry(pos, struct dev_list_node, list);
 		free(dlist->name);
 		list_del(&dlist->list);
 		free(dlist);
@@ -189,6 +189,7 @@ void uc_mgr_free_device(struct list_head *base)
 		uc_mgr_free_sequence(&dev->enable_list);
 		uc_mgr_free_sequence(&dev->disable_list);
 		uc_mgr_free_transition(&dev->transition_list);
+		uc_mgr_free_dev_list(&dev->dev_list);
 		uc_mgr_free_value(&dev->value_list);
 		list_del(&dev->list);
 		free(dev);
-- 
1.7.0.4
