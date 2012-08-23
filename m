From: George Stefan <stefan.george87@gmail.com>
Subject: Re: SAIF configuration on imx28
Date: Thu, 23 Aug 2012 12:15:05 +0300
Message-ID: <CAACwSTL4MG3opgQTve9k1nt1eZbpTJcn7Fw84GQufW8+J-qg3Q@mail.gmail.com>
References: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
 <CAOMZO5C9ezzU7S0M-AN0f8gk7SBWs3WNbA6cG2S+7BF8j+dVxA@mail.gmail.com>
 <CAACwSTKiN17gAHnUs5BoHZH_K5NNo0z7X9QbVRFu9FZGCUw2mg@mail.gmail.com>
 <CAACwST+=owJQ+KGAKYLgpGY4k1hGNSC4ptSGMyVObSRpUightQ@mail.gmail.com>
 <CAOMZO5BGiU7J6W8TSybe8ELqnfLD=SYf9c_uVz6ppb4E2MOnzw@mail.gmail.com>
 <CAACwSTKkNFw9kC54VJ8en+tWpO9vpnHsszfyDtufWDeWhZCY5Q@mail.gmail.com>
 <20120823064844.GD10057@shlinux2.ap.freescale.net>
 <CAACwSTLLKCKj8rOfvqVZ5zCBTCUaFEJMEeA3oNBgnQRHFtciKQ@mail.gmail.com>
 <20120823074617.GI10057@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BB592661AE
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 11:15:05 +0200 (CEST)
Received: by eaa13 with SMTP id 13so114903eaa.38
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 02:15:05 -0700 (PDT)
In-Reply-To: <20120823074617.GI10057@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Fabio Estevam <festevam@gmail.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

2012/8/23 Dong Aisheng <b29396@freescale.com>

> On Thu, Aug 23, 2012 at 03:13:11PM +0800, George Stefan wrote:
> >    2012/8/23 Dong Aisheng <b29396@freescale.com>
> >
> >      On Thu, Aug 23, 2012 at 02:41:30PM +0800, George Stefan wrote:
> >      ...
> >      >    /*set the saif clk mux, saif0/saif1 both use saif0 clk*/
> >      >    __raw_writel(BF_DIGCTL_CTRL_SAIF_CLKMUX_SEL(0x0),
>   \
> >      Should this be 0x2 if both saif0 and saif1 are using saif0 clk?
> >      >    IO_ADDRESS(DIGCTL_PHYS_ADDR) + HW_DIGCTL_CTRL);
> >      >    Using this configuration i am not able to receive IRQs from
> DMA and
> >      i
> >      >    think the reason
> >      >    is that SAIF is not receiving the CLK.
> >      >    What do you think?
> >      >    Thanks,
> >      >    George.
> >
> >      Regards
> >      Dong Aisheng
> >
> >    Yes, it should be 0x2 if they are using saif0 clk. but it they are
> using
> >    the CLK from an external device
> >    which is master, i think that they should use an independent clock.
> >    "In slave clocking mode, the SAIF configures the BITCLK and LRCLK
> pins as
> >    inputs, and
> >    the off-chip codec is responsible for driving both clocks to the
> >    SAIF"(imx28 reference manual)
> >    0x0 - DIRECT - SAIF0 clock pins selected for SAIF0 input clocks, and
> SAIF1
> >    clock pins selected for
> >    SAIF1 input clocks.
> >    Am i interpreting this in the wrong way?
> Your understand is right if all are working on slave mode.
> But be noted that the current driver in mainline only supports master mode,
> mainly due to playback can not work on slave mode(see spec) while capture
> can.
> If all are in slave mode, that means the playback may not work.
> You should make sure if your requirements really wants that.
> And if you want to run in slave mode, you need change the mainline driver
> to support it.
>
> Regards
> Dong Aisheng
>
> The problem in using SAIF as master, is that in slave mode the modem uses
short frame sync(SND_SOC_DAIFMT_DSP_A),
which is not supported in the current driver.
