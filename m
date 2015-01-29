From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: simple-audio-card vs. platform question
Date: Thu, 29 Jan 2015 14:37:52 +0100
Message-ID: <54CA37B0.2040503@metafoo.de>
References: <alpine.DEB.2.02.1501271301400.11532@lnxricardw1.se.axis.com>
 <54C7848F.6070903@metafoo.de>
 <alpine.DEB.2.02.1501271730110.11532@lnxricardw1.se.axis.com>
 <54C7D4D8.9020301@metafoo.de>
 <alpine.DEB.2.02.1501290938240.11532@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D99226048B
 for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2015 14:37:54 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1501290938240.11532@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 01/29/2015 09:58 AM, Ricard Wanderlof wrote:
>
> On Tue, 27 Jan 2015, Lars-Peter Clausen wrote:
>
>>>> Usually in such a setup the CPU DAI driver also register the platform
>>>> component. Which then as the same of_node as the CPU DAI and so the matching
>>>> works. There are plenty of examples e.g. check the drivers using
>>>> devm_snd_dmaengine_pcm_register().
>>>
>>> Curious though, wouldn't it be more natural to bind it all together in the
>>> simple-audio-card DT entry, having a "simple-audio-card,platform"
>>> specification? Or is the idea that normally the CPU DAI driver is fairly
>>> tightly coupled to the PCM driver so it makes more sense to make that
>>> connection in the code?
>>
>> Usually there is no representation of the platform object in the devicetree.
>> E.g. typically this is a external shared DMA controller which is referenced
>> by the dmas property in the CPU DAI node.
>
> But perhaps there should be? As it is now, the I2S driver is bound in the
> code to the PCM driver using the devm_snd_dmaengine_pcm_register() call,
> which doesn't seem to fit in with the device tree philosphy of having the
> DT describe the hardware.
>
> Taking davinci-mcasp.c as an example, there's a bulk of #if's which govern
> calling the correct PCM driver depending on the setup, which is a bit
> cumbersome.
>
> Granted, having a platform description in the DT would not actually
> describe any specific hardware since as you said the DMA controller is
> normally described elsewhere, which would go against the DT philosophy.
>
> I'm not necessarily saying it would be better with a platform description
> in the DT, all things considered, just trying to understand why it may not
> be.

If you can make a compelling case that it should be added and that it 
describes the hardware that you have accurately I shouldn't be a problem to 
add it.

But in my opinion and experience the model where you have platform, CPU DAI, 
CODEC DAI is antiquated and does not match the modern hardware very well. 
We've started to restructure the ASoC framework to better accommodate the 
requirements of modern systems. And I'm hoping that once this restructuring 
is complete there will be no need for snd_soc_platform anymore.

>
> BTW, I can't find any DT in the kernel where the DMA is referenced in the
> CPU DAI node, all the DT's I can find which use simple-audio-card at least
> just reference the i2s device, which in turn references the DMA. Makes
> sense to me, perhaps that is what you meant?

Yes, that's what I meant.

- Lars
