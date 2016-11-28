From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 3/3] ucm: Execute sequence of component
	devices
Date: Mon, 28 Nov 2016 13:34:21 +0800
Message-ID: <dcfe20086be514cc044735956b00377f41eab495.1480309753.git.mengdong.lin@linux.intel.com>
References: <cover.1480309753.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 79ADC2669E3
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 06:32:16 +0100 (CET)
In-Reply-To: <cover.1480309753.git.mengdong.lin@linux.intel.com>
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

Components don't define card device cdev in their sequences. So before
executing a component device sequence, UCM manager will
- store cdev defined by the sequence of its parent, the machine device;
- mark itself entering 'component domain'.

Then this cdev will be used to excute the sequence of the component
device.

When UCM manager completes executing the sequence of the component device,
it will leave 'compnent domain' and reset the saved cdev to NULL.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 8cc9208..750e65d 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -35,6 +35,7 @@
 #include <stdarg.h>
 #include <pthread.h>
 #include <sys/stat.h>
+#include <limits.h>
 
 /*
  * misc
@@ -48,6 +49,13 @@ static int get_value3(char **value,
 		      struct list_head *value_list2,
 		      struct list_head *value_list3);
 
+static int execute_component_seq(snd_use_case_mgr_t *uc_mgr,
+				 struct component_sequence *cmpt_seq,
+				 struct list_head *value_list1,
+				 struct list_head *value_list2,
+				 struct list_head *value_list3,
+				 char *cdev);
+
 static int check_identifier(const char *identifier, const char *prefix)
 {
 	int len;
@@ -366,7 +374,19 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 		case SEQUENCE_ELEMENT_TYPE_CSET:
 		case SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE:
 		case SEQUENCE_ELEMENT_TYPE_CSET_TLV:
-			if (cdev == NULL) {
+			if (cdev == NULL && uc_mgr->in_component_domain) {
+				/* For sequence of a component device, use
+				 * its parent's cdev stored by ucm manager.
+				 */
+				if (uc_mgr->cdev == NULL) {
+					uc_error("cdev is not defined!");
+					return err;
+				}
+
+				cdev = strndup(uc_mgr->cdev, PATH_MAX);
+				if (!cdev)
+					return -ENOMEM;
+			} else if (cdev == NULL) {
 				char *playback_ctl = NULL;
 				char *capture_ctl = NULL;
 
@@ -427,6 +447,19 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 			if (err < 0)
 				goto __fail;
 			break;
+		case SEQUENCE_ELEMENT_TYPE_CMPT_SEQ:
+			/* Execute enable or disable sequence of a component
+			 * device. Pass the cdev defined by the machine device.
+			 */
+			err = execute_component_seq(uc_mgr,
+						    &s->data.cmpt_seq,
+						    value_list1,
+						    value_list2,
+						    value_list3,
+						    cdev);
+			if (err < 0)
+				goto __fail;
+			break;
 		default:
 			uc_error("unknown sequence command %i", s->type);
 			break;
@@ -442,6 +475,49 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 
 }
 
+/* Execute enable or disable sequence of a component device.
+ *
+ * For a component device (a codec or embedded DSP), its sequence doesn't
+ * specify the sound card device 'cdev', because a component can be reused
+ * by different sound cards (machines). So when executing its sequence, a
+ * parameter 'cdev' is used to pass cdev defined by the sequence of its
+ * parent, the machine device. UCM manger will store the cdev when entering
+ * the component domain.
+ */
+static int execute_component_seq(snd_use_case_mgr_t *uc_mgr,
+				 struct component_sequence *cmpt_seq,
+				 struct list_head *value_list1,
+				 struct list_head *value_list2,
+				 struct list_head *value_list3,
+				 char *cdev)
+{
+	struct use_case_device *device = cmpt_seq->device;
+	struct list_head *seq;
+	int err;
+
+	/* enter component domain and store cdev for the component */
+	uc_mgr->in_component_domain = 1;
+	uc_mgr->cdev = cdev;
+
+	/* choose enable or disable sequence of the component device */
+	if (cmpt_seq->enable)
+		seq = &device->enable_list;
+	else
+		seq = &device->disable_list;
+
+	/* excecute the sequence of the component dev */
+	err = execute_sequence(uc_mgr, seq,
+			       &device->value_list,
+			       &uc_mgr->active_verb->value_list,
+			       &uc_mgr->value_list);
+
+	/* exit component domain and clear cdev */
+	uc_mgr->in_component_domain = 0;
+	uc_mgr->cdev = NULL;
+
+	return err;
+}
+
 /**
  * \brief Import master config and execute the default sequence
  * \param uc_mgr Use case manager
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 3bfdd67..6d3302f 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -212,6 +212,14 @@ struct snd_use_case_mgr {
 	/* change to list of ctl handles */
 	snd_ctl_t *ctl;
 	char *ctl_dev;
+
+	/* Components don't define cdev, the card device. When executing
+	 * a sequence of a component device, ucm manager enters component
+	 * domain and needs to provide cdev to the component. This cdev
+	 * should be defined by the machine, parent of the component.
+	 */
+	int in_component_domain;
+	char *cdev;
 };
 
 #define uc_error SNDERR
-- 
2.7.4
