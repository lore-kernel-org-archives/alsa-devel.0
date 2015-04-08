From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: ctl: fill identical information to
	return value
Date: Thu,  9 Apr 2015 02:07:17 +0900
Message-ID: <1428512838-2493-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E8EEF265375
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 19:07:21 +0200 (CEST)
In-Reply-To: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

currently some members related identical information are not fiiled
in returned parameter of SNDRV_CTL_IOCTL_ELEM_ADD. This is not better
for userspace application.

This commit copies information to returned value.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 37203a6..b0b110a 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1312,6 +1312,13 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	err = snd_ctl_add(card, kctl);
 	if (err < 0)
 		return err;
+	info->id = kctl->id;
+	/*
+	 * We cannot fill any field for the number of elements added by this
+	 * operation because there're no specific fields. The usage of 'owner'
+	 * field for this purpose may cause any bugs to userspace applications
+	 * because the field originally means any applications lock it.
+	 */
 
 	down_write(&card->controls_rwsem);
 	card->user_ctl_count++;
@@ -1321,12 +1328,20 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 }
 
 static int snd_ctl_elem_add_user(struct snd_ctl_file *file,
-				 struct snd_ctl_elem_info __user *_info, int replace)
+				 struct snd_ctl_elem_info __user *_info,
+				 int replace)
 {
 	struct snd_ctl_elem_info info;
+	int err;
+
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
-	return snd_ctl_elem_add(file, &info, replace);
+	err = snd_ctl_elem_add(file, &info, replace);
+	if (err < 0)
+		return err;
+	if (copy_to_user(_info, &info, sizeof(info)))
+		return -EFAULT;
+	return 0;
 }
 
 static int snd_ctl_elem_remove(struct snd_ctl_file *file,
-- 
2.1.0
