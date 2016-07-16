From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] ctl: rename APIs to add an element
	set so that their names are appropriate
Date: Sat, 16 Jul 2016 22:20:01 +0900
Message-ID: <1468675201-31693-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 4680726509E
 for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2016 15:20:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In this development period, some APIs have already been added. Most of
them are to add an element set, while their names are not so appropriate
against their feature. This is due to following to names of old APIs.

This commit renames them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h           | 10 +++++-----
 src/control/control.c       | 34 +++++++++++++++++-----------------
 src/pcm/pcm_softvol.c       |  4 ++--
 test/user-ctl-element-set.c | 10 +++++-----
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/control.h b/include/control.h
index cd60d90..1d4bfcb 100644
--- a/include/control.h
+++ b/include/control.h
@@ -425,24 +425,24 @@ void snd_ctl_elem_info_set_subdevice(snd_ctl_elem_info_t *obj, unsigned int val)
 void snd_ctl_elem_info_set_name(snd_ctl_elem_info_t *obj, const char *val);
 void snd_ctl_elem_info_set_index(snd_ctl_elem_info_t *obj, unsigned int val);
 
-int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_integer_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count,
 				 long min, long max, long step);
-int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_integer64_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				   unsigned int element_count,
 				   unsigned int member_count,
 				   long long min, long long max,
 				   long long step);
-int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_boolean_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count);
-int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_enumerated_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				    unsigned int element_count,
 				    unsigned int member_count,
 				    unsigned int items,
 				    const char *const labels[]);
-int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_bytes_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 			       unsigned int element_count,
 			       unsigned int member_count);
 
diff --git a/src/control/control.c b/src/control/control.c
index a48ba9d..aa05130 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -371,7 +371,7 @@ static bool validate_element_member_dimension(snd_ctl_elem_info_t *info)
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_integer_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count,
 				 long min, long max, long step)
@@ -460,7 +460,7 @@ int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_integer64_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				   unsigned int element_count,
 				   unsigned int member_count,
 				   long long min, long long max, long long step)
@@ -545,7 +545,7 @@ int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_boolean_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count)
 {
@@ -609,7 +609,7 @@ int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_enumerated_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				    unsigned int element_count,
 				    unsigned int member_count,
 				    unsigned int items,
@@ -694,7 +694,7 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
+int snd_ctl_add_bytes_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 			       unsigned int element_count,
 			       unsigned int member_count)
 {
@@ -716,9 +716,9 @@ int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 /**
  * \brief Create and add an user-defined control element of integer type.
  *
- * This is a wrapper function to snd_ctl_elem_add_integer_set() for a control
+ * This is a wrapper function to snd_ctl_add_integer_elem_set() for a control
  * element. This doesn't fill the id data with full information, thus it's
- * recommended to use snd_ctl_elem_add_integer_set(), instead.
+ * recommended to use snd_ctl_add_integer_elem_set(), instead.
  */
 int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int member_count,
@@ -728,16 +728,16 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 
 	info.id = *id;
 
-	return snd_ctl_elem_add_integer_set(ctl, &info, 1, member_count,
+	return snd_ctl_add_integer_elem_set(ctl, &info, 1, member_count,
 					    min, max, step);
 }
 
 /**
  * \brief Create and add an user-defined control element of integer64 type.
  *
- * This is a wrapper function to snd_ctl_elem_add_integer64_set() for a single
+ * This is a wrapper function to snd_ctl_add_integer64_elem_set() for a single
  * control element. This doesn't fill the id data with full information, thus
- * it's recommended to use snd_ctl_elem_add_integer64_set(), instead.
+ * it's recommended to use snd_ctl_add_integer64_elem_set(), instead.
  */
 int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			       unsigned int member_count,
@@ -747,16 +747,16 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 
 	info.id = *id;
 
-	return snd_ctl_elem_add_integer64_set(ctl, &info, 1, member_count,
+	return snd_ctl_add_integer64_elem_set(ctl, &info, 1, member_count,
 					      min, max, step);
 }
 
 /**
  * \brief Create and add an user-defined control element of boolean type.
  *
- * This is a wrapper function to snd_ctl_elem_add_boolean_set() for a single
+ * This is a wrapper function to snd_ctl_add_boolean_elem_set() for a single
  * control element. This doesn't fill the id data with full information, thus
- * it's recommended to use snd_ctl_elem_add_boolean_set(), instead.
+ * it's recommended to use snd_ctl_add_boolean_elem_set(), instead.
  */
 int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int member_count)
@@ -765,15 +765,15 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 
 	info.id = *id;
 
-	return snd_ctl_elem_add_boolean_set(ctl, &info, 1, member_count);
+	return snd_ctl_add_boolean_elem_set(ctl, &info, 1, member_count);
 }
 
 /**
  * \brief Create and add a user-defined control element of enumerated type.
  *
- * This is a wrapper function to snd_ctl_elem_add_enumerated_set() for a single
+ * This is a wrapper function to snd_ctl_add_enumerated_elem_set() for a single
  * control element. This doesn't fill the id data with full information, thus
- * it's recommended to use snd_ctl_elem_add_enumerated_set(), instead.
+ * it's recommended to use snd_ctl_add_enumerated_elem_set(), instead.
  *
  * This function is added in version 1.0.25.
  */
@@ -785,7 +785,7 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 
 	info.id = *id;
 
-	return snd_ctl_elem_add_enumerated_set(ctl, &info, 1, member_count,
+	return snd_ctl_add_enumerated_elem_set(ctl, &info, 1, member_count,
 					       items, labels);
 }
 
diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index 6135778..1fe5784 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -671,9 +671,9 @@ static int add_user_ctl(snd_pcm_softvol_t *svol, snd_ctl_elem_info_t *cinfo,
 	unsigned int def_val;
 	
 	if (svol->max_val == 1)
-		err = snd_ctl_elem_add_boolean_set(svol->ctl, cinfo, 1, count);
+		err = snd_ctl_add_boolean_elem_set(svol->ctl, cinfo, 1, count);
 	else
-		err = snd_ctl_elem_add_integer_set(svol->ctl, cinfo, 1, count,
+		err = snd_ctl_add_integer_elem_set(svol->ctl, cinfo, 1, count,
 						   0, svol->max_val, 0);
 	if (err < 0)
 		return err;
diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 0481300..9b9dc59 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -31,7 +31,7 @@ struct elem_set_trial {
 static int add_bool_elem_set(struct elem_set_trial *trial,
 			     snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_boolean_set(trial->handle, info,
+	return snd_ctl_add_boolean_elem_set(trial->handle, info,
 				trial->element_count, trial->member_count);
 }
 
@@ -51,7 +51,7 @@ static void change_bool_elem_members(struct elem_set_trial *trial,
 static int add_int_elem_set(struct elem_set_trial *trial,
 			    snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_integer_set(trial->handle, info,
+	return snd_ctl_add_integer_elem_set(trial->handle, info,
 				trial->element_count, trial->member_count,
 				0, 99, 1);
 }
@@ -93,7 +93,7 @@ static const char *const labels[] = {
 static int add_enum_elem_set(struct elem_set_trial *trial,
 			     snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_enumerated_set(trial->handle, info,
+	return snd_ctl_add_enumerated_elem_set(trial->handle, info,
 				trial->element_count, trial->member_count,
 				sizeof(labels) / sizeof(labels[0]),
 				labels);
@@ -142,7 +142,7 @@ static void change_enum_elem_members(struct elem_set_trial *trial,
 static int add_bytes_elem_set(struct elem_set_trial *trial,
 			      snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_bytes_set(trial->handle, info,
+	return snd_ctl_add_bytes_elem_set(trial->handle, info,
 				trial->element_count, trial->member_count);
 }
 
@@ -195,7 +195,7 @@ static void change_iec958_elem_members(struct elem_set_trial *trial,
 static int add_int64_elem_set(struct elem_set_trial *trial,
 			      snd_ctl_elem_info_t *info)
 {
-	return snd_ctl_elem_add_integer64_set(trial->handle, info,
+	return snd_ctl_add_integer64_elem_set(trial->handle, info,
 				trial->element_count, trial->member_count,
 				100, 10000, 30);
 }
-- 
2.7.4
