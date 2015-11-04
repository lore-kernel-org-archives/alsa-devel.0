From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Wed, 4 Nov 2015 09:58:16 -0800
Message-ID: <20151104175815.GB3794@Asurada-CZ80>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 15DD1260537
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 18:58:21 +0100 (CET)
Received: by pasz6 with SMTP id z6so61055489pas.2
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2015 09:58:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <563A253C.7080709@tekno-soft.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 04, 2015 at 04:33:16PM +0100, Roberto Fichera wrote:
 
> With the patch below I'm able to see the error happening. And more likely it happen just just afterwards
> the EVTERR notify the problem to the ISR. At this point the DMA simply stalls due to some problems, most
> likely because the SSI FIFO is in overflow or underflow condition. I will do add the code to dump the SSI

No, SSI FIFO under/overflow were caused by the DMA stall as their
channels got error out -- SSI was still consuming the TX FIFO and
filling the RX FIFO while DMA didn't move the data at all so SSI
FIFOs got under/overflowed.

> I think that at this point we should in theory restart the DMA channel, but however how to fix this and
> why this is happening?

According to Reference Manual:
----

1) The CHNERR[i] bit is set when a DMA request that triggers channel
i is received through the corresponding input pins and the EP[i]
bit is already set;

2) Externally triggered channel pending flag EP[i] is set by the
scheduler when the channel was activated by a DMA request. It can
be cleared by the ith channel script.

----

It looks like your system made another DMA request while the SDMA
was still in the middle of the transaction for the same channel.
I guess you should find a way to make less frequent DMA requests,
making higher watermarks and larger burst size for example.
