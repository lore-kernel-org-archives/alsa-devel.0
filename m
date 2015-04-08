From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: ctl: fix to handle several elements
	added by
Date: Thu,  9 Apr 2015 02:07:18 +0900
Message-ID: <1428512838-2493-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A9F62654C6
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 19:07:22 +0200 (CEST)
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

An element instance can have several elements with the same feature.
Some userspace applications can add such an element instance by add
operation with the number of elements. Then, an userspace element
instance keeps a memory object to keep state of these elements.

But the element instance has just one memory object for the elements.
This forces each read/write operations to the different elements
brings the same result.

This commit fixes this bug by allocating enough memory objects to element
instance for each of elements.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index b0b110a..2ab7ee5 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1074,9 +1074,14 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct user_element *ue = kcontrol->private_data;
+	char *data = ue->elem_data;
+	unsigned int size = ue->elem_data_size;
+	unsigned int offset;
+
+	offset = (ucontrol->id.numid - kcontrol->id.numid) * size;
 
 	mutex_lock(&ue->card->user_ctl_lock);
-	memcpy(&ucontrol->value, ue->elem_data, ue->elem_data_size);
+	memcpy(&ucontrol->value, data + offset, size);
 	mutex_unlock(&ue->card->user_ctl_lock);
 	return 0;
 }
@@ -1084,13 +1089,18 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
 static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	int change;
 	struct user_element *ue = kcontrol->private_data;
+	char *data = ue->elem_data;
+	unsigned int size = ue->elem_data_size;
+	unsigned int offset;
+	int change;
+
+	offset = (ucontrol->id.numid - kcontrol->id.numid) * size;
 
 	mutex_lock(&ue->card->user_ctl_lock);
-	change = memcmp(&ucontrol->value, ue->elem_data, ue->elem_data_size) != 0;
+	change = memcmp(&ucontrol->value, data + offset, size) != 0;
 	if (change)
-		memcpy(ue->elem_data, &ucontrol->value, ue->elem_data_size);
+		memcpy(data + offset, &ucontrol->value, size);
 	mutex_unlock(&ue->card->user_ctl_lock);
 	return change;
 }
@@ -1273,7 +1283,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
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
