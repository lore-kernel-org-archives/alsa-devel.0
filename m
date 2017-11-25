From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 23/24] ALSA: ctl: replacement for compat
	ELEM_READ/ELEM_WRITE operation for modern 32 bit ABI
Date: Sat, 25 Nov 2017 18:20:05 +0900
Message-ID: <20171125092006.24408-24-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id F38B6267480
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:17 +0100 (CET)
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

This commit obsoletes old implementation for compat ELEM_READ/ELEM_WRITE
operation for modern 32 bit ABI with a renewal way.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 218 ++++----------------------------------------
 1 file changed, 20 insertions(+), 198 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 430f178aa4d8..bbda8eabf18f 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -397,194 +397,6 @@ static int __maybe_unused serialize_to_elem_value_i386(
 	return 0;
 }
 
-/* read / write */
-struct snd_ctl_elem_value32 {
-	struct snd_ctl_elem_id id;
-	unsigned int indirect;	/* bit-field causes misalignment */
-        union {
-		s32 integer[128];
-		unsigned char data[512];
-		s64 integer64[64];
-        } value;
-        unsigned char reserved[128];
-};
-
-/* get the value type and count of the control */
-static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
-			int *countp)
-{
-	struct snd_kcontrol *kctl;
-	struct snd_ctl_elem_info *info;
-	int err;
-
-	down_read(&card->controls_rwsem);
-	kctl = snd_ctl_find_id(card, id);
-	if (! kctl) {
-		up_read(&card->controls_rwsem);
-		return -ENOENT;
-	}
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (info == NULL) {
-		up_read(&card->controls_rwsem);
-		return -ENOMEM;
-	}
-	info->id = *id;
-	err = kctl->info(kctl, info);
-	up_read(&card->controls_rwsem);
-	if (err >= 0) {
-		err = info->type;
-		*countp = info->count;
-	}
-	kfree(info);
-	return err;
-}
-
-static int get_elem_size(int type, int count)
-{
-	switch (type) {
-	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
-		return sizeof(s64) * count;
-	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
-		return sizeof(int) * count;
-	case SNDRV_CTL_ELEM_TYPE_BYTES:
-		return 512;
-	case SNDRV_CTL_ELEM_TYPE_IEC958:
-		return sizeof(struct snd_aes_iec958);
-	default:
-		return -1;
-	}
-}
-
-static int copy_ctl_value_from_user(struct snd_card *card,
-				    struct snd_ctl_elem_value *data,
-				    void __user *userdata,
-				    void __user *valuep,
-				    int *typep, int *countp)
-{
-	struct snd_ctl_elem_value32 __user *data32 = userdata;
-	int i, type, size;
-	int uninitialized_var(count);
-	unsigned int indirect;
-
-	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)))
-		return -EFAULT;
-	if (get_user(indirect, &data32->indirect))
-		return -EFAULT;
-	if (indirect)
-		return -EINVAL;
-	type = get_ctl_type(card, &data->id, &count);
-	if (type < 0)
-		return type;
-
-	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
-	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
-		for (i = 0; i < count; i++) {
-			s32 __user *intp = valuep;
-			int val;
-			if (get_user(val, &intp[i]))
-				return -EFAULT;
-			data->value.integer.value[i] = val;
-		}
-	} else {
-		size = get_elem_size(type, count);
-		if (size < 0) {
-			dev_err(card->dev, "snd_ioctl32_ctl_elem_value: unknown type %d\n", type);
-			return -EINVAL;
-		}
-		if (copy_from_user(data->value.bytes.data, valuep, size))
-			return -EFAULT;
-	}
-
-	*typep = type;
-	*countp = count;
-	return 0;
-}
-
-/* restore the value to 32bit */
-static int copy_ctl_value_to_user(void __user *userdata,
-				  void __user *valuep,
-				  struct snd_ctl_elem_value *data,
-				  int type, int count)
-{
-	int i, size;
-
-	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
-	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
-		for (i = 0; i < count; i++) {
-			s32 __user *intp = valuep;
-			int val;
-			val = data->value.integer.value[i];
-			if (put_user(val, &intp[i]))
-				return -EFAULT;
-		}
-	} else {
-		size = get_elem_size(type, count);
-		if (copy_to_user(valuep, data->value.bytes.data, size))
-			return -EFAULT;
-	}
-	return 0;
-}
-
-static int ctl_elem_read_user(struct snd_ctl_file *ctl_file,
-			      void __user *userdata, void __user *valuep)
-{
-	struct snd_ctl_elem_value *data;
-	int err, type, count;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (data == NULL)
-		return -ENOMEM;
-
-	err = copy_ctl_value_from_user(ctl_file->card, data, userdata, valuep,
-				       &type, &count);
-	if (err < 0)
-		goto error;
-
-	err = snd_ctl_elem_read(ctl_file, data);
-	if (err < 0)
-		goto error;
-	err = copy_ctl_value_to_user(userdata, valuep, data, type, count);
- error:
-	kfree(data);
-	return err;
-}
-
-static int ctl_elem_write_user(struct snd_ctl_file *ctl_file,
-			       void __user *userdata, void __user *valuep)
-{
-	struct snd_ctl_elem_value *data;
-	int err, type, count;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (data == NULL)
-		return -ENOMEM;
-
-	err = copy_ctl_value_from_user(ctl_file->card, data, userdata, valuep,
-				       &type, &count);
-	if (err < 0)
-		goto error;
-
-	err = snd_ctl_elem_write(ctl_file, data);
-	if (err < 0)
-		goto error;
-	err = copy_ctl_value_to_user(userdata, valuep, data, type, count);
- error:
-	kfree(data);
-	return err;
-}
-
-static int snd_ctl_elem_read_user_compat(struct snd_ctl_file *ctl_file,
-					 struct snd_ctl_elem_value32 __user *data32)
-{
-	return ctl_elem_read_user(ctl_file, data32, &data32->value);
-}
-
-static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
-					  struct snd_ctl_elem_value32 __user *data32)
-{
-	return ctl_elem_write_user(file, data32, &data32->value);
-}
-
 static int ctl_compat_ioctl_elem_list_32(struct snd_ctl_file *ctl_file,
 					 void *buf)
 {
@@ -638,12 +450,14 @@ enum {
 				_IOWR('U', 0x10, struct snd_ctl_elem_list_32),
 	SNDRV_CTL_IOCTL_ELEM_INFO_32 =
 				_IOWR('U', 0x11, struct snd_ctl_elem_info_32),
-	SNDRV_CTL_IOCTL_ELEM_READ32 = _IOWR('U', 0x12, struct snd_ctl_elem_value32),
-	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_ADD_32 =
 				_IOWR('U', 0x17, struct snd_ctl_elem_info_32),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE_32 =
 				_IOWR('U', 0x18, struct snd_ctl_elem_info_32),
+	SNDRV_CTL_IOCTL_ELEM_READ_32 =
+				_IOWR('U', 0x12, struct snd_ctl_elem_value_32),
+	SNDRV_CTL_IOCTL_ELEM_WRITE_32 =
+				_IOWR('U', 0x13, struct snd_ctl_elem_value_32),
 	SNDRV_CTL_IOCTL_ELEM_READ_I386 =
 				_IOWR('U', 0x12, struct snd_ctl_elem_value_i386),
 	SNDRV_CTL_IOCTL_ELEM_WRITE_I386 =
@@ -690,6 +504,22 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 			serialize_to_elem_info_32,
 			SNDRV_CTL_IOCTL_ELEM_REPLACE,
 		},
+#if !defined(CONFIG_X86_64) || defined(CONFIG_X86_X32)
+		{
+			SNDRV_CTL_IOCTL_ELEM_READ_32,
+			deserialize_from_elem_value_32,
+			ctl_compat_ioctl_elem_read_32,
+			serialize_to_elem_value_32,
+			SNDRV_CTL_IOCTL_ELEM_READ,
+		},
+		{
+			SNDRV_CTL_IOCTL_ELEM_WRITE_32,
+			deserialize_from_elem_value_32,
+			ctl_compat_ioctl_elem_write_32,
+			serialize_to_elem_value_32,
+			SNDRV_CTL_IOCTL_ELEM_WRITE,
+		},
+#endif
 #ifdef CONFIG_X86_64
 		{
 			SNDRV_CTL_IOCTL_ELEM_READ_I386,
@@ -708,7 +538,6 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 #endif
 	};
 	struct snd_ctl_file *ctl;
-	void __user *argp = compat_ptr(arg);
 	void *buf, *data;
 	unsigned int size;
 	int i;
@@ -718,13 +547,6 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 	if (snd_BUG_ON(!ctl || !ctl->card))
 		return -ENXIO;
 
-	switch (cmd) {
-	case SNDRV_CTL_IOCTL_ELEM_READ32:
-		return snd_ctl_elem_read_user_compat(ctl, argp);
-	case SNDRV_CTL_IOCTL_ELEM_WRITE32:
-		return snd_ctl_elem_write_user_compat(ctl, argp);
-	}
-
 	for (i = 0; i < ARRAY_SIZE(handlers); ++i) {
 		if (handlers[i].cmd == cmd)
 			break;
-- 
2.14.1
