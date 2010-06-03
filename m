From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC][PATCH 21/26] alsa: ASoC: Add JZ4740 ASoC
	support
Date: Thu, 03 Jun 2010 19:16:42 +0200
Message-ID: <4C07E37A.40502@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
	<1275505950-17334-5-git-send-email-lars@metafoo.de>
	<1275569309.3593.106.camel@odin> <4C07DD48.2050503@metafoo.de>
	<1275584609.3118.26.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B249103AD8
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 19:17:14 +0200 (CEST)
In-Reply-To: <1275584609.3118.26.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Thu, 2010-06-03 at 18:50 +0200, Lars-Peter Clausen wrote:
>   
>>>> +    config = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai,
>>>>         
>> substream);
>>     
>>>> +    if (!prtd->dma) {
>>>> +            const char *dma_channel_name;
>>>> +            if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>>> +                    dma_channel_name = "PCM Playback";
>>>> +            else
>>>> +                    dma_channel_name = "PCM Capture";
>>>> +
>>>> +            prtd->dma = jz4740_dma_request(substream,
>>>>         
>> dma_channel_name);
>>     
>>>>     
>>>>         
>>> dma_channel_name variable is not required here. Just use the const
>>>       
>> char
>>     
>>> * directly.
>>>
>>>   
>>>       
>> I actually had it like that before, but I think it is much more readable
>> in its current form.
>>     
>
> I disagree, having the char pointer here just adds an extra level of
> indirection and costs an extra two lines of code. 
>
> Liam 
>   
Hi

Could you give an concrete example of how you would code it?

- Lars
