From: "Vladimir A. Barinov" <vbarinov@ru.mvista.com>
Subject: Re: [PATCH] ASoC TLV320AIC3X codec driver
Date: Wed, 14 Nov 2007 17:22:37 +0300
Message-ID: <473B04AD.20301@ru.mvista.com>
References: <20071113194125.GA17302@ru.mvista.com>	<s5hhcjpfecc.wl%tiwai@suse.de>	<473AF25F.5060305@ru.mvista.com>
	<s5h6405facy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 94B8524775
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 15:22:39 +0100 (CET)
In-Reply-To: <s5h6405facy.wl%tiwai@suse.de>
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
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 14 Nov 2007 16:04:31 +0300,
> Vladimir A. Barinov wrote:
>   
>>>> +/*
>>>> + * All input lines are connected when !0xf and disconnected with 0xf bit field,
>>>>     
>>>>         
>>> Please keep the line within 80 chars.  Try to run checkpatch.pl in
>>> linuxkernel/scripts for checking such minor coding-style issues.
>>>   
>>>       
>> But this line is less then 80 chars :)
>>     
>
> Ah, ok, maybe my editor window was too narrow.  Please disregard it.
>
>   
>>>> +#define AIC3X_RATES	SNDRV_PCM_RATE_8000_96000
>>>> +#define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
>>>> +			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>>>>     
>>>>         
>>> Are you sure that it's FMTBIT_S24_LE?  It's not packed in 3 bytes but
>>> uses lower 3 bytes of 4 bytes frame.
>>>
>>>   
>>>       
>> Aic3x supports 16/20/24/32 bits data word length and in accordance with 
>> aic33 documentation the
>> number of clocks per half-frame for each channel are equal to exact 
>> number of bits of the word.
>> Unfortunately, now I have no h/w to test 24bits mode.
>>     
>
> Then it sounds like the correct data format is FMTBIT_S24_3LE instead
> of FMTBIT_S24_LE.  The former is 3-byte format while the latter is
> 4-byte.  Please check again.
>
>   
Thanks for clarification! That's it. Will correct in the next take.

Vladimir
