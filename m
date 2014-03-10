From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: integration into ASoC
Date: Mon, 10 Mar 2014 11:15:29 +0100
Message-ID: <531D90C1.8000800@metafoo.de>
References: <20140307165335.GT607@lukather> <5319FE01.3070909@metafoo.de>
 <20140310095039.GC2815@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id A110A2650BA
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 11:14:51 +0100 (CET)
In-Reply-To: <20140310095039.GC2815@lukather>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zhuzhenhua@allwinnertech.com, Mark Brown <broonie@kernel.org>, kevin.z.m.zh@gmail.com, sunny@allwinnertech.com, shuge@allwinnertech.com
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 10:50 AM, Maxime Ripard wrote:
> Hi Lars,
>
> On Fri, Mar 07, 2014 at 06:12:33PM +0100, Lars-Peter Clausen wrote:
>> On 03/07/2014 05:53 PM, Maxime Ripard wrote:
>>> Hi Liam, Mark,
>>>
>>> I have a sound IP that is part of an SoC that I'm willing to write a
>>> driver for.
>>
>> Which SoC is this?
>
> Allwinner A31.
>
> Unfortunately, the datasheet for this SoC is not public, but most of
> the other Allwinner SoCs have an IP that behaves pretty much in the
> same way.
>
> You can find a datasheet for the A20 here:
> http://dl.linux-sunxi.org/A20/A20%20User%20Manual%202013-03-22.pdf,
> starting page 172.
>
> The A31 has a slightly different IP, but from an architectural
> standpoint, it's pretty much the same thing.
>
>>> This IP is made of a few registers to control the sampling rate, if
>>> we're using mono/stereo, plus two fifos, one for playback, one for
>>> capture, that can be seed with data. The data are then taken, go
>>> through a DAC, and the outer interface of the IP are directly analog
>>> signals (so the DAC/ADC are directly in the SoC, and the only
>>> interface we have is plain registers).
>>>
>>>  From what I understood from ASoC, you have mostly three components,
>>> the DAI, the codec and the platform that plumbers the two first
>>> together. Here, my understanding is that it's pretty much the whole
>>> three in a single IP.
>>
>> The platform component usually takes care of transferring data from
>> memory to your IP. It sounds as if this is still separate on your
>> platform. Quite possibly you can use the generic dmaengine PCM
>> driver.
>
> You really have two intertwined sets of registers, one for the FIFO
> themselves (and you will obviously use DMA for that, I'll keep in mind
> the dmaengine PCM driver), and the control registers, so you can't
> really split it into two separate drivers (at least, not easily).

You'd configure the FIFOs from the CPU component driver, but the part that 
takes care of moving the audio data around is a separate component.

>
>> Right now ASoC expects you to specify a DAI link for a PCM
>> device. The DAI link connects the DAIs of two components typically
>> the SoC side and a external CODEC. In your case you do not have the
>> external CODEC. You can solve this by using a dummy CODEC or
>> splitting things up and register both the CODEC and the CPU DAI from
>> the same driver.
>
> That would probably be the best solution, yes.
>
>> But I'm currently working on a patchset that will eventually allow
>> these kind of devices to be supported more naturally. It will allow
>> to register them as one component that won't need the CODEC
>> component to work.
>
> Great! Do you have a branch with that work somewhere?

Not yet. But I hope to get there in the next weeks.

>
>>> Should such a hardware block be handled into ASoC, and if yes, how?
>>> If not, which other framework should be used?
>>
>> It makes sense to use ASoC if there are components where the driver
>> can be shared e.g. the DMA in your case. Otherwise you can also use
>> plain old ALSA.
>
> The DMA controller this IP will use is a system-wide DMA master, so
> I don't think this driver will provide something to other drivers.

That's what I meant. The DMA controller is not integrated into the sound 
core, so you'll have a dmaengine driver for the DMA controller and the part 
that can be shared with other drivers is the code that handles setting up 
the DMA transfers etc.

- Lars
