From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/6] control: rename variables so that it
	represents the number of channels which an element has
Date: Tue, 23 Feb 2016 09:48:25 +0900
Message-ID: <1456188510-7189-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1456188510-7189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 60AA32605B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 01:48:35 +0100 (CET)
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

An element has some channels which can be changed in a single operation
from userspace. In control API, variables to represents the number of
channels is described as 'count'. On the other hand, in ALSA control core,
the number of elements in an element set is also described as 'count'.
They're a bit confusing.

This commit renames 'count' with 'channels'. The 'count' is reserved for
future commit to describe the number of elements in an element set.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 8a5d530..e02727a 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -264,14 +264,15 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
  * \brief Create and add an user INTEGER CTL element
  * \param ctl CTL handle
  * \param id CTL element id to add
- * \param count number of elements
+ * \param channels number of elements
  * \param min minimum value
  * \param max maximum value
  * \param step value step
  * \return 0 on success otherwise a negative error code
  */
 int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			     unsigned int count, long min, long max, long step)
+			     unsigned int channels, long min, long max,
+			     long step)
 {
 	snd_ctl_elem_info_t *info;
 	snd_ctl_elem_value_t *val;
@@ -284,7 +285,7 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	info->type = SND_CTL_ELEM_TYPE_INTEGER;
 	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE;
-	info->count = count;
+	info->count = channels;
 	info->value.integer.min = min;
 	info->value.integer.max = max;
 	info->value.integer.step = step;
@@ -293,7 +294,7 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 		return err;
 	snd_ctl_elem_value_alloca(&val);
 	val->id = info->id;
-	for (i = 0; i < count; i++)
+	for (i = 0; i < channels; i++)
 		val->value.integer.value[i] = min;
 	err = ctl->ops->element_write(ctl, val);
 	return err;
@@ -303,15 +304,15 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \brief Create and add an user INTEGER64 CTL element
  * \param ctl CTL handle
  * \param id CTL element id to add
- * \param count number of elements
+ * \param channels number of elements
  * \param min minimum value
  * \param max maximum value
  * \param step value step
  * \return 0 on success otherwise a negative error code
  */
 int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			       unsigned int count, long long min, long long max,
-			       long long step)
+			       unsigned int channels, long long min,
+			       long long max, long long step)
 {
 	snd_ctl_elem_info_t *info;
 	snd_ctl_elem_value_t *val;
@@ -322,7 +323,7 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_INTEGER64;
-	info->count = count;
+	info->count = channels;
 	info->value.integer64.min = min;
 	info->value.integer64.max = max;
 	info->value.integer64.step = step;
@@ -331,7 +332,7 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 		return err;
 	snd_ctl_elem_value_alloca(&val);
 	val->id = info->id;
-	for (i = 0; i < count; i++)
+	for (i = 0; i < channels; i++)
 		val->value.integer64.value[i] = min;
 	err = ctl->ops->element_write(ctl, val);
 	return err;
@@ -341,11 +342,11 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \brief Create and add an user BOOLEAN CTL element
  * \param ctl CTL handle
  * \param id CTL element id to add
- * \param count number of elements
+ * \param channels number of elements
  * \return 0 on success otherwise a negative error code
  */
 int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-			     unsigned int count)
+			     unsigned int channels)
 {
 	snd_ctl_elem_info_t *info;
 
@@ -353,7 +354,7 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_BOOLEAN;
-	info->count = count;
+	info->count = channels;
 	info->value.integer.min = 0;
 	info->value.integer.max = 1;
 	return ctl->ops->element_add(ctl, info);
@@ -363,7 +364,7 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \brief Create and add a user-defined control element of type enumerated.
  * \param[in] ctl Control device handle.
  * \param[in] id ID of the new control element.
- * \param[in] count Number of element values.
+ * \param[in] channels Number of element values.
  * \param[in] items Range of possible values (0 ... \a items - 1).
  * \param[in] names An array containing \a items strings.
  * \return Zero on success, otherwise a negative error code.
@@ -380,9 +381,10 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \par Errors:
  * <dl>
  * <dt>-EBUSY<dd>A control element with ID \a id already exists.
- * <dt>-EINVAL<dd>\a count is not at least one or greater than 128, or \a items
- * 	is not at least one, or a string in \a names is empty or longer than 63
- * 	bytes, or the strings in \a names require more than 64 KB storage.
+ * <dt>-EINVAL<dd>\a channels is not at least one or greater than 128, or \a
+ *	items is not at least one, or a string in \a names is empty or longer
+ *	than 63 bytes, or the strings in \a names require more than 64 KB
+ *	storage.
  * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
  * <dt>-ENXIO<dd>This driver does not support (enumerated) user controls.
  * <dt>-ENODEV<dd>Device unplugged.
@@ -392,7 +394,7 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * snd_ctl_elem_add_enumerated() was introduced in ALSA 1.0.25.
  */
 int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
-				unsigned int count, unsigned int items,
+				unsigned int channels, unsigned int items,
 				const char *const names[])
 {
 	snd_ctl_elem_info_t *info;
@@ -405,7 +407,7 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_ENUMERATED;
-	info->count = count;
+	info->count = channels;
 	info->value.enumerated.items = items;
 
 	bytes = 0;
-- 
2.5.0
