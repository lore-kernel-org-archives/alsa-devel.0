From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/24] ALSA: ctl: add serializer/deserializer
	of 'elem_info' structure for 32bit ABI compatibility
Date: Sat, 25 Nov 2017 18:19:45 +0900
Message-ID: <20171125092006.24408-4-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 3D7B726698E
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:12 +0100 (CET)
In-Reply-To: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
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

A 'snd_ctl_elem_info' structure includes a member of 'integer long' type.
A machine type for the type is known to have different size and alignment
between System V ABIs for architectures which adopts 'ILP32' or 'LP64'
data model.

This commit adds a pair of serializer and deserializer to convert data
between different layout of the structure on the ABIs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 3bd04ef5d221..7ebae996804a 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -105,6 +105,100 @@ static int serialize_to_elem_list_32(struct snd_ctl_file *ctl_file, void *dst,
 	return 0;
 }
 
+/*
+ * In this structure, '.value' member includes double-word (= 64 bits) member
+ * ('.integer64'). System V ABI for i386 architecture adopts different byte
+ * alignment for this type (4 bytes) than the ones in the other architectures
+ * (8 bytes). Fortunately, the total size of '.id', '.type', '.access', '.count'
+ * and '.owner' is multiples of 8, and there's no issue for offset of the
+ * '.value' member.
+ */
+struct snd_ctl_elem_info_32 {
+	struct snd_ctl_elem_id id;
+	s32 type;
+	u32 access;
+	u32 count;
+	s32 owner;
+	union {
+		struct {
+			s32 min;	/* long on ILP32. */
+			s32 max;	/* long on ILP32. */
+			s32 step;	/* long on ILP32. */
+		} integer;
+		struct {
+			u64 min;
+			u64 max;
+			u64 step;
+		} integer64;
+		struct {
+			u32 items;
+			u32 item;
+			s8 name[64];
+			u64 names_ptr;
+			u32 names_length;
+		} enumerated;
+		u8 reserved[128];
+	} value;
+	u16 dimen[4];
+	u8 reserved[64 - 4 * sizeof(u16)];
+} __packed;
+
+static int deserialize_from_elem_info_32(struct snd_ctl_file *ctl_file,
+					 void *dst, void *src)
+{
+	struct snd_ctl_elem_info *data = dst;
+	struct snd_ctl_elem_info_32 *data32 = src;
+
+	data->id = data32->id;
+	data->type = data32->type;
+	data->access = data32->access;
+	data->count = data32->count;
+	data->owner = data32->owner;
+
+	if (data->type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
+		data->value.integer.min = (s64)data32->value.integer.min;
+		data->value.integer.max = (s64)data32->value.integer.max;
+		data->value.integer.step = (s64)data32->value.integer.step;
+		/* Drop the rest of this field. */
+	} else {
+		/* Copy whole space of this field. */
+		memcpy(&data->value, &data32->value, sizeof(data->value));
+	}
+
+	memcpy(&data->dimen, &data32->dimen, sizeof(data->dimen));
+	memcpy(&data->reserved, &data32->reserved, sizeof(data->reserved));
+
+	return 0;
+}
+
+static int serialize_to_elem_info_32(struct snd_ctl_file *ctl_file, void *dst,
+				     void *src)
+{
+	struct snd_ctl_elem_info_32 *data32 = dst;
+	struct snd_ctl_elem_info *data = src;
+
+	data32->id = data->id;
+	data32->type = data->type;
+	data32->access = data->access;
+	data32->count = data->count;
+	data32->owner = data->owner;
+
+	if (data->type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
+		data32->value.integer.min = (s32)data->value.integer.min;
+		data32->value.integer.max = (s32)data->value.integer.max;
+		data32->value.integer.step = (s32)data->value.integer.step;
+		/* Drop rest of this field. */
+	} else {
+		/* Copy whole space of this field. */
+		memcpy(&data32->value, &data->value, sizeof(data32->value));
+	}
+
+	memcpy(&data32->dimen, &data->dimen, sizeof(data32->dimen));
+	memcpy(&data32->reserved, &data->reserved, sizeof(data32->reserved));
+
+	return 0;
+}
+
 struct snd_ctl_elem_list32 {
 	u32 offset;
 	u32 space;
-- 
2.14.1
