From: arvindY <arvind.yadav.cs@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: nuc900: Fix platform_get_irq()
 error checking some more
Date: Sun, 10 Dec 2017 08:10:26 +0530
Message-ID: <5A2C9E9A.7020501@gmail.com>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
 <5A2BE644.3070009@gmail.com> <20171209172732.GF15660@piout.net>
 <20171210015200.gr4mxzqgzyvamxui@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171210015200.gr4mxzqgzyvamxui@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On Sunday 10 December 2017 07:22 AM, Dan Carpenter wrote:
> On Sat, Dec 09, 2017 at 06:27:32PM +0100, Alexandre Belloni wrote:
>>>> diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
>>>> index 5e4fbd2d3479..71fce7c85c93 100644
>>>> --- a/sound/soc/nuc900/nuc900-ac97.c
>>>> +++ b/sound/soc/nuc900/nuc900-ac97.c
>>>> @@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
>>>>    		goto out;
>>>>    	}
>>>> -	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
>>>> -	if (nuc900_audio->irq_num <= 0) {
>>>> -		ret = nuc900_audio->irq_num < 0 ? nuc900_audio->irq_num : -EBUSY;
>>>> +	ret = platform_get_irq(pdev, 0);
>>>> +	if (ret < 0)
>> The <= 0 was ok, see:
>> https://lkml.org/lkml/2017/11/18/41
>>
> Yeah, but is it ever going to return 0?  That seems like a design error
> and also really crap commenting if so
yes, It can return 0 on sprac platform and If you see the return of
platform_get_irq() 'return r ? r->start : -ENXIO;'. It should be
'return r && r->start? r->start : -ENXIO;'. We can not add checks here,
Because There's a bunch of platforms in the kernel they still use IRQ0 
as valid.
I have separate mails where few maintainer ask me to add check for 0 and 
few not.
Adding check for 0 will never harm.
>
> regards,
> dan carpenter
>
~arvind
