From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Wed, 03 Jul 2013 11:07:05 +0200
Message-ID: <51D3E9B9.3020903@metafoo.de>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D2270D.3090403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-086.synserver.de (smtp-out-086.synserver.de
 [212.40.185.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 318AC265549
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 11:06:34 +0200 (CEST)
In-Reply-To: <51D2270D.3090403@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joel Fernandes <joelf@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/02/2013 03:04 AM, Joel Fernandes wrote:
> On 06/30/2013 07:06 AM, Lars-Peter Clausen wrote:
>> Added alsa-devel to Cc.
>>
>> On 06/28/2013 05:27 AM, Fernandes, Joel wrote:
>>> Hi Lars,
>>>
>>> Hope you are doing well.
>>>
>>> I am implementing Cyclic DMA support in the EDMA driver that is used by Davinci and now newer TI SoCs.
>>> I am thinking once I am done I can plug it into the snd_dmaengine framework.
>>>
>>> Currently however, the davinci-pcm code directly programs the EDMA. That is what I am working to replace with a single driver and adapt to the snd dmaengine framework. However, once the current code in davinci-pcm uses internal RAM as an intermediate step in the whole DMA process (First data is TX to IRAM from DRAM and then from DRAM to the audio device).
>>>
>>> Do you have any ideas on how we can adapt to the framework, such that we can till use the IRAM? Are there any existing implementations out there that do something similar?
>>
>> Hm, I guess using the snd_dmaengine_pcm helper functions here shouldn't be too
>> hard. Using the generic snd_dmaengine_pcm driver will require some extensions
>> to it though. The mmp platform (pxa/mmp-pcm.c) is also using some kind of
>> on-chip memory, so having support for this in the generic driver certainly
> 
> I quickly looked at the implementation there. That's neat the way IRAM is used
> to allocate the DMA buffer.
> 
>> makes sense. For the chaining you'd probably have to extend the dmaengine
>> framework, since this kind of interleaved mem-to-mem and mem-to-dev cyclic
>> transfer is currently not possible.
> 
> I was thinking , if it makes sense to make this kind of intermediate IRAM step
> purely a DMA controller driver specific implementation. Basically, what I mean
> is the use of IRAM will be unknown to any of the other DMA layers and purely
> implement in the DMA controller driver making the interleaving with IRAM
> transparent to the DMAEngine framework or the other drivers. Using device tree
> or some other method, one could indicate that IRAM is present and should be used
> for the specific DMA channel.

Putting the ping-pong buffer handling into the DMA driver would allow you to
re-implement the current functionality with the current dmaengine API. So
this sounds like an option. And maybe there are also other usecases besides
audio for this.

- Lars
