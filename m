From: Udo Eberhardt <udo.eberhardt@thesycon.de>
Subject: Re: quirks patch for new T+A USB DAC
Date: Tue, 5 Feb 2019 17:24:04 +0100
Message-ID: <86a1c195-3fc6-567c-32e5-e1bc0ddc92da@thesycon.de>
References: <b2d6f671-1cee-231d-bf1c-a6a58e31076b@thesycon.de>
 <s5hzhra6wo6.wl-tiwai@suse.de>
 <cf0ca668-9589-001a-a111-48f1321344f6@thesycon.de>
 <s5htvhi6wcq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from routemea1.hes.trendmicro.eu (routemea1.hes.trendmicro.eu
 [52.58.63.6]) by alsa0.perex.cz (Postfix) with ESMTP id 3BCD22666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:24:05 +0100 (CET)
Received: from 0.0.0.0_hes.trendmicro.com (unknown [192.168.13.212])
 by routemea1.hes.trendmicro.eu (Postfix) with SMTP id 5032C456073
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 16:24:05 +0000 (UTC)
Received: from mail.lan.thesycon.de (unknown [80.88.23.201])
 by relayemea3.hes.trendmicro.eu (TrendMicro Hosted Email Security) with ESMTP
 id 9D1B858C059
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 16:24:04 +0000 (UTC)
Received: from [192.168.1.106] (ue1.lan.thesycon.de [192.168.1.106])
 by mail.lan.thesycon.de (Postfix) with ESMTP id 4E35FE8C3E6
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:24:04 +0100 (CET)
In-Reply-To: <s5htvhi6wcq.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Got it. Thanks for the tip. Will follow the rules next time.

Udo

On 05.02.2019 17:20, Takashi Iwai wrote:
> On Tue, 05 Feb 2019 17:18:56 +0100,
> Udo Eberhardt wrote:
>> Here it is:
>>
>> Signed-off-by: Udo Eberhardt <udo.eberhardt@thesycon.de>
> Thanks.
>
>> I'm not familiar with your conventions, sorry for any inconvenience.
> The general rule for submitting a kernel patch is well described in
> Documentation/process/submitting-patches.rst.
>
>
> Takashi
>
>> Thanks
>> Udo
>>
>> On 05.02.2019 17:13, Takashi Iwai wrote:
>>> On Tue, 05 Feb 2019 17:08:51 +0100,
>>> Udo Eberhardt wrote:
>>>> Hi all,
>>>>
>>>> This is a patch for sound/usb/quirks.c which enables DSD support for a
>>>> new T+A DAC for which we have developed the USB firmware. Here is a
>>>> patch description:
>>>>
>>>> This patch adds the T+A VID to the generic check in order to enable
>>>> native DSD support for T+A devices. This works with the new T+A USB
>>>> DAC model SD3100HV and will also work with future devices which
>>>> support the XMOS/Thesycon style DSD format.
>>>>
>>>>
>>>> I hope you can apply this patch. Let me know if you need more info.
>>> Could you give your sign-off (Signed-off-by: xxx line) at least?
>>> This is mandatory for merging to the upstream.  I should have
>>> mentioned that in the previous conversation...
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>>> Thank you,
>>>> Udo
>>>>
>>>> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
>>>> index ef67d19117c4..f372c624bbf4 100644
>>>> --- a/sound/usb/quirks.c
>>>> +++ b/sound/usb/quirks.c
>>>> @@ -1553,6 +1553,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
>>>>    	case 0x20b1:  /* XMOS based devices */
>>>>    	case 0x152a:  /* Thesycon devices */
>>>>    	case 0x25ce:  /* Mytek devices */
>>>> +	case 0x2ab6:  /* T+A devices */
>>>>    		if (fp->dsd_raw)
>>>>    			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
>>>>    		break;
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
