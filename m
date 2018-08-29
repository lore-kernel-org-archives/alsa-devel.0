From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 1/1] axi-i2s: set period size register
Date: Wed, 29 Aug 2018 09:15:56 +0200
Message-ID: <00d6c06e-851e-9d8e-fa79-983e826b8d5b@lucaceresoli.net>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
 <20180824160430.10222-2-luca@lucaceresoli.net>
 <b87937b6-da7c-76d7-5dd2-24909e648671@metafoo.de>
 <263e42b4-75a3-183c-894b-e485e387eccf@lucaceresoli.net>
 <f1845eab-ea85-5c2f-98c2-ac63a13ff68a@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f1845eab-ea85-5c2f-98c2-ac63a13ff68a@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 27/08/2018 18:51, Lars-Peter Clausen wrote:
> On 08/27/2018 06:22 PM, Luca Ceresoli wrote:
>> Hi,
>>
>> thanks for your feedback.
>>
>> [Adding Michal Simek (Xilinx maintainer) in Cc]
>>
>> On 27/08/2018 14:27, Lars-Peter Clausen wrote:
>>> On 08/24/2018 06:04 PM, Luca Ceresoli wrote:
>>>> The default value of the PERIOD_LEN register is 0 and results in
>>>> axi-i2s keeping TLAST always asserted in its AXI Stream output.
>>>>
>>>> When the AXI Stream is sent to a Xilinx AXI-DMA, this results in the
>>>> DMA generating an interrupt flood and ALSA produce a corrupted
>>>> recording. This is because AXI-DMA raises an interrupt whenever TLAST
>>>> is active.
>>>>
>>>> Fix by setting the PERIOD_LEN register as soon as the period is
>>>> known. This way TLAST is emitted once per period, and the DMA raises
>>>> interrupts correctly.
>>>
>>> The patch looks OK. But I'd prefer not to merge it if possible.
>>>
>>> We've done some early experiments with the Xilinx AXI-DMA, but it turned out
>>> to be to unreliable and we've abandoned support for it. One of the more
>>> critical issues was that you can't abort a DMA transfer. That means when
>>> audio capture is stopped the DMA will halt, but not complete the current
>>> transfer. Then when the next audio capture start the DMA will continue with
>>> the previous transfer. The observed effect of this was that the system would
>>> just crash randomly (Presumably due to memory corruption).
>>
>> Strange. I have done many capture experiments with arecord and didn't
>> run into such bad issues. I only have a much less serious problem
>> (garbage or old samples in the first few buffers), but no crashes.
>>
>> Michal, are you aware of these problems?
>>
>>> Have you considered using the ADI AXI-DMAC? That should work just fine.
>>
>> Not until today, because AXI-DMA is working here.
>>
>> I'd like to better understand what's going on before changing an IP that
>> is working. Do you have additional details about your setup? How do you
>> run your tests?
> 
> This was 4-5 years ago. A AXI-DMA with both TX and RX connected to the
> AXI-I2S.
> 
> It might be that back then I didn't have buffer prealloc enabled, so a
> new DMA buffer gets allocated for each transfer. Then you end up with
> use after free and the DMA overwriting freed (and maybe reused) memory.
> 
> It was bad enough that it was a lot easier to add PL330 support to the
> I2S peripheral. Not using Xilinx DMA for anything anymore has saved me
> from a lot of headache.

I kind of understand you. However since AXI-DMA it is working for me
with this patch, chances are that bug has been fixed in the meanwhile.

-- 
Luca
