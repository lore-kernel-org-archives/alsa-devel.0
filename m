From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 16:33:26 -0700
Message-ID: <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
References: <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 09818265891
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 00:33:47 +0100 (CET)
Received: by wmeg8 with SMTP id g8so121234wme.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 16:33:46 -0700 (PDT)
In-Reply-To: <20151029224713.GA44369@Asurada-CZ80>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2015 at 3:47 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Thu, Oct 29, 2015 at 03:23:41PM -0700, Caleb Crome wrote:
>
>> > I saw your problem in the other reply. And I suggested you to let
>> > DMA work first before SSI gets enabled. As SDMA in that case would
>> > transfer one burst length (16 if you applied my patch I sent you)
>> > and pause before SSI gets enabled. Then SSI would have enough data
>> > to send out without any startup issue.
>>
>> Ah ha, you are exactly right.  The root cause is that TE and SSIE are
>> enabled at the same regmap write, with no opportunity for delay
>> between the SSIE and TE.
>> DMA can only get going if SSIE is enabled, and the only place SSIE
>> gets enabled is exactly the same line that TE gets enabled.
>
> A little difference between your point and mine is that you think
> DMA request only starts when SSIE and TDMAE both get set while I
> only think about TDMAE. It's hard to say which one is correct as
> it depends on the design of IP wrapper but you can fairly test it
> with your change below: Mask both TE with SSIE and set them after
> the delay. If it doesn't work, yours is the correct one.

Ah, that's one thing that's very clear in the FSL datasheet:  the
FIFOs are ZEROED if SSIE is 0.  This means that even if the DMA were
trying to dump data in before SSIE is enabled, the data would go to
bit heaven.

The docs for TE say, "The normal transmit enable sequence is to write
data to the STX register(s) and then set the TE bit." (page 5145 of
IMX6SDLRM.pdf)

So in the DMA + fifo case the words, "write data to the STX
register(s)" imply that it's actually DMA writing to FIFOs, which then
write the STX register.  So, the sequence must be:  enable SSIE &
TDMAE to allow DMA to write to the fifo, then later enable TE, right?

>
>> I've looked over your emails and I don't see the patch that shows a
>
> You may need to open an offline email that I sent you with patches
> in its attachment. I can see it via Gmail anyway.

Will do.  Thanks.

>
>> pause between SSIE enable and TE enable.  (I do see the dual-fifo
>> example -- thank you!  I'll give that a try -- it may further reduce
>> stress on the system).
>
> I'm sure dual FIFO will get better performance. But the example I
> gave you doesn't set RX parameters so well. You may need to fine
> tune it later.
>
>> Is adding the udelay the best way to put a delay between SSIE and TE enable?
>> Are there any other mechanisms for that?
>
> Having a delay is much safer for you but surely it's not a common
> practice that's best all other platforms such as two-channel cases
> and those who needs performance.
>
> I encourage you to try to follow one of patches I gave you that
> sets TDMAE/RDMAE at the beginning of the trigger(). Surely you may
> change it to TDMAE | SSIE after you find out that SSIE is indeed
> required. If you are still having trouble, adding a delay would
> be nice for you but it may be hard for me to ack it if you want
> to merge it in the driver.

I now I see your patch!  Okay, I'll give that a go, but it's still
just a race condition between the regmap_update_bits with TDMAE (your
patch) verses the regmap_update_bits from fsl_ssi_config. You're just
hoping that a DMA write happens between TDMAE and the end of
fsl_ssi_config where TE is enabled.

Now I think I get it though.  We do TMDAE + SSIEN like your patch,
then a short while loop on SFCSR.TFCNT0.  After the first word gets
written to the fifo, TFCNT0 should go > 0, and then we can release TE.

There may be a better status register to wait on but TFCNT0 seems like
it will do the trick.

What do you think of that solution?  Any better register to wait on?
Would that be acceptable to merge into the driver?

Thanks,
  -Caleb

>
> Nicolin
