From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Fri, 6 Nov 2015 00:01:25 +0100
Message-ID: <563BDFC5.9000005@tekno-soft.it>
References: <CAG5mAdz+RDM8r1o+Q5WHhQM134Lp7Dxn78+ixX1D_u7G=WqE8w@mail.gmail.com>
 <563BD376.60305@tekno-soft.it>
 <CAG5mAdxVcnuvcPiKPUAn+HfMfTJ=g25DzGE-dXEx=HVNbrA0yQ@mail.gmail.com>
 <563BDAD5.3040007@tekno-soft.it>
 <CAG5mAdwQVC+0YW06R+6KCM++RPDx+k8Db7YpYC=Ewn=esR+63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id AF6AC26063F
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 00:01:53 +0100 (CET)
In-Reply-To: <CAG5mAdwQVC+0YW06R+6KCM++RPDx+k8Db7YpYC=Ewn=esR+63g@mail.gmail.com>
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



On 11/05/2015 11:49 PM, Caleb Crome wrote:
> On Thu, Nov 5, 2015 at 2:40 PM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>> On 11/05/2015 11:25 PM, Caleb Crome wrote:
>>> On Thu, Nov 5, 2015 at 2:08 PM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>>> On 11/05/2015 10:34 PM, Caleb Crome wrote:
>>>>> On Thu, Nov 5, 2015 at 3:48 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>>>>> On 11/05/2015 12:30 PM, Fabio Estevam wrote:
>>>>>>> On Thu, Nov 5, 2015 at 8:03 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>>>>>>
>>>>>>>> Following your suggestion, I've increased the buffer size to 2K and set the period to fifo_length - 2 (13),
>>>>>>>> with that I'm now running substantially smooth except 3 EVTERR on RX DMA over 4 million of interrupts.
>>>>>>>>
>>>>>>>> Thanks Nicolin! I'm quite happy now!
>>>>>>> That's good progress, Roberto.
>>>>>>>
>>>>>>> It would be nice if you and Caleb could post the patches to the mailing list.
>>>>>>>
>>>>> Yes, when I get something quite solid, I'd like to submit it all to
>>>>> the list, and hope to get it into the kernel so nobody else has to go
>>>>> through this pain again.
>>>>>
>>>>>> Indeed! Now the TDM is stable, I've also found the reason of the EVTERRs, which was related to some stale
>>>>>> code I've used to enable and disable both RDMAE and TDMAE bits to try to reset the transfers.
>>>>>> Once removed that code everything is looks ok now.
>>>>>>
>>>>>> Regarding patches, well, from my side there isn't nothing special compared to the original fsl_ssi.c code.
>>>>>> I'm basically running against a very skinny fsl_ssi.c version, I've just setup a bit larger DMA buffer, from
>>>>>> 16bytes to 2K, and now reduced the DMA period to 8 because I'm mostly comfortable with that size to simplify
>>>>>> sampling exchange against DAHDI subsystem within my DMA callbacks.
>>>>>>
>>>>>> In a few words, my problem was related due to a DMA buffer too small.
>>>>>>
>>>>>> What eventually might be interesting to have is the INTRMASK and EVTERR DMA setting to trigger DMA
>>>>>> related errors, but I guess this need to be discussed elsewhere.
>>>>> I have implemented roberto's patch on the 4.2 kernel, and I get a huge
>>>>> number of EVTERR interrupts.  Something like 7200/second at 16kHz
>>>>> sample rate.  But strangely, the audio seems to be correct.
>>>> I've notice that clearing the EVTERR bit seems restarting the given SDMA.
>>>>
>>>>> My patch is slightly different in that it just enables EVTERR for all
>>>>> channels, not just for the SSI.  Might as well see if there are any
>>>>> other problems.
>>>> Oh yes! This will overload the SDMA isr.
>>> It didn't seem to.  There didn't seem to be any other DMA happening in
>>> my system, definitely none that made the EVTRR trigger.  However, I
>>> changed it back to the way you had it.  No differences, still got a
>>> TON of EVTERRs.
>> This might be related to SDMA request when another is pending.
>>
>>>> How bigger is your audio buffer?
>>>> In your case I guess you will need something like 16KHz * 16 channels *
>>>> 2 bytes (16bits) = 512K minimum.
>>>> I would try to start from 1MB or maybe more.
>>> That's 2 seconds of audio!  We definitely need less buffering than
>>> that.    We pretty much need a latency of 100ms, worst case, or 1600
>>> frames, or 51,200 bytes.
>> I haven't checked in detail how the DAI buffering is working, but likely
>> the samples are passed not in buffer size chunks but instead with less
>> granularity. Having a large buffer gives more chance to the SSI to not
>> overlap DMA requests, hence no more EVTERRs.
>>
>> I would give it a try.
>>> I did change the max buffer size to 1MB though, but I'm not sure how
>>> much is actually being used.
>> I guess it's 64K, look for IMX_SSI_DMABUF_SIZE.
>>
>>
> Exactly, I changed that to 1024*1024, but still I don't get zero
> EVTERRs, even when I set my periods long and number of periods high.

They decreased?
