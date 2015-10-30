From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 18:29:35 -0700
Message-ID: <20151030012934.GA5456@Asurada-GSX>
References: <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B102265917
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 02:29:40 +0100 (CET)
Received: by padhk11 with SMTP id hk11so57008890pad.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 18:29:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
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

On Thu, Oct 29, 2015 at 04:33:26PM -0700, Caleb Crome wrote:

> > A little difference between your point and mine is that you think
> > DMA request only starts when SSIE and TDMAE both get set while I
> > only think about TDMAE. It's hard to say which one is correct as
> > it depends on the design of IP wrapper but you can fairly test it
> > with your change below: Mask both TE with SSIE and set them after
> > the delay. If it doesn't work, yours is the correct one.
> 
> Ah, that's one thing that's very clear in the FSL datasheet:  the
> FIFOs are ZEROED if SSIE is 0.  This means that even if the DMA were
> trying to dump data in before SSIE is enabled, the data would go to
> bit heaven.
> 
> The docs for TE say, "The normal transmit enable sequence is to write
> data to the STX register(s) and then set the TE bit." (page 5145 of
> IMX6SDLRM.pdf)
> 
> So in the DMA + fifo case the words, "write data to the STX
> register(s)" imply that it's actually DMA writing to FIFOs, which then
> write the STX register.  So, the sequence must be:  enable SSIE &
> TDMAE to allow DMA to write to the fifo, then later enable TE, right?

You have the point. If SSIEN is being treated as the reset signal
internally, any write enable signal could be ignored.

> > I encourage you to try to follow one of patches I gave you that
> > sets TDMAE/RDMAE at the beginning of the trigger(). Surely you may
> > change it to TDMAE | SSIE after you find out that SSIE is indeed
> > required. If you are still having trouble, adding a delay would
> > be nice for you but it may be hard for me to ack it if you want
> > to merge it in the driver.
> 
> I now I see your patch!  Okay, I'll give that a go, but it's still
> just a race condition between the regmap_update_bits with TDMAE (your
> patch) verses the regmap_update_bits from fsl_ssi_config. You're just
> hoping that a DMA write happens between TDMAE and the end of
> fsl_ssi_config where TE is enabled.

DMA transaction will be issued once BD is ready (in SDMA driver)
and SSI sends a DMA request. So I'm hoping that the context
latency between the regmap_update_bits() and TE setting should be
enough for DMA to fill the FIFO.

> Now I think I get it though.  We do TMDAE + SSIEN like your patch,
> then a short while loop on SFCSR.TFCNT0.  After the first word gets
> written to the fifo, TFCNT0 should go > 0, and then we can release TE.
> 
> There may be a better status register to wait on but TFCNT0 seems like
> it will do the trick.

Waiting for TFCNT0 sounds reasonable to me as long as the code is
well commented.
