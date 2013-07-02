From: Joel Fernandes <joelf@ti.com>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Mon, 1 Jul 2013 20:28:14 -0500
Message-ID: <51D22CAE.2020302@ti.com>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 052D3265289
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 03:28:22 +0200 (CEST)
In-Reply-To: <51D11D64.3070805@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 07/01/2013 01:10 AM, Mike Looijmans wrote:
> On 06/30/2013 02:06 PM, Lars-Peter Clausen wrote:
>> Added alsa-devel to Cc.
>>
>> On 06/28/2013 05:27 AM, Fernandes, Joel wrote:
>>> Hi Lars,
>>>
>>> Hope you are doing well.
>>>
>>> I am implementing Cyclic DMA support in the EDMA driver that is used by
>>> Davinci and now newer TI SoCs.
>>> I am thinking once I am done I can plug it into the snd_dmaengine framework.
>>>
>>> Currently however, the davinci-pcm code directly programs the EDMA. That is
>>> what I am working to replace with a single driver and adapt to the snd
>>> dmaengine framework. However, once the current code in davinci-pcm uses
>>> internal RAM as an intermediate step in the whole DMA process (First data is
>>> TX to IRAM from DRAM and then from DRAM to the audio device).
>>>
>>> Do you have any ideas on how we can adapt to the framework, such that we can
>>> till use the IRAM? Are there any existing implementations out there that do
>>> something similar?
>>
>> Hm, I guess using the snd_dmaengine_pcm helper functions here shouldn't be too
>> hard. Using the generic snd_dmaengine_pcm driver will require some extensions
>> to it though. The mmp platform (pxa/mmp-pcm.c) is also using some kind of
>> on-chip memory, so having support for this in the generic driver certainly
>> makes sense. For the chaining you'd probably have to extend the dmaengine
>> framework, since this kind of interleaved mem-to-mem and mem-to-dev cyclic
>> transfer is currently not possible.
>>
>> I'm wondering though why do you need to copy the data to RAM first, is it not
>> possible to map the IRAM to userspace?
> 
> 
> I've already built a cyclic DMA implementation into the EDMA driver for Davinci,
> without using the internal RAM. But that was for a 2.6.37 kernel.

Great!

> For capture, the internal RAM ping pong only made things worse, not better. I
> really have no idea what problem it was supposed to solve.

Interesting.

> The trouble with the current davinci driver is that the IRQ handler has a
> real-time requirement, it must finish before the next DMA block completes. This
> causes most of the buffer overruns on heavily loaded systems.

But how do you get around not calling snd_pcm_period_elapsed in a time-sensitive
fashion? Isn't it always time senstive,  or maybe you mean the timing is a bit
more relaxed (still sensitive though) as now the interrupt handler can its own
time to finish as long as it finishes before the next interrupt comes.

If that's what you mean, then actually what you said is not true for the
ping-pong implementation. because the DMA controller is programmed only *once*
at the beginning for the ping-pong or IRAM case. It is just the way the
ping-pong works, there is no need to program the DMA controller again and again
every interrupt. On the other hand, fully agree that for the regular case the
DMA controller has to be programmed for every period and this is what I guess
makes it time sensitive, you could confirm.

> It's easy to set up a cyclic chain of DMA transfers with the EDMA controller
> that continuously transfers data to the audio buffer. Once that is done, the
> completion IRQ can be used to periodically "trigger" user space, but it isn't
> time critical any more.

That makes a lot of sense.

> The McASP has enough internal buffering to take care of any DDR latency issues.

Sure.

> With the cyclic DMA, I can capture 16 channels of 32-bit audio at 51kHz,
> simultaneously playback 2 channels and write the audio data to an SD card on the
> OMAP-L138. Before that change, it wasn't even possible to capture 4 channels
> without overruns.

Sweet! Any particular reason why it wasn't merged in vs the existing ping-pong code?

> I can mail you the 2.6.37 code, it isn't worthy for direct inclusion but may
> save you some time to figure things out.

Certainly could take a look. Could you share it? Thank you.

Thanks,

-Joel
