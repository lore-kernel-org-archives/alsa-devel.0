From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/5] ALSA: usb-audio: deallocate memory
 objects in error path
Date: Wed, 22 Feb 2017 10:42:39 +0900
Message-ID: <070a40e4-f90e-7c29-5058-f3a247fd9104@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
 <20170220200921.824-5-o-takashi@sakamocchi.jp> <s5hwpckpoz4.wl-tiwai@suse.de>
 <d7632df1-6524-d01c-cbcf-136902976953@sakamocchi.jp>
 <c4b1c062-2099-bd14-0bc2-5a2f9b1d30ab@sakamocchi.jp>
 <0f1bb4cb-daa3-7dd9-aa55-990b67c34a38@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 9D2A426680A
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 02:42:41 +0100 (CET)
In-Reply-To: <0f1bb4cb-daa3-7dd9-aa55-990b67c34a38@sakamocchi.jp>
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
Cc: onkel@paraair.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Feb 22 2017 07:59, Takashi Sakamoto wrote:
> On Feb 22 2017 07:45, Takashi Sakamoto wrote:
>> On Fe 21 2017 11:32, Takashi Sakamoto wrote:
>>> But it's wrong. The allocated memory objects are used for private data
>>> for each control element set. I didn't care of it...
>>>
>>> Here, what I should fix is just for error path. I'll post revised
>>> version of this patch this night.
>>
>> I realize that this is not concern because the code includes assignment
>> deallocate function to each control element set. Thus, in error path,
>> the allocated private data is going to free in below callgrach.
>>
>> (sound/usb/mixer_us16x08.c)
>> add_new_ctl(elem)
>>   kctl->private_free = freeer;
>>   (sound/usb/mixer.c)
>>   ->snd_usb_mixer_add_control(kctl)
>>     (sound/core/control.c)
>>     ->snd_ctl_add(kctl)
>>       ->snd_ctl_free_one(kctl)
>>         (in error path)
>>         ->kcontrol->private_free(kctl);
>>         (sound/usb/mixer_us16x08.c)
>>         = freeer()
>
> Oops. On the other hand, the private data for unregistered control
> element set is not deallocated automatically in error path of the other
> control element set. It should be fixed...

Mmm. There might be an issue of double free corruption, I think.

 >>     (sound/core/control.c)
 >>     ->snd_ctl_add(kctl)
 >>       (in error path)
 >>       ->snd_ctl_free_one(kctl)
 >>         ->kcontrol->private_free(kctl);
 >>         (sound/usb/mixer_us16x08.c)
 >>         = freeer()

This 'freeer()' is set in beginning of the graph.

 >> (sound/usb/mixer_us16x08.c)
 >> add_new_ctl(elem)
 >>   kctl->private_free = freeer;

The memory objects are not allocated for each of the control element 
set. On the other hand, the calls of the 'freeer()' are corresponding to 
each control element set. When the ratio between 
.private_data/.private_free and control element set is 1:N, 
.private_free can cause double free corruption at freeing control 
character device in kernel side.

In current code, there're two cases; NULL or 'snd_usb_mixer_elem_free()' 
are assigned as the 'freeer()'. But this is not enough. Actually, the 
allocated memory object for the 'comp_store' variable is going to be 
deallocated by two control element sets; for 'channel_controls[0]' and 
'channel_controls[0]' the allocated memory object for the 'eq_sotre' 
variable is going to be deallocated for several control element sets; 
the 'eq_controls[0, 1, 3, 6, 9]'.

As long as I understand, current code has the above issue and can bring 
kernel corruption. If I missing something, please inform it to me.


Regards

Takashi Sakamoto
