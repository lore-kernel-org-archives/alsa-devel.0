From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Thu, 5 Nov 2015 23:08:54 +0100
Message-ID: <563BD376.60305@tekno-soft.it>
References: <CAG5mAdz+RDM8r1o+Q5WHhQM134Lp7Dxn78+ixX1D_u7G=WqE8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 353FD260639
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 23:09:16 +0100 (CET)
In-Reply-To: <CAG5mAdz+RDM8r1o+Q5WHhQM134Lp7Dxn78+ixX1D_u7G=WqE8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11/05/2015 10:34 PM, Caleb Crome wrote:
> On Thu, Nov 5, 2015 at 3:48 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>> On 11/05/2015 12:30 PM, Fabio Estevam wrote:
>>> On Thu, Nov 5, 2015 at 8:03 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>>
>>>> Following your suggestion, I've increased the buffer size to 2K and set the period to fifo_length - 2 (13),
>>>> with that I'm now running substantially smooth except 3 EVTERR on RX DMA over 4 million of interrupts.
>>>>
>>>> Thanks Nicolin! I'm quite happy now!
>>> That's good progress, Roberto.
>>>
>>> It would be nice if you and Caleb could post the patches to the mailing list.
>>>
> Yes, when I get something quite solid, I'd like to submit it all to
> the list, and hope to get it into the kernel so nobody else has to go
> through this pain again.
>
>> Indeed! Now the TDM is stable, I've also found the reason of the EVTERRs, which was related to some stale
>> code I've used to enable and disable both RDMAE and TDMAE bits to try to reset the transfers.
>> Once removed that code everything is looks ok now.
>>
>> Regarding patches, well, from my side there isn't nothing special compared to the original fsl_ssi.c code.
>> I'm basically running against a very skinny fsl_ssi.c version, I've just setup a bit larger DMA buffer, from
>> 16bytes to 2K, and now reduced the DMA period to 8 because I'm mostly comfortable with that size to simplify
>> sampling exchange against DAHDI subsystem within my DMA callbacks.
>>
>> In a few words, my problem was related due to a DMA buffer too small.
>>
>> What eventually might be interesting to have is the INTRMASK and EVTERR DMA setting to trigger DMA
>> related errors, but I guess this need to be discussed elsewhere.
> I have implemented roberto's patch on the 4.2 kernel, and I get a huge
> number of EVTERR interrupts.  Something like 7200/second at 16kHz
> sample rate.  But strangely, the audio seems to be correct.

I've notice that clearing the EVTERR bit seems restarting the given SDMA.

> My patch is slightly different in that it just enables EVTERR for all
> channels, not just for the SSI.  Might as well see if there are any
> other problems.

Oh yes! This will overload the SDMA isr. How bigger is your audio buffer?
In your case I guess you will need something like 16KHz * 16 channels *
2 bytes (16bits) = 512K minimum.
I would try to start from 1MB or maybe more.

>
> And it puts the stats file at
> /sys/kernel/debug/20ec000.sdma/stats
>
> When I aplay a file for 10 seconds I get ~366 EVTERR interrupts.
> When I arecord for 10 seconds, I get 1 EVTERR interrupt
> When I run my application for 10 seconds, which does full duplex, I
> get 72703 EVTERR interrupts, but the data integrity checks out okay.
>
> Interstingly, when I enable dual fifo, it goes from about 7200
> EVTERR's/sec to about 18 EVTERRs/sec.  Much better, but still a long
> way from working perfectly.
>

Cyclic DMA is particular scatter-gater DMA list dedicated for repetitive
tasks looping over the same buffer, so audio.
The associated callback is triggered every period (fifo_depth-2) but the
job will last only when the buffer is
filled in the request length. All this "tasks" will be managed by SDMA
ISR. You can follow the SG_LOOP flag if you
want understand more.

> When I get a 'hang' from my application (no more portaudio callbacks),
> I'm actually getting repeated calls to sdma_prep_dma_cyclic, though I
> don't know how that call gets triggered.  But once that starts
> happening, no more audio data gets through.

If I remember correctly portaudio has a thread that controls your
callback that receive/play all samples, but I don't remember if the
callback is responsible to stop recording or playing in case of error.
I've to check this in my last app.
