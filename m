From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 21/24] ALSA: ctl: replacement for compat
	ELEM_REPLACE operation for any 32 bit ABI
Date: Sat, 25 Nov 2017 18:20:03 +0900
Message-ID: <20171125092006.24408-22-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 89C2A266FA1
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:18 +0100 (CET)
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

This commit obsoletes old implementation for compat ELEM_REPLACE operation
with a renewal way.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 111 ++++++++------------------------------------
 1 file changed, 19 insertions(+), 92 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 8e2617c6217e..2982423dccd0 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -397,40 +397,6 @@ static int __maybe_unused serialize_to_elem_value_i386(
 	return 0;
 }
 
-/*
- * control element info
- * it uses union, so the things are not easy..
- */
-
-struct snd_ctl_elem_info32 {
-	struct snd_ctl_elem_id id; // the size of struct is same
-	s32 type;
-	u32 access;
-	u32 count;
-	s32 owner;
-	union {
-		struct {
-			s32 min;
-			s32 max;
-			s32 step;
-		} integer;
-		struct {
-			u64 min;
-			u64 max;
-			u64 step;
-		} integer64;
-		struct {
-			u32 items;
-			u32 item;
-			char name[64];
-			u64 names_ptr;
-			u32 names_length;
-		} enumerated;
-		unsigned char reserved[128];
-	} value;
-	unsigned char reserved[64];
-} __attribute__((packed));
-
 /* read / write */
 struct snd_ctl_elem_value32 {
 	struct snd_ctl_elem_id id;
@@ -649,60 +615,6 @@ static int snd_ctl_elem_write_user_x32(struct snd_ctl_file *file,
 }
 #endif /* CONFIG_X86_X32 */
 
-/* add or replace a user control */
-static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
-				   struct snd_ctl_elem_info32 __user *data32,
-				   int replace)
-{
-	struct snd_ctl_elem_info *data;
-	int err;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (! data)
-		return -ENOMEM;
-
-	err = -EFAULT;
-	/* id, type, access, count */ \
-	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
-	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
-		goto error;
-	if (get_user(data->owner, &data32->owner) ||
-	    get_user(data->type, &data32->type))
-		goto error;
-	switch (data->type) {
-	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
-	case SNDRV_CTL_ELEM_TYPE_INTEGER:
-		if (get_user(data->value.integer.min, &data32->value.integer.min) ||
-		    get_user(data->value.integer.max, &data32->value.integer.max) ||
-		    get_user(data->value.integer.step, &data32->value.integer.step))
-			goto error;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
-		if (copy_from_user(&data->value.integer64,
-				   &data32->value.integer64,
-				   sizeof(data->value.integer64)))
-			goto error;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
-		if (copy_from_user(&data->value.enumerated,
-				   &data32->value.enumerated,
-				   sizeof(data->value.enumerated)))
-			goto error;
-		data->value.enumerated.names_ptr =
-			(uintptr_t)compat_ptr(data->value.enumerated.names_ptr);
-		break;
-	default:
-		break;
-	}
-	if (!replace)
-		err = snd_ctl_elem_add(file, data);
-	else
-		err = snd_ctl_elem_replace(file, data);
- error:
-	kfree(data);
-	return err;
-}  
-
 static int ctl_compat_ioctl_elem_list_32(struct snd_ctl_file *ctl_file,
 					 void *buf)
 {
@@ -727,6 +639,14 @@ static int ctl_compat_ioctl_elem_add_32(struct snd_ctl_file *ctl_file,
 	return snd_ctl_elem_add(ctl_file, info);
 }
 
+static int ctl_compat_ioctl_elem_replace_32(struct snd_ctl_file *ctl_file,
+					    void *buf)
+{
+	struct snd_ctl_elem_info *info = buf;
+
+	return snd_ctl_elem_replace(ctl_file, info);
+}
+
 enum {
 	SNDRV_CTL_IOCTL_ELEM_LIST_32 =
 				_IOWR('U', 0x10, struct snd_ctl_elem_list_32),
@@ -736,7 +656,8 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_ADD_32 =
 				_IOWR('U', 0x17, struct snd_ctl_elem_info_32),
-	SNDRV_CTL_IOCTL_ELEM_REPLACE32 = _IOWR('U', 0x18, struct snd_ctl_elem_info32),
+	SNDRV_CTL_IOCTL_ELEM_REPLACE_32 =
+				_IOWR('U', 0x18, struct snd_ctl_elem_info_32),
 #ifdef CONFIG_X86_X32
 	SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE_X32 = _IOWR('U', 0x13, struct snd_ctl_elem_value_x32),
@@ -776,6 +697,13 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 			serialize_to_elem_info_32,
 			SNDRV_CTL_IOCTL_ELEM_ADD,
 		},
+		{
+			SNDRV_CTL_IOCTL_ELEM_REPLACE_32,
+			deserialize_from_elem_info_32,
+			ctl_compat_ioctl_elem_replace_32,
+			serialize_to_elem_info_32,
+			SNDRV_CTL_IOCTL_ELEM_REPLACE,
+		},
 	};
 	struct snd_ctl_file *ctl;
 	void __user *argp = compat_ptr(arg);
@@ -793,8 +721,6 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		return snd_ctl_elem_read_user_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE32:
 		return snd_ctl_elem_write_user_compat(ctl, argp);
-	case SNDRV_CTL_IOCTL_ELEM_REPLACE32:
-		return snd_ctl_elem_add_compat(ctl, argp, 1);
 #ifdef CONFIG_X86_X32
 	case SNDRV_CTL_IOCTL_ELEM_READ_X32:
 		return snd_ctl_elem_read_user_x32(ctl, argp);
@@ -862,7 +788,8 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 	}
 
 	if (err < 0) {
-		if (cmd == SNDRV_CTL_IOCTL_ELEM_ADD_32) {
+		if (cmd == SNDRV_CTL_IOCTL_ELEM_ADD_32 ||
+		    cmd == SNDRV_CTL_IOCTL_ELEM_REPLACE_32) {
 			struct snd_ctl_elem_info *info = buf;
 			snd_ctl_remove_user_ctl(ctl, &info->id);
 		}
-- 
2.14.1
