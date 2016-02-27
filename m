From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: ctl: Fix incompatible ioctls for X32 ABI
Date: Sat, 27 Feb 2016 18:04:40 +0100
Message-ID: <1456592680-1688-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 532FA260509
 for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2016 18:04:48 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D2694AC46
 for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2016 17:04:44 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The X32 ABI takes the same alignment like x86-64, and this may result
in the incompatible struct size from ia32.  Unfortunately, we hit this
in some control ABI: struct snd_ctl_elem_value differs between them
due to the position of 64bit variable array.  This ends up with the
unknown ioctl (ENOTTY) error.

The fix is to add the compat entries for the new aligned struct.

Reported-and-tested-by: Steven Newbury <steve@snewbury.org.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control_compat.c | 90 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index b9c0910fb8c4..dff3671217c8 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -170,6 +170,19 @@ struct snd_ctl_elem_value32 {
         unsigned char reserved[128];
 };
 
+#ifdef CONFIG_X86_X32
+/* x32 has a different alignment for 64bit values from ia32 */
+struct snd_ctl_elem_value_x32 {
+	struct snd_ctl_elem_id id;
+	unsigned int indirect;	/* bit-field causes misalignment */
+	union {
+		s32 integer[128];
+		unsigned char data[512];
+		s64 integer64[64];
+	} value;
+	unsigned char reserved[128];
+};
+#endif /* CONFIG_X86_X32 */
 
 /* get the value type and count of the control */
 static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
@@ -219,9 +232,11 @@ static int get_elem_size(int type, int count)
 
 static int copy_ctl_value_from_user(struct snd_card *card,
 				    struct snd_ctl_elem_value *data,
-				    struct snd_ctl_elem_value32 __user *data32,
+				    void __user *userdata,
+				    void __user *valuep,
 				    int *typep, int *countp)
 {
+	struct snd_ctl_elem_value32 __user *data32 = userdata;
 	int i, type, size;
 	int uninitialized_var(count);
 	unsigned int indirect;
@@ -239,8 +254,9 @@ static int copy_ctl_value_from_user(struct snd_card *card,
 	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
 	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
 		for (i = 0; i < count; i++) {
+			s32 __user *intp = valuep;
 			int val;
-			if (get_user(val, &data32->value.integer[i]))
+			if (get_user(val, &intp[i]))
 				return -EFAULT;
 			data->value.integer.value[i] = val;
 		}
@@ -250,8 +266,7 @@ static int copy_ctl_value_from_user(struct snd_card *card,
 			dev_err(card->dev, "snd_ioctl32_ctl_elem_value: unknown type %d\n", type);
 			return -EINVAL;
 		}
-		if (copy_from_user(data->value.bytes.data,
-				   data32->value.data, size))
+		if (copy_from_user(data->value.bytes.data, valuep, size))
 			return -EFAULT;
 	}
 
@@ -261,7 +276,8 @@ static int copy_ctl_value_from_user(struct snd_card *card,
 }
 
 /* restore the value to 32bit */
-static int copy_ctl_value_to_user(struct snd_ctl_elem_value32 __user *data32,
+static int copy_ctl_value_to_user(void __user *userdata,
+				  void __user *valuep,
 				  struct snd_ctl_elem_value *data,
 				  int type, int count)
 {
@@ -270,22 +286,22 @@ static int copy_ctl_value_to_user(struct snd_ctl_elem_value32 __user *data32,
 	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
 	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
 		for (i = 0; i < count; i++) {
+			s32 __user *intp = valuep;
 			int val;
 			val = data->value.integer.value[i];
-			if (put_user(val, &data32->value.integer[i]))
+			if (put_user(val, &intp[i]))
 				return -EFAULT;
 		}
 	} else {
 		size = get_elem_size(type, count);
-		if (copy_to_user(data32->value.data,
-				 data->value.bytes.data, size))
+		if (copy_to_user(valuep, data->value.bytes.data, size))
 			return -EFAULT;
 	}
 	return 0;
 }
 
-static int snd_ctl_elem_read_user_compat(struct snd_card *card, 
-					 struct snd_ctl_elem_value32 __user *data32)
+static int ctl_elem_read_user(struct snd_card *card,
+			      void __user *userdata, void __user *valuep)
 {
 	struct snd_ctl_elem_value *data;
 	int err, type, count;
@@ -294,7 +310,9 @@ static int snd_ctl_elem_read_user_compat(struct snd_card *card,
 	if (data == NULL)
 		return -ENOMEM;
 
-	if ((err = copy_ctl_value_from_user(card, data, data32, &type, &count)) < 0)
+	err = copy_ctl_value_from_user(card, data, userdata, valuep,
+				       &type, &count);
+	if (err < 0)
 		goto error;
 
 	snd_power_lock(card);
@@ -303,14 +321,15 @@ static int snd_ctl_elem_read_user_compat(struct snd_card *card,
 		err = snd_ctl_elem_read(card, data);
 	snd_power_unlock(card);
 	if (err >= 0)
-		err = copy_ctl_value_to_user(data32, data, type, count);
+		err = copy_ctl_value_to_user(userdata, valuep, data,
+					     type, count);
  error:
 	kfree(data);
 	return err;
 }
 
-static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
-					  struct snd_ctl_elem_value32 __user *data32)
+static int ctl_elem_write_user(struct snd_ctl_file *file,
+			       void __user *userdata, void __user *valuep)
 {
 	struct snd_ctl_elem_value *data;
 	struct snd_card *card = file->card;
@@ -320,7 +339,9 @@ static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
 	if (data == NULL)
 		return -ENOMEM;
 
-	if ((err = copy_ctl_value_from_user(card, data, data32, &type, &count)) < 0)
+	err = copy_ctl_value_from_user(card, data, userdata, valuep,
+				       &type, &count);
+	if (err < 0)
 		goto error;
 
 	snd_power_lock(card);
@@ -329,12 +350,39 @@ static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
 		err = snd_ctl_elem_write(card, file, data);
 	snd_power_unlock(card);
 	if (err >= 0)
-		err = copy_ctl_value_to_user(data32, data, type, count);
+		err = copy_ctl_value_to_user(userdata, valuep, data,
+					     type, count);
  error:
 	kfree(data);
 	return err;
 }
 
+static int snd_ctl_elem_read_user_compat(struct snd_card *card,
+					 struct snd_ctl_elem_value32 __user *data32)
+{
+	return ctl_elem_read_user(card, data32, &data32->value);
+}
+
+static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
+					  struct snd_ctl_elem_value32 __user *data32)
+{
+	return ctl_elem_write_user(file, data32, &data32->value);
+}
+
+#ifdef CONFIG_X86_X32
+static int snd_ctl_elem_read_user_x32_compat(struct snd_card *card,
+				 struct snd_ctl_elem_value_x32 __user *data32)
+{
+	return ctl_elem_read_user(card, data32, &data32->value);
+}
+
+static int snd_ctl_elem_write_user_x32_compat(struct snd_ctl_file *file,
+				 struct snd_ctl_elem_value_x32 __user *data32)
+{
+	return ctl_elem_write_user(file, data32, &data32->value);
+}
+#endif /* CONFIG_X86_X32 */
+
 /* add or replace a user control */
 static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
 				   struct snd_ctl_elem_info32 __user *data32,
@@ -391,6 +439,10 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_INFO32 = _IOWR('U', 0x11, struct snd_ctl_elem_info32),
 	SNDRV_CTL_IOCTL_ELEM_READ32 = _IOWR('U', 0x12, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
+#ifdef CONFIG_X86_X32
+	SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
+	SNDRV_CTL_IOCTL_ELEM_WRITE_X32 = _IOWR('U', 0x13, struct snd_ctl_elem_value_x32),
+#endif
 	SNDRV_CTL_IOCTL_ELEM_ADD32 = _IOWR('U', 0x17, struct snd_ctl_elem_info32),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE32 = _IOWR('U', 0x18, struct snd_ctl_elem_info32),
 };
@@ -427,6 +479,12 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
 		return snd_ctl_elem_read_user_compat(ctl->card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE32:
 		return snd_ctl_elem_write_user_compat(ctl, argp);
+#ifdef CONFIG_X86_X32
+	case SNDRV_CTL_IOCTL_ELEM_READ_X32:
+		return snd_ctl_elem_read_user_x32_compat(ctl->card, argp);
+	case SNDRV_CTL_IOCTL_ELEM_WRITE_X32:
+		return snd_ctl_elem_write_user_x32_compat(ctl, argp);
+#endif
 	case SNDRV_CTL_IOCTL_ELEM_ADD32:
 		return snd_ctl_elem_add_compat(ctl, argp, 0);
 	case SNDRV_CTL_IOCTL_ELEM_REPLACE32:
-- 
2.7.2
