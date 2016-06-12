From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/10] ctl: add functions to add an element set
Date: Sun, 12 Jun 2016 17:16:04 +0900
Message-ID: <1465719371-27721-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 89D2E260511
 for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2016 10:16:17 +0200 (CEST)
In-Reply-To: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
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

ALSA control core allows userspace applications to add an element set.
However, in ALSA userspace library, there's no APIs enough to utilize
the feature. The library has APIs just to add an element set with a single
element.

This commit adds functions to add an element set with several elements.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h     |  21 +++
 src/control/control.c | 392 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 413 insertions(+)

diff --git a/include/control.h b/include/control.h
index 5fdf379..d6069ff 100644
--- a/include/control.h
+++ b/include/control.h
@@ -423,6 +423,27 @@ void snd_ctl_elem_info_set_subdevice(snd_ctl_elem_info_t *obj, unsigned int val)
 void snd_ctl_elem_info_set_name(snd_ctl_elem_info_t *obj, const char *val);
 void snd_ctl_elem_info_set_index(snd_ctl_elem_info_t *obj, unsigned int val);
 
+int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				 unsigned int element_count,
+				 unsigned int member_count,
+				 long min, long max, long step);
+int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				   unsigned int element_count,
+				   unsigned int member_count,
+				   long long min, long long max,
+				   long long step);
+int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				 unsigned int element_count,
+				 unsigned int member_count);
+int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				    unsigned int element_count,
+				    unsigned int member_count,
+				    unsigned int items,
+				    const char *const labels[]);
+int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+			       unsigned int element_count,
+			       unsigned int member_count);
+
 int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, long imin, long imax, long istep);
 int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, long long imin, long long imax, long long istep);
 int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count);
diff --git a/src/control/control.c b/src/control/control.c
index 7d1e412..48b0080 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -281,6 +281,398 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
 }
 
 /**
+ * \brief Create and add some user-defined control elements of integer type.
+ * \param ctl A handle of backend module for control interface.
+ * \param id ID of the first new element.
+ * \param element_count The number of elements added by this operation.
+ * \param member_count The number of members which a element has to
+ *			   represent its states.
+ * \param min Minimum value for each member of the elements.
+ * \param max Maximum value for each member of the elements.
+ * \param step The step of value for each member in the elements.
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function creates some user elements with integer type. These elements
+ * are not controlled by device drivers in kernel. They can be operated by the
+ * same way as usual elements added by the device drivers.
+ *
+ * The name field of \a id must be set with unique value to identify new control
+ * elements. After returning, all fields of \a id are filled. A element can be
+ * identified by the combination of name and index, or by numid.
+ *
+ * All of members in the new elements are locked. The value of each member is
+ * initialized with the minimum value.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY
+ * <dd>A element with ID \a id already exists.
+ * <dt>-EINVAL
+ * <dd>ID has no name, or the number of members is not between 1 to 127.
+ * <dt>-ENOMEM
+ * <dd>Out of memory, or there are too many user elements.
+ * <dt>-ENXIO
+ * <dd>This backend module does not support user elements of integer type.
+ * <dt>-ENODEV
+ * <dd>Device unplugged.
+ * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.2.
+ */
+int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				 unsigned int element_count,
+				 unsigned int member_count,
+				 long min, long max, long step)
+{
+	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_value_t *data;
+	unsigned int i;
+	unsigned int j;
+	unsigned int numid;
+	int err;
+
+	assert(ctl && id && id->name[0]);
+
+	snd_ctl_elem_info_alloca(&info);
+	info->id = *id;
+	info->type = SND_CTL_ELEM_TYPE_INTEGER;
+	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_USER;
+	info->owner = element_count;
+	info->count = member_count;
+	info->value.integer.min = min;
+	info->value.integer.max = max;
+	info->value.integer.step = step;
+
+	err = ctl->ops->element_add(ctl, info);
+	if (err < 0)
+		return err;
+	numid = snd_ctl_elem_id_get_numid(&info->id);
+
+	/* Set initial value to all of members in all of added elements. */
+	snd_ctl_elem_value_alloca(&data);
+	data->id = info->id;
+	for (i = 0; i < element_count; i++) {
+		snd_ctl_elem_id_set_numid(&data->id, numid + i);
+
+		for (j = 0; j < member_count; j++)
+			data->value.integer.value[j] = min;
+
+		err = ctl->ops->element_write(ctl, data);
+		if (err < 0)
+			return err;
+	}
+
+	*id = info->id;
+	return 0;
+}
+
+/**
+ * \brief Create and add some user-defined control elements of integer64 type.
+ * \param ctl A handle of backend module for control interface.
+ * \param id ID of the first new control element.
+ * \param element_count The number of elements added by this operation.
+ * \param member_count The number of members which a element has to
+ *	    	   represent its states.
+ * \param min Minimum value for each member of the elements.
+ * \param max Maximum value for each member of the elements.
+ * \param step The step of value for each member in the elements.
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function creates some user elements with integer64 type. These elements
+ * are not controlled by device drivers in kernel. They can be operated by the
+ * same way as usual elements added by the device drivers.
+ *
+ * The name field of \a id must be set with unique value to identify new control
+ * elements. After returning, all fields of \a id are filled. A element can be
+ * identified by the combination of name and index, or by numid.
+ *
+ * All of members in the new elements are locked. The value of each member is
+ * initialized with the minimum value.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY
+ * <dd>A element with ID \a id already exists.
+ * <dt>-EINVAL
+ * <dd>ID has no name, or the number of members is not between 1 to 127.
+ * <dt>-ENOMEM
+ * <dd>Out of memory, or there are too many user elements.
+ * <dt>-ENXIO
+ * <dd>This backend module does not support user elements of integer64 type.
+ * <dt>-ENODEV
+ * <dd>Device unplugged.
+ * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.2.
+ */
+int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				   unsigned int element_count,
+				   unsigned int member_count,
+				   long long min, long long max, long long step)
+{
+	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_value_t *data;
+	unsigned int i;
+	unsigned int j;
+	unsigned int numid;
+	int err;
+
+	assert(ctl && id && id->name[0]);
+
+	snd_ctl_elem_info_alloca(&info);
+	info->id = *id;
+	info->type = SND_CTL_ELEM_TYPE_INTEGER64;
+	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_USER;
+	info->owner = element_count;
+	info->count = member_count;
+	info->value.integer64.min = min;
+	info->value.integer64.max = max;
+	info->value.integer64.step = step;
+
+	err = ctl->ops->element_add(ctl, info);
+	if (err < 0)
+		return err;
+	numid = snd_ctl_elem_id_get_numid(&info->id);
+
+	/* Set initial value to all of members in all of added elements. */
+	snd_ctl_elem_value_alloca(&data);
+	data->id = info->id;
+	for (i = 0; i < element_count; i++) {
+		snd_ctl_elem_id_set_numid(&data->id, numid + i);
+
+		for (j = 0; j < member_count; j++)
+			data->value.integer64.value[j] = min;
+
+		err = ctl->ops->element_write(ctl, data);
+		if (err < 0)
+			return err;
+	}
+
+	*id = info->id;
+	return 0;
+}
+
+/**
+ * \brief Create and add some user-defined control elements of boolean type.
+ * \param ctl A handle of backend module for control interface.
+ * \param id ID of the new control element.
+ * \param element_count The number of elements added by this operation.
+ * \param member_count The number of members which a element has to
+ *			   represent its states.
+ *
+ * This function creates some user elements with boolean type. These elements
+ * are not controlled by device drivers in kernel. They can be operated by the
+ * same way as usual elements added by the device drivers.
+ *
+ * The name field of \a id must be set with unique value to identify new control
+ * elements. After returning, all fields of \a id are filled. A element can be
+ * identified by the combination of name and index, or by numid.
+ *
+ * All of members in the new elements are locked. The value of each member is
+ * initialized with false.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY
+ * <dd>A element with ID \a id already exists.
+ * <dt>-EINVAL
+ * <dd>ID has no name, or the number of members is not between 1 to 127.
+ * <dt>-ENOMEM
+ * <dd>Out of memory, or there are too many user elements.
+ * <dt>-ENXIO
+ * <dd>This backend module does not support user elements of boolean type.
+ * <dt>-ENODEV
+ * <dd>Device unplugged.
+ * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.2.
+ */
+int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				 unsigned int element_count,
+				 unsigned int member_count)
+{
+	snd_ctl_elem_info_t *info;
+	int err;
+
+	assert(ctl && id && id->name[0]);
+
+	snd_ctl_elem_info_alloca(&info);
+	info->id = *id;
+	info->type = SND_CTL_ELEM_TYPE_BOOLEAN;
+	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_USER;
+	info->owner = element_count;
+	info->count = member_count;
+	info->value.integer.min = 0;
+	info->value.integer.max = 1;
+
+	err = ctl->ops->element_add(ctl, info);
+	if (err >= 0)
+		*id = info->id;
+
+	return err;
+}
+
+/**
+ * \brief Create and add some user-defined control elements of enumerated type.
+ * \param ctl A handle of backend module for control interface.
+ * \param id ID of the first new element.
+ * \param element_count The number of elements added by this operation.
+ * \param member_count The number of members which a element has to
+ *	    	   represent its states.
+ * \param items Range of possible values (0 ... \a items - 1).
+ * \param labels An array containing \a items strings.
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function creates some user elements with enumerated type. These elements
+ * are not controlled by device drivers in kernel. They can be operated by the
+ * same way as usual elements added by the device drivers.
+ *
+ * The name field of \a id must be set with unique value to identify new control
+ * elements. After returning, all fields of \a id are filled. A element can be
+ * identified by the combination of name and index, or by numid.
+ *
+ * All of members in the new elements are locked. The value of each member is
+ * initialized with the first entry of labels.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY
+ * <dd>A control element with ID \a id already exists.
+ * <dt>-EINVAL
+ * <dd>\a element_count is not between 1 to 127, or \a items is not at least
+ *     one, or a string in \a labels is empty, or longer than 63 bytes, or total
+ *     length of the labels requires more than 64 KiB storage.
+ * <dt>-ENOMEM
+ * <dd>Out of memory, or there are too many user control elements.
+ * <dt>-ENXIO
+ * <dd>This driver does not support (enumerated) user controls.
+ * <dt>-ENODEV
+ * <dd>Device unplugged.
+ * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.2.
+ */
+int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				    unsigned int element_count,
+				    unsigned int member_count,
+				    unsigned int items,
+				    const char *const labels[])
+{
+	snd_ctl_elem_info_t *info;
+	unsigned int i, bytes;
+	char *buf, *p;
+	int err;
+
+	assert(ctl && id && id->name[0] && labels);
+
+	snd_ctl_elem_info_alloca(&info);
+	info->id = *id;
+	info->type = SND_CTL_ELEM_TYPE_ENUMERATED;
+	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_USER;
+	info->owner = element_count;
+	info->count = member_count;
+	info->value.enumerated.items = items;
+
+	bytes = 0;
+	for (i = 0; i < items; ++i)
+		bytes += strlen(labels[i]) + 1;
+	if (bytes == 0)
+		return -EINVAL;
+	buf = malloc(bytes);
+	if (buf == NULL)
+		return -ENOMEM;
+	info->value.enumerated.names_ptr = (uintptr_t)buf;
+	info->value.enumerated.names_length = bytes;
+	p = buf;
+	for (i = 0; i < items; ++i) {
+		strcpy(p, labels[i]);
+		p += strlen(labels[i]) + 1;
+	}
+
+	err = ctl->ops->element_add(ctl, info);
+	if (err >= 0)
+		*id = info->id;
+
+	free(buf);
+
+	return err;
+}
+
+/**
+ * \brief Create and add some user-defined control elements of bytes type.
+ * \param ctl A handle of backend module for control interface.
+ * \param id ID of the first new element.
+ * \param element_count The number of elements added by this operation.
+ * \param member_count The number of members which a element has to
+ *			   represent its states.
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function creates some user elements with bytes type. These elements are
+ * not controlled by device drivers in kernel. They can be operated by the same
+ * way as usual elements added by the device drivers.
+ *
+ * The name field of \a id must be set with unique value to identify new control
+ * elements. After returning, all fields of \a id are filled. A element can be
+ * identified by the combination of name and index, or by numid.
+ *
+ * All of members in the new elements are locked. The value of each member is
+ * initialized with the minimum value.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY
+ * <dd>A element with ID \a id already exists.
+ * <dt>-EINVAL
+ * <dd>ID has no name, or the number of members is not between 1 to 511.
+ * <dt>-ENOMEM
+ * <dd>Out of memory, or there are too many user elements.
+ * <dt>-ENXIO
+ * <dd>This backend module does not support user elements of bytes type.
+ * <dt>-ENODEV
+ * <dd>Device unplugged.
+ * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.2.
+ */
+int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+			       unsigned int element_count,
+			       unsigned int member_count)
+{
+	snd_ctl_elem_info_t *info;
+	int err;
+
+	assert(ctl && id && id->name[0]);
+
+	snd_ctl_elem_info_alloca(&info);
+	info->id = *id;
+	info->type = SND_CTL_ELEM_TYPE_BYTES;
+	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_USER;
+	info->owner = element_count;
+	info->count = member_count;
+
+	err = ctl->ops->element_add(ctl, info);
+	if (err >= 0)
+		*id = info->id;
+
+	return err;
+}
+
+/**
  * \brief Create and add an user INTEGER CTL element
  * \param ctl CTL handle
  * \param id CTL element id to add
-- 
2.7.4
