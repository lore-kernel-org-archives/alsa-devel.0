From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/9] ctl: change former APIs as wrapper
	functions of element set APIs
Date: Wed, 15 Jun 2016 23:57:41 +0900
Message-ID: <1466002665-30048-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 222DA266B41
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:57:53 +0200 (CEST)
In-Reply-To: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In former commit, userspace library gets some APIs for element set. Some
existed functions can be simple wrappers of them.

This commit changes these APIs as wrapper functions. Additionally, this
commit also adds local variables for identical information of elements.
This modification is important to keep API consistency.

Some old APIs to add an element have id variables with const type
qualifier, while some new APIs to add element set changes the content of
given parameters. This comes from a change in Linux kernel 4.1.

In this commit [1], in-kernel implementation fills all fields of identical
data in userspace. As a result, when adding a new element set, userspace
applications can get an identical data for the first element in the set.
This lost the semantics of const type qualifier in userspace.

[1] http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/core?id=cab2ed7474bffafd2a68a885e03b85526194abcd

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 187 +++++++++++++-------------------------------------
 1 file changed, 49 insertions(+), 138 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 9fad0c0..38700bb 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -673,172 +673,83 @@ int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Create and add an user INTEGER CTL element
- * \param ctl CTL handle
- * \param id CTL element id to add
- * \param count number of elements
- * \param min minimum value
- * \param max maximum value
- * \param step value step
- * \return 0 on success otherwise a negative error code
+ * \brief Create and add an user-defined control element of integer type.
+ *
+ * This is a wrapper function to snd_ctl_elem_add_integer_set() for a control
+ * element. This doesn't fill the id data with full information, thus it's
+ * recommended to use snd_ctl_elem_add_integer_set(), instead.
  */
 int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			     unsigned int count, long min, long max, long step)
+			     unsigned int member_count,
+			     long min, long max, long step)
 {
-	snd_ctl_elem_info_t *info;
-	snd_ctl_elem_value_t *val;
-	unsigned int i;
-	int err;
+	snd_ctl_elem_id_t *local_id;
 
-	assert(ctl && id && id->name[0]);
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_INTEGER;
-	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE;
-	info->count = count;
-	info->value.integer.min = min;
-	info->value.integer.max = max;
-	info->value.integer.step = step;
-	err = ctl->ops->element_add(ctl, info);
-	if (err < 0)
-		return err;
-	snd_ctl_elem_value_alloca(&val);
-	val->id = info->id;
-	for (i = 0; i < count; i++)
-		val->value.integer.value[i] = min;
-	err = ctl->ops->element_write(ctl, val);
-	return err;
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
+
+	return snd_ctl_elem_add_integer_set(ctl, local_id, 1, member_count,
+					    min, max, step);
 }
 
 /**
- * \brief Create and add an user INTEGER64 CTL element
- * \param ctl CTL handle
- * \param id CTL element id to add
- * \param count number of elements
- * \param min minimum value
- * \param max maximum value
- * \param step value step
- * \return 0 on success otherwise a negative error code
+ * \brief Create and add an user-defined control element of integer64 type.
+ *
+ * This is a wrapper function to snd_ctl_elem_add_integer64_set() for a single
+ * control element. This doesn't fill the id data with full information, thus
+ * it's recommended to use snd_ctl_elem_add_integer64_set(), instead.
  */
 int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			       unsigned int count, long long min, long long max,
-			       long long step)
+			       unsigned int member_count,
+			       long long min, long long max, long long step)
 {
-	snd_ctl_elem_info_t *info;
-	snd_ctl_elem_value_t *val;
-	unsigned int i;
-	int err;
+	snd_ctl_elem_id_t *local_id;
 
-	assert(ctl && id && id->name[0]);
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_INTEGER64;
-	info->count = count;
-	info->value.integer64.min = min;
-	info->value.integer64.max = max;
-	info->value.integer64.step = step;
-	err = ctl->ops->element_add(ctl, info);
-	if (err < 0)
-		return err;
-	snd_ctl_elem_value_alloca(&val);
-	val->id = info->id;
-	for (i = 0; i < count; i++)
-		val->value.integer64.value[i] = min;
-	err = ctl->ops->element_write(ctl, val);
-	return err;
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
+
+	return snd_ctl_elem_add_integer64_set(ctl, local_id, 1, member_count,
+					      min, max, step);
 }
 
 /**
- * \brief Create and add an user BOOLEAN CTL element
- * \param ctl CTL handle
- * \param id CTL element id to add
- * \param count number of elements
- * \return 0 on success otherwise a negative error code
+ * \brief Create and add an user-defined control element of boolean type.
+ *
+ * This is a wrapper function to snd_ctl_elem_add_boolean_set() for a single
+ * control element. This doesn't fill the id data with full information, thus
+ * it's recommended to use snd_ctl_elem_add_boolean_set(), instead.
  */
 int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			     unsigned int count)
+			     unsigned int member_count)
 {
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_id_t *local_id;
 
-	assert(ctl && id && id->name[0]);
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_BOOLEAN;
-	info->count = count;
-	info->value.integer.min = 0;
-	info->value.integer.max = 1;
-	return ctl->ops->element_add(ctl, info);
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
+
+	return snd_ctl_elem_add_boolean_set(ctl, local_id, 1, member_count);
 }
 
 /**
- * \brief Create and add a user-defined control element of type enumerated.
- * \param[in] ctl Control device handle.
- * \param[in] id ID of the new control element.
- * \param[in] count Number of element values.
- * \param[in] items Range of possible values (0 ... \a items - 1).
- * \param[in] names An array containing \a items strings.
- * \return Zero on success, otherwise a negative error code.
+ * \brief Create and add a user-defined control element of enumerated type.
  *
- * This function creates a user element, i.e., a control element that is not
- * controlled by the control device's driver but that is just stored together
- * with the other elements of \a ctl.
+ * This is a wrapper function to snd_ctl_elem_add_enumerated_set() for a single
+ * control element. This doesn't fill the id data with full information, thus
+ * it's recommended to use snd_ctl_elem_add_enumerated_set(), instead.
  *
- * The fields of \a id, except numid, must be set to unique values that
- * identify the new element.
- *
- * The new element is locked; its value is initialized as zero.
- *
- * \par Errors:
- * <dl>
- * <dt>-EBUSY<dd>A control element with ID \a id already exists.
- * <dt>-EINVAL<dd>\a count is not at least one or greater than 128, or \a items
- * 	is not at least one, or a string in \a names is empty or longer than 63
- * 	bytes, or the strings in \a names require more than 64 KB storage.
- * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
- * <dt>-ENXIO<dd>This driver does not support (enumerated) user controls.
- * <dt>-ENODEV<dd>Device unplugged.
- * </dl>
- *
- * \par Compatibility:
- * snd_ctl_elem_add_enumerated() was introduced in ALSA 1.0.25.
+ * This function is added in version 1.0.25.
  */
 int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-				unsigned int count, unsigned int items,
-				const char *const names[])
+				unsigned int member_count, unsigned int items,
+				const char *const labels[])
 {
-	snd_ctl_elem_info_t *info;
-	unsigned int i, bytes;
-	char *buf, *p;
-	int err;
-
-	assert(ctl && id && id->name[0] && names);
-
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_ENUMERATED;
-	info->count = count;
-	info->value.enumerated.items = items;
-
-	bytes = 0;
-	for (i = 0; i < items; ++i)
-		bytes += strlen(names[i]) + 1;
-	buf = bytes ? malloc(bytes) : NULL;
-	if (!buf)
-		return -ENOMEM;
-	info->value.enumerated.names_ptr = (uintptr_t)buf;
-	info->value.enumerated.names_length = bytes;
-	p = buf;
-	for (i = 0; i < items; ++i) {
-		strcpy(p, names[i]);
-		p += strlen(names[i]) + 1;
-	}
+	snd_ctl_elem_id_t *local_id;
 
-	err = ctl->ops->element_add(ctl, info);
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
 
-	free(buf);
-
-	return err;
+	return snd_ctl_elem_add_enumerated_set(ctl, local_id, 1, member_count,
+					       items, labels);
 }
 
 /**
-- 
2.7.4
