From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] UCM: Implement ConflictingDevices,
	add device list to devices
Date: Thu,  2 Jun 2011 18:03:51 -0600
Message-ID: <1307059431-4913-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 187B6244A3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 02:04:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>, lrg@ti.com
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
Depending on decisions in the thread I recently started entitled
"UCM modifier names", this patch may change, e.g. name_match may not
be needed, or could be simpler.

I should probably split some of this into separate patches, but I
figured I'd get it out there for people to discuss first.

This patch builds on the other couple of alsa-lib UCM patches I posted
earlier today.

 src/ucm/main.c      |  169 +++++++++++++++++++++++++++++++++------------------
 src/ucm/parser.c    |   74 ++++++++++++++++++----
 src/ucm/ucm_local.h |   19 +++++-
 src/ucm/utils.c     |    9 ++-
 4 files changed, 190 insertions(+), 81 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index fb4aa91..0a3331a 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -463,6 +463,82 @@ static inline struct use_case_verb *find_verb(snd_use_case_mgr_t *uc_mgr,
 		    verb_name);
 }
 
+static int name_match(const char *test, const char *against)
+{
+	char *pos_test, *pos_against;
+	int len_test, len_against;
+
+	pos_test = strchr(test, '.');
+	if (pos_test) {
+		if (strcmp(test, against))
+			return 0;
+		return 1;
+	}
+
+	pos_against = strchr(against, '.');
+	if (!pos_against) {
+		if (strcmp(test, against))
+			return 0;
+		return 1;
+	}
+
+	len_test = strlen(test);
+	len_against = pos_against - against;
+
+	if (len_test != len_against)
+		return 0;
+
+	if (memcmp(test, against, len_test))
+		return 0;
+
+	return 1;
+}
+
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
+			if (name_match(device->name, adev->name))
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
@@ -470,52 +546,27 @@ static inline struct use_case_verb *find_verb(snd_use_case_mgr_t *uc_mgr,
  * \return structure on success, otherwise a NULL (not found)
  */
 static inline struct use_case_device *
-        find_device(struct use_case_verb *verb,
-                      const char *device_name)
+        find_device(snd_use_case_mgr_t *uc_mgr, const char *device_name,
+		    int check_supported)
 {
-	return find(&verb->device_list,
-		    struct use_case_device, list, name,
-		    device_name);
-}
+	struct use_case_device *device;
+	struct use_case_verb *verb = uc_mgr->active_verb;
+	struct list_head *pos;
 
-static int is_modifier_supported(snd_use_case_mgr_t *uc_mgr, 
-	struct use_case_modifier *modifier)
-{
-	struct dev_list *device;
-	struct use_case_device *adev;
-	struct list_head *pos, *pos1;
-	char *cpos;
-	int dlen, len;
-
-	list_for_each(pos, &modifier->dev_list) {
-		device = list_entry(pos, struct dev_list, list);
-		cpos = strchr(device->name, '.');
-		if (cpos) {
-			if (find(&uc_mgr->active_devices,
-					struct use_case_device, active_list,
-					name, device->name))
-				return 1;
-		} else {
-			dlen = strlen(device->name);
-			list_for_each(pos1, &uc_mgr->active_devices) {
-				adev = list_entry(pos1, struct use_case_device,
-						  active_list);
-				cpos = strchr(adev->name, '.');
-				if (cpos)
-					len = cpos - adev->name;
-				else
-					len = strlen(adev->name);
-				if (len != dlen)
-					continue;
-				if (memcmp(adev->name, device->name, len))
-					continue;
-				return 1;
-			}
-		}
+	list_for_each(pos, &verb->device_list) {
+		device = list_entry(pos, struct use_case_device, list);
+
+		if (!name_match(device_name, device->name))
+			continue;
+
+		if (check_supported &&
+		    !is_device_supported(uc_mgr, device))
+			continue;
+
+		return device;
 	}
-	return 0;
+	return NULL;
 }
-
 /**
  * \brief Find modifier
  * \param verb Use case verb
@@ -523,28 +574,24 @@ static int is_modifier_supported(snd_use_case_mgr_t *uc_mgr,
  * \return structure on success, otherwise a NULL (not found)
  */
 static struct use_case_modifier *
-        find_modifier(snd_use_case_mgr_t *uc_mgr, const char *modifier_name)
+        find_modifier(snd_use_case_mgr_t *uc_mgr, const char *modifier_name,
+		      int check_supported)
 {
 	struct use_case_modifier *modifier;
 	struct use_case_verb *verb = uc_mgr->active_verb;
 	struct list_head *pos;
-	char name[64], *cpos;
 
 	list_for_each(pos, &verb->modifier_list) {
 		modifier = list_entry(pos, struct use_case_modifier, list);
 
-		strncpy(name, modifier->name, sizeof(name));
-		name[sizeof(name)-1] = '\0';
-		cpos = strchr(name, '.');
-		if (!cpos)
+		if (!name_match(modifier_name, modifier->name))
 			continue;
-		*cpos= '\0';
 
-		if (strcmp(name, modifier_name))
+		if (check_supported &&
+		    !is_modifier_supported(uc_mgr, modifier))
 			continue;
 
-		if (is_modifier_supported(uc_mgr, modifier))
-			return modifier;
+		return modifier;
 	}
 	return NULL;
 }
@@ -1084,13 +1131,13 @@ static int get_value(snd_use_case_mgr_t *uc_mgr,
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
@@ -1309,7 +1356,7 @@ static int set_device_user(snd_use_case_mgr_t *uc_mgr,
 
         if (uc_mgr->active_verb == NULL)
                 return -ENOENT;
-        device = find_device(uc_mgr->active_verb, device_name);
+        device = find_device(uc_mgr, device_name, 1);
         if (device == NULL)
                 return -ENOENT;
         return set_device(uc_mgr, device, enable);
@@ -1324,7 +1371,7 @@ static int set_modifier_user(snd_use_case_mgr_t *uc_mgr,
         if (uc_mgr->active_verb == NULL)
                 return -ENOENT;
 
-        modifier = find_modifier(uc_mgr, modifier_name);
+        modifier = find_modifier(uc_mgr, modifier_name, 1);
         if (modifier == NULL)
                 return -ENOENT;
         return set_modifier(uc_mgr, modifier, enable);
@@ -1349,10 +1396,12 @@ static int switch_device(snd_use_case_mgr_t *uc_mgr,
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
@@ -1401,10 +1450,10 @@ static int switch_modifier(snd_use_case_mgr_t *uc_mgr,
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
index f7de9bd..53ff035 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -165,18 +165,25 @@ static int parse_compound(snd_use_case_mgr_t *uc_mgr, snd_config_t *cfg,
 
 
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
 
@@ -191,7 +198,7 @@ static int parse_supported_device(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
 		if (snd_config_get_id(n, &id) < 0)
 			return -EINVAL;
 
-		sdev = calloc(1, sizeof(struct dev_list));
+		sdev = calloc(1, sizeof(struct dev_list_node));
 		if (sdev == NULL)
 			return -ENOMEM;
 		err = parse_string(n, &sdev->name);
@@ -199,8 +206,11 @@ static int parse_supported_device(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
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
 
@@ -392,11 +402,17 @@ static int parse_value(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
  *	SectionModifier."Capture Voice".0 {
  *
  *		Comment "Record voice call"
+ *
  *		SupportedDevice [
  *			"x"		# all x device instances
  *			"y.0"		# device y instance 0 only
  *		]
  *
+ *		ConflictingDevice [
+ *			"x"		# all x device instances
+ *			"y.0"		# device y instance 0 only
+ *		]
+ *
  *		EnableSequence [
  *			....
  *		]
@@ -418,6 +434,9 @@ static int parse_value(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
  *		}
  *
  *	 }
+ *
+ * SupportedDevice and ConflictingDevice cannot be specified together.
+ * Both are optional.
  */
 static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 		snd_config_t *cfg,
@@ -441,7 +460,7 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 	INIT_LIST_HEAD(&modifier->enable_list);
 	INIT_LIST_HEAD(&modifier->disable_list);
 	INIT_LIST_HEAD(&modifier->transition_list);
-	INIT_LIST_HEAD(&modifier->dev_list);
+	INIT_LIST_HEAD(&modifier->dev_list.list);
 	INIT_LIST_HEAD(&modifier->value_list);
 	list_add_tail(&modifier->list, &verb->modifier_list);
 	err = parse_get_safe_id(cfg, &id);
@@ -470,7 +489,8 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 		}
 
 		if (strcmp(id, "SupportedDevice") == 0) {
-			err = parse_supported_device(uc_mgr, &modifier->dev_list, n);
+			err = parse_device_list(uc_mgr, &modifier->dev_list,
+						DEVLIST_SUPPORTED, n);
 			if (err < 0) {
 				uc_error("error: failed to parse supported"
 					" device list");
@@ -478,6 +498,16 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
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
@@ -518,11 +548,6 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 		}
 	}
 
-	if (list_empty(&modifier->dev_list)) {
-		uc_error("error: %s: modifier missing supported device sequence", modifier->name);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -572,6 +597,7 @@ static int parse_device_index(snd_use_case_mgr_t *uc_mgr,
 	INIT_LIST_HEAD(&device->enable_list);
 	INIT_LIST_HEAD(&device->disable_list);
 	INIT_LIST_HEAD(&device->transition_list);
+	INIT_LIST_HEAD(&device->dev_list.list);
 	INIT_LIST_HEAD(&device->value_list);
 	list_add_tail(&device->list, &verb->device_list);
 	if (parse_get_safe_id(cfg, &id) < 0)
@@ -598,6 +624,26 @@ static int parse_device_index(snd_use_case_mgr_t *uc_mgr,
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
