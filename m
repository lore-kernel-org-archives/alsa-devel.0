From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 2/3] ucm: Parse sequence of component devices
Date: Fri, 18 Nov 2016 13:28:04 +0800
Message-ID: <7efc58e307fce50c6db6326e5e25dfe8403c11a6.1479446217.git.mengdong.lin@linux.intel.com>
References: <cover.1479446217.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A93E1265823
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 06:26:15 +0100 (CET)
In-Reply-To: <cover.1479446217.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

A machine device's sequence can enable or disable a component device by
keyword 'enadev' and 'disdev' followed the name of the component device.

UCM sequence parser will find the component device and mark if its enable
or disable sequence is needed by the parent, the machine device.

New element type and struct are defined for the sequence of a component
device. Component devices will be removed from the machine device list
'device_list' of a verb, since we don't want to expose them to audio
servers with original API to list devices for backward compatibility.
A new list 'cmpt_device_list' is used for the component devices of a verb.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 5c99ab4..c98373a 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -254,6 +254,82 @@ static int parse_device_list(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
 	return 0;
 }
 
+/* Find a component device by its name, and remove it from machine device
+ * list.
+ *
+ * Component devices are defined by machine components (usually off-soc
+ * codes or DSP embeded in SoC). Since alsaconf imports their configuration
+ * files automatically, we don't know which devices are component devices
+ * until they are referenced by a machine device sequence. So here when we
+ * find a referenced device, we move it from the machine device list to the
+ * component device list. Component devices will not be exposed to applications
+ * by the original API to list devices for backward compatibility. So sound
+ * servers can only see the machine devices.
+ */
+struct use_case_device *find_component_dev(snd_use_case_mgr_t *uc_mgr,
+	const char *name)
+{
+	struct list_head *pos, *posdev, *_posdev;
+	struct use_case_verb *verb;
+	struct use_case_device *dev;
+
+	list_for_each(pos, &uc_mgr->verb_list) {
+		verb = list_entry(pos, struct use_case_verb, list);
+
+		/* search in the component device list */
+		list_for_each(posdev, &verb->cmpt_device_list) {
+			dev = list_entry(posdev, struct use_case_device, list);
+			if (!strcmp(dev->name, name))
+				return dev;
+		}
+
+		/* search the machine device list */
+		list_for_each_safe(posdev, _posdev, &verb->device_list) {
+			dev = list_entry(posdev, struct use_case_device, list);
+			if (!strcmp(dev->name, name)) {
+				/* find the component device, move it from the
+				 * machine device list to the component device
+				 * list.
+				 */
+				list_del(&dev->list);
+				list_add_tail(&dev->list,
+					      &verb->cmpt_device_list);
+				return dev;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/* parse sequence of a component device
+ *
+ * This function will find the component device and mark if its enable or
+ * disable sequence is needed by its parenet device.
+ */
+static int parse_component_seq(snd_use_case_mgr_t *uc_mgr,
+			  snd_config_t *n, int enable,
+			  struct component_sequence *cmpt_seq)
+{
+	const char *val;
+	int err;
+
+	err = snd_config_get_string(n, &val);
+	if (err < 0)
+		return err;
+
+	cmpt_seq->device = find_component_dev(uc_mgr, val);
+	if (!cmpt_seq->device) {
+		uc_error("error: Cannot find component device %s", val);
+		return -EINVAL;
+	}
+
+	/* Parent needs its enable or disable sequence */
+	cmpt_seq->enable = enable;
+
+	return 0;
+}
+
 /*
  * Parse sequences.
  *
@@ -263,12 +339,16 @@ static int parse_device_list(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
  * cset "element_id_syntax value_syntax"
  * usleep time
  * exec "any unix command with arguments"
+ * enadev "component device name"
+ * disdev "component device name"
  *
  * e.g.
  *	cset "name='Master Playback Switch' 0,0"
  *      cset "iface=PCM,name='Disable HDMI',index=1 0"
+ *	enadev "rt286:Headphones"
+ *	disdev "rt286:Speaker"
  */
-static int parse_sequence(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
+static int parse_sequence(snd_use_case_mgr_t *uc_mgr,
 			  struct list_head *base,
 			  snd_config_t *cfg)
 {
@@ -325,6 +405,30 @@ static int parse_sequence(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
 			continue;
 		}
 
+		if (strcmp(cmd, "enadev") == 0) {
+			/* need to enable a component device */
+			curr->type = SEQUENCE_ELEMENT_TYPE_CMPT_SEQ;
+			err = parse_component_seq(uc_mgr, n, 1,
+						&curr->data.cmpt_seq);
+			if (err < 0) {
+				uc_error("error: enadev requires a valid device!");
+				return err;
+			}
+			continue;
+		}
+
+		if (strcmp(cmd, "disdev") == 0) {
+			/* need to disable a component device */
+			curr->type = SEQUENCE_ELEMENT_TYPE_CMPT_SEQ;
+			err = parse_component_seq(uc_mgr, n, 0,
+						&curr->data.cmpt_seq);
+			if (err < 0) {
+				uc_error("error: disdev requires a valid device!");
+				return err;
+			}
+			continue;
+		}
+
 		if (strcmp(cmd, "cset-bin-file") == 0) {
 			curr->type = SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE;
 			err = parse_string(n, &curr->data.cset);
@@ -957,6 +1061,7 @@ static int parse_verb_file(snd_use_case_mgr_t *uc_mgr,
 	INIT_LIST_HEAD(&verb->disable_list);
 	INIT_LIST_HEAD(&verb->transition_list);
 	INIT_LIST_HEAD(&verb->device_list);
+	INIT_LIST_HEAD(&verb->cmpt_device_list);
 	INIT_LIST_HEAD(&verb->modifier_list);
 	INIT_LIST_HEAD(&verb->value_list);
 	list_add_tail(&verb->list, &uc_mgr->verb_list);
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index b89de2a..3bfdd67 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -49,6 +49,7 @@
 #define SEQUENCE_ELEMENT_TYPE_EXEC	4
 #define SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE	5
 #define SEQUENCE_ELEMENT_TYPE_CSET_TLV	6
+#define SEQUENCE_ELEMENT_TYPE_CMPT_SEQ	7
 
 struct ucm_value {
         struct list_head list;
@@ -56,6 +57,12 @@ struct ucm_value {
         char *data;
 };
 
+/* sequence of a component device */
+struct component_sequence {
+	struct use_case_device *device; /* component device */
+	int enable; /* flag to choose enable or disable list of the device */
+};
+
 struct sequence_element {
 	struct list_head list;
 	unsigned int type;
@@ -64,6 +71,7 @@ struct sequence_element {
 		char *cdev;
 		char *cset;
 		char *exec;
+		struct component_sequence cmpt_seq; /* component sequence */
 	} data;
 };
 
@@ -167,6 +175,9 @@ struct use_case_verb {
 	/* hardware devices that can be used with this use case */
 	struct list_head device_list;
 
+	/* component device list */
+	struct list_head cmpt_device_list;
+
 	/* modifiers that can be used with this use case */
 	struct list_head modifier_list;
 
diff --git a/src/ucm/utils.c b/src/ucm/utils.c
index 45307b0..0fba85a 100644
--- a/src/ucm/utils.c
+++ b/src/ucm/utils.c
@@ -210,6 +210,7 @@ void uc_mgr_free_verb(snd_use_case_mgr_t *uc_mgr)
 		uc_mgr_free_transition(&verb->transition_list);
 		uc_mgr_free_value(&verb->value_list);
 		uc_mgr_free_device(&verb->device_list);
+		uc_mgr_free_device(&verb->cmpt_device_list);
 		uc_mgr_free_modifier(&verb->modifier_list);
 		list_del(&verb->list);
 		free(verb);
-- 
2.7.4
