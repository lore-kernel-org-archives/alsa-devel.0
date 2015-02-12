From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 5/8] ALSA: control: rename loop index to i
Date: Thu, 12 Feb 2015 21:50:27 +0900
Message-ID: <54DCA193.9050808@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>	<1423651052-19593-6-git-send-email-o-takashi@sakamocchi.jp>
 <s5h61b8psqi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C98002604E3
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 13:50:28 +0100 (CET)
In-Reply-To: <s5h61b8psqi.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Feb 11 2015 20:55, Takashi Iwai wrote:
> At Wed, 11 Feb 2015 19:37:29 +0900,
> Takashi Sakamoto wrote:
>>
>> This is a fashion and subtle issue, but can reduce characters in a file.
> 
> Sorry, I see no merit by this action.  The idx is even clearer than
> using i for these purposes.  And, if it's i, people expect it being
> int, not unsigned.

OK. I drop this patch.

Thanks

Takashi Sakamoto

>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  sound/core/control.c | 44 ++++++++++++++++++++++----------------------
>>  1 file changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/sound/core/control.c b/sound/core/control.c
>> index 19f9f4e..15af804 100644
>> --- a/sound/core/control.c
>> +++ b/sound/core/control.c
>> @@ -119,7 +119,7 @@ static int snd_ctl_release(struct inode *inode, struct file *file)
>>  	struct snd_card *card;
>>  	struct snd_ctl_file *ctl;
>>  	struct snd_kcontrol *control;
>> -	unsigned int idx;
>> +	unsigned int i;
>>  
>>  	ctl = file->private_data;
>>  	file->private_data = NULL;
>> @@ -129,9 +129,9 @@ static int snd_ctl_release(struct inode *inode, struct file *file)
>>  	write_unlock_irqrestore(&card->ctl_files_rwlock, flags);
>>  	down_write(&card->controls_rwsem);
>>  	list_for_each_entry(control, &card->controls, list)
>> -		for (idx = 0; idx < control->count; idx++)
>> -			if (control->vd[idx].owner == ctl)
>> -				control->vd[idx].owner = NULL;
>> +		for (i = 0; i < control->count; i++)
>> +			if (control->vd[i].owner == ctl)
>> +				control->vd[i].owner = NULL;
>>  	up_write(&card->controls_rwsem);
>>  	snd_ctl_empty_read_queue(ctl);
>>  	put_pid(ctl->pid);
>> @@ -205,7 +205,7 @@ static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
>>  					unsigned int access)
>>  {
>>  	struct snd_kcontrol *kctl;
>> -	unsigned int idx;
>> +	unsigned int i;
>>  	
>>  	if (snd_BUG_ON(!control || !control->count))
>>  		return NULL;
>> @@ -219,8 +219,8 @@ static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
>>  		return NULL;
>>  	}
>>  	*kctl = *control;
>> -	for (idx = 0; idx < kctl->count; idx++)
>> -		kctl->vd[idx].access = access;
>> +	for (i = 0; i < kctl->count; i++)
>> +		kctl->vd[i].access = access;
>>  	return kctl;
>>  }
>>  
>> @@ -340,7 +340,7 @@ static int snd_ctl_find_hole(struct snd_card *card, unsigned int count)
>>  int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
>>  {
>>  	struct snd_ctl_elem_id id;
>> -	unsigned int idx;
>> +	unsigned int i;
>>  	unsigned int count;
>>  	int err = -EINVAL;
>>  
>> @@ -376,7 +376,7 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
>>  	id = kcontrol->id;
>>  	count = kcontrol->count;
>>  	up_write(&card->controls_rwsem);
>> -	for (idx = 0; idx < count; idx++, id.index++, id.numid++)
>> +	for (i = 0; i < count; i++, id.index++, id.numid++)
>>  		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
>>  	return 0;
>>  
>> @@ -405,7 +405,7 @@ int snd_ctl_replace(struct snd_card *card, struct snd_kcontrol *kcontrol,
>>  {
>>  	struct snd_ctl_elem_id id;
>>  	unsigned int count;
>> -	unsigned int idx;
>> +	unsigned int i;
>>  	struct snd_kcontrol *old;
>>  	int ret;
>>  
>> @@ -443,7 +443,7 @@ add:
>>  	id = kcontrol->id;
>>  	count = kcontrol->count;
>>  	up_write(&card->controls_rwsem);
>> -	for (idx = 0; idx < count; idx++, id.index++, id.numid++)
>> +	for (i = 0; i < count; i++, id.index++, id.numid++)
>>  		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
>>  	return 0;
>>  
>> @@ -467,14 +467,14 @@ EXPORT_SYMBOL(snd_ctl_replace);
>>  int snd_ctl_remove(struct snd_card *card, struct snd_kcontrol *kcontrol)
>>  {
>>  	struct snd_ctl_elem_id id;
>> -	unsigned int idx;
>> +	unsigned int i;
>>  
>>  	if (snd_BUG_ON(!card || !kcontrol))
>>  		return -EINVAL;
>>  	list_del(&kcontrol->list);
>>  	card->controls_count -= kcontrol->count;
>>  	id = kcontrol->id;
>> -	for (idx = 0; idx < kcontrol->count; idx++, id.index++, id.numid++)
>> +	for (i = 0; i < kcontrol->count; i++, id.index++, id.numid++)
>>  		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_REMOVE, &id);
>>  	snd_ctl_free_one(kcontrol);
>>  	return 0;
>> @@ -523,7 +523,7 @@ static int snd_ctl_remove_user_ctl(struct snd_ctl_file * file,
>>  {
>>  	struct snd_card *card = file->card;
>>  	struct snd_kcontrol *kctl;
>> -	int idx, ret;
>> +	int i, ret;
>>  
>>  	down_write(&card->controls_rwsem);
>>  	kctl = snd_ctl_find_id(card, id);
>> @@ -535,8 +535,8 @@ static int snd_ctl_remove_user_ctl(struct snd_ctl_file * file,
>>  		ret = -EINVAL;
>>  		goto error;
>>  	}
>> -	for (idx = 0; idx < kctl->count; idx++)
>> -		if (kctl->vd[idx].owner != NULL && kctl->vd[idx].owner != file) {
>> +	for (i = 0; i < kctl->count; i++)
>> +		if (kctl->vd[i].owner != NULL && kctl->vd[i].owner != file) {
>>  			ret = -EBUSY;
>>  			goto error;
>>  		}
>> @@ -725,7 +725,7 @@ static int snd_ctl_elem_list(struct snd_card *card,
>>  	struct snd_ctl_elem_list list;
>>  	struct snd_kcontrol *kctl;
>>  	struct snd_ctl_elem_id *dst, *id;
>> -	unsigned int offset, space, jidx;
>> +	unsigned int offset, space, i;
>>  	
>>  	if (copy_from_user(&list, _list, sizeof(list)))
>>  		return -EFAULT;
>> @@ -755,8 +755,8 @@ static int snd_ctl_elem_list(struct snd_card *card,
>>  		id = dst;
>>  		while (space > 0 && plist != &card->controls) {
>>  			kctl = snd_kcontrol(plist);
>> -			for (jidx = offset; space > 0 && jidx < kctl->count; jidx++) {
>> -				snd_ctl_build_ioff(id, kctl, jidx);
>> +			for (i = offset; space > 0 && i < kctl->count; i++) {
>> +				snd_ctl_build_ioff(id, kctl, i);
>>  				id++;
>>  				space--;
>>  				list.used++;
>> @@ -1183,7 +1183,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>>  	unsigned int access;
>>  	unsigned int elem_data_size;
>>  	struct user_element *ue;
>> -	int idx, err;
>> +	int i, err;
>>  
>>  	if (info->count < 1)
>>  		return -EINVAL;
>> @@ -1257,8 +1257,8 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>>  	_kctl->private_data = ue;
>>  
>>  	/* Lock values in this user controls. */
>> -	for (idx = 0; idx < _kctl->count; idx++)
>> -		_kctl->vd[idx].owner = file;
>> +	for (i = 0; i < _kctl->count; i++)
>> +		_kctl->vd[i].owner = file;
>>  
>>  	err = snd_ctl_add(card, _kctl);
>>  	if (err < 0)
>> -- 
>> 2.1.0
