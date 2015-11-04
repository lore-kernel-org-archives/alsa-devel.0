From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Wed, 4 Nov 2015 18:52:12 +0100
Message-ID: <563A45CC.2070605@tekno-soft.it>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it> <563A380E.8060406@tekno-soft.it>
 <CAG5mAdw_VZFjKz7_H+jg=48-Y3uG1-xGT2P8M1cGm8PQqunkzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C8F4260537
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 18:52:32 +0100 (CET)
In-Reply-To: <CAG5mAdw_VZFjKz7_H+jg=48-Y3uG1-xGT2P8M1cGm8PQqunkzQ@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/04/2015 06:41 PM, Caleb Crome wrote:
> On Wed, Nov 4, 2015 at 8:53 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>> On 11/04/2015 04:33 PM, Roberto Fichera wrote:
>>>         *RX DMA frame count=36795*
>>>         RX DMA addr=0x9ef0e000
>>>         RX DMA buffer len=16
>>>         *TX DMA frame count=36795*
>>>         TX DMA addr=0x9ee49000
>>>         TX DMA buffer len=16
>
> I notice your DMA buffer length is very short, which would require
> very frequency interrupts to service, right?   Can you increase your
> DMA buffer length by increasing the period size?  Maybe that would
> help reduce the likelyhood of a failure.  

Not sure if this can help! SSI TDM is set to 32 slots but only 2 are masked. So every frame only
2 slots are pushed/pulled from the FIFOs. maxburst is set to pull a block of 8 elements from the
FIFOs, DMA cyclic call it period. So the full DMA buffer is filled in buffer size / period DMA iterations.

> Although it would be good to
> be able to recover from a failure gracefully.

Yep! I will try to restart the DMA channels from a failure to see if this might work or not.

> -Caleb
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
