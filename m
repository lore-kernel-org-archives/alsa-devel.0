From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/24] ALSA: ctl: add serializer/deserializer
	of 'elem_list' structure for 32bit ABI compatibility
Date: Sat, 25 Nov 2017 18:19:44 +0900
Message-ID: <20171125092006.24408-3-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 3FD8C266F59
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

A 'snd_ctl_elem_list' structure includes a member of 'pointer' type.
A machine type for the type is known to have different size and alignment
between System V ABIs for architectures which adopts 'ILP32' or 'LP64'
data model.

This commit adds a pair of serializer and deserializer to convert data
between different layout of the structure on the ABIs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index dec89717d8e3..3bd04ef5d221 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -23,6 +23,88 @@
 #include <linux/compat.h>
 #include <linux/slab.h>
 
+/*
+ * In this file, System V ABIs for any 64 bit architecture are assumed:
+ *  - Machine type for storage class of 1 byte has:
+ *    - size: 1 byte
+ *    - alignment: 1 byte
+ *  - Machine type for storage class of 2 bytes has:
+ *    - size: 2 bytes
+ *    - alignment: 2 bytes
+ *  - Machine type for storage class of 4 bytes has:
+ *    - size: 4 bytes
+ *    - alignment: 4 bytes
+ *  - Machine type for storage class of 8 bytes has:
+ *    - size: 8 bytes
+ *    - alignment: 8 bytes
+ *
+ * And System V ABIs for modern 32 bit architecture are assumed to have the same
+ * rule about size and alignment as the above machine types.
+ *
+ * As an exception, System V ABI for i386 architecture is assumed:
+ *  - Machine type for storage class of 8 bytes has:
+ *    - size: 8 bytes
+ *    - alignment: 4 bytes
+ *
+ * Any System V ABIs are assumed to have the same rule for aggregates, unions
+ * and alignment of members with bitfields. Additionally, 'packed' of attribute
+ * is a hint for compiles to remove internal and tail paddings even if bitfields
+ * are used.
+ */
+
+/*
+ * In any System V ABI for 32 bit architecture, the maximum length of members on
+ * this structure is 4 bytes. This member has 4 byte alignment and the size of
+ * this structure is multiples of 4 bytes, equals to 72 bytes. However, total
+ * size of all members is 70 bytes. As a result, 2 bytes are added as padding in
+ * the end.
+ */
+struct snd_ctl_elem_list_32 {
+	u32 offset;
+	u32 space;
+	u32 used;
+	u32 count;
+	u32 pids;		/* pointer on ILP32. */
+	u8 reserved[50];
+	u8 padding[2];
+} __packed;
+
+static int deserialize_from_elem_list_32(struct snd_ctl_file *ctl_file,
+					 void *dst, void *src)
+{
+	struct snd_ctl_elem_list *data = dst;
+	struct snd_ctl_elem_list_32 *data32 = src;
+
+	data->offset = data32->offset;
+	data->space = data32->space;
+	data->used = data32->used;
+	data->count = data32->count;
+
+	data->pids = (struct snd_ctl_elem_id __user *)compat_ptr(data32->pids);
+
+	memcpy(data->reserved, data32->reserved, sizeof(data->reserved));
+
+	return 0;
+}
+
+static int serialize_to_elem_list_32(struct snd_ctl_file *ctl_file, void *dst,
+				     void *src)
+{
+	struct snd_ctl_elem_list_32 *data32 = dst;
+	struct snd_ctl_elem_list *data = src;
+
+	data32->offset = data->offset;
+	data32->space = data->space;
+	data32->used = data->used;
+	data32->count = data->count;
+
+	data32->pids = (u32)ptr_to_compat(data->pids);
+
+	memcpy(data32->reserved, data->reserved, sizeof(data32->reserved));
+
+	return 0;
+}
+
 struct snd_ctl_elem_list32 {
 	u32 offset;
 	u32 space;
-- 
2.14.1
