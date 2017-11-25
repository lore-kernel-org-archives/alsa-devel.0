From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/24] ALSA: ctl: add a helper function to
	allocate for ELEM_LIST request
Date: Sat, 25 Nov 2017 18:19:49 +0900
Message-ID: <20171125092006.24408-8-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E9BC8266F78
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:15 +0100 (CET)
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

When investigating compatibility layer, several functions for native ABI
are called by the layer. A 'snd_ctl_elem_list()' is such a function,
while it cannot receive a second argument for data on kernel space. This
will bring a future inconvenience in integration of the layer.

This commit adds a helper function to allocate memory object on kernel
space for the argument.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c        | 41 ++++++++++++++++++++++++++++-------------
 sound/core/control_compat.c |  2 +-
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 8baee922a400..ad4d27c681c4 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -745,22 +745,19 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
 }
 
 static int snd_ctl_elem_list(struct snd_ctl_file *ctl_file,
-			     struct snd_ctl_elem_list __user *_list)
+			     struct snd_ctl_elem_list *list)
 {
-	struct snd_ctl_elem_list list;
 	struct snd_kcontrol *kctl;
 	struct snd_ctl_elem_id id;
 	unsigned int offset, space, jidx;
 	int err = 0;
 	
-	if (copy_from_user(&list, _list, sizeof(list)))
-		return -EFAULT;
-	offset = list.offset;
-	space = list.space;
+	offset = list->offset;
+	space = list->space;
 
 	down_read(&ctl_file->card->controls_rwsem);
-	list.count = ctl_file->card->controls_count;
-	list.used = 0;
+	list->count = ctl_file->card->controls_count;
+	list->used = 0;
 	if (space > 0) {
 		list_for_each_entry(kctl, &ctl_file->card->controls, list) {
 			if (offset >= kctl->count) {
@@ -769,12 +766,12 @@ static int snd_ctl_elem_list(struct snd_ctl_file *ctl_file,
 			}
 			for (jidx = offset; jidx < kctl->count; jidx++) {
 				snd_ctl_build_ioff(&id, kctl, jidx);
-				if (copy_to_user(list.pids + list.used, &id,
+				if (copy_to_user(list->pids + list->used, &id,
 						 sizeof(id))) {
 					err = -EFAULT;
 					goto out;
 				}
-				list.used++;
+				list->used++;
 				if (!--space)
 					goto out;
 			}
@@ -783,8 +780,26 @@ static int snd_ctl_elem_list(struct snd_ctl_file *ctl_file,
 	}
  out:
 	up_read(&ctl_file->card->controls_rwsem);
-	if (!err && copy_to_user(_list, &list, sizeof(list)))
-		err = -EFAULT;
+	return err;
+}
+
+static int snd_ctl_elem_list_user(struct snd_ctl_file *ctl_file,
+				  void __user *arg)
+{
+	struct snd_ctl_elem_list *list;
+	int err;
+
+	list = memdup_user(arg, sizeof(*list));
+	if (IS_ERR(list))
+		return PTR_ERR(list);
+
+	err = snd_ctl_elem_list(ctl_file, list);
+	if (err >= 0) {
+		if (copy_to_user(arg, list, sizeof(*list)))
+			err = -EFAULT;
+	}
+
+	kfree(list);
 	return err;
 }
 
@@ -1552,7 +1567,7 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_CARD_INFO:
 		return snd_ctl_card_info(card, ctl, cmd, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST:
-		return snd_ctl_elem_list(ctl, argp);
+		return snd_ctl_elem_list_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
 		return snd_ctl_elem_info_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ:
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 3594bd41750e..8a4c58c0cf3b 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -422,7 +422,7 @@ static int snd_ctl_elem_list_compat(struct snd_ctl_file *ctl_file,
 	if (get_user(ptr, &data32->pids) ||
 	    put_user(compat_ptr(ptr), &data->pids))
 		return -EFAULT;
-	err = snd_ctl_elem_list(ctl_file, data);
+	err = snd_ctl_elem_list_user(ctl_file, data);
 	if (err < 0)
 		return err;
 	/* copy the result */
-- 
2.14.1
