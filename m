From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/5] ALSA: usb-audio: deallocate memory
 objects in error path
Date: Tue, 21 Feb 2017 11:32:02 +0900
Message-ID: <d7632df1-6524-d01c-cbcf-136902976953@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
 <20170220200921.824-5-o-takashi@sakamocchi.jp> <s5hwpckpoz4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B46A22666F2
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 03:32:05 +0100 (CET)
In-Reply-To: <s5hwpckpoz4.wl-tiwai@suse.de>
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

On Feb 21 2017 05:49, Takashi Iwai wrote:
> On Mon, 20 Feb 2017 21:09:20 +0100,
> Takashi Sakamoto wrote:
>>
>> Some functions for quirks of Tascam US-16x08 have memory leaks.
>>
>> This commit fixes the bugs.
>>
>> Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  sound/usb/mixer_us16x08.c | 27 ++++++++++++++++-----------
>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
>> index 5dae63c..d34dd1c 100644
>> --- a/sound/usb/mixer_us16x08.c
>> +++ b/sound/usb/mixer_us16x08.c
>> @@ -1082,8 +1082,8 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
>>
>>  	kctl = snd_ctl_new1(ncontrol, elem);
>>  	if (!kctl) {
>> -		kfree(elem);
>> -		return -ENOMEM;
>> +		err = -ENOMEM;
>> +		goto end;
>>  	}
>>
>>  	kctl->private_free = freeer;
>> @@ -1092,11 +1092,12 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
>>
>>  	err = snd_usb_mixer_add_control(&elem->head, kctl);
>>  	if (err < 0)
>> -		return err;
>> +		goto end;
>>
>>  	if (elem_ret)
>>  		*elem_ret = elem;
>> -
>> +end:
>> +	kfree(elem);
>>  	return 0;
>
> This will release elem even for the success case, no?

Yes, it's my intension of this patch.

But it's wrong. The allocated memory objects are used for private data 
for each control element set. I didn't care of it...

Here, what I should fix is just for error path. I'll post revised 
version of this patch this night.


Thanks

Takashi Sakamoto
