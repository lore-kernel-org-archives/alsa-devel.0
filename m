From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/24] ALSA: ctl: replacement for compat
	ELEM_LIST operation for any 32 bit ABI
Date: Sat, 25 Nov 2017 18:20:00 +0900
Message-ID: <20171125092006.24408-19-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8924F266F6B
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

This commit obsoletes old implementation for compat ELEM_LIST operation
with a renewal way.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 59 +++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 1cfacea867b6..427158b39f5a 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -397,44 +397,6 @@ static int __maybe_unused serialize_to_elem_value_i386(
 	return 0;
 }
 
-struct snd_ctl_elem_list32 {
-	u32 offset;
-	u32 space;
-	u32 used;
-	u32 count;
-	u32 pids;
-	unsigned char reserved[50];
-} /* don't set packed attribute here */;
-
-static int snd_ctl_elem_list_compat(struct snd_ctl_file *ctl_file,
-				    struct snd_ctl_elem_list32 __user *data32)
-{
-	struct snd_ctl_elem_list *list;
-	compat_uptr_t uptr;
-	int err;
-
-	list = kzalloc(sizeof(*list), GFP_KERNEL);
-	if (!list)
-		return -EFAULT;
-
-	if (copy_from_user(list, data32, 4 * sizeof(u32)) ||
-	    get_user(uptr, &data32->pids)) {
-		err = -EFAULT;
-		goto end;
-	}
-	list->pids = compat_ptr(uptr);
-
-	err = snd_ctl_elem_list(ctl_file, list);
-	if (err < 0)
-		goto end;
-
-	if (copy_to_user(data32, list, 4 * sizeof(u32)))
-		err = -EFAULT;
-end:
-	kfree(list);
-	return err;
-}
-
 /*
  * control element info
  * it uses union, so the things are not easy..
@@ -801,8 +763,17 @@ static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
 	return err;
 }  
 
+static int ctl_compat_ioctl_elem_list_32(struct snd_ctl_file *ctl_file,
+					 void *buf)
+{
+	struct snd_ctl_elem_list *list = buf;
+
+	return snd_ctl_elem_list(ctl_file, list);
+}
+
 enum {
-	SNDRV_CTL_IOCTL_ELEM_LIST32 = _IOWR('U', 0x10, struct snd_ctl_elem_list32),
+	SNDRV_CTL_IOCTL_ELEM_LIST_32 =
+				_IOWR('U', 0x10, struct snd_ctl_elem_list_32),
 	SNDRV_CTL_IOCTL_ELEM_INFO32 = _IOWR('U', 0x11, struct snd_ctl_elem_info32),
 	SNDRV_CTL_IOCTL_ELEM_READ32 = _IOWR('U', 0x12, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
@@ -826,7 +797,13 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 				 void *src);
 		unsigned int orig_cmd;
 	} handlers[] = {
-		{ 0, NULL, NULL, NULL, 0, },
+		{
+			SNDRV_CTL_IOCTL_ELEM_LIST_32,
+			deserialize_from_elem_list_32,
+			ctl_compat_ioctl_elem_list_32,
+			serialize_to_elem_list_32,
+			SNDRV_CTL_IOCTL_ELEM_LIST,
+		},
 	};
 	struct snd_ctl_file *ctl;
 	void __user *argp = compat_ptr(arg);
@@ -840,8 +817,6 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		return -ENXIO;
 
 	switch (cmd) {
-	case SNDRV_CTL_IOCTL_ELEM_LIST32:
-		return snd_ctl_elem_list_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO32:
 		return snd_ctl_elem_info_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ32:
-- 
2.14.1
