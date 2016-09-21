From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: snd-usb-line6 depends on CONFIG_SND_HWDEP
Date: Thu, 22 Sep 2016 08:01:05 +0900
Message-ID: <12c7a28b-0e74-beb0-00e2-7c307a17b987@sakamocchi.jp>
References: <86590.1474409693@turing-police.cc.vt.edu>
 <046fe4be-f3e8-0088-8b1d-ed94bb9ef914@sakamocchi.jp>
 <s5hk2e5l97y.wl-tiwai@suse.de>
 <b9ed1809-b48a-5e72-b815-f5ad073520d1@sakamocchi.jp>
 <s5heg4dl6s4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5heg4dl6s4.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
List-Id: alsa-devel@alsa-project.org

On Sep 21 2016 22:30, Takashi Iwai wrote:
> On Wed, 21 Sep 2016 15:25:43 +0200,
> Takashi Sakamoto wrote:
>>
>> On Sep 21 2016 21:37, Takashi Iwai wrote:
>>> On Wed, 21 Sep 2016 03:56:05 +0200,
>>> Takashi Sakamoto wrote:
>>>>
>>>> On Sep 21 2016 07:14, Valdis Kletnieks wrote:
>>>>> ALSA - snd-usb-line6 depends on CONFIG_SND_HWDEP
>>>>>
>>>>> ERROR: "snd_hwdep_new" [sound/usb/line6/snd-usb-line6.ko] undefined!
>>>>> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>>>>> make[1]: *** [__modpost] Error 1
>>>>>
>>>>> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>>>>
>>>> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>>>
>>>> As a nitpicking, I think it better to change the subject line with a
>>>> prefix of 'ALSA: line6:' or 'ALSA: usb-line6:', following to our
>>>> fashion.
>>>
>>> Yes, I modified the subject line and added fixes tag.
>>
>> Thanks.
>>
>> As another issue, I can see sparse (v0.5.0) errors:
>>
>> sound/usb/line6/driver.c:274:43: error: cannot size expression
>> sound/usb/line6/driver.c:275:16: error: cannot size expression
>> sound/usb/line6/driver.c:276:16: error: cannot size expression
>> sound/usb/line6/driver.c:277:16: error: cannot size expression
>>
>> And this fix can suppresses them:
>>
>> $ git diff sound/usb/line6
>> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
>> index f9224ec..ad7efc0 100644
>> --- a/sound/usb/line6/driver.c
>> +++ b/sound/usb/line6/driver.c
>> @@ -30,7 +30,7 @@
>>  /*
>>         This is Line 6's MIDI manufacturer ID.
>>  */
>> -const unsigned char line6_midi_id[] = {
>> +const unsigned char line6_midi_id[3] = {
>>         0x00, 0x01, 0x0c
>>  };
>>  EXPORT_SYMBOL_GPL(line6_midi_id);
>>
>> Besides, there's a difference of the declaration between header and code:
>> $ cat sound/usb/line6/driver.h
>> ...
>> extern const unsigned char line6_midi_id[3];
>>
>> This is quite minor. So I can't judge to fix it or not... What do you
>> think about it?
> 
> The only problem I can see is the inconsistency between the
> declaration and the definition.

I have the same opinion. Sparse is not versatile.

> So yes, we should align to [3], if we keep the declaration as is.
> (And actually it's sometimes safer to have the explicit array size.)

OK. I'll post the fix later.


Thanks

Takashi Sakamoto
