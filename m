From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ctl: fix to handle several elements added by
	one operation for userspace element
Date: Sun, 12 Apr 2015 10:12:25 +0900
Message-ID: <1428801145-5203-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C5318260464
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 03:12:33 +0200 (CEST)
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

An element instance can have several elements with the same feature.
Some userspace applications can add such an element instance by add
operation with the number of elements. Then, the element instance
gets a memory object to keep states of these elements.

But the element instance has just one memory object for the elements.
This causes the same result to each read/write operations to the
different elements.

This commit fixes this bug by allocating enough memory objects to the
element instance for each of elements.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index ccb1ca2..5b2c352 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1029,7 +1029,7 @@ static int snd_ctl_elem_unlock(struct snd_ctl_file *file,
 struct user_element {
 	struct snd_ctl_elem_info info;
 	struct snd_card *card;
-	void *elem_data;		/* element data */
+	char *elem_data;		/* element data */
 	unsigned long elem_data_size;	/* size of element data in bytes */
 	void *tlv_data;			/* TLV data */
 	unsigned long tlv_data_size;	/* TLV data size */
@@ -1078,9 +1078,12 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct user_element *ue = kcontrol->private_data;
+	unsigned int size = ue->elem_data_size;
+	char *src = ue->elem_data +
+			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
 
 	mutex_lock(&ue->card->user_ctl_lock);
-	memcpy(&ucontrol->value, ue->elem_data, ue->elem_data_size);
+	memcpy(&ucontrol->value, src, size);
 	mutex_unlock(&ue->card->user_ctl_lock);
 	return 0;
 }
@@ -1090,11 +1093,14 @@ static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 {
 	int change;
 	struct user_element *ue = kcontrol->private_data;
+	unsigned int size = ue->elem_data_size;
+	char *dst = ue->elem_data +
+			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
 
 	mutex_lock(&ue->card->user_ctl_lock);
-	change = memcmp(&ucontrol->value, ue->elem_data, ue->elem_data_size) != 0;
+	change = memcmp(&ucontrol->value, dst, size) != 0;
 	if (change)
-		memcpy(ue->elem_data, &ucontrol->value, ue->elem_data_size);
+		memcpy(dst, &ucontrol->value, size);
 	mutex_unlock(&ue->card->user_ctl_lock);
 	return change;
 }
@@ -1278,7 +1284,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	if (err < 0)
 		return err;
 	memcpy(&kctl->id, &info->id, sizeof(kctl->id));
-	kctl->private_data = kzalloc(sizeof(struct user_element) + private_size,
+	kctl->private_data = kzalloc(sizeof(struct user_element) + private_size * count,
 				     GFP_KERNEL);
 	if (kctl->private_data == NULL) {
 		kfree(kctl);
-- 
2.1.0
