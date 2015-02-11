From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: control: fix logic error about
	control count in a device
Date: Wed, 11 Feb 2015 19:40:11 +0900
Message-ID: <1423651213-19829-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id D8728264FF9
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:40:21 +0100 (CET)
In-Reply-To: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
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

It's assumed that the number of userspace controls is just 1 in several
parts, while this assumptions is not always true because the value of
'owner' member can be assigned to.

This commit fixes this issue.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 1edd6c5..bce4730 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -514,6 +514,7 @@ static int snd_ctl_remove_user_ctl(struct snd_ctl_file * file,
 {
 	struct snd_card *card = file->card;
 	struct snd_kcontrol *kctl;
+	unsigned int count;
 	int i, ret;
 
 	down_write(&card->controls_rwsem);
@@ -531,10 +532,11 @@ static int snd_ctl_remove_user_ctl(struct snd_ctl_file * file,
 			ret = -EBUSY;
 			goto error;
 		}
+	count = kctl->count;
 	ret = snd_ctl_remove(card, kctl);
 	if (ret < 0)
 		goto error;
-	card->user_ctl_count--;
+	card->user_ctl_count -= count;
 error:
 	up_write(&card->controls_rwsem);
 	return ret;
@@ -1202,10 +1204,15 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 			return err;
 	}
 
-	if (card->user_ctl_count >= MAX_USER_CONTROLS)
-		return -ENOMEM;
+	/*
+	 * The number of controls with the same feature, distinguished by index.
+	 */
+	kctl.count = info->owner;
+	if (kctl.count == 0)
+		kctl.count = 1;
+	if (card->user_ctl_count + kctl.count > MAX_USER_CONTROLS)
+		return -ENOSPC;
 
-	kctl.count = info->owner ? info->owner : 1;
 	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED)
 		kctl.info = snd_ctl_elem_user_enum_info;
 	else
@@ -1259,7 +1266,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		return err;
 
 	down_write(&card->controls_rwsem);
-	card->user_ctl_count++;
+	card->user_ctl_count += _kctl->count;
 	up_write(&card->controls_rwsem);
 
 	return 0;
-- 
2.1.0
