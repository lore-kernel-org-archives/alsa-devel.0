From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/5] UCM: Deprecate index on Section{Device,
	Modifier}
Date: Fri,  3 Jun 2011 14:56:30 -0600
Message-ID: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C57E6244DB
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 22:56:44 +0200 (CEST)
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

The previous supported "legacy" syntax was:

SectionDevice."Speaker".0 {
SectionModifier."Capture Voice".0 {

This change supports new syntax:

SectionDevice."Speaker" {
SectionModifier."Capture Voice" {

... but also allows the old syntax, iff the index is exactly "0". If an
index is present, but not exactly "0", parsing will appear to succeed,
but produce an empty device or modifier.

When naming devices and modifiers, even if the legacy format is used,
any index is not included in the name; i.e. both sets of syntax above
name the device just "Speaker".

The SupportedDevice list syntax still also accepts either "x" or "x.0",
but internally strips ".0" from the tail of any device name. Any other
name including "." is disallowed.

Finally, when comparing device or modifier names, a simple exact string
compare is now used, since no index data is ever present in device or
modifier names.

The one functional change introduced here is that a SupportedDevice
entry of just "x" will now only ever match a single device. It previously
acted as a wildcard for any device named "x.foo".

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 src/ucm/main.c   |   43 ++++-----------
 src/ucm/parser.c |  156 ++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 114 insertions(+), 85 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index fb4aa91..5acb5a8 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -484,33 +484,18 @@ static int is_modifier_supported(snd_use_case_mgr_t *uc_mgr,
 	struct dev_list *device;
 	struct use_case_device *adev;
 	struct list_head *pos, *pos1;
-	char *cpos;
-	int dlen, len;
 
 	list_for_each(pos, &modifier->dev_list) {
 		device = list_entry(pos, struct dev_list, list);
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
+
+		list_for_each(pos1, &uc_mgr->active_devices) {
+			adev = list_entry(pos1, struct use_case_device,
+					    active_list);
+
+			if (strcmp(adev->name, device->name))
+				continue;
+
+			return 1;
 		}
 	}
 	return 0;
@@ -528,19 +513,11 @@ static struct use_case_modifier *
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
-			continue;
-		*cpos= '\0';
-
-		if (strcmp(name, modifier_name))
+		if (strcmp(modifier->name, modifier_name))
 			continue;
 
 		if (is_modifier_supported(uc_mgr, modifier))
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index f7de9bd..b0bebe0 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -59,7 +59,7 @@ int parse_string(snd_config_t *n, char **res)
 /*
  * Parse safe ID
  */
-int parse_is_name_safe(char *name)
+int parse_is_name_safe(const char *name)
 {
 	if (strchr(name, '.')) {
 		uc_error("char '.' not allowed in '%s'", name);
@@ -75,7 +75,9 @@ int parse_get_safe_id(snd_config_t *n, const char **id)
 	err = snd_config_get_id(n, id);
 	if (err < 0)
 		return err;
-	return parse_is_name_safe((char *)(*id));
+	if (!parse_is_name_safe((char *)(*id)))
+		return -EINVAL;
+	return 0;
 }
 
 /*
@@ -151,7 +153,7 @@ static int parse_compound(snd_use_case_mgr_t *uc_mgr, snd_config_t *cfg,
 		n = snd_config_iterator_entry(i);
 
 		if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
-			uc_error("compound type expected for %s", id);
+			uc_error("compound type expected for %s, is %d", id, snd_config_get_type(cfg));
 			return -EINVAL;
 		}
 		
@@ -163,6 +165,19 @@ static int parse_compound(snd_use_case_mgr_t *uc_mgr, snd_config_t *cfg,
 	return 0;
 }
 
+static int strip_legacy_dev_index(char *name)
+{
+	char *dot = strchr(name, '.');
+	if (!dot)
+		return 0;
+	if (dot[1] != '0' || dot[2] != '\0') {
+		uc_error("device name %s contains a '.',"
+			 " and is not legacy foo.0 format", name);
+		return -EINVAL;
+	}
+	*dot = '\0';
+	return 0;
+}
 
 /*
  * Parse transition
@@ -199,6 +214,12 @@ static int parse_supported_device(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
 			free(sdev);
 			return err;
 		}
+		err = strip_legacy_dev_index(sdev->name);
+		if (err < 0) {
+			free(sdev->name);
+			free(sdev);
+			return err;
+		}
 		list_add(&sdev->list, dlist);
 	}
 	return 0;
@@ -389,12 +410,12 @@ static int parse_value(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
  * Parse Modifier Use cases
  *
  *	# Each modifier is described in new section. N modifiers are allowed
- *	SectionModifier."Capture Voice".0 {
+ *	SectionModifier."Capture Voice" {
  *
  *		Comment "Record voice call"
  *		SupportedDevice [
- *			"x"		# all x device instances
- *			"y.0"		# device y instance 0 only
+ *			"x"
+ *			"y"
  *		]
  *
  *		EnableSequence [
@@ -426,14 +447,21 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 {
 	struct use_case_verb *verb = data1;
 	struct use_case_modifier *modifier;
-	char *name = data2;
-	const char *id;
+	const char *name;
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	int err;
 
-	if (!parse_is_name_safe(name))
-		return -EINVAL;
+	if (data2) {
+		name = data2;
+		if (!parse_is_name_safe(name))
+			return -EINVAL;
+	}
+	else {
+		if (parse_get_safe_id(cfg, &name) < 0)
+			return -EINVAL;
+	}
+
 	/* allocate modifier */
 	modifier = calloc(1, sizeof(*modifier));
 	if (modifier == NULL)
@@ -444,15 +472,7 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 	INIT_LIST_HEAD(&modifier->dev_list);
 	INIT_LIST_HEAD(&modifier->value_list);
 	list_add_tail(&modifier->list, &verb->modifier_list);
-	err = parse_get_safe_id(cfg, &id);
-	if (err < 0)
-		return err;
-	modifier->name = malloc(strlen(name) + strlen(id) + 2);
-	if (modifier->name == NULL)
-		return -ENOMEM;
-	strcpy(modifier->name, name);
-	strcat(modifier->name, ".");
-	strcat(modifier->name, id);
+	modifier->name = strdup(name);
 
 	snd_config_for_each(i, next, cfg) {
 		const char *id;
@@ -530,7 +550,7 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
  * Parse Device Use Cases
  *
  *# Each device is described in new section. N devices are allowed
- *SectionDevice."Headphones".0 {
+ *SectionDevice."Headphones" {
  *	Comment "Headphones connected to 3.5mm jack"
  *
  *	EnableSequence [
@@ -551,21 +571,28 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
  *	}
  * }
  */
-static int parse_device_index(snd_use_case_mgr_t *uc_mgr,
-			      snd_config_t *cfg,
-			      void *data1,
-			      void *data2)
+static int parse_device(snd_use_case_mgr_t *uc_mgr,
+			snd_config_t *cfg,
+			void *data1,
+			void *data2)
 {
 	struct use_case_verb *verb = data1;
-	char *name = data2;
+	const char *name;
 	struct use_case_device *device;
-	const char *id;
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	int err;
-	
-	if (!parse_is_name_safe(name))
-		return -EINVAL;
+
+	if (data2) {
+		name = data2;
+		if (!parse_is_name_safe(name))
+			return -EINVAL;
+	}
+	else {
+		if (parse_get_safe_id(cfg, &name) < 0)
+			return -EINVAL;
+	}
+
 	device = calloc(1, sizeof(*device));
 	if (device == NULL)
 		return -ENOMEM;
@@ -574,14 +601,7 @@ static int parse_device_index(snd_use_case_mgr_t *uc_mgr,
 	INIT_LIST_HEAD(&device->transition_list);
 	INIT_LIST_HEAD(&device->value_list);
 	list_add_tail(&device->list, &verb->device_list);
-	if (parse_get_safe_id(cfg, &id) < 0)
-		return -EINVAL;
-	device->name = malloc(strlen(name) + strlen(id) + 2);
-	if (device->name == NULL)
-		return -ENOMEM;
-	strcpy(device->name, name);
-	strcat(device->name, ".");
-	strcat(device->name, id);
+	device->name = strdup(name);
 
 	snd_config_for_each(i, next, cfg) {
 		const char *id;
@@ -643,34 +663,66 @@ static int parse_device_index(snd_use_case_mgr_t *uc_mgr,
 	return 0;
 }
 
-static int parse_device_name(snd_use_case_mgr_t *uc_mgr,
-			     snd_config_t *cfg,
-			     void *data1,
-			     void *data2 ATTRIBUTE_UNUSED)
+static int parse_compound_check_legacy(snd_use_case_mgr_t *uc_mgr,
+	  snd_config_t *cfg,
+	  int (*fcn)(snd_use_case_mgr_t *, snd_config_t *, void *, void *),
+	  void *data1)
 {
-	const char *id;
+	const char *id, *idchild;
+	int child_ctr = 0, legacy_format = 1;
+	snd_config_iterator_t i, next;
+	snd_config_t *child;
 	int err;
 
 	err = snd_config_get_id(cfg, &id);
 	if (err < 0)
 		return err;
-	return parse_compound(uc_mgr, cfg, parse_device_index,
-			      data1, (void *)id);
+
+	snd_config_for_each(i, next, cfg) {
+		child_ctr++;
+		if (child_ctr > 1) {
+			break;
+		}
+
+		child = snd_config_iterator_entry(i);
+
+		if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+			legacy_format = 0;
+			break;
+		}
+
+		if (snd_config_get_id(child, &idchild) < 0)
+			return -EINVAL;
+
+		if (strcmp(idchild, "0")) {
+			legacy_format = 0;
+			break;
+		}
+	}
+	if (child_ctr != 1) {
+		legacy_format = 0;
+	}
+
+	if (legacy_format)
+		return parse_compound(uc_mgr, cfg, fcn, data1, (void *)id);
+	else
+		return fcn(uc_mgr, cfg, data1, NULL);
 }
 
-static int parse_modifier_name(snd_use_case_mgr_t *uc_mgr,
+static int parse_device_name(snd_use_case_mgr_t *uc_mgr,
 			     snd_config_t *cfg,
 			     void *data1,
 			     void *data2 ATTRIBUTE_UNUSED)
 {
-	const char *id;
-	int err;
+	return parse_compound_check_legacy(uc_mgr, cfg, parse_device, data1);
+}
 
-	err = snd_config_get_id(cfg, &id);
-	if (err < 0)
-		return err;
-	return parse_compound(uc_mgr, cfg, parse_modifier,
-			      data1, (void *)id);
+static int parse_modifier_name(snd_use_case_mgr_t *uc_mgr,
+			     snd_config_t *cfg,
+			     void *data1,
+			     void *data2 ATTRIBUTE_UNUSED)
+{
+	return parse_compound_check_legacy(uc_mgr, cfg, parse_modifier, data1);
 }
 
 /*
-- 
1.7.0.4
