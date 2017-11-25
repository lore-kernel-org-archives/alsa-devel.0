From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/24] ALSA: ctl: add serializer/deserializer
	of 'elem_value' structure for i386 ABI compatibility
Date: Sat, 25 Nov 2017 18:19:47 +0900
Message-ID: <20171125092006.24408-6-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E11D3266F70
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:15 +0100 (CET)
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

A previous commit adds serializer/deserializer of 'snd_ctl_elem_value'
structure for System V ABIs to modern 32 bit architectures. However, i386
is an exception because it has 4 bytes alignment for double-word machine
type. This brings different 'internal padding' to the structure from the
one on ABIs for modern 32 bit architectures.

This commit adds a pair of serializer and deserializer to convert data
between different layout of the structure on the ABIs. To describe
layout of the structure for i386 ABI on LP64 ABI, bitfield is used for
the internal padding, and 'packed' attribute is used as a hint for
compilers to native padding convention.

The serializer/deserializer are useless on non-Intel architectures. For
this case, '__maybe_unused' is added as a hint to compilers for
optimization.

Reference: System V application binary interface Intel386 architecture
           processor supplenent, draft copy of forth edition (1997,
           The Santa Cruz Operation, Inc. and AT&T)
Reference: System V application binary interface AMD64 architecture
           processor supplement (with LP64 and ILP32 programming models)
           draft version 0.99.8 (2017, H.J. Lu, Michael Matz, Milind
           Girkar, Jan Hubicka, Andreas Jaeger and Mark Mitchell)
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 5c0e82afe400..5dfb31a22470 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -308,6 +308,95 @@ static int __maybe_unused serialize_to_elem_value_32(
 	return 0;
 }
 
+/*
+ * Unlikw any System V ABI for 32 bit architecture, ABI for i386 architecture has
+ * different alignment (4 bytes) for double-word type. Thus offset of '.value'
+ * member is multiples of 4 bytes.
+ */
+struct snd_ctl_elem_value_i386 {
+	struct snd_ctl_elem_id id;
+	u32 indirect:1;
+	u32 padding:31;			/* For 4 bytes alignment of '.value'. */
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
+static int __maybe_unused deserialize_from_elem_value_i386(
+			struct snd_ctl_file *ctl_file, void *dst, void *src)
+{
+	struct snd_ctl_elem_value *data = dst;
+	struct snd_ctl_elem_value_i386 *datai386 = src;
+	snd_ctl_elem_type_t type;
+	int err;
+
+	err = get_type(ctl_file, &datai386->id, &type);
+	if (err < 0)
+		return err;
+
+	data->id = datai386->id;
+	data->indirect = datai386->indirect;
+
+	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
+	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
+		int i;
+		for (i = 0; i < 128; ++i) {
+			data->value.integer.value[i] =
+						(s64)datai386->value.integer[i];
+		}
+		/* Drop rest of this field. */
+	} else {
+		/* Copy whole space of this field. */
+		memcpy(&data->value, &datai386->value, sizeof(data->value));
+	}
+
+	data->tstamp.tv_sec = (s64)datai386->tstamp.tv_sec;
+	data->tstamp.tv_nsec = (s64)datai386->tstamp.tv_nsec;
+
+	return 0;
+}
+
+static int __maybe_unused serialize_to_elem_value_i386(
+			struct snd_ctl_file *ctl_file, void *dst, void *src)
+{
+	struct snd_ctl_elem_value_i386 *datai386 = dst;
+	struct snd_ctl_elem_value *data = src;
+	snd_ctl_elem_type_t type;
+	int err;
+
+	err = get_type(ctl_file, &data->id, &type);
+	if (err < 0)
+		return err;
+
+	datai386->id = data->id;
+	datai386->indirect = data->indirect;
+
+	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
+	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
+		int i;
+		for (i = 0; i < 128; ++i) {
+			datai386->value.integer[i] =
+					(s32)data->value.integer.value[i];
+		}
+		/* Drop rest of this field. */
+	} else {
+		/* Copy whole space of this field. */
+		memcpy(&datai386->value, &data->value, sizeof(datai386->value));
+	}
+
+	datai386->tstamp.tv_sec = (s32)data->tstamp.tv_sec;
+	datai386->tstamp.tv_nsec = (s32)data->tstamp.tv_nsec;
+
+	return 0;
+}
+
 struct snd_ctl_elem_list32 {
 	u32 offset;
 	u32 space;
-- 
2.14.1
