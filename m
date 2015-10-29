From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 15:47:14 -0700
Message-ID: <20151029224713.GA44369@Asurada-CZ80>
References: <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id EBF162651A5
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 23:47:20 +0100 (CET)
Received: by pacfv9 with SMTP id fv9so55444167pac.3
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 15:47:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2015 at 03:23:41PM -0700, Caleb Crome wrote:

> > I saw your problem in the other reply. And I suggested you to let
> > DMA work first before SSI gets enabled. As SDMA in that case would
> > transfer one burst length (16 if you applied my patch I sent you)
> > and pause before SSI gets enabled. Then SSI would have enough data
> > to send out without any startup issue.
> 
> Ah ha, you are exactly right.  The root cause is that TE and SSIE are
> enabled at the same regmap write, with no opportunity for delay
> between the SSIE and TE.
> DMA can only get going if SSIE is enabled, and the only place SSIE
> gets enabled is exactly the same line that TE gets enabled.

A little difference between your point and mine is that you think
DMA request only starts when SSIE and TDMAE both get set while I
only think about TDMAE. It's hard to say which one is correct as
it depends on the design of IP wrapper but you can fairly test it
with your change below: Mask both TE with SSIE and set them after
the delay. If it doesn't work, yours is the correct one.

> I've looked over your emails and I don't see the patch that shows a

You may need to open an offline email that I sent you with patches
in its attachment. I can see it via Gmail anyway.

> pause between SSIE enable and TE enable.  (I do see the dual-fifo
> example -- thank you!  I'll give that a try -- it may further reduce
> stress on the system).

I'm sure dual FIFO will get better performance. But the example I
gave you doesn't set RX parameters so well. You may need to fine
tune it later.

> Is adding the udelay the best way to put a delay between SSIE and TE enable?
> Are there any other mechanisms for that?

Having a delay is much safer for you but surely it's not a common
practice that's best all other platforms such as two-channel cases
and those who needs performance.

I encourage you to try to follow one of patches I gave you that
sets TDMAE/RDMAE at the beginning of the trigger(). Surely you may
change it to TDMAE | SSIE after you find out that SSIE is indeed
required. If you are still having trouble, adding a delay would
be nice for you but it may be hard for me to ack it if you want
to merge it in the driver.

Nicolin
