From: The Source <thesourcehim@gmail.com>
Subject: Re: snd-ctxfi oops
Date: Sat, 13 Jun 2009 10:05:08 +0400
Message-ID: <4A334194.6030704@gmail.com>
References: <4A31D0F6.5080901@gmail.com> <s5hr5xpvry1.wl%tiwai@suse.de>
	<4A329D02.8070202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A43E245C6
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 08:05:13 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2558010bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2009 23:05:12 -0700 (PDT)
In-Reply-To: <4A329D02.8070202@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12.06.2009 22:22, The Source wrote:
> On 12.06.2009 11:20, Takashi Iwai wrote:
>> At Fri, 12 Jun 2009 07:52:22 +0400,
>> The Source wrote:
>>> Hello. I use snd-ctxfi from 8 June snapshot. I hadn't oopses since I
>>> installed this driver but recently I got one again:
>>>
>>> Kernel failure message 1:
>>> BUG: sleeping function called from invalid context at mm/slub.c:1599
>> Could you try the patch below?
>>
>>
>> thanks,
>>
>> Takashi
>>
>> ---
>> diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
>> index 80fb2ba..b0adc80 100644
>> --- a/sound/pci/ctxfi/ctatc.c
>> +++ b/sound/pci/ctxfi/ctatc.c
>> @@ -259,7 +259,6 @@ static int atc_pcm_playback_prepare(struct ct_atc 
>> *atc, struct ct_atc_pcm *apcm)
>>       int n_amixer = apcm->substream->runtime->channels, i = 0;
>>       int device = apcm->substream->pcm->device;
>>       unsigned int pitch;
>> -    unsigned long flags;
>>
>>       if (NULL != apcm->src) {
>>           /* Prepared pcm playback */
>> @@ -311,10 +310,10 @@ static int atc_pcm_playback_prepare(struct 
>> ct_atc *atc, struct ct_atc_pcm *apcm)
>>       src = apcm->src;
>>       for (i = 0; i<  n_amixer; i++) {
>>           amixer = apcm->amixers[i];
>> -        spin_lock_irqsave(&atc->atc_lock, flags);
>> +        mutex_lock(&atc->atc_mutex);
>>           amixer->ops->setup(amixer,&src->rsc,
>>                       INIT_VOL, atc->pcm[i+device*2]);
>> -        spin_unlock_irqrestore(&atc->atc_lock, flags);
>> +        mutex_unlock(&atc->atc_mutex);
>>           src = src->ops->next_interleave(src);
>>           if (NULL == src)
>>               src = apcm->src;
>> @@ -865,7 +864,6 @@ static int
>>   spdif_passthru_playback_setup(struct ct_atc *atc, struct ct_atc_pcm 
>> *apcm)
>>   {
>>       struct dao *dao = container_of(atc->daios[SPDIFOO], struct dao, 
>> daio);
>> -    unsigned long flags;
>>       unsigned int rate = apcm->substream->runtime->rate;
>>       unsigned int status;
>>       int err;
>> @@ -885,7 +883,7 @@ spdif_passthru_playback_setup(struct ct_atc *atc, 
>> struct ct_atc_pcm *apcm)
>>           return -ENOENT;
>>       }
>>
>> -    spin_lock_irqsave(&atc->atc_lock, flags);
>> +    mutex_lock(&atc->atc_mutex);
>>       dao->ops->get_spos(dao,&status);
>>       if (((status>>  24)&  IEC958_AES3_CON_FS) != iec958_con_fs) {
>>           status&= ((~IEC958_AES3_CON_FS)<<  24);
>> @@ -895,7 +893,7 @@ spdif_passthru_playback_setup(struct ct_atc *atc, 
>> struct ct_atc_pcm *apcm)
>>       }
>>       if ((rate != atc->pll_rate)&&  (32000 != rate))
>>           err = atc_pll_init(atc, rate);
>> -    spin_unlock_irqrestore(&atc->atc_lock, flags);
>> +    mutex_unlock(&atc->atc_mutex);
>>
>>       return err;
>>   }
>> @@ -908,7 +906,6 @@ spdif_passthru_playback_prepare(struct ct_atc 
>> *atc, struct ct_atc_pcm *apcm)
>>       struct dao *dao;
>>       int err;
>>       int i;
>> -    unsigned long flags;
>>
>>       if (NULL != apcm->src)
>>           return 0;
>> @@ -934,13 +931,13 @@ spdif_passthru_playback_prepare(struct ct_atc 
>> *atc, struct ct_atc_pcm *apcm)
>>               src = apcm->src;
>>       }
>>       /* Connect to SPDIFOO */
>> -    spin_lock_irqsave(&atc->atc_lock, flags);
>> +    mutex_lock(&atc->atc_mutex);
>>       dao = container_of(atc->daios[SPDIFOO], struct dao, daio);
>>       amixer = apcm->amixers[0];
>>       dao->ops->set_left_input(dao,&amixer->rsc);
>>       amixer = apcm->amixers[1];
>>       dao->ops->set_right_input(dao,&amixer->rsc);
>> -    spin_unlock_irqrestore(&atc->atc_lock, flags);
>> +    mutex_unlock(&atc->atc_mutex);
>>
>>       ct_timer_prepare(apcm->timer);
>>
>> @@ -1088,7 +1085,6 @@ static int atc_spdif_out_set_status(struct 
>> ct_atc *atc, unsigned int status)
>>
>>   static int atc_spdif_out_passthru(struct ct_atc *atc, unsigned char 
>> state)
>>   {
>> -    unsigned long flags;
>>       struct dao_desc da_dsc = {0};
>>       struct dao *dao;
>>       int err;
>> @@ -1096,7 +1092,7 @@ static int atc_spdif_out_passthru(struct ct_atc 
>> *atc, unsigned char state)
>>       struct rsc *rscs[2] = {NULL};
>>       unsigned int spos = 0;
>>
>> -    spin_lock_irqsave(&atc->atc_lock, flags);
>> +    mutex_lock(&atc->atc_mutex);
>>       dao = container_of(atc->daios[SPDIFOO], struct dao, daio);
>>       da_dsc.msr = state ? 1 : atc->msr;
>>       da_dsc.passthru = state ? 1 : 0;
>> @@ -1114,7 +1110,7 @@ static int atc_spdif_out_passthru(struct ct_atc 
>> *atc, unsigned char state)
>>       }
>>       dao->ops->set_spos(dao, spos);
>>       dao->ops->commit_write(dao);
>> -    spin_unlock_irqrestore(&atc->atc_lock, flags);
>> +    mutex_unlock(&atc->atc_mutex);
>>
>>       return err;
>>   }
>> @@ -1572,7 +1568,7 @@ int __devinit ct_atc_create(struct snd_card 
>> *card, struct pci_dev *pci,
>>       atc->msr = msr;
>>       atc->chip_type = chip_type;
>>
>> -    spin_lock_init(&atc->atc_lock);
>> +    mutex_init(&atc->atc_mutex);
>>
>>       /* Find card model */
>>       err = atc_identify_card(atc);
>> diff --git a/sound/pci/ctxfi/ctatc.h b/sound/pci/ctxfi/ctatc.h
>> index a033472..9fe620e 100644
>> --- a/sound/pci/ctxfi/ctatc.h
>> +++ b/sound/pci/ctxfi/ctatc.h
>> @@ -19,7 +19,7 @@
>>   #define CTATC_H
>>
>>   #include<linux/types.h>
>> -#include<linux/spinlock_types.h>
>> +#include<linux/mutex.h>
>>   #include<linux/pci.h>
>>   #include<linux/timer.h>
>>   #include<sound/core.h>
>> @@ -90,7 +90,7 @@ struct ct_atc {
>>       void (*unmap_audio_buffer)(struct ct_atc *atc, struct 
>> ct_atc_pcm *apcm);
>>       unsigned long (*get_ptp_phys)(struct ct_atc *atc, int index);
>>
>> -    spinlock_t atc_lock;
>> +    struct mutex atc_mutex;
>>
>>       int (*pcm_playback_prepare)(struct ct_atc *atc,
>>                       struct ct_atc_pcm *apcm);
>>
> No oopses with this patch so far, thank you.
Tested the patch more. Really no oopses. Instead of them I get rare 
system lockups.
