From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Wed, 4 Nov 2015 10:11:45 -0800
Message-ID: <20151104181144.GA4057@Asurada-CZ80>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it> <563A380E.8060406@tekno-soft.it>
 <CAG5mAdw_VZFjKz7_H+jg=48-Y3uG1-xGT2P8M1cGm8PQqunkzQ@mail.gmail.com>
 <563A45CC.2070605@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E9816260537
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 19:11:50 +0100 (CET)
Received: by padhx2 with SMTP id hx2so51612452pad.1
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2015 10:11:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <563A45CC.2070605@tekno-soft.it>
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

On Wed, Nov 04, 2015 at 06:52:12PM +0100, Roberto Fichera wrote:

> > I notice your DMA buffer length is very short, which would require
> > very frequency interrupts to service, right?   Can you increase your
> > DMA buffer length by increasing the period size?  Maybe that would
> > help reduce the likelyhood of a failure.  
> 
> Not sure if this can help! SSI TDM is set to 32 slots but only 2 are masked. So every frame only
> 2 slots are pushed/pulled from the FIFOs. maxburst is set to pull a block of 8 elements from the
> FIFOs, DMA cyclic call it period. So the full DMA buffer is filled in buffer size / period DMA iterations.

A smaller period size may course DMA buffer over/underrun -- ALSA
over/underrun even though it seems that you didn't report any.

And apparently SDMA would get more interrupt/callbacks. I would
suggest a larger period size and buffer size although I cannot
tie your problem with the size. But you may try.
