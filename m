From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] control: add functions to add element set
Date: Tue, 23 Feb 2016 09:48:30 +0900
Message-ID: <1456188510-7189-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1456188510-7189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CCB92606CF
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 01:48:37 +0100 (CET)
In-Reply-To: <1456188510-7189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA Ctl core allows userspace applications to add element sets. Currently,
some APIs use the functionality to add a single element.

This commit adds functions to add element set for each type. Some existed
functions are simple wrappers of the new ones to add one elements.

I note that some old APIs get static id variables, although Linux kernel
4.1 or later fills id field with all parameters. In this commit, old APIs
are what they're to keep signature, while new APIs get non-static id
parameters.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h     |  34 ++++++-
 src/control/control.c | 267 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 245 insertions(+), 56 deletions(-)

diff --git a/include/control.h b/include/control.h
index 12859f0..cf3ff1b 100644
--- a/include/control.h
+++ b/include/control.h
@@ -423,11 +423,37 @@ void snd_ctl_elem_info_set_subdevice(snd_ctl_elem_info_t *obj, unsigned int val)
 void snd_ctl_elem_info_set_name(snd_ctl_elem_info_t *obj, const char *val);
 void snd_ctl_elem_info_set_index(snd_ctl_elem_info_t *obj, unsigned int val);
 
-int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, long imin, long imax, long istep);
-int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, long long imin, long long imax, long long istep);
-int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count);
-int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, unsigned int items, const char *const names[]);
+int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				 unsigned int count, unsigned int channels,
+				 long min, long max, long step);
+int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				   unsigned int count, unsigned int channels,
+				   long long min, long long max,
+				   long long step);
+int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				 unsigned int count, unsigned int channels);
+int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				    unsigned int count, unsigned int channels,
+				    unsigned int items,
+				    const char *const names[]);
+int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+			       unsigned int count, unsigned int channels);
+
+int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			     unsigned int channels,
+			     long min, long max, long step);
+int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			       unsigned int channels,
+			       long long min, long long max, long long step);
+int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			     unsigned int channels);
+int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+				unsigned int channels, unsigned int items,
+				const char *const names[]);
+int snd_ctl_elem_add_bytes(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			   unsigned int channels);
 int snd_ctl_elem_add_iec958(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id);
+
 int snd_ctl_elem_remove(snd_ctl_t *ctl, snd_ctl_elem_id_t *id);
 
 size_t snd_ctl_elem_value_sizeof(void);
diff --git a/src/control/control.c b/src/control/control.c
index 17a2620..a752972 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -261,23 +261,25 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
 }
 
 /**
- * \brief Create and add an user-defined control element of integer type.
+ * \brief Create and add some user-defined control elements of integer type.
  * \param[in] ctl CTL handle
  * \param[in,out] id ID of the new control element.
+ * \param[in] count The number of control elements added by this operation.
  * \param[in] channels The number of channels which a control element includes.
  * \param[in] min Minimum value for the value of each channel.
  * \param[in] max Maximum value for the value of each channel.
  * \param[in] step The step of value for the value of each channel.
  * \return Zero on success, otherwise a negative error code.
  *
- * This function creates a user control element. This control element is not
- * controlled by device drivers in kernel, but can be handled by the same way as
- * usual control elements added by the device drivers.
+ * This function creates some user control elements. These control elements are
+ * not controlled by device drivers in kernel, but can be handled by the same
+ * way as usual control elements added by the device drivers.
  *
  * The fields of \a id, except for numid, must be set with unique values to
- * identify the new element. After returning, all fields of \a id are filled.
+ * identify the first new element. After returning, all fields of \a id are
+ * filled.
  *
- * All of channels in the new element are locked. The value of each channel is
+ * All of channels in the new elements are locked. The value of each channel is
  * initialized with the minimum value.
  *
  * \par Errors:
@@ -288,103 +290,145 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
  * <dt>-ENXIO<dd>This driver does not support (integer) user controls.
  * <dt>-ENODEV<dd>Device unplugged.
  * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.1.
  */
-int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			     unsigned int channels, long min, long max,
-			     long step)
+int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				 unsigned int count, unsigned int channels,
+				 long min, long max, long step)
 {
 	snd_ctl_elem_info_t *info;
 	snd_ctl_elem_value_t *val;
 	unsigned int i;
+	unsigned int j;
+	unsigned int numid;
 	int err;
 
 	assert(ctl && id && id->name[0]);
+
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_INTEGER;
 	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE;
+	info->owner = count;
 	info->count = channels;
 	info->value.integer.min = min;
 	info->value.integer.max = max;
 	info->value.integer.step = step;
+
 	err = ctl->ops->element_add(ctl, info);
 	if (err < 0)
 		return err;
+	numid = snd_ctl_elem_id_get_numid(&info->id);
+
+	/* Set initial value to all of chanenls in all of elements. */
 	snd_ctl_elem_value_alloca(&val);
 	val->id = info->id;
-	for (i = 0; i < channels; i++)
-		val->value.integer.value[i] = min;
-	err = ctl->ops->element_write(ctl, val);
-	return err;
+	for (i = 0; i < count; i++) {
+		snd_ctl_elem_id_set_numid(&val->id, numid + i);
+
+		for (j = 0; j < channels; j++)
+			val->value.integer.value[j] = min;
+
+		err = ctl->ops->element_write(ctl, val);
+		if (err < 0)
+			return err;
+	}
+
+	*id = info->id;
+	return 0;
 }
 
 /**
- * \brief Create and add an user-defined control element of integer64 type.
+ * \brief Create and add some user-defined control elements of integer64 type.
  * \param[in] ctl CTL handle
  * \param[in,out] id ID of the new control element.
+ * \param[in] count The number of control elements added by this operation.
  * \param[in] channels The number of channels which a control element includes.
  * \param[in] min Minimum value for the value of each channel
  * \param[in] max Maximum value for the value of each channel
  * \param[in] step Step of value for the value of each channel
  * \return Zero on success, otherwise a negative error code.
  *
- * This function creates a user control element. This control element is not
- * controlled by device drivers in kernel, but can be handled by the same way as
- * usual control elements added by the device drivers.
+ * This function creates some user control element. These control elements are
+ * not controlled by device drivers in kernel, but can be handled by the same
+ * way as usual control elements added by the device drivers.
  *
  * The fields of \a id, except for numid, must be set with unique values to
  * identify the new element. After returning, all fields of \a id are filled.
  *
- * All of channels in the new element are locked. The value of each channel is
+ * All of channels in the new elements are locked. The value of each channel is
  * initialized with the minimum value.
  *
  * \par Errors:
  * <dl>
  * <dt>-EBUSY<dd>A control element with ID \a id already exists.
- * <dt>-EINVAL<dd>ID has no name, or \a channels is not between 1 to 63.
+ * <dt>-EINVAL<dd>ID has no name, or \a channels is not between 1 to 127.
  * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
- * <dt>-ENXIO<dd>This driver does not support (integer64) user controls.
+ * <dt>-ENXIO<dd>This driver does not support (integer) user controls.
  * <dt>-ENODEV<dd>Device unplugged.
  * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.1.
  */
-int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			       unsigned int channels, long long min,
-			       long long max, long long step)
+int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				   unsigned int count, unsigned int channels,
+				   long long min, long long max, long long step)
 {
 	snd_ctl_elem_info_t *info;
 	snd_ctl_elem_value_t *val;
 	unsigned int i;
+	unsigned int j;
+	unsigned int numid;
 	int err;
 
 	assert(ctl && id && id->name[0]);
+
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_INTEGER64;
+	info->owner = count;
 	info->count = channels;
 	info->value.integer64.min = min;
 	info->value.integer64.max = max;
 	info->value.integer64.step = step;
+
 	err = ctl->ops->element_add(ctl, info);
 	if (err < 0)
 		return err;
+	numid = snd_ctl_elem_id_get_numid(&info->id);
+
+	/* Set initial value to all of chanenls in all of elements. */
 	snd_ctl_elem_value_alloca(&val);
 	val->id = info->id;
-	for (i = 0; i < channels; i++)
-		val->value.integer64.value[i] = min;
-	err = ctl->ops->element_write(ctl, val);
-	return err;
+	for (i = 0; i < count; i++) {
+		snd_ctl_elem_id_set_numid(&val->id, numid + i);
+
+		for (j = 0; j < channels; j++)
+			val->value.integer64.value[i] = min;
+
+		err = ctl->ops->element_write(ctl, val);
+		if (err < 0)
+			return err;
+	}
+
+	*id = info->id;
+	return 0;
 }
 
 /**
- * \brief Create and add an user-defined control element of boolean type.
+ * \brief Create and add some user-defined control elements of boolean type.
  * \param[in] ctl CTL handle
  * \param[in,out] id ID of the new control element.
+ * \param[in] count The number of control elements added by this operation.
  * \param[in] channels The number of channels which a control element includes.
  *
- * This function creates a user control element. This control element is not
- * controlled by device drivers in kernel, but can be handled by the same way as
- * usual control elements added by the device drivers.
+ * This function creates some user control elements. These control elements are
+ * not controlled by device drivers in kernel, but can be handled by the same
+ * way as usual control elements added by the device drivers.
  *
  * The fields of \a id, except for numid, must be set with unique values to
  * identify the new element. After returning, all fields of \a id are filled.
@@ -400,34 +444,46 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * <dt>-ENXIO<dd>This driver does not support (boolean) user controls.
  * <dt>-ENODEV<dd>Device unplugged.
  * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.1.
  */
-int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			     unsigned int channels)
+int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				 unsigned int count, unsigned int channels)
 {
 	snd_ctl_elem_info_t *info;
+	int err;
 
 	assert(ctl && id && id->name[0]);
+
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_BOOLEAN;
+	info->owner = count;
 	info->count = channels;
 	info->value.integer.min = 0;
 	info->value.integer.max = 1;
-	return ctl->ops->element_add(ctl, info);
+
+	err = ctl->ops->element_add(ctl, info);
+	if (err >= 0)
+		*id = info->id;
+
+	return err;
 }
 
 /**
- * \brief Create and add a user-defined control element of enumerated type.
+ * \brief Create and add some user-defined control elements of enumerated type.
  * \param[in] ctl CTL handle
  * \param[in,out] id ID of the new control element.
+ * \param[in] count The number of control elements added by this operation.
  * \param[in] channels The number of channels which a control element includes.
  * \param[in] items Range of possible values (0 ... \a items - 1).
  * \param[in] names An array containing \a items strings.
  * \return Zero on success, otherwise a negative error code.
  *
- * This function creates a user control element. This control element is not
- * controlled by device drivers in kernel, but can be handled by the same way as
- * usual control elements added by the device drivers.
+ * This function creates some user control elements. These control elements are
+ * not controlled by device drivers in kernel, but can be handled by the same
+ * way as usual control elements added by the device drivers.
  *
  * The fields of \a id, except for numid, must be set to unique values that
  * identify the new element.
@@ -447,11 +503,12 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * </dl>
  *
  * \par Compatibility:
- * This function is added in ALSA 1.0.25.
+ * This function is added in version 1.1.1.
  */
-int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-				unsigned int channels, unsigned int items,
-				const char *const names[])
+int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+				    unsigned int count, unsigned int channels,
+				    unsigned int items,
+				    const char *const names[])
 {
 	snd_ctl_elem_info_t *info;
 	unsigned int i, bytes;
@@ -463,6 +520,7 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_ENUMERATED;
+	info->owner = count;
 	info->count = channels;
 	info->value.enumerated.items = items;
 
@@ -481,6 +539,8 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	}
 
 	err = ctl->ops->element_add(ctl, info);
+	if (err >= 0)
+		*id = info->id;
 
 	free(buf);
 
@@ -488,20 +548,22 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Create and add an user-defined control element of bytes type.
+ * \brief Create and add some user-defined control elements of bytes type.
  * \param[in] ctl CTL handle.
  * \param[in,out] id ID of the new control element.
+ * \param[in] count The number of control elements added by this operation.
  * \param[in] channels The number of channels which a control element includes.
  * \return Zero on success, otherwise a negative error code.
  *
- * This function creates an user control element, This control element is not
- * controlled by device drivers in kernel but that is handled by the same way as
- * the control elements added by the device drivers.
+ * This function creates some user control element, This control elements are
+ * not controlled by device drivers in kernel but that is handled by the same
+ * way as usual control elements added by the device drivers.
  *
  * The fields of \a id, except for numid, must be set with unique values to
- * identify the new element. After returning, all fields of \a id are filled.
+ * identify the first new element. After returning, all fields of \a id are
+ * filled.
  *
- * All of channels in the new element are locked. The value of each channel is
+ * All of channels in the new elements are locked. The value of each channel is
  * initialized with zero.
  *
  * \par Errors:
@@ -516,20 +578,121 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \par Compatibility:
  * This function is added in version 1.1.1.
  */
-int snd_ctl_elem_add_bytes(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			   unsigned int channels)
+int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+			       unsigned int count, unsigned int channels)
 {
 	snd_ctl_elem_info_t *info;
+	int err;
 
 	assert(ctl && id && id->name[0]);
 
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_BYTES;
-	info->owner = 1;
+	info->owner = count;
 	info->count = channels;
 
-	return ctl->ops->element_add(ctl, info);
+	err = ctl->ops->element_add(ctl, info);
+	if (err >= 0)
+		*id = info->id;
+
+	return err;
+}
+
+/**
+ * \brief Create and add an user-defined control element of integer type.
+ *
+ * This function is a wrapper function to snd_ctl_elem_add_integer_set() for
+ * single control element.
+ */
+int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			     unsigned int channels,
+			     long min, long max, long step)
+{
+	snd_ctl_elem_id_t *local_id;
+
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
+
+	return snd_ctl_elem_add_integer_set(ctl, local_id, 1, channels,
+					    min, max, step);
+}
+
+/**
+ * \brief Create and add an user-defined control element of integer64 type.
+ *
+ * This function is a wrapper function to snd_ctl_elem_add_integer64_set() for
+ * single control element.
+ */
+int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			       unsigned int channels,
+			       long long min, long long max, long long step)
+{
+	snd_ctl_elem_id_t *local_id;
+
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
+
+	return snd_ctl_elem_add_integer64_set(ctl, local_id, 1, channels,
+					      min, max, step);
+}
+
+/**
+ * \brief Create and add an user-defined control element of boolean type.
+ *
+ * This function is a wrapper function to snd_ctl_elem_add_boolean_set() for
+ * single control element.
+ */
+int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			     unsigned int channels)
+{
+	snd_ctl_elem_id_t *local_id;
+
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
+
+	return snd_ctl_elem_add_boolean_set(ctl, local_id, 1, channels);
+}
+
+/**
+ * \brief Create and add a user-defined control element of enumerated type.
+ *
+ * This function is a wrapper function to snd_ctl_elem_add_enumerated_set() for
+ * single control element.
+ *
+ * This function is added in version 1.0.25.
+ */
+int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+				unsigned int channels, unsigned int items,
+				const char *const names[])
+{
+	snd_ctl_elem_id_t *local_id;
+
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
+
+	return snd_ctl_elem_add_enumerated_set(ctl, local_id, 1, channels,
+					       items, names);
+}
+
+/**
+ * \brief Create and add a user-defined control element of bytes type.
+ *
+ * This function is a wrapper function to snd_ctl_elem_add_bytes_set() for
+ * single control element.
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.1.
+ */
+int snd_ctl_elem_add_bytes(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			   unsigned int channels)
+{
+	snd_ctl_elem_id_t *local_id;
+
+	snd_ctl_elem_id_alloca(&local_id);
+	*local_id = *id;
+
+	return snd_ctl_elem_add_bytes_set(ctl, local_id, 1, channels);
 }
 
 /**
-- 
2.5.0
