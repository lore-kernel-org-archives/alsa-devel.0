From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/24] ALSA: ctl: replacement for compat
	ELEM_INFO operation for any 32 bit ABI
Date: Sat, 25 Nov 2017 18:20:01 +0900
Message-ID: <20171125092006.24408-20-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EEB53267467
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

This commit obsoletes old implementation for compat ELEM_INFO operation
with a renewal way.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 80 ++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 63 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 427158b39f5a..499cc459917f 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -431,66 +431,6 @@ struct snd_ctl_elem_info32 {
 	unsigned char reserved[64];
 } __attribute__((packed));
 
-static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
-				    struct snd_ctl_elem_info32 __user *data32)
-{
-	struct snd_ctl_elem_info *data;
-	int err;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (! data)
-		return -ENOMEM;
-
-	err = -EFAULT;
-	/* copy id */
-	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)))
-		goto error;
-	/* we need to copy the item index.
-	 * hope this doesn't break anything..
-	 */
-	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item))
-		goto error;
-
-	err = snd_ctl_elem_info(ctl, data);
-	if (err < 0)
-		goto error;
-	/* restore info to 32bit */
-	err = -EFAULT;
-	/* id, type, access, count */
-	if (copy_to_user(&data32->id, &data->id, sizeof(data->id)) ||
-	    copy_to_user(&data32->type, &data->type, 3 * sizeof(u32)))
-		goto error;
-	if (put_user(data->owner, &data32->owner))
-		goto error;
-	switch (data->type) {
-	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
-	case SNDRV_CTL_ELEM_TYPE_INTEGER:
-		if (put_user(data->value.integer.min, &data32->value.integer.min) ||
-		    put_user(data->value.integer.max, &data32->value.integer.max) ||
-		    put_user(data->value.integer.step, &data32->value.integer.step))
-			goto error;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
-		if (copy_to_user(&data32->value.integer64,
-				 &data->value.integer64,
-				 sizeof(data->value.integer64)))
-			goto error;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
-		if (copy_to_user(&data32->value.enumerated,
-				 &data->value.enumerated,
-				 sizeof(data->value.enumerated)))
-			goto error;
-		break;
-	default:
-		break;
-	}
-	err = 0;
- error:
-	kfree(data);
-	return err;
-}
-
 /* read / write */
 struct snd_ctl_elem_value32 {
 	struct snd_ctl_elem_id id;
@@ -771,10 +711,19 @@ static int ctl_compat_ioctl_elem_list_32(struct snd_ctl_file *ctl_file,
 	return snd_ctl_elem_list(ctl_file, list);
 }
 
+static int ctl_compat_ioctl_elem_info_32(struct snd_ctl_file *ctl_file,
+					 void *buf)
+{
+	struct snd_ctl_elem_info *info = buf;
+
+	return snd_ctl_elem_info(ctl_file, info);
+}
+
 enum {
 	SNDRV_CTL_IOCTL_ELEM_LIST_32 =
 				_IOWR('U', 0x10, struct snd_ctl_elem_list_32),
-	SNDRV_CTL_IOCTL_ELEM_INFO32 = _IOWR('U', 0x11, struct snd_ctl_elem_info32),
+	SNDRV_CTL_IOCTL_ELEM_INFO_32 =
+				_IOWR('U', 0x11, struct snd_ctl_elem_info_32),
 	SNDRV_CTL_IOCTL_ELEM_READ32 = _IOWR('U', 0x12, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_ADD32 = _IOWR('U', 0x17, struct snd_ctl_elem_info32),
@@ -804,6 +753,13 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 			serialize_to_elem_list_32,
 			SNDRV_CTL_IOCTL_ELEM_LIST,
 		},
+		{
+			SNDRV_CTL_IOCTL_ELEM_INFO_32,
+			deserialize_from_elem_info_32,
+			ctl_compat_ioctl_elem_info_32,
+			serialize_to_elem_info_32,
+			SNDRV_CTL_IOCTL_ELEM_INFO,
+		},
 	};
 	struct snd_ctl_file *ctl;
 	void __user *argp = compat_ptr(arg);
@@ -817,8 +773,6 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		return -ENXIO;
 
 	switch (cmd) {
-	case SNDRV_CTL_IOCTL_ELEM_INFO32:
-		return snd_ctl_elem_info_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ32:
 		return snd_ctl_elem_read_user_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE32:
-- 
2.14.1
