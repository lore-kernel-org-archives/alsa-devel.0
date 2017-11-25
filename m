From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 20/24] ALSA: ctl: replacement for compat
	ELEM_ADD operation for any 32 bit ABI
Date: Sat, 25 Nov 2017 18:20:02 +0900
Message-ID: <20171125092006.24408-21-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EE77E267454
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

This commit obsoletes old implementation for compat ELEM_ADD operation
with a renewal way.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 499cc459917f..8e2617c6217e 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -719,6 +719,14 @@ static int ctl_compat_ioctl_elem_info_32(struct snd_ctl_file *ctl_file,
 	return snd_ctl_elem_info(ctl_file, info);
 }
 
+static int ctl_compat_ioctl_elem_add_32(struct snd_ctl_file *ctl_file,
+					void *buf)
+{
+	struct snd_ctl_elem_info *info = buf;
+
+	return snd_ctl_elem_add(ctl_file, info);
+}
+
 enum {
 	SNDRV_CTL_IOCTL_ELEM_LIST_32 =
 				_IOWR('U', 0x10, struct snd_ctl_elem_list_32),
@@ -726,7 +734,8 @@ enum {
 				_IOWR('U', 0x11, struct snd_ctl_elem_info_32),
 	SNDRV_CTL_IOCTL_ELEM_READ32 = _IOWR('U', 0x12, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
-	SNDRV_CTL_IOCTL_ELEM_ADD32 = _IOWR('U', 0x17, struct snd_ctl_elem_info32),
+	SNDRV_CTL_IOCTL_ELEM_ADD_32 =
+				_IOWR('U', 0x17, struct snd_ctl_elem_info_32),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE32 = _IOWR('U', 0x18, struct snd_ctl_elem_info32),
 #ifdef CONFIG_X86_X32
 	SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
@@ -760,6 +769,13 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 			serialize_to_elem_info_32,
 			SNDRV_CTL_IOCTL_ELEM_INFO,
 		},
+		{
+			SNDRV_CTL_IOCTL_ELEM_ADD_32,
+			deserialize_from_elem_info_32,
+			ctl_compat_ioctl_elem_add_32,
+			serialize_to_elem_info_32,
+			SNDRV_CTL_IOCTL_ELEM_ADD,
+		},
 	};
 	struct snd_ctl_file *ctl;
 	void __user *argp = compat_ptr(arg);
@@ -777,8 +793,6 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		return snd_ctl_elem_read_user_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE32:
 		return snd_ctl_elem_write_user_compat(ctl, argp);
-	case SNDRV_CTL_IOCTL_ELEM_ADD32:
-		return snd_ctl_elem_add_compat(ctl, argp, 0);
 	case SNDRV_CTL_IOCTL_ELEM_REPLACE32:
 		return snd_ctl_elem_add_compat(ctl, argp, 1);
 #ifdef CONFIG_X86_X32
@@ -846,6 +860,13 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 				err = -EFAULT;
 		}
 	}
+
+	if (err < 0) {
+		if (cmd == SNDRV_CTL_IOCTL_ELEM_ADD_32) {
+			struct snd_ctl_elem_info *info = buf;
+			snd_ctl_remove_user_ctl(ctl, &info->id);
+		}
+	}
 end:
 	kfree(data);
 	kfree(buf);
-- 
2.14.1
