From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 06/19] ASoC: fsl: Don't set unused struct
 snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 19:16:34 +0100
Message-ID: <52B48982.2000308@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-6-git-send-email-lars@metafoo.de>
 <52B45371.8020808@tabi.org> <52B44E58.4080609@metafoo.de>
 <20131220182727.GA31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-137.synserver.de
 [212.40.185.137])
 by alsa0.perex.cz (Postfix) with ESMTP id AD590261B25
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 20:15:38 +0100 (CET)
In-Reply-To: <20131220182727.GA31886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 12/20/2013 07:27 PM, Mark Brown wrote:
> On Fri, Dec 20, 2013 at 03:04:08PM +0100, Lars-Peter Clausen wrote:
>> On 12/20/2013 03:25 PM, Timur Tabi wrote:
> 
>>> Is this new?  There are formats that the codec and the SSI support that the
>>> DMA controller does NOT support, like packed 24-bit samples.  How do we
>>> ensure that we never get those?
> 
>> No, this is how it has always been. If there are restrictions imposed by the
>> DMA controller we need to add support for expressing this inside the ASoC
>> framework. But I think it will probably be more complex than just saying the
>> DMA controller supports format A, B, C and the DAI controller supports
>> format B, C, D and then just do the intersection of both. E.g. the DAI
>> controller probably does not care whether the samples are packed or not if
>> it only sees one sample at a time, while
> 
> The most common pattern I've seen is that the DAIs expect to see whole
> samples at a time get written into their FIFOs since the FIFOs tend to
> be stored in samples rather than bytes. With that pattern it'd be a bit
> cleaner to have them advertise sample sizes and transfer sizes and then
> have the core work out that if you can for example do 24 bit samples
> with four byte transfers and have a DMA controller that needs a 1:1
> mapping between data read and written then we can't do packed format.
> 

Yep. The other one I've seen is where the audio controller expects the DMA
to pack samples, that are smaller than the bus width, to one bus width word.
E.g. if the bus width is 32 and the sample width is 16 the DMA controller is
supposed to write 2 samples at once.

And then there might be different variations of the first one. Some
controllers might expect narrow writes/reads while others might expect full
bus width access with the upper bytes padded/discarded. But I think most
controllers are fine with both.

The audio controller should probably advertise what sample sizes it supports
and how it expects them to be written/read. And the DMA controller then
based on that list needs to figure out what kind of in memory
representations of the audio data it can support.

> I think in general we want to be moving the DAIs to a sample size based
> interface and then mapping that onto the DMA controller when we connect
> the DMA and CPU DAIs.  This would help with clarity on the CODEC side as
> well.
> 

Yep, something similar should probably be done for format negotiation
between DAI and CODEC.
