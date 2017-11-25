From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 24/24] ALSA: ctl: code cleanup for compat
	handler
Date: Sat, 25 Nov 2017 18:20:06 +0900
Message-ID: <20171125092006.24408-25-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8C6B02674DC
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

This commit applies some changes for naming consistency. Additionally,
a series of author's work results to replace most of the codes. To
facilitate searching by developers, this commit adds author's signature.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index bbda8eabf18f..ab2ba7994a60 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -2,6 +2,7 @@
  * compat ioctls for control API
  *
  *   Copyright (c) by Takashi Iwai <tiwai@suse.de>
+ *   Copyright (c) 2017 Takashi Sakamoto
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -537,14 +538,14 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		},
 #endif
 	};
-	struct snd_ctl_file *ctl;
+	struct snd_ctl_file *ctl_file;
 	void *buf, *data;
 	unsigned int size;
 	int i;
 	int err;
 
-	ctl = file->private_data;
-	if (snd_BUG_ON(!ctl || !ctl->card))
+	ctl_file = file->private_data;
+	if (snd_BUG_ON(!ctl_file || !ctl_file->card))
 		return -ENXIO;
 
 	for (i = 0; i < ARRAY_SIZE(handlers); ++i) {
@@ -557,7 +558,8 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		down_read(&snd_ioctl_rwsem);
 		list_for_each_entry(p, &snd_control_compat_ioctls, list) {
 			if (p->fioctl) {
-				err = p->fioctl(ctl->card, ctl, cmd, arg);
+				err = p->fioctl(ctl_file->card, ctl_file, cmd,
+						arg);
 				if (err != -ENOIOCTLCMD) {
 					up_read(&snd_ioctl_rwsem);
 					return err;
@@ -589,15 +591,15 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		}
 	}
 
-	err = handlers[i].deserialize(ctl, buf, data);
+	err = handlers[i].deserialize(ctl_file, buf, data);
 	if (err < 0)
 		goto end;
 
-	err = handlers[i].func(ctl, buf);
+	err = handlers[i].func(ctl_file, buf);
 	if (err < 0)
 		goto end;
 
-	err = handlers[i].serialize(ctl, data, buf);
+	err = handlers[i].serialize(ctl_file, data, buf);
 	if (err >= 0) {
 		if (handlers[i].cmd & IOC_OUT) {
 			if (copy_to_user(compat_ptr(arg), data, size))
@@ -609,7 +611,7 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		if (cmd == SNDRV_CTL_IOCTL_ELEM_ADD_32 ||
 		    cmd == SNDRV_CTL_IOCTL_ELEM_REPLACE_32) {
 			struct snd_ctl_elem_info *info = buf;
-			snd_ctl_remove_user_ctl(ctl, &info->id);
+			snd_ctl_remove_user_ctl(ctl_file, &info->id);
 		}
 	}
 end:
-- 
2.14.1
