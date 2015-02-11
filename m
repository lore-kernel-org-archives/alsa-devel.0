From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: control: save stack usage at
	creating new instance
Date: Wed, 11 Feb 2015 19:40:13 +0900
Message-ID: <1423651213-19829-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B2E264FF0
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:40:23 +0100 (CET)
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

When creating a new instance of control, both of userspace or kernel driver
uses stack for a instance of kernel control structure with parameters, then
keep memory object and copy the instance. This way is a waste of stack.

This commit change to keep memory object at first, then copy the parameters
to the object. These items are applied:
 * change prototype of ctl_new() with new parameters
 * call ctl_new() at first and get memory objects
 * then set identical info and callback by callers's side

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 198 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 107 insertions(+), 91 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 9944d75..e7fabbb 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -193,30 +193,35 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 }
 EXPORT_SYMBOL(snd_ctl_notify);
 
-static struct snd_kcontrol *ctl_new(struct snd_kcontrol *control,
-				    unsigned int access)
+static int ctl_new(struct snd_kcontrol **kctl, unsigned int count,
+		   unsigned int access, unsigned int private_size)
 {
-	struct snd_kcontrol *kctl;
 	unsigned int size;
 	unsigned int i;
 	
-	if (snd_BUG_ON(!control || !control->count))
-		return NULL;
+	if (count == 0 || count > MAX_VALUES_COUNT)
+		return -EINVAL;
 
-	if (control->count > MAX_VALUES_COUNT)
-		return NULL;
+	size  = sizeof(struct snd_kcontrol);
+	size += sizeof(struct snd_kcontrol_volatile) * count;
 
-	size  = sizeof(*kctl);
-	size += sizeof(struct snd_kcontrol_volatile) * control->count;
-	kctl = kzalloc(size, GFP_KERNEL);
-	if (kctl == NULL) {
-		pr_err("ALSA: Cannot allocate control instance\n");
-		return NULL;
+	*kctl = kzalloc(size, GFP_KERNEL);
+	if (*kctl == NULL)
+		return -ENOMEM;
+
+	if (private_size > 0) {
+		(*kctl)->private_data = kzalloc(private_size, GFP_KERNEL);
+		if ((*kctl)->private_data == NULL) {
+			kfree(*kctl);
+			return -ENOMEM;
+		}
 	}
-	*kctl = *control;
-	for (i = 0; i < kctl->count; i++)
-		kctl->vd[i].access = access;
-	return kctl;
+
+	for (i = 0; i < count; i++)
+		(*kctl)->vd[i].access = access;
+	(*kctl)->count = count;
+
+	return 0;
 }
 
 /**
@@ -233,37 +238,52 @@ static struct snd_kcontrol *ctl_new(struct snd_kcontrol *control,
 struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 				  void *private_data)
 {
-	struct snd_kcontrol kctl;
+	struct snd_kcontrol *kctl;
+	unsigned int count;
 	unsigned int access;
 	
 	if (snd_BUG_ON(!ncontrol || !ncontrol->info))
 		return NULL;
-	memset(&kctl, 0, sizeof(kctl));
-	kctl.id.iface = ncontrol->iface;
-	kctl.id.device = ncontrol->device;
-	kctl.id.subdevice = ncontrol->subdevice;
+
+	count = ncontrol->count;
+	if (count == 0)
+		count = 1;
+
+	access = ncontrol->access;
+	if (access == 0)
+		access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	access &= SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		  SNDRV_CTL_ELEM_ACCESS_VOLATILE |
+		  SNDRV_CTL_ELEM_ACCESS_INACTIVE |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+
+	if (ctl_new(&kctl, count, access, 0) < 0) {
+		pr_err("ALSA: Cannot allocate control instance\n");
+		return NULL;
+	}
+
+	kctl->id.iface = ncontrol->iface;
+	kctl->id.device = ncontrol->device;
+	kctl->id.subdevice = ncontrol->subdevice;
+	kctl->id.index = ncontrol->index;
 	if (ncontrol->name) {
-		strlcpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name));
-		if (strcmp(ncontrol->name, kctl.id.name) != 0)
+		strlcpy(kctl->id.name, ncontrol->name, sizeof(kctl->id.name));
+		if (strcmp(ncontrol->name, kctl->id.name) != 0)
 			pr_warn("ALSA: Control name '%s' truncated to '%s'\n",
-				ncontrol->name, kctl.id.name);
+				ncontrol->name, kctl->id.name);
 	}
-	kctl.id.index = ncontrol->index;
-	kctl.count = ncontrol->count ? ncontrol->count : 1;
-	access = ncontrol->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
-		 (ncontrol->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
-				      SNDRV_CTL_ELEM_ACCESS_VOLATILE|
-				      SNDRV_CTL_ELEM_ACCESS_INACTIVE|
-				      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE|
-				      SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND|
-				      SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK));
-	kctl.info = ncontrol->info;
-	kctl.get = ncontrol->get;
-	kctl.put = ncontrol->put;
-	kctl.tlv.p = ncontrol->tlv.p;
-	kctl.private_value = ncontrol->private_value;
-	kctl.private_data = private_data;
-	return ctl_new(&kctl, access);
+
+	kctl->info = ncontrol->info;
+	kctl->get = ncontrol->get;
+	kctl->put = ncontrol->put;
+	kctl->tlv.p = ncontrol->tlv.p;
+
+	kctl->private_value = ncontrol->private_value;
+	kctl->private_data = private_data;
+
+	return kctl;
 }
 EXPORT_SYMBOL(snd_ctl_new1);
 
@@ -1175,14 +1195,29 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		[SNDRV_CTL_ELEM_TYPE_INTEGER64] = 64,
 	};
 	struct snd_card *card = file->card;
-	struct snd_kcontrol kctl, *_kctl;
+	struct snd_kcontrol *kctl;
+	unsigned int count;
 	unsigned int access;
 	unsigned int elem_data_size;
 	struct user_element *ue;
 	int i, err;
 
-	if (info->count < 1)
+	if (info->type < SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
+	    info->type > SNDRV_CTL_ELEM_TYPE_INTEGER64)
+		return -EINVAL;
+	if (info->count < 1 || info->count > max_value_counts[info->type])
 		return -EINVAL;
+	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED &&
+	    info->value.enumerated.items == 0)
+		return -EINVAL;
+	elem_data_size = value_sizes[info->type] * info->count;
+
+	/*
+	 * The number of controls with the same feature, distinguished by index.
+	 */
+	count = info->owner;
+	if (count == 0)
+		count = 1;
 
 	access = info->access;
 	if (access == 0)
@@ -1194,48 +1229,36 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
 	access |= SNDRV_CTL_ELEM_ACCESS_USER;
 
-	memset(&kctl, 0, sizeof(kctl));
-	kctl.id = info->id;
-	kctl.id.numid = 0;
+	err = ctl_new(&kctl, count, access,
+		      sizeof(struct user_element) + elem_data_size);
+	if (err < 0)
+		return err;
+	kctl->private_free = snd_ctl_elem_user_free;
 
+	kctl->id = info->id;
 	if (replace) {
-		err = snd_ctl_remove_user_ctl(file, &kctl.id);
-		if (err)
-			return err;
+		err = snd_ctl_remove_user_ctl(file, &kctl->id);
+		if (err < 0)
+			goto error_allocated;
 	}
 
-	/*
-	 * The number of controls with the same feature, distinguished by index.
-	 */
-	kctl.count = info->owner;
-	if (kctl.count == 0)
-		kctl.count = 1;
-	if (card->user_ctl_count + kctl.count > MAX_USER_CONTROLS)
-		return -ENOSPC;
+	if (card->user_ctl_count + kctl->count > MAX_USER_CONTROLS) {
+		err = -ENOSPC;
+		goto error_allocated;
+	}
 
 	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED)
-		kctl.info = snd_ctl_elem_user_enum_info;
+		kctl->info = snd_ctl_elem_user_enum_info;
 	else
-		kctl.info = snd_ctl_elem_user_info;
+		kctl->info = snd_ctl_elem_user_info;
 	if (access & SNDRV_CTL_ELEM_ACCESS_READ)
-		kctl.get = snd_ctl_elem_user_get;
+		kctl->get = snd_ctl_elem_user_get;
 	if (access & SNDRV_CTL_ELEM_ACCESS_WRITE)
-		kctl.put = snd_ctl_elem_user_put;
+		kctl->put = snd_ctl_elem_user_put;
 	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE)
-		kctl.tlv.c = snd_ctl_elem_user_tlv;
+		kctl->tlv.c = snd_ctl_elem_user_tlv;
 
-	if (info->type < SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
-	    info->type > SNDRV_CTL_ELEM_TYPE_INTEGER64)
-		return -EINVAL;
-	if (info->count > max_value_counts[info->type])
-		return -EINVAL;
-	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED &&
-	    info->value.enumerated.items == 0)
-		return -EINVAL;
-	elem_data_size = value_sizes[info->type] * info->count;
-	ue = kzalloc(sizeof(struct user_element) + elem_data_size, GFP_KERNEL);
-	if (ue == NULL)
-		return -ENOMEM;
+	ue = (struct user_element *)kctl->private_data;
 	ue->card = card;
 	ue->info = *info;
 	ue->info.access = 0;
@@ -1243,33 +1266,26 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	ue->elem_data_size = elem_data_size;
 	if (ue->info.type == SNDRV_CTL_ELEM_TYPE_ENUMERATED) {
 		err = snd_ctl_elem_init_enum_names(ue);
-		if (err < 0) {
-			kfree(ue);
-			return err;
-		}
-	}
-	kctl.private_free = snd_ctl_elem_user_free;
-	_kctl = ctl_new(&kctl, access);
-	if (_kctl == NULL) {
-		kfree(ue->priv_data);
-		kfree(ue);
-		return -ENOMEM;
+		if (err < 0)
+			goto error_allocated;
 	}
-	_kctl->private_data = ue;
 
 	/* Lock values in this user controls. */
-	for (i = 0; i < _kctl->count; i++)
-		_kctl->vd[i].owner = file;
+	for (i = 0; i < kctl->count; i++)
+		kctl->vd[i].owner = file;
 
-	err = snd_ctl_add(card, _kctl);
+	err = snd_ctl_add(card, kctl);
 	if (err < 0)
-		return err;
+		return err;	/* already freed. */
 
 	down_write(&card->controls_rwsem);
-	card->user_ctl_count += _kctl->count;
+	card->user_ctl_count += kctl->count;
 	up_write(&card->controls_rwsem);
 
 	return 0;
+error_allocated:
+	snd_ctl_free_one(kctl);
+	return err;
 }
 
 static int snd_ctl_elem_add_user(struct snd_ctl_file *file,
-- 
2.1.0
