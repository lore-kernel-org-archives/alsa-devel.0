From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Mon, 01 Jul 2013 08:10:44 +0200
Message-ID: <51D11D64.3070805@topic.nl>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob09.myregisteredsite.com
 (atl4mhob09.myregisteredsite.com [209.17.115.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 2951E2610C5
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 08:10:46 +0200 (CEST)
Received: from mailpod.hostingplatform.com ([10.30.71.207])
 by atl4mhob09.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r616AjsF019456
 for <alsa-devel@alsa-project.org>; Mon, 1 Jul 2013 02:10:45 -0400
In-Reply-To: <51D01F31.3010602@metafoo.de>
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
Cc: joelf@ti.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 06/30/2013 02:06 PM, Lars-Peter Clausen wrote:
> Added alsa-devel to Cc.
>
> On 06/28/2013 05:27 AM, Fernandes, Joel wrote:
>> Hi Lars,
>>
>> Hope you are doing well.
>>
>> I am implementing Cyclic DMA support in the EDMA driver that is used by Davinci and now newer TI SoCs.
>> I am thinking once I am done I can plug it into the snd_dmaengine framework.
>>
>> Currently however, the davinci-pcm code directly programs the EDMA. That is what I am working to replace with a single driver and adapt to the snd dmaengine framework. However, once the current code in davinci-pcm uses internal RAM as an intermediate step in the whole DMA process (First data is TX to IRAM from DRAM and then from DRAM to the audio device).
>>
>> Do you have any ideas on how we can adapt to the framework, such that we can till use the IRAM? Are there any existing implementations out there that do something similar?
>
> Hm, I guess using the snd_dmaengine_pcm helper functions here shouldn't be too
> hard. Using the generic snd_dmaengine_pcm driver will require some extensions
> to it though. The mmp platform (pxa/mmp-pcm.c) is also using some kind of
> on-chip memory, so having support for this in the generic driver certainly
> makes sense. For the chaining you'd probably have to extend the dmaengine
> framework, since this kind of interleaved mem-to-mem and mem-to-dev cyclic
> transfer is currently not possible.
>
> I'm wondering though why do you need to copy the data to RAM first, is it not
> possible to map the IRAM to userspace?


I've already built a cyclic DMA implementation into the EDMA driver for 
Davinci, without using the internal RAM. But that was for a 2.6.37 kernel.

For capture, the internal RAM ping pong only made things worse, not 
better. I really have no idea what problem it was supposed to solve.

The trouble with the current davinci driver is that the IRQ handler has 
a real-time requirement, it must finish before the next DMA block 
completes. This causes most of the buffer overruns on heavily loaded 
systems.
It's easy to set up a cyclic chain of DMA transfers with the EDMA 
controller that continuously transfers data to the audio buffer. Once 
that is done, the completion IRQ can be used to periodically "trigger" 
user space, but it isn't time critical any more.
The McASP has enough internal buffering to take care of any DDR latency 
issues.

With the cyclic DMA, I can capture 16 channels of 32-bit audio at 51kHz, 
simultaneously playback 2 channels and write the audio data to an SD 
card on the OMAP-L138. Before that change, it wasn't even possible to 
capture 4 channels without overruns.

I can mail you the 2.6.37 code, it isn't worthy for direct inclusion but 
may save you some time to figure things out.

Kind regards,
Mike.
