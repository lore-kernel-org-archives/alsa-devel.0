From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Wed, 4 Nov 2015 19:09:14 +0100
Message-ID: <563A49CA.8090501@tekno-soft.it>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it> <20151104175815.GB3794@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id ADEB8260537
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 19:09:35 +0100 (CET)
In-Reply-To: <20151104175815.GB3794@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/04/2015 06:58 PM, Nicolin Chen wrote:
> On Wed, Nov 04, 2015 at 04:33:16PM +0100, Roberto Fichera wrote:
>  
>> With the patch below I'm able to see the error happening. And more likely it happen just just afterwards
>> the EVTERR notify the problem to the ISR. At this point the DMA simply stalls due to some problems, most
>> likely because the SSI FIFO is in overflow or underflow condition. I will do add the code to dump the SSI
> No, SSI FIFO under/overflow were caused by the DMA stall as their
> channels got error out -- SSI was still consuming the TX FIFO and
> filling the RX FIFO while DMA didn't move the data at all so SSI
> FIFOs got under/overflowed.

Yeah! The SSI is correctly reporting this problem because DMA is stalled for some reason.

>
>> I think that at this point we should in theory restart the DMA channel, but however how to fix this and
>> why this is happening?
> According to Reference Manual:
> ----
>
> 1) The CHNERR[i] bit is set when a DMA request that triggers channel
> i is received through the corresponding input pins and the EP[i]
> bit is already set;
>
> 2) Externally triggered channel pending flag EP[i] is set by the
> scheduler when the channel was activated by a DMA request. It can
> be cleared by the ith channel script.
>
> ----
>
> It looks like your system made another DMA request while the SDMA
> was still in the middle of the transaction for the same channel.

I don't know because this is something I cannot control. I'm just setting up 2 cyclic dma
for both TX and RX before to set both RDMAE and TDMAE and nothing else. The rest
is done by the SDMA ISR.

> I guess you should find a way to make less frequent DMA requests,
> making higher watermarks and larger burst size for example.
>
I can try to increase the FIFO watermark up to 15 elements, but after that
I don't have more choices. The problem is that the TDM has to run continuously
because the SLIC need it. I can eventually enable and disable the DMA requests
depending by the active channels for optimization, but the problem still,why the
DMA transfer is not triggered?
