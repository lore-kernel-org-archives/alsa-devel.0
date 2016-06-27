From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] ctl: use automatic variable instead
	of call of alloca(3)
Date: Mon, 27 Jun 2016 23:37:36 +0900
Message-ID: <1467038256-314-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 256192673F4
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 16:37:43 +0200 (CEST)
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

Inner this library, layouts of all structures are public. At a compilation
time, each size of the structures can be calculated. It means that we can
use automatic variable instead of calling alloca(3) to program this
library because in both ways storages are kept on stack frame of process
VMA. Besides, the usage of automatic variables requires less instructions
than calls of alloca(3). Furthermore, alloca(3) is not described in any
C language standards.

This commit replaces calls of alloca(3) just for structures with automatic
variables, for control features.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c  | 201 +++++++++++++++++++++++--------------------------
 src/control/ctlparse.c |   7 +-
 src/control/namehint.c |  40 +++++-----
 src/control/setup.c    |   5 +-
 src/control/tlv.c      |  15 ++--
 5 files changed, 125 insertions(+), 143 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 0cb0105..5c0efc6 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -347,8 +347,8 @@ int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 				 unsigned int member_count,
 				 long min, long max, long step)
 {
-	snd_ctl_elem_info_t *info;
-	snd_ctl_elem_value_t *data;
+	snd_ctl_elem_info_t info = {0};
+	snd_ctl_elem_value_t data = {0};
 	unsigned int i;
 	unsigned int j;
 	unsigned int numid;
@@ -356,38 +356,36 @@ int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 
 	assert(ctl && id && id->name[0]);
 
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_INTEGER;
-	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_USER;
-	info->owner = element_count;
-	info->count = member_count;
-	info->value.integer.min = min;
-	info->value.integer.max = max;
-	info->value.integer.step = step;
-
-	err = ctl->ops->element_add(ctl, info);
+	info.id = *id;
+	info.type = SND_CTL_ELEM_TYPE_INTEGER;
+	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+	              SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+	              SNDRV_CTL_ELEM_ACCESS_USER;
+	info.owner = element_count;
+	info.count = member_count;
+	info.value.integer.min = min;
+	info.value.integer.max = max;
+	info.value.integer.step = step;
+
+	err = ctl->ops->element_add(ctl, &info);
 	if (err < 0)
 		return err;
-	numid = snd_ctl_elem_id_get_numid(&info->id);
+	numid = snd_ctl_elem_id_get_numid(&info.id);
 
 	/* Set initial value to all of members in all of added elements. */
-	snd_ctl_elem_value_alloca(&data);
-	data->id = info->id;
+	data.id = info.id;
 	for (i = 0; i < element_count; i++) {
-		snd_ctl_elem_id_set_numid(&data->id, numid + i);
+		snd_ctl_elem_id_set_numid(&data.id, numid + i);
 
 		for (j = 0; j < member_count; j++)
-			data->value.integer.value[j] = min;
+			data.value.integer.value[j] = min;
 
-		err = ctl->ops->element_write(ctl, data);
+		err = ctl->ops->element_write(ctl, &data);
 		if (err < 0)
 			return err;
 	}
 
-	*id = info->id;
+	*id = info.id;
 	return 0;
 }
 
@@ -436,8 +434,8 @@ int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 				   unsigned int member_count,
 				   long long min, long long max, long long step)
 {
-	snd_ctl_elem_info_t *info;
-	snd_ctl_elem_value_t *data;
+	snd_ctl_elem_info_t info = {0};
+	snd_ctl_elem_value_t data = {0};
 	unsigned int i;
 	unsigned int j;
 	unsigned int numid;
@@ -445,38 +443,36 @@ int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 
 	assert(ctl && id && id->name[0]);
 
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_INTEGER64;
-	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_USER;
-	info->owner = element_count;
-	info->count = member_count;
-	info->value.integer64.min = min;
-	info->value.integer64.max = max;
-	info->value.integer64.step = step;
-
-	err = ctl->ops->element_add(ctl, info);
+	info.id = *id;
+	info.type = SND_CTL_ELEM_TYPE_INTEGER64;
+	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		      SNDRV_CTL_ELEM_ACCESS_USER;
+	info.owner = element_count;
+	info.count = member_count;
+	info.value.integer64.min = min;
+	info.value.integer64.max = max;
+	info.value.integer64.step = step;
+
+	err = ctl->ops->element_add(ctl, &info);
 	if (err < 0)
 		return err;
-	numid = snd_ctl_elem_id_get_numid(&info->id);
+	numid = snd_ctl_elem_id_get_numid(&info.id);
 
 	/* Set initial value to all of members in all of added elements. */
-	snd_ctl_elem_value_alloca(&data);
-	data->id = info->id;
+	data.id = info.id;
 	for (i = 0; i < element_count; i++) {
-		snd_ctl_elem_id_set_numid(&data->id, numid + i);
+		snd_ctl_elem_id_set_numid(&data.id, numid + i);
 
 		for (j = 0; j < member_count; j++)
-			data->value.integer64.value[j] = min;
+			data.value.integer64.value[j] = min;
 
-		err = ctl->ops->element_write(ctl, data);
+		err = ctl->ops->element_write(ctl, &data);
 		if (err < 0)
 			return err;
 	}
 
-	*id = info->id;
+	*id = info.id;
 	return 0;
 }
 
@@ -520,25 +516,24 @@ int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 				 unsigned int element_count,
 				 unsigned int member_count)
 {
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_info_t info = {0};
 	int err;
 
 	assert(ctl && id && id->name[0]);
 
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_BOOLEAN;
-	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_USER;
-	info->owner = element_count;
-	info->count = member_count;
-	info->value.integer.min = 0;
-	info->value.integer.max = 1;
-
-	err = ctl->ops->element_add(ctl, info);
+	info.id = *id;
+	info.type = SND_CTL_ELEM_TYPE_BOOLEAN;
+	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		      SNDRV_CTL_ELEM_ACCESS_USER;
+	info.owner = element_count;
+	info.count = member_count;
+	info.value.integer.min = 0;
+	info.value.integer.max = 1;
+
+	err = ctl->ops->element_add(ctl, &info);
 	if (err >= 0)
-		*id = info->id;
+		*id = info.id;
 
 	return err;
 }
@@ -590,22 +585,21 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 				    unsigned int items,
 				    const char *const labels[])
 {
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_info_t info = {0};
 	unsigned int i, bytes;
 	char *buf, *p;
 	int err;
 
 	assert(ctl && id && id->name[0] && labels);
 
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_ENUMERATED;
-	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_USER;
-	info->owner = element_count;
-	info->count = member_count;
-	info->value.enumerated.items = items;
+	info.id = *id;
+	info.type = SND_CTL_ELEM_TYPE_ENUMERATED;
+	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		      SNDRV_CTL_ELEM_ACCESS_USER;
+	info.owner = element_count;
+	info.count = member_count;
+	info.value.enumerated.items = items;
 
 	bytes = 0;
 	for (i = 0; i < items; ++i)
@@ -615,17 +609,17 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 	buf = malloc(bytes);
 	if (buf == NULL)
 		return -ENOMEM;
-	info->value.enumerated.names_ptr = (uintptr_t)buf;
-	info->value.enumerated.names_length = bytes;
+	info.value.enumerated.names_ptr = (uintptr_t)buf;
+	info.value.enumerated.names_length = bytes;
 	p = buf;
 	for (i = 0; i < items; ++i) {
 		strcpy(p, labels[i]);
 		p += strlen(labels[i]) + 1;
 	}
 
-	err = ctl->ops->element_add(ctl, info);
+	err = ctl->ops->element_add(ctl, &info);
 	if (err >= 0)
-		*id = info->id;
+		*id = info.id;
 
 	free(buf);
 
@@ -673,23 +667,22 @@ int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 			       unsigned int element_count,
 			       unsigned int member_count)
 {
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_info_t info = {0};
 	int err;
 
 	assert(ctl && id && id->name[0]);
 
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_BYTES;
-	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
-		       SNDRV_CTL_ELEM_ACCESS_USER;
-	info->owner = element_count;
-	info->count = member_count;
+	info.id = *id;
+	info.type = SND_CTL_ELEM_TYPE_BYTES;
+	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		      SNDRV_CTL_ELEM_ACCESS_USER;
+	info.owner = element_count;
+	info.count = member_count;
 
-	err = ctl->ops->element_add(ctl, info);
+	err = ctl->ops->element_add(ctl, &info);
 	if (err >= 0)
-		*id = info->id;
+		*id = info.id;
 
 	return err;
 }
@@ -705,12 +698,11 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int member_count,
 			     long min, long max, long step)
 {
-	snd_ctl_elem_id_t *local_id;
+	snd_ctl_elem_id_t local_id = {0};
 
-	snd_ctl_elem_id_alloca(&local_id);
-	*local_id = *id;
+	local_id = *id;
 
-	return snd_ctl_elem_add_integer_set(ctl, local_id, 1, member_count,
+	return snd_ctl_elem_add_integer_set(ctl, &local_id, 1, member_count,
 					    min, max, step);
 }
 
@@ -725,12 +717,11 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			       unsigned int member_count,
 			       long long min, long long max, long long step)
 {
-	snd_ctl_elem_id_t *local_id;
+	snd_ctl_elem_id_t local_id = {0};
 
-	snd_ctl_elem_id_alloca(&local_id);
-	*local_id = *id;
+	local_id = *id;
 
-	return snd_ctl_elem_add_integer64_set(ctl, local_id, 1, member_count,
+	return snd_ctl_elem_add_integer64_set(ctl, &local_id, 1, member_count,
 					      min, max, step);
 }
 
@@ -744,12 +735,11 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int member_count)
 {
-	snd_ctl_elem_id_t *local_id;
+	snd_ctl_elem_id_t local_id = {0};
 
-	snd_ctl_elem_id_alloca(&local_id);
-	*local_id = *id;
+	local_id = *id;
 
-	return snd_ctl_elem_add_boolean_set(ctl, local_id, 1, member_count);
+	return snd_ctl_elem_add_boolean_set(ctl, &local_id, 1, member_count);
 }
 
 /**
@@ -765,12 +755,11 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 				unsigned int member_count, unsigned int items,
 				const char *const labels[])
 {
-	snd_ctl_elem_id_t *local_id;
+	snd_ctl_elem_id_t local_id = {0};
 
-	snd_ctl_elem_id_alloca(&local_id);
-	*local_id = *id;
+	local_id = *id;
 
-	return snd_ctl_elem_add_enumerated_set(ctl, local_id, 1, member_count,
+	return snd_ctl_elem_add_enumerated_set(ctl, &local_id, 1, member_count,
 					       items, labels);
 }
 
@@ -805,15 +794,15 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  */
 int snd_ctl_elem_add_iec958(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id)
 {
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_info_t info = {0};
 
 	assert(ctl && id && id->name[0]);
-	snd_ctl_elem_info_alloca(&info);
-	info->id = *id;
-	info->type = SND_CTL_ELEM_TYPE_IEC958;
-	info->owner = 1;
-	info->count = 1;
-	return ctl->ops->element_add(ctl, info);
+
+	info.id = *id;
+	info.type = SND_CTL_ELEM_TYPE_IEC958;
+	info.owner = 1;
+	info.count = 1;
+	return ctl->ops->element_add(ctl, &info);
 }
 
 /**
diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
index d38b44e..5c9a168 100644
--- a/src/control/ctlparse.c
+++ b/src/control/ctlparse.c
@@ -312,17 +312,16 @@ int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
 			      const char *value)
 {
 	const char *ptr = value;
-	snd_ctl_elem_id_t *myid;
+	snd_ctl_elem_id_t myid = {0};
 	snd_ctl_elem_type_t type;
 	unsigned int idx, count;
 	long tmp;
 	long long tmp64;
 
-	snd_ctl_elem_id_alloca(&myid);
-	snd_ctl_elem_info_get_id(info, myid);
+	snd_ctl_elem_info_get_id(info, &myid);
 	type = snd_ctl_elem_info_get_type(info);
 	count = snd_ctl_elem_info_get_count(info);
-	snd_ctl_elem_value_set_id(dst, myid);
+	snd_ctl_elem_value_set_id(dst, &myid);
 	
 	for (idx = 0; idx < count && idx < 128 && ptr && *ptr; idx++) {
 		if (*ptr == ',')
diff --git a/src/control/namehint.c b/src/control/namehint.c
index ad8dda3..4dbd216 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -97,45 +97,42 @@ static int get_dev_name1(struct hint_list *list, char **res, int device,
 #ifdef BUILD_HWDEP
 	case SND_CTL_ELEM_IFACE_HWDEP:
 		{
-			snd_hwdep_info_t *info;
-			snd_hwdep_info_alloca(&info);
-			snd_hwdep_info_set_device(info, device);
-			if (snd_ctl_hwdep_info(list->ctl, info) < 0)
+			snd_hwdep_info_t info = {0};
+			snd_hwdep_info_set_device(&info, device);
+			if (snd_ctl_hwdep_info(list->ctl, &info) < 0)
 				return 0;
-			*res = strdup(snd_hwdep_info_get_name(info));
+			*res = strdup(snd_hwdep_info_get_name(&info));
 			return 0;
 		}
 #endif
 #ifdef BUILD_PCM
 	case SND_CTL_ELEM_IFACE_PCM:
 		{
-			snd_pcm_info_t *info;
-			snd_pcm_info_alloca(&info);
-			snd_pcm_info_set_device(info, device);
-			snd_pcm_info_set_stream(info, stream ? SND_PCM_STREAM_CAPTURE : SND_PCM_STREAM_PLAYBACK);
-			if (snd_ctl_pcm_info(list->ctl, info) < 0)
+			snd_pcm_info_t info = {0};
+			snd_pcm_info_set_device(&info, device);
+			snd_pcm_info_set_stream(&info, stream ? SND_PCM_STREAM_CAPTURE : SND_PCM_STREAM_PLAYBACK);
+			if (snd_ctl_pcm_info(list->ctl, &info) < 0)
 				return 0;
-			switch (snd_pcm_info_get_class(info)) {
+			switch (snd_pcm_info_get_class(&info)) {
 			case SND_PCM_CLASS_MODEM:
 			case SND_PCM_CLASS_DIGITIZER:
 				return -ENODEV;
 			default:
 				break;
 			}
-			*res = strdup(snd_pcm_info_get_name(info));
+			*res = strdup(snd_pcm_info_get_name(&info));
 			return 0;
 		}
 #endif
 #ifdef BUILD_RAWMIDI
 	case SND_CTL_ELEM_IFACE_RAWMIDI:
 		{
-			snd_rawmidi_info_t *info;
-			snd_rawmidi_info_alloca(&info);
-			snd_rawmidi_info_set_device(info, device);
-			snd_rawmidi_info_set_stream(info, stream ? SND_RAWMIDI_STREAM_INPUT : SND_RAWMIDI_STREAM_OUTPUT);
-			if (snd_ctl_rawmidi_info(list->ctl, info) < 0)
+			snd_rawmidi_info_t info = {0};
+			snd_rawmidi_info_set_device(&info, device);
+			snd_rawmidi_info_set_stream(&info, stream ? SND_RAWMIDI_STREAM_INPUT : SND_RAWMIDI_STREAM_OUTPUT);
+			if (snd_ctl_rawmidi_info(list->ctl, &info) < 0)
 				return 0;
-			*res = strdup(snd_rawmidi_info_get_name(info));
+			*res = strdup(snd_rawmidi_info_get_name(&info));
 			return 0;
 		}
 #endif
@@ -419,11 +416,10 @@ static int add_card(snd_config_t *config, snd_config_t *rw_config, struct hint_l
 	snd_config_iterator_t i, next;
 	const char *str;
 	char ctl_name[16];
-	snd_ctl_card_info_t *info;
+	snd_ctl_card_info_t info = {0};
 	int device, max_device = 0;
 	
-	snd_ctl_card_info_alloca(&info);
-	list->info = info;
+	list->info = &info;
 	err = snd_config_search(config, list->siface, &conf);
 	if (err < 0)
 		return err;
@@ -431,7 +427,7 @@ static int add_card(snd_config_t *config, snd_config_t *rw_config, struct hint_l
 	err = snd_ctl_open(&list->ctl, ctl_name, 0);
 	if (err < 0)
 		return err;
-	err = snd_ctl_card_info(list->ctl, info);
+	err = snd_ctl_card_info(list->ctl, &info);
 	if (err < 0)
 		goto __error;
 	snd_config_for_each(i, next, conf) {
diff --git a/src/control/setup.c b/src/control/setup.c
index f23bf2c..c598c8b 100644
--- a/src/control/setup.c
+++ b/src/control/setup.c
@@ -252,13 +252,12 @@ static int snd_config_get_ctl_elem_value(snd_config_t *conf,
 {
 	int err;
 	snd_config_iterator_t i, next;
-	snd_ctl_elem_id_t *id;
+	snd_ctl_elem_id_t id = {0};
 	snd_ctl_elem_type_t type;
 	unsigned int count;
 	long v;
 	long idx;
-	snd_ctl_elem_id_alloca(&id);
-	snd_ctl_elem_value_get_id(val, id);
+	snd_ctl_elem_value_get_id(val, &id);
 	count = snd_ctl_elem_info_get_count(info);
 	type = snd_ctl_elem_info_get_type(info);
 	if (count == 1) {
diff --git a/src/control/tlv.c b/src/control/tlv.c
index b08d887..6ad64a1 100644
--- a/src/control/tlv.c
+++ b/src/control/tlv.c
@@ -409,20 +409,19 @@ struct tlv_info {
 static int get_tlv_info(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			struct tlv_info *rec)
 {
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_info_t info = {0};
 	int err;
 
-	snd_ctl_elem_info_alloca(&info);
-	snd_ctl_elem_info_set_id(info, id);
-	err = snd_ctl_elem_info(ctl, info);
+	snd_ctl_elem_info_set_id(&info, id);
+	err = snd_ctl_elem_info(ctl, &info);
 	if (err < 0)
 		return err;
-	if (!snd_ctl_elem_info_is_tlv_readable(info))
+	if (!snd_ctl_elem_info_is_tlv_readable(&info))
 		return -EINVAL;
-	if (snd_ctl_elem_info_get_type(info) != SND_CTL_ELEM_TYPE_INTEGER)
+	if (snd_ctl_elem_info_get_type(&info) != SND_CTL_ELEM_TYPE_INTEGER)
 		return -EINVAL;
-	rec->minval = snd_ctl_elem_info_get_min(info);
-	rec->maxval = snd_ctl_elem_info_get_max(info);
+	rec->minval = snd_ctl_elem_info_get_min(&info);
+	rec->maxval = snd_ctl_elem_info_get_max(&info);
 	err = snd_ctl_elem_tlv_read(ctl, id, rec->buf, sizeof(rec->buf));
 	if (err < 0)
 		return err;
-- 
2.7.4
