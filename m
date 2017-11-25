From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/24] ALSA: ctl: add serializer/deserializer
	of 'elem_value' structure for modern 32 bit ABIs compatibility
Date: Sat, 25 Nov 2017 18:19:46 +0900
Message-ID: <20171125092006.24408-5-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 420FB266F6B
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

A structure of 'snd_ctl_elem_value' includes a member of 'long' type. A
machine type for this type is known to have different size and alignment
between System V ABIs for architectures which adopts 'ILP32' or 'LP64'
data model.

Furthermore, the structure has another issue about offset for union with
a member of 'long long' type. Regardless of the ABIs, this type has 8 bytes
size and 8 bytes alignment. This causes the offset as multiples of 8 bytes.
On the other hand, total in the structure, size of members forth of the
union is not multiples of 8 bytes. This brings 'internal padding' to the
structure.

This commit adds a pair of serializer and deserializer to convert data
between different layout of the structure on the ABIs. To describe
layout of the structure for ILP32 ABI, bitfield is used for the internal
padding, and 'packed' attribute is used as a hint for compilers to
native padding convention.

On machines of Intel architecture, unless support for x32 ABI is enabled,
the serializer/deserializer are useless. For this case, '__maybe_unused'
is added as a hint to compilers for optimization.

Reference: System V application binary interface AMD64 architecture
           processor supplement (with LP64 and ILP32 programming models)
           draft version 0.99.8 (2017, H.J. Lu, Michael Matz, Milind
           Girkar, Jan Hubicka, Andreas Jaeger and Mark Mitchell)
Reference: Procedure call standard for the ARM architecture (2015, ARM
           Ltd.) ARM IHI 0042F
Reference: Procedure call standard for the ARM 64-bit architecture
           (aarch64) (2013, ARM Limited) ARM IHI 0055C_beta
Reference: System V application binary interface PowerPC processor
           supplement, revision A (1995, Steve Zecker and Kari Karhi)
           802-334-10
Reference: 64-bit PowerPC ELF application binary interface supplement, 1.7
           edition (2003, Ian Lance Taylor)
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 109 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 7ebae996804a..5c0e82afe400 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -199,6 +199,115 @@ static int serialize_to_elem_info_32(struct snd_ctl_file *ctl_file, void *dst,
 	return 0;
 }
 
+/*
+ * Unfortunately, unlike the above structure, total size of '.id' and
+ * '.indirect' is not multiples of 8 bytes (it's 68 bytes). Except for System V
+ * ABI for i386 architecture, 'double-word' type has 8 bytes alignment. For such
+ * architectures, 32 bit padding is needed.
+ */
+struct snd_ctl_elem_value_32 {
+	struct snd_ctl_elem_id id;
+	u32 indirect:1;
+	u64 padding1:63;		/* For 8 bytes alignment of '.value'. */
+	union {
+		s32 integer[128];	/* long on ILP32. */
+		u8 data[512];
+		s64 integer64[64];
+	} value;
+	struct {
+		s32 tv_sec;		/* long on ILP32. */
+		s32 tv_nsec;		/* long on ILP32. */
+	} tstamp;
+	u8 reserved[128 - sizeof(s32) - sizeof(s32)];
+} __packed;
+
+static int get_type(struct snd_ctl_file *ctl_file, struct snd_ctl_elem_id *id,
+		    snd_ctl_elem_type_t *type)
+{
+	struct snd_ctl_elem_info *info;
+	int err;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->id = *id;
+
+	err = snd_ctl_elem_info(ctl_file, info);
+	if (err >= 0)
+		*type = info->type;
+
+	kfree(info);
+	return err;
+}
+
+static int __maybe_unused deserialize_from_elem_value_32(
+			struct snd_ctl_file *ctl_file, void *dst, void *src)
+{
+	struct snd_ctl_elem_value *data = dst;
+	struct snd_ctl_elem_value_32 *data32 = src;
+	snd_ctl_elem_type_t type;
+	int err;
+
+	err = get_type(ctl_file, &data32->id, &type);
+	if (err < 0)
+		return err;
+
+	data->id = data32->id;
+	data->indirect = data32->indirect;
+
+	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
+	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
+		int i;
+		for (i = 0; i < 128; ++i) {
+			data->value.integer.value[i] =
+						(s64)data32->value.integer[i];
+		}
+		/* Drop rest of this field. */
+	} else {
+		/* Copy whole space of this field. */
+		memcpy(&data->value, &data32->value, sizeof(data->value));
+	}
+
+	data->tstamp.tv_sec = (s64)data32->tstamp.tv_sec;
+	data->tstamp.tv_nsec = (s64)data32->tstamp.tv_nsec;
+
+	return 0;
+}
+
+static int __maybe_unused serialize_to_elem_value_32(
+			struct snd_ctl_file *ctl_file, void *dst, void *src)
+{
+	struct snd_ctl_elem_value_32 *data32 = dst;
+	struct snd_ctl_elem_value *data = src;
+	snd_ctl_elem_type_t type;
+	int err;
+
+	err = get_type(ctl_file, &data->id, &type);
+	if (err < 0)
+		return err;
+
+	data32->id = data->id;
+	data32->indirect = data->indirect;
+
+	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
+	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
+		int i;
+		for (i = 0; i < 128; ++i) {
+			data32->value.integer[i] =
+					(s32)data->value.integer.value[i];
+		}
+		/* Drop rest of this field. */
+	} else {
+		/* Copy whole space of this field. */
+		memcpy(&data32->value, &data->value, sizeof(data32->value));
+	}
+
+	data32->tstamp.tv_sec = (s32)data->tstamp.tv_sec;
+	data32->tstamp.tv_nsec = (s32)data->tstamp.tv_nsec;
+
+	return 0;
+}
+
 struct snd_ctl_elem_list32 {
 	u32 offset;
 	u32 space;
-- 
2.14.1
