From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: control: obsolete user_ctl_lock
Date: Thu,  3 Aug 2017 20:20:42 +0900
Message-ID: <20170803112044.17138-4-o-takashi@sakamocchi.jp>
References: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C1CCF267346
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 13:20:49 +0200 (CEST)
In-Reply-To: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
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

At a previous commit, concurrent requests for TLV data are maintained
exclusively between read requests and write/command requests. TLV
callback handlers in each driver has no risk from concurrent access for
reference/change.

In current implementation, 'struct snd_card' has a mutex to control
concurrent accesses to user-defined element sets. This commit obsoletes it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/core.h |  2 --
 sound/core/control.c | 37 +++++++++++++------------------------
 sound/core/init.c    |  1 -
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 55385588eefa..357f36b5ee80 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -118,8 +118,6 @@ struct snd_card {
 	int user_ctl_count;		/* count of all user controls */
 	struct list_head controls;	/* all controls for this card */
 	struct list_head ctl_files;	/* active control files */
-	struct mutex user_ctl_lock;	/* protects user controls against
-					   concurrent access */
 
 	struct snd_info_entry *proc_root;	/* root for soundcard specific files */
 	struct snd_info_entry *proc_id;	/* the card id */
diff --git a/sound/core/control.c b/sound/core/control.c
index 3648fff28138..c1795b42796e 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1095,9 +1095,7 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
 	char *src = ue->elem_data +
 			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
 
-	mutex_lock(&ue->card->user_ctl_lock);
 	memcpy(&ucontrol->value, src, size);
-	mutex_unlock(&ue->card->user_ctl_lock);
 	return 0;
 }
 
@@ -1110,11 +1108,9 @@ static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 	char *dst = ue->elem_data +
 			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
 
-	mutex_lock(&ue->card->user_ctl_lock);
 	change = memcmp(&ucontrol->value, dst, size) != 0;
 	if (change)
 		memcpy(dst, &ucontrol->value, size);
-	mutex_unlock(&ue->card->user_ctl_lock);
 	return change;
 }
 
@@ -1124,44 +1120,37 @@ static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
 				 unsigned int __user *tlv)
 {
 	struct user_element *ue = kcontrol->private_data;
-	int change = 0;
-	void *new_data;
 
 	if (op_flag == SNDRV_CTL_TLV_OP_WRITE) {
+		int change;
+		void *new_data;
+
 		if (size > 1024 * 128)	/* sane value */
 			return -EINVAL;
 
 		new_data = memdup_user(tlv, size);
 		if (IS_ERR(new_data))
 			return PTR_ERR(new_data);
-		mutex_lock(&ue->card->user_ctl_lock);
 		change = ue->tlv_data_size != size;
 		if (!change)
 			change = memcmp(ue->tlv_data, new_data, size);
 		kfree(ue->tlv_data);
 		ue->tlv_data = new_data;
 		ue->tlv_data_size = size;
-		mutex_unlock(&ue->card->user_ctl_lock);
+
+		return change;
 	} else {
-		int ret = 0;
+		if (!ue->tlv_data_size || !ue->tlv_data)
+			return -ENXIO;
+
+		if (size < ue->tlv_data_size)
+			return -ENOSPC;
 
-		mutex_lock(&ue->card->user_ctl_lock);
-		if (!ue->tlv_data_size || !ue->tlv_data) {
-			ret = -ENXIO;
-			goto err_unlock;
-		}
-		if (size < ue->tlv_data_size) {
-			ret = -ENOSPC;
-			goto err_unlock;
-		}
 		if (copy_to_user(tlv, ue->tlv_data, ue->tlv_data_size))
-			ret = -EFAULT;
-err_unlock:
-		mutex_unlock(&ue->card->user_ctl_lock);
-		if (ret)
-			return ret;
+			return -EFAULT;
+
+		return 0;
 	}
-	return change;
 }
 
 static int snd_ctl_elem_init_enum_names(struct user_element *ue)
diff --git a/sound/core/init.c b/sound/core/init.c
index 00f2cbb76e69..f1425f9af703 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -248,7 +248,6 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	INIT_LIST_HEAD(&card->devices);
 	init_rwsem(&card->controls_rwsem);
 	rwlock_init(&card->ctl_files_rwlock);
-	mutex_init(&card->user_ctl_lock);
 	INIT_LIST_HEAD(&card->controls);
 	INIT_LIST_HEAD(&card->ctl_files);
 	spin_lock_init(&card->files_lock);
-- 
2.11.0
