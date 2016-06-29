From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ctl: support extra information to
	user-defined element set
Date: Wed, 29 Jun 2016 22:42:59 +0900
Message-ID: <1467207783-19792-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 212DE266D8B
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 15:43:08 +0200 (CEST)
In-Reply-To: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
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

In ALSA control feature, information of an element includes extra fields
to type-specific parameters; i.e. dimension. The fields can be extended in
future.

Meanwhile, current APIs to add user-defined element set can not support
such an extended fields. This may cause inconveniences in future.

This commit supports the fields, by changing APIs for element set.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h     |  10 +--
 src/control/control.c | 189 ++++++++++++++++++++++----------------------------
 src/pcm/pcm_softvol.c |  10 +--
 3 files changed, 94 insertions(+), 115 deletions(-)

diff --git a/include/control.h b/include/control.h
index 13b0d4e..b14edee 100644
--- a/include/control.h
+++ b/include/control.h
@@ -423,24 +423,24 @@ void snd_ctl_elem_info_set_subdevice(snd_ctl_elem_info_t *obj, unsigned int val)
 void snd_ctl_elem_info_set_name(snd_ctl_elem_info_t *obj, const char *val);
 void snd_ctl_elem_info_set_index(snd_ctl_elem_info_t *obj, unsigned int val);
 
-int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count,
 				 long min, long max, long step);
-int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				   unsigned int element_count,
 				   unsigned int member_count,
 				   long long min, long long max,
 				   long long step);
-int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count);
-int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				    unsigned int element_count,
 				    unsigned int member_count,
 				    unsigned int items,
 				    const char *const labels[]);
-int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 			       unsigned int element_count,
 			       unsigned int member_count);
 
diff --git a/src/control/control.c b/src/control/control.c
index c7fcbd2..70b166b 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -305,7 +305,8 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
 /**
  * \brief Create and add some user-defined control elements of integer type.
  * \param ctl A handle of backend module for control interface.
- * \param id ID of the first new element.
+ * \param info Common iformation for a new element set, with ID of the first new
+ *	       element.
  * \param element_count The number of elements added by this operation.
  * \param member_count The number of members which a element has to
  *			   represent its states.
@@ -342,38 +343,36 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count,
 				 long min, long max, long step)
 {
-	snd_ctl_elem_info_t info = {0};
 	snd_ctl_elem_value_t data = {0};
 	unsigned int i;
 	unsigned int j;
 	unsigned int numid;
 	int err;
 
-	assert(ctl && id && id->name[0]);
+	assert(ctl && info && info->id.name[0]);
 
-	info.id = *id;
-	info.type = SND_CTL_ELEM_TYPE_INTEGER;
-	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-	              SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-	              SNDRV_CTL_ELEM_ACCESS_USER;
-	info.owner = element_count;
-	info.count = member_count;
-	info.value.integer.min = min;
-	info.value.integer.max = max;
-	info.value.integer.step = step;
-
-	err = ctl->ops->element_add(ctl, &info);
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
 	if (err < 0)
 		return err;
-	numid = snd_ctl_elem_id_get_numid(&info.id);
+	numid = snd_ctl_elem_id_get_numid(&info->id);
 
 	/* Set initial value to all of members in all of added elements. */
-	data.id = info.id;
+	data.id = info->id;
 	for (i = 0; i < element_count; i++) {
 		snd_ctl_elem_id_set_numid(&data.id, numid + i);
 
@@ -385,14 +384,14 @@ int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 			return err;
 	}
 
-	*id = info.id;
 	return 0;
 }
 
 /**
  * \brief Create and add some user-defined control elements of integer64 type.
  * \param ctl A handle of backend module for control interface.
- * \param id ID of the first new control element.
+ * \param info Common iformation for a new element set, with ID of the first new
+ *	       element.
  * \param element_count The number of elements added by this operation.
  * \param member_count The number of members which a element has to
  *	    	   represent its states.
@@ -429,38 +428,36 @@ int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				   unsigned int element_count,
 				   unsigned int member_count,
 				   long long min, long long max, long long step)
 {
-	snd_ctl_elem_info_t info = {0};
 	snd_ctl_elem_value_t data = {0};
 	unsigned int i;
 	unsigned int j;
 	unsigned int numid;
 	int err;
 
-	assert(ctl && id && id->name[0]);
+	assert(ctl && info && info->id.name[0]);
 
-	info.id = *id;
-	info.type = SND_CTL_ELEM_TYPE_INTEGER64;
-	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		      SNDRV_CTL_ELEM_ACCESS_USER;
-	info.owner = element_count;
-	info.count = member_count;
-	info.value.integer64.min = min;
-	info.value.integer64.max = max;
-	info.value.integer64.step = step;
-
-	err = ctl->ops->element_add(ctl, &info);
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
 	if (err < 0)
 		return err;
-	numid = snd_ctl_elem_id_get_numid(&info.id);
+	numid = snd_ctl_elem_id_get_numid(&info->id);
 
 	/* Set initial value to all of members in all of added elements. */
-	data.id = info.id;
+	data.id = info->id;
 	for (i = 0; i < element_count; i++) {
 		snd_ctl_elem_id_set_numid(&data.id, numid + i);
 
@@ -472,14 +469,14 @@ int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 			return err;
 	}
 
-	*id = info.id;
 	return 0;
 }
 
 /**
  * \brief Create and add some user-defined control elements of boolean type.
  * \param ctl A handle of backend module for control interface.
- * \param id ID of the new control element.
+ * \param info Common iformation for a new element set, with ID of the first new
+ *	       element.
  * \param element_count The number of elements added by this operation.
  * \param member_count The number of members which a element has to
  *			   represent its states.
@@ -512,36 +509,29 @@ int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count)
 {
-	snd_ctl_elem_info_t info = {0};
-	int err;
-
-	assert(ctl && id && id->name[0]);
+	assert(ctl && info && info->id.name[0]);
 
-	info.id = *id;
-	info.type = SND_CTL_ELEM_TYPE_BOOLEAN;
-	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		      SNDRV_CTL_ELEM_ACCESS_USER;
-	info.owner = element_count;
-	info.count = member_count;
-	info.value.integer.min = 0;
-	info.value.integer.max = 1;
-
-	err = ctl->ops->element_add(ctl, &info);
-	if (err >= 0)
-		*id = info.id;
+	info->type = SND_CTL_ELEM_TYPE_BOOLEAN;
+	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_USER;
+	info->owner = element_count;
+	info->count = member_count;
+	info->value.integer.min = 0;
+	info->value.integer.max = 1;
 
-	return err;
+	return ctl->ops->element_add(ctl, info);
 }
 
 /**
  * \brief Create and add some user-defined control elements of enumerated type.
  * \param ctl A handle of backend module for control interface.
- * \param id ID of the first new element.
+ * \param info Common iformation for a new element set, with ID of the first new
+ *	       element.
  * \param element_count The number of elements added by this operation.
  * \param member_count The number of members which a element has to
  *	    	   represent its states.
@@ -579,27 +569,25 @@ int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				    unsigned int element_count,
 				    unsigned int member_count,
 				    unsigned int items,
 				    const char *const labels[])
 {
-	snd_ctl_elem_info_t info = {0};
 	unsigned int i, bytes;
 	char *buf, *p;
 	int err;
 
-	assert(ctl && id && id->name[0] && labels);
+	assert(ctl && info && info->id.name[0] && labels);
 
-	info.id = *id;
-	info.type = SND_CTL_ELEM_TYPE_ENUMERATED;
-	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		      SNDRV_CTL_ELEM_ACCESS_USER;
-	info.owner = element_count;
-	info.count = member_count;
-	info.value.enumerated.items = items;
+	info->type = SND_CTL_ELEM_TYPE_ENUMERATED;
+	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_USER;
+	info->owner = element_count;
+	info->count = member_count;
+	info->value.enumerated.items = items;
 
 	bytes = 0;
 	for (i = 0; i < items; ++i)
@@ -609,17 +597,15 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 	buf = malloc(bytes);
 	if (buf == NULL)
 		return -ENOMEM;
-	info.value.enumerated.names_ptr = (uintptr_t)buf;
-	info.value.enumerated.names_length = bytes;
+	info->value.enumerated.names_ptr = (uintptr_t)buf;
+	info->value.enumerated.names_length = bytes;
 	p = buf;
 	for (i = 0; i < items; ++i) {
 		strcpy(p, labels[i]);
 		p += strlen(labels[i]) + 1;
 	}
 
-	err = ctl->ops->element_add(ctl, &info);
-	if (err >= 0)
-		*id = info.id;
+	err = ctl->ops->element_add(ctl, info);
 
 	free(buf);
 
@@ -629,7 +615,8 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 /**
  * \brief Create and add some user-defined control elements of bytes type.
  * \param ctl A handle of backend module for control interface.
- * \param id ID of the first new element.
+ * \param info Common iformation for a new element set, with ID of the first new
+ *	       element.
  * \param element_count The number of elements added by this operation.
  * \param member_count The number of members which a element has to
  *			   represent its states.
@@ -663,28 +650,20 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
  * \par Compatibility:
  * This function is added in version 1.1.2.
  */
-int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
+int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 			       unsigned int element_count,
 			       unsigned int member_count)
 {
-	snd_ctl_elem_info_t info = {0};
-	int err;
-
-	assert(ctl && id && id->name[0]);
+	assert(ctl && info && info->id.name[0]);
 
-	info.id = *id;
-	info.type = SND_CTL_ELEM_TYPE_BYTES;
-	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		      SNDRV_CTL_ELEM_ACCESS_USER;
-	info.owner = element_count;
-	info.count = member_count;
-
-	err = ctl->ops->element_add(ctl, &info);
-	if (err >= 0)
-		*id = info.id;
+	info->type = SND_CTL_ELEM_TYPE_BYTES;
+	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		       SNDRV_CTL_ELEM_ACCESS_USER;
+	info->owner = element_count;
+	info->count = member_count;
 
-	return err;
+	return ctl->ops->element_add(ctl, info);
 }
 
 /**
@@ -698,11 +677,11 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int member_count,
 			     long min, long max, long step)
 {
-	snd_ctl_elem_id_t local_id = {0};
+	snd_ctl_elem_info_t info = {0};
 
-	local_id = *id;
+	info.id = *id;
 
-	return snd_ctl_elem_add_integer_set(ctl, &local_id, 1, member_count,
+	return snd_ctl_elem_add_integer_set(ctl, &info, 1, member_count,
 					    min, max, step);
 }
 
@@ -717,11 +696,11 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			       unsigned int member_count,
 			       long long min, long long max, long long step)
 {
-	snd_ctl_elem_id_t local_id = {0};
+	snd_ctl_elem_info_t info = {0};
 
-	local_id = *id;
+	info.id = *id;
 
-	return snd_ctl_elem_add_integer64_set(ctl, &local_id, 1, member_count,
+	return snd_ctl_elem_add_integer64_set(ctl, &info, 1, member_count,
 					      min, max, step);
 }
 
@@ -735,11 +714,11 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int member_count)
 {
-	snd_ctl_elem_id_t local_id = {0};
+	snd_ctl_elem_info_t info = {0};
 
-	local_id = *id;
+	info.id = *id;
 
-	return snd_ctl_elem_add_boolean_set(ctl, &local_id, 1, member_count);
+	return snd_ctl_elem_add_boolean_set(ctl, &info, 1, member_count);
 }
 
 /**
@@ -755,11 +734,11 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 				unsigned int member_count, unsigned int items,
 				const char *const labels[])
 {
-	snd_ctl_elem_id_t local_id = {0};
+	snd_ctl_elem_info_t info = {0};
 
-	local_id = *id;
+	info.id = *id;
 
-	return snd_ctl_elem_add_enumerated_set(ctl, &local_id, 1, member_count,
+	return snd_ctl_elem_add_enumerated_set(ctl, &info, 1, member_count,
 					       items, labels);
 }
 
diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index 459ff8e..a667c85 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -663,18 +663,18 @@ static int add_tlv_info(snd_pcm_softvol_t *svol, snd_ctl_elem_info_t *cinfo)
 	return snd_ctl_elem_tlv_write(svol->ctl, &cinfo->id, tlv);
 }
 
-static int add_user_ctl(snd_pcm_softvol_t *svol, snd_ctl_elem_info_t *cinfo, int count)
+static int add_user_ctl(snd_pcm_softvol_t *svol, snd_ctl_elem_info_t *cinfo,
+			int count)
 {
 	int err;
 	int i;
 	unsigned int def_val;
 	
 	if (svol->max_val == 1)
-		err = snd_ctl_elem_add_boolean_set(svol->ctl, &cinfo->id, 1,
-						   count);
+		err = snd_ctl_elem_add_boolean_set(svol->ctl, cinfo, 1, count);
 	else
-		err = snd_ctl_elem_add_integer_set(svol->ctl, &cinfo->id, 1,
-						   count, 0, svol->max_val, 0);
+		err = snd_ctl_elem_add_integer_set(svol->ctl, cinfo, 1, count,
+						   0, svol->max_val, 0);
 	if (err < 0)
 		return err;
 	if (svol->max_val == 1)
-- 
2.7.4
