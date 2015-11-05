From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Thu, 5 Nov 2015 11:03:30 +0100
Message-ID: <563B2972.10202@tekno-soft.it>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it> <563A380E.8060406@tekno-soft.it>
 <CAG5mAdw_VZFjKz7_H+jg=48-Y3uG1-xGT2P8M1cGm8PQqunkzQ@mail.gmail.com>
 <563A45CC.2070605@tekno-soft.it> <20151104181144.GA4057@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 56EA026531B
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 11:03:51 +0100 (CET)
In-Reply-To: <20151104181144.GA4057@Asurada-CZ80>
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

On 11/04/2015 07:11 PM, Nicolin Chen wrote:
> On Wed, Nov 04, 2015 at 06:52:12PM +0100, Roberto Fichera wrote:
>
>>> I notice your DMA buffer length is very short, which would require
>>> very frequency interrupts to service, right?   Can you increase your
>>> DMA buffer length by increasing the period size?  Maybe that would
>>> help reduce the likelyhood of a failure.  
>> Not sure if this can help! SSI TDM is set to 32 slots but only 2 are masked. So every frame only
>> 2 slots are pushed/pulled from the FIFOs. maxburst is set to pull a block of 8 elements from the
>> FIFOs, DMA cyclic call it period. So the full DMA buffer is filled in buffer size / period DMA iterations.
> A smaller period size may course DMA buffer over/underrun -- ALSA
> over/underrun even though it seems that you didn't report any.
>
> And apparently SDMA would get more interrupt/callbacks. I would
> suggest a larger period size and buffer size although I cannot
> tie your problem with the size. But you may try.
>

Following your suggestion, I've increased the buffer size to 2K and set the period to fifo_length - 2 (13),
with that I'm now running substantially smooth except 3 EVTERR on RX DMA over 4 million of interrupts.

Thanks Nicolin! I'm quite happy now!
