From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 3/3] ucm: Execute sequence of component
	devices
Date: Fri, 18 Nov 2016 13:28:11 +0800
Message-ID: <5c28a80cf70a75472ed001cc71c4d3be4199f40f.1479446217.git.mengdong.lin@linux.intel.com>
References: <cover.1479446217.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D500265823
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 06:26:21 +0100 (CET)
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

A machine device's sequence can enable or disable a component device. So
when executing a machine device's sequence, the enable or disable sequence
of its component devices will also be excecuted.

Components don't define card device cdev in their sequences. So before
executing a component device sequence, UCM manager will
- store cdev defined by the sequence of its parent, the machine device;
- mark itself entering 'component domain'.

Then this cdev will be used to excute the sequence of the component
device.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 8cc9208..4a78877 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -35,6 +35,7 @@
 #include <stdarg.h>
 #include <pthread.h>
 #include <sys/stat.h>
+#include <limits.h>
 
 /*
  * misc
@@ -48,6 +49,30 @@ static int get_value3(char **value,
 		      struct list_head *value_list2,
 		      struct list_head *value_list3);
 
+/* enter component domain and store cdev for the component */
+#define ENTER_COMPONENT_DOMAIN(uc_mgr, cdev) \
+	do {\
+		(uc_mgr)->in_component_domain = 1;\
+		(uc_mgr)->cdev = (cdev);\
+	} while (0)
+
+/* exit component domain and clear cdev */
+#define EXIT_COMPONENT_DOMAIN(uc_mgr) \
+	do {\
+		(uc_mgr)->in_component_domain = 0;\
+		(uc_mgr)->cdev = NULL;\
+	} while (0)
+
+#define IN_COMPONENT_DOMAIN(uc_mgr) \
+	((uc_mgr)->in_component_domain)
+
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
@@ -366,7 +391,19 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 		case SEQUENCE_ELEMENT_TYPE_CSET:
 		case SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE:
 		case SEQUENCE_ELEMENT_TYPE_CSET_TLV:
-			if (cdev == NULL) {
+			if (cdev == NULL && IN_COMPONENT_DOMAIN(uc_mgr)) {
+				/* For sequence of a component device, use
+				 * parent's cdev stored by ucm manager.
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
 
@@ -427,6 +464,19 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
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
@@ -442,6 +492,42 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 
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
+	ENTER_COMPONENT_DOMAIN(uc_mgr, cdev);
+
+	if (cmpt_seq->enable)
+		seq = &device->enable_list;
+	else
+		seq = &device->disable_list;
+
+	err = execute_sequence(uc_mgr, seq,
+			       &device->value_list,
+			       &uc_mgr->active_verb->value_list,
+			       &uc_mgr->value_list);
+
+	EXIT_COMPONENT_DOMAIN(uc_mgr);
+	return err;
+}
+
 /**
  * \brief Import master config and execute the default sequence
  * \param uc_mgr Use case manager
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 3bfdd67..614e786 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -212,6 +212,14 @@ struct snd_use_case_mgr {
 	/* change to list of ctl handles */
 	snd_ctl_t *ctl;
 	char *ctl_dev;
+
+	/* Components don't define cdev, the card device. When executing
+	 * a sequence of a component device, ucm manager enters compoent
+	 * domain and needs to provide cdev to the component. This cdev
+	 * should be defined by the machine, parent of the component.
+	 */
+	int in_component_domain;
+	char *cdev;
 };
 
 #define uc_error SNDERR
-- 
2.7.4
