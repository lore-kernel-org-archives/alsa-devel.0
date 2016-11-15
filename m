From: mengdong.lin@linux.intel.com
Subject: [RFC PATCH 3/3] ucm: Execute sequence of component
	devices
Date: Tue, 15 Nov 2016 16:02:38 +0800
Message-ID: <b610787835a8530f0b3105321e8f15661fc55b0b.1479195801.git.mengdong.lin@linux.intel.com>
References: <cover.1479195801.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3859C266FF1
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 09:00:53 +0100 (CET)
In-Reply-To: <cover.1479195801.git.mengdong.lin@linux.intel.com>
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

A machine device's sequence can enable or disable a component device. So
when executing a machine device's sequence, the enable or disable sequence
of its component devices will also be excecuted.

Add a parameter 'cdev_in' to function execute_sequence(). This function
is used to execute a sequence of either machine or component devices.
Since the sequence of a component device does not define the card device,
when executing its sequence, this parameter can pass the cdev defined by
the sequence of its parent, the machine device. When executing sequence of
machine devices, this parameter should be set to NULL.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 8cc9208..a852cf4 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -48,6 +48,13 @@ static int get_value3(char **value,
 		      struct list_head *value_list2,
 		      struct list_head *value_list3);
 
+static int execute_component_seq(snd_use_case_mgr_t *uc_mgr,
+				 struct component_sequence *cmpt_seq,
+				 struct list_head *value_list1,
+				 struct list_head *value_list2,
+				 struct list_head *value_list3,
+				 char *cdev_in);
+
 static int check_identifier(const char *identifier, const char *prefix)
 {
 	int len;
@@ -341,13 +348,22 @@ static int execute_cset(snd_ctl_t *ctl, const char *cset, unsigned int type)
  * \brief Execute the sequence
  * \param uc_mgr Use case manager
  * \param seq Sequence
+ * \param cdev_in input cdev,  parenet's cdev for a component device,
+ *				or NULL for a machine device.
  * \return zero on success, otherwise a negative error code
+ *
+ * A machine device's sequence can enable or disable a component device.
+ * But the enable/disable sequence of a component device does not define
+ * cdev, the card device. So when executing a component device's sequence,
+ * we need to pass the cdev defined by the sequence of its parent, the
+ * machine device. And for machine device, cdev should be set to NULL.
  */
 static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 			    struct list_head *seq,
 			    struct list_head *value_list1,
 			    struct list_head *value_list2,
-			    struct list_head *value_list3)
+			    struct list_head *value_list3,
+			    char *cdev_in)
 {
 	struct list_head *pos;
 	struct sequence_element *s;
@@ -366,7 +382,16 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 		case SEQUENCE_ELEMENT_TYPE_CSET:
 		case SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE:
 		case SEQUENCE_ELEMENT_TYPE_CSET_TLV:
-			if (cdev == NULL) {
+			if (cdev == NULL && cdev_in) {
+				/* Sequence of a component device, should use
+				 * the input cdev defined by sequence of its
+				 * parent, the machine device.
+				 */
+				cdev = strdup(cdev_in);
+				if (cdev == NULL)
+					goto __fail_nomem;
+
+			} else if (cdev == NULL) {
 				char *playback_ctl = NULL;
 				char *capture_ctl = NULL;
 
@@ -405,7 +430,9 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 					free(capture_ctl);
 				} else
 					cdev = capture_ctl;
+
 			}
+
 			if (ctl == NULL) {
 				err = open_ctl(uc_mgr, &ctl, cdev);
 				if (err < 0) {
@@ -427,6 +454,19 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 			if (err < 0)
 				goto __fail;
 			break;
+		case SEQUENCE_ELEMENT_TYPE_CMPT_SEQ:
+			/* Execute enable or disable sequence of a component
+			 * device. Pass the cdev defined by the machine device.
+			 */
+			err = execute_component_seq(uc_mgr,
+							&s->data.cmpt_seq,
+							value_list1,
+							value_list2,
+							value_list3,
+							cdev);
+			if (err < 0)
+				goto __fail;
+			break;
 		default:
 			uc_error("unknown sequence command %i", s->type);
 			break;
@@ -442,6 +482,39 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 
 }
 
+/* Execute enable or disable sequence of a component device.
+ *
+ * For a component device (a codec or embedded DSP), its sequence doesn't
+ * specify the sound card device 'cdev', because a component can be reused
+ * by different sound cards (machines). So when executing its sequence, a
+ * parameter 'cdev_in' is used to pass cdev defined by the sequence of its
+ * parent, the machine device.
+ */
+static int execute_component_seq(snd_use_case_mgr_t *uc_mgr,
+				 struct component_sequence *cmpt_seq,
+				 struct list_head *value_list1,
+				 struct list_head *value_list2,
+				 struct list_head *value_list3,
+				 char *cdev_in)
+{
+	struct use_case_device *device = cmpt_seq->device;
+	struct list_head *seq;
+	int err;
+
+
+	if (cmpt_seq->enable)
+		seq = &device->enable_list;
+	else
+		seq = &device->disable_list;
+
+	err = execute_sequence(uc_mgr, seq,
+			       &device->value_list,
+			       &uc_mgr->active_verb->value_list,
+			       &uc_mgr->value_list,
+			       cdev_in);
+	return err;
+}
+
 /**
  * \brief Import master config and execute the default sequence
  * \param uc_mgr Use case manager
@@ -455,7 +528,7 @@ static int import_master_config(snd_use_case_mgr_t *uc_mgr)
 	if (err < 0)
 		return err;
 	err = execute_sequence(uc_mgr, &uc_mgr->default_list,
-			       &uc_mgr->value_list, NULL, NULL);
+			       &uc_mgr->value_list, NULL, NULL, NULL);
 	if (err < 0)
 		uc_error("Unable to execute default sequence");
 	return err;
@@ -761,7 +834,7 @@ static int set_verb(snd_use_case_mgr_t *uc_mgr,
 	err = execute_sequence(uc_mgr, seq,
 			       &verb->value_list,
 			       &uc_mgr->value_list,
-			       NULL);
+			       NULL, NULL);
 	if (enable && err >= 0)
 		uc_mgr->active_verb = verb;
 	return err;
@@ -792,7 +865,8 @@ static int set_modifier(snd_use_case_mgr_t *uc_mgr,
 	err = execute_sequence(uc_mgr, seq,
 			       &modifier->value_list,
 			       &uc_mgr->active_verb->value_list,
-			       &uc_mgr->value_list);
+			       &uc_mgr->value_list,
+			       NULL);
 	if (enable && err >= 0) {
 		list_add_tail(&modifier->active_list, &uc_mgr->active_modifiers);
 	} else if (!enable) {
@@ -826,7 +900,8 @@ static int set_device(snd_use_case_mgr_t *uc_mgr,
 	err = execute_sequence(uc_mgr, seq,
 			       &device->value_list,
 			       &uc_mgr->active_verb->value_list,
-			       &uc_mgr->value_list);
+			       &uc_mgr->value_list,
+			       NULL);
 	if (enable && err >= 0) {
 		list_add_tail(&device->active_list, &uc_mgr->active_devices);
 	} else if (!enable) {
@@ -953,7 +1028,7 @@ static int dismantle_use_case(snd_use_case_mgr_t *uc_mgr)
 	uc_mgr->active_verb = NULL;
 
 	err = execute_sequence(uc_mgr, &uc_mgr->default_list,
-			       &uc_mgr->value_list, NULL, NULL);
+			       &uc_mgr->value_list, NULL, NULL, NULL);
 	
 	return err;
 }
@@ -969,7 +1044,7 @@ int snd_use_case_mgr_reset(snd_use_case_mgr_t *uc_mgr)
 
 	pthread_mutex_lock(&uc_mgr->mutex);
 	err = execute_sequence(uc_mgr, &uc_mgr->default_list,
-			       &uc_mgr->value_list, NULL, NULL);
+			       &uc_mgr->value_list, NULL, NULL, NULL);
 	INIT_LIST_HEAD(&uc_mgr->active_modifiers);
 	INIT_LIST_HEAD(&uc_mgr->active_devices);
 	uc_mgr->active_verb = NULL;
@@ -1578,6 +1653,7 @@ static int handle_transition_verb(snd_use_case_mgr_t *uc_mgr,
                         err = execute_sequence(uc_mgr, &trans->transition_list,
 					       &uc_mgr->active_verb->value_list,
 					       &uc_mgr->value_list,
+					       NULL,
 					       NULL);
                         if (err >= 0)
                                 return 1;
@@ -1689,7 +1765,8 @@ static int switch_device(snd_use_case_mgr_t *uc_mgr,
                         err = execute_sequence(uc_mgr, &trans->transition_list,
 					       &xold->value_list,
 					       &uc_mgr->active_verb->value_list,
-					       &uc_mgr->value_list);
+					       &uc_mgr->value_list,
+					       NULL);
                         if (err >= 0) {
                                 list_del(&xold->active_list);
                                 list_add_tail(&xnew->active_list, &uc_mgr->active_devices);
@@ -1741,7 +1818,8 @@ static int switch_modifier(snd_use_case_mgr_t *uc_mgr,
                         err = execute_sequence(uc_mgr, &trans->transition_list,
 					       &xold->value_list,
 					       &uc_mgr->active_verb->value_list,
-					       &uc_mgr->value_list);
+					       &uc_mgr->value_list,
+					       NULL);
                         if (err >= 0) {
                                 list_del(&xold->active_list);
                                 list_add_tail(&xnew->active_list, &uc_mgr->active_modifiers);
-- 
2.7.4
