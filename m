From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] control: improve API documentation
Date: Mon, 15 Feb 2016 22:33:11 +0900
Message-ID: <1455543193-28109-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1455543193-28109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A47C82612DF
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 14:33:18 +0100 (CET)
In-Reply-To: <1455543193-28109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some parts of control API documentation are described with
core-developer friendly representations. To usual developer,
they have little meanings.

This commit improves such comments.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 230 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 151 insertions(+), 79 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 96dfbf6..3533ffe 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -261,14 +261,33 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
 }
 
 /**
- * \brief Create and add an user INTEGER CTL element
- * \param ctl CTL handle
- * \param id CTL element id to add
- * \param channels number of elements
- * \param min minimum value
- * \param max maximum value
- * \param step value step
- * \return 0 on success otherwise a negative error code
+ * \brief Create and add an user-defined control element of integer type.
+ * \param[in] ctl CTL handle
+ * \param[in/out] id ID of the new control element.
+ * \param[in] channels The number of channels which a control element includes.
+ * \param[in] min Minimum value for the value of each channel.
+ * \param[in] max Maximum value for the value of each channel.
+ * \param[in] step The step of value for the value of each channel.
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function creates a user control element. This control element is not
+ * controlled by device drivers in kernel, but can be handled by the same way as
+ * usual control elements added by the device drivers.
+ *
+ * The fields of \a id, except for numid, must be set with unique values to
+ * identify the new element. After returning, all fields of \a id are filled.
+ *
+ * All of channels in the new element are locked. The value of each channel is
+ * initialized with the minimum value.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY<dd>A control element with ID \a id already exists.
+ * <dt>-EINVAL<dd>ID has no name, or \a channels is not between 1 to 127.
+ * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
+ * <dt>-ENXIO<dd>This driver does not support (integer) user controls.
+ * <dt>-ENODEV<dd>Device unplugged.
+ * </dl>
  */
 int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int channels, long min, long max,
@@ -301,14 +320,33 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Create and add an user INTEGER64 CTL element
- * \param ctl CTL handle
- * \param id CTL element id to add
- * \param channels number of elements
- * \param min minimum value
- * \param max maximum value
- * \param step value step
- * \return 0 on success otherwise a negative error code
+ * \brief Create and add an user-defined control element of integer64 type.
+ * \param[in] ctl CTL handle
+ * \param[in/out] id ID of the new control element.
+ * \param[in] channels The number of channels which a control element includes.
+ * \param[in] min Minimum value for the value of each channel
+ * \param[in] max Maximum value for the value of each channel
+ * \param[in] step Step of value for the value of each channel
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function creates a user control element. This control element is not
+ * controlled by device drivers in kernel, but can be handled by the same way as
+ * usual control elements added by the device drivers.
+ *
+ * The fields of \a id, except for numid, must be set with unique values to
+ * identify the new element. After returning, all fields of \a id are filled.
+ *
+ * All of channels in the new element are locked. The value of each channel is
+ * initialized with the minimum value.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY<dd>A control element with ID \a id already exists.
+ * <dt>-EINVAL<dd>ID has no name, or \a channels is not between 1 to 63.
+ * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
+ * <dt>-ENXIO<dd>This driver does not support (integer64) user controls.
+ * <dt>-ENODEV<dd>Device unplugged.
+ * </dl>
  */
 int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			       unsigned int channels, long long min,
@@ -339,11 +377,29 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Create and add an user BOOLEAN CTL element
- * \param ctl CTL handle
- * \param id CTL element id to add
- * \param channels number of elements
- * \return 0 on success otherwise a negative error code
+ * \brief Create and add an user-defined control element of boolean type.
+ * \param[in] ctl CTL handle
+ * \param[in/out] id ID of the new control element.
+ * \param[in] channels The number of channels which a control element includes.
+ *
+ * This function creates a user control element. This control element is not
+ * controlled by device drivers in kernel, but can be handled by the same way as
+ * usual control elements added by the device drivers.
+ *
+ * The fields of \a id, except for numid, must be set with unique values to
+ * identify the new element. After returning, all fields of \a id are filled.
+ *
+ * All of channels in the new element are locked. The value of each channel is
+ * initialized with false.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY<dd>A control element with ID \a id already exists.
+ * <dt>-EINVAL<dd>ID has no name, or \a channels is not between 1 to 127.
+ * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
+ * <dt>-ENXIO<dd>This driver does not support (boolean) user controls.
+ * <dt>-ENODEV<dd>Device unplugged.
+ * </dl>
  */
 int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int channels)
@@ -361,37 +417,37 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Create and add a user-defined control element of type enumerated.
- * \param[in] ctl Control device handle.
- * \param[in] id ID of the new control element.
- * \param[in] channels Number of element values.
+ * \brief Create and add a user-defined control element of enumerated type.
+ * \param[in] ctl CTL handle
+ * \param[in/out] id ID of the new control element.
+ * \param[in] channels The number of channels which a control element includes.
  * \param[in] items Range of possible values (0 ... \a items - 1).
  * \param[in] names An array containing \a items strings.
  * \return Zero on success, otherwise a negative error code.
  *
- * This function creates a user element, i.e., a control element that is not
- * controlled by the control device's driver but that is just stored together
- * with the other elements of \a ctl.
+ * This function creates a user control element. This control element is not
+ * controlled by device drivers in kernel, but can be handled by the same way as
+ * usual control elements added by the device drivers.
  *
- * The fields of \a id, except numid, must be set to unique values that
+ * The fields of \a id, except for numid, must be set to unique values that
  * identify the new element.
  *
- * The new element is locked; its value is initialized as zero.
+ * All of channels in the new element are locked. The value of each channel is
+ * initialized with the first entry of names.
  *
  * \par Errors:
  * <dl>
  * <dt>-EBUSY<dd>A control element with ID \a id already exists.
- * <dt>-EINVAL<dd>\a channels is not at least one or greater than 128, or \a
- *	items is not at least one, or a string in \a names is empty or longer
- *	than 63 bytes, or the strings in \a names require more than 64 KB
- *	storage.
+ * <dt>-EINVAL<dd>\a channels is not between 1 to 127, or \a items is not at
+ *	least one, or a string in \a names is empty or longer than 63
+ * 	bytes, or the strings in \a names require more than 64 KB storage.
  * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
  * <dt>-ENXIO<dd>This driver does not support (enumerated) user controls.
  * <dt>-ENODEV<dd>Device unplugged.
  * </dl>
  *
  * \par Compatibility:
- * snd_ctl_elem_add_enumerated() was introduced in ALSA 1.0.25.
+ * This function is added in ALSA 1.0.25.
  */
 int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 				unsigned int channels, unsigned int items,
@@ -432,10 +488,26 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Create and add an user IEC958 CTL element
- * \param ctl CTL handle
- * \param id CTL element info to add
- * \return 0 on success otherwise a negative error code
+ * \brief Create and add a user-defined control element of IEC958 type.
+ * \param[in] ctl CTL handle
+ * \param[in/out] id ID of the new control element.
+ *
+ * This function creates a user control element, This control element is not
+ * controlled by device drivers in kernel but that is handled by the same way as
+ * the control elements added by the device drivers.
+ *
+ * The fields of \a id, except numid, must be set with unique values to identify
+ * the new element. After returning, all fields of \a id are filled.
+ *
+ * The channel in the new element is locked; the value is initialized with zero.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY<dd>A control element with ID \a id already exists.
+ * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
+ * <dt>-ENXIO<dd>This driver does not support (IEC958) user controls.
+ * <dt>-ENODEV<dd>Device unplugged.
+ * </dl>
  */
 int snd_ctl_elem_add_iec958(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id)
 {
@@ -2491,10 +2563,10 @@ void snd_ctl_elem_value_set_index(snd_ctl_elem_value_t *obj, unsigned int val)
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_BOOLEAN CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified channel in the control element of boolean type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \return value for specified channel
  */ 
 int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2504,10 +2576,10 @@ int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified channel in the control element of integer type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \return value in specified channel
  */ 
 long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2517,10 +2589,10 @@ long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned in
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER64 CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified channel in the control element of integer64 type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \return value in specified channel
  */ 
 long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2530,10 +2602,10 @@ long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsi
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_ENUMERATED CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified channel in the control element of enumerated type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \return value of specified channel
  */ 
 unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2543,10 +2615,10 @@ unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj,
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_BYTES CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified channel in the control element of bytes type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \return value of specified channel
  */ 
 unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2556,10 +2628,10 @@ unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsig
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_BOOLEAN CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Get value of a specified channel in the control element of boolean type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \return value of specified channel
  */ 
 void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int idx, long val)
 {
@@ -2569,10 +2641,10 @@ void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int idx,
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value of a specified channel in the control element of integer type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \param[in] val The value to the specified channel
  */ 
 void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int idx, long val)
 {
@@ -2582,10 +2654,10 @@ void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int idx,
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER64 CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value of a specified channel in the control element of integer64 type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \param[in] val The value to the specified channel
  */ 
 void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int idx, long long val)
 {
@@ -2595,10 +2667,10 @@ void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int id
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_ENUMERATED CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value of a specified channel in the control element of enumerated type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \param[in] val The value to the specified channel
  */ 
 void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned int val)
 {
@@ -2608,10 +2680,10 @@ void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int i
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_BYTES CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value of a specified channel in the control element of bytes type.
+ * \param[in] ctl CTL handle
+ * \param[in] idx The index of channel in the control element
+ * \param[in] val The value to the specified channel
  */ 
 void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned char val)
 {
-- 
2.5.0
