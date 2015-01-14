From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Correct rx format
 unit configuration
Date: Wed, 14 Jan 2015 16:05:45 +0100
Message-ID: <54B685C9.70000@gmail.com>
References: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
 <54B64EC4.6040600@gmail.com> <54B6621C.7060505@ti.com>
 <54B66DF8.6000806@gmail.com> <54B67A86.6080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
 [74.125.82.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 8158426527F
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 16:12:01 +0100 (CET)
Received: by mail-we0-f174.google.com with SMTP id k48so9338654wev.5
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 07:12:01 -0800 (PST)
In-Reply-To: <54B67A86.6080202@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 14.01.2015 15:17, Peter Ujfalusi wrote:
> On 01/14/2015 03:24 PM, Pascal Huerst wrote:
>> Yes, even this single line.
>>
>> - u32 rx_rotate = 0;
>> + u32 rx_rotate = (32 - word_length) / 4;
>>
>>>> Do you have any Idea, what might cause that behavior?
>>>
>>> No, I don't. I quickly checked on am335x, am437x and on J6 boards and the
>>> command you are using works w/o any issue or distortion in recorded audio.
>>
>>> what codec or codecs are you using? I see that you record from hw:0,1 and play
>>> it back to hw:0,0
>>> Can you check if the recorded sample alone is correct? Just record it to a
>>> file and look at it on the PC. I did the same and the recorded sample looks
>>> fine on my PC as well.
>>
>> if I record into a file, it behaves just the same. Noise if
>> rx_rotate == 0, correct otherwise. I guess it is a problem in the input
>> codec, then.
>>
>> input codec:   AK5386
>> output codec:  TAS5086
>>
>>> Looking at the patch again, I still think it is a valid fix.
>>
>> Yes, I agree, the patch looks right.
>>
>> I'll have a look into the ak5386 and see, what impact your change could
>> have there.
> 
> Can you try S24_LE format as well? I think it should work.

If I record to a file everything works fine, no noise. But I can not map
to the output, since the output codec does not support S24_LE

> I assume you are running the AK5386 as master which would explain the
> symptoms. In this mode you have 64bclk per sample (32 per channel).

no I'm not. it's running in slave mode. CKS[0-2] = 0 (GND).

> I believe this should fix your capture in case of S16_LE:
> keep the (in linux-next):
> fe0a29e163a5d045c73faab682a8dac71c2f8012 : ASoC: davinci-mcasp: Correct rx
> format unit configuration
> 
> make sure you have (as in linux-next):
> d742b925244ce91f16d380befdca473e4536359b : ASoC: davinci-mcasp: Fix rx format
> when more bclk is used on the bus

Yes. Although AK5386 is in slave mode, this fixed the issue!

> add the following to your machine driver's hw_params callback:
> 
> ...
> snd_soc_dai_set_clkdiv(cpu_dai, 2, 64);
> ...

That line was there already.

> I think the issue with your setup is that McASP expects the you have 32bclk
> per sample, but AK5386 generates 64 for you, this will mess up the data you
> are receiving since in this case we need to shift the data with 16bits before
> we invert it.

Ok. I think I will have to look deeper into that, to really understand,
where these 64bclk came from in my case (assuming its set in the machine
driver).

But anyways, thanks a lot for your help!

pascal
