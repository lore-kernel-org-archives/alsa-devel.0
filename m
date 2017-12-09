From: arvindY <arvind.yadav.cs@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: nuc900: Fix platform_get_irq()
 error checking some more
Date: Sun, 10 Dec 2017 00:07:17 +0530
Message-ID: <5A2C2D5D.2060708@gmail.com>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
 <5A2BE644.3070009@gmail.com> <20171209172732.GF15660@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171209172732.GF15660@piout.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Saturday 09 December 2017 10:57 PM, Alexandre Belloni wrote:
> Arvind,
>
> This was v5 and it contains an error that was corrected between v1 and
> v2. For whatever reason, you reintroduced it between v4 and v5.
>
> This is wasting a lot of time.
Yes, You are right. That is my mistake.  Next time I will try to avoid
These kind of error.

>
> On 09/12/2017 at 19:03:56 +0530, arvindY wrote:
>> Hi Dan,
>>
>> On Saturday 09 December 2017 05:22 PM, Dan Carpenter wrote:
>>> The error handling doesn't work here because "nuc900_audio->irq_num" is
>>> unsigned.  Also we should be checking for < 0 and not <= 0 but I believe
>>> that's harmless.  The platform_get_irq() comments don't talk about the
>>> return values...
>> Sorry for this  patch. I will fix it and send you updated patch.
>> Thanks for point it.
Thanks for Fix. Please ignore my previous comment.
>>> Fixes: fa8cc38165c2 ("ASoC: nuc900: Fix platform_get_irq's error checking")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Arvind Yadav <Arvind.yadav.cs@gmail.com>
>>>
>>> diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
>>> index 5e4fbd2d3479..71fce7c85c93 100644
>>> --- a/sound/soc/nuc900/nuc900-ac97.c
>>> +++ b/sound/soc/nuc900/nuc900-ac97.c
>>> @@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
>>>    		goto out;
>>>    	}
>>> -	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
>>> -	if (nuc900_audio->irq_num <= 0) {
>>> -		ret = nuc900_audio->irq_num < 0 ? nuc900_audio->irq_num : -EBUSY;
>>> +	ret = platform_get_irq(pdev, 0);
>>> +	if (ret < 0)
> The <= 0 was ok, see:
> https://lkml.org/lkml/2017/11/18/41
>
>
~arvind
