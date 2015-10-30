From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Fri, 30 Oct 2015 10:21:41 -0700
Message-ID: <20151030172141.GA4193@Asurada-CZ80>
References: <20151027071344.GC25728@pengutronix.de>
 <CAOMZO5DPL6H+Ahz_32Zn8AmDU8muGnVQG_owrGXtDQ1MQXcQ5g@mail.gmail.com>
 <CAG5mAdzxHTqYf0MjogUPYKze9WqKaKXpQvqSvvmSBZJORAQz2Q@mail.gmail.com>
 <CAOMZO5D0Xqpv2LDHfgWf87b8YwaZy424q_9wLTh8bYzoqJwq3g@mail.gmail.com>
 <CAG5mAdxAgyC4YNK80bu=JubPV1CfSiazf9QdWjgVFsgvzdGM8A@mail.gmail.com>
 <CAOMZO5CmALnrsCyTwd+v4NvLzZc1QuoSL8vDLi6z9s4mGTMV9g@mail.gmail.com>
 <CAOMZO5AOPSDH55mkJPbmn_VyNc173cFY6Uykg74-BznxWmwOvg@mail.gmail.com>
 <5630833B.10309@tekno-soft.it>
 <20151029230404.GB44369@Asurada-CZ80>
 <563357BD.6020202@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB0D260663
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 18:21:48 +0100 (CET)
Received: by pacfv9 with SMTP id fv9so83165012pac.3
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 10:21:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <563357BD.6020202@tekno-soft.it>
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

On Fri, Oct 30, 2015 at 12:42:53PM +0100, Roberto Fichera wrote:


>         /*
>          * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
>          * don't use FIFO 1.  We program the transmit water to signal a
>          * DMA transfer if there are only two (or fewer) elements left
>          * in the FIFO. 
>          */

> SSI clock calculated and then enabled. Both TX and RX DMA channel are requested in the probe() function as below.
> and the corresponding TX and RX SDMA event in DTS are using the default from imx6sx.dtsi:

Since you are using single FIFO configuration, which SDMA script
are you using? This should reflects in the Device Tree. As far as
I learned, FSL 3.14 is using number 22 for SSIs which is the one
for Dual FIFO Mode.

> At this time I should see the DMA callbacks called every burst_size words. This behaviour
> doesn't really happen as I wish because I can see from a proc file that such callbacks
> are called from 1 to 20000 times and then anymore. This is also confirmed by the fact that
> the interrupt 34 (sdma) doesn't increase anymore but matches my internal counters collected
> within my callbacks. Here is what I can inspect from the data I have collected:

Just for clarification, the behaviour doesn't happen as you wish
is just the DMA stopped? I remember you also mentioned bit clock
has stopped as you can check the clock status from the Codec chip.

> SSI Registers:
>         ssi_sfcsr=0x0088f088

At this point you have data in RxFIFO and get empty in TxFIFO, so
the DMA requests from both side should be issued. If the DMA stops
as you described, you must check those two channels from the SDMA
side by dumping SDMAARM_STOP_STAT, SDMAARM_HSTART, SDMAARM_EVTOVR,
SDMAARM_EVTPEND, SDMAARM_EVTERR, SDMAARM_DSPOVR and SDMAARM_HOSTOVR
registers.

Overall, I don't see an obvious defect from you SSI side, but you
may also try to toggle TDMAE and RDMAE at the point that callback
stops -- re-raise the DMA requests by disabling and enabling TDMAE
and RDMAE again and see if it works. I think either something did
intervene register controls of SDMA or SSI, or SDMA have missed the
request signals from SSI.
