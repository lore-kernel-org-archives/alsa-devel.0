From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Fri, 30 Oct 2015 18:48:45 -0700
Message-ID: <20151031014845.GB3525@Asurada-CZ80>
References: <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX>
 <CAG5mAdwUKwzGvpO3ckKZWfE+oKXHK7umT5Z3Ru3Oyq8AD7gNMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id F28CF260462
 for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2015 02:48:49 +0100 (CET)
Received: by padhk11 with SMTP id hk11so89561313pad.1
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 18:48:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdwUKwzGvpO3ckKZWfE+oKXHK7umT5Z3Ru3Oyq8AD7gNMg@mail.gmail.com>
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

On Fri, Oct 30, 2015 at 03:04:37PM -0700, Caleb Crome wrote:
 
> **********************
> ** Problem 1 *******
> **********************
> When I enable your patch in single fifo mode we get maxburst lost
> samples at the beginning of the stream.  The important bit is below.
> It doesn't matter if the SSIEN comes before or after the TDMAE, the
> samples are lost.  Surely because something in the fsl_ssi_config
> clears the fifo.  I didn't look into that yet.

The config function has gone way complicated than I realized.
But you may need to dig a little bit to make a perfect point
to insert your change as it might break other platforms: AC97
and old i.MX and MPC.

> --------------------------- snip -------------------
> 
> If instead, I do the SSIEN at the bottom of the fsl_ssi_configure
> function like this, it works perfectly (in single fifo mode)
> 
> --------------------------- snip -------------------
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -435,8 +435,49 @@ static void fsl_ssi_config(struct fsl_ssi_private
> *ssi_private, bool enable,
> 
>  config_done:
>      /* Enabling of subunits is done after configuration */
> -    if (enable)
> +    if (enable) {
> +        /* eanble SSI */
> +        regmap_update_bits(regs, CCSR_SSI_SCR,
> +                   CCSR_SSI_SCR_SSIEN,
> +                   CCSR_SSI_SCR_SSIEN);
> +        /*
> +         * We must wait here until the DMA actually manages to
> +         * get a word into the Tx FIFO.  Only if starting a Tx
> +         * stream.
> +         * In tests on an MX6 at 1GHz clock speed, the do
> +         * loop below never iterated at all (i.e. it dropped
> +         * through without repeating ever.  which means that
> +         * the DMA has had time to get some words into the TX
> +         * buffer. In fact, the tfcnt0 was always 13, so it
> +         * was quite full by the time it reached this point,
> +         * so this do loop should never be a bottleneck.  If
> +         * max iterations is hit, then something might be
> +         * wrong.  report it in that case.
> +         */
> +        int tfcnt0 = 0;
> +        int tfcnt1 = 1;
> +        int max_iterations = 1000;
> +        if (vals->scr & CCSR_SSI_SCR_TE) {
> +            u32 sfcsr;
> +            do {
> +                regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
> +                tfcnt0 = CCSR_SSI_SFCSR_TFCNT0(sfcsr);
> +                tfcnt1 = CCSR_SSI_SFCSR_TFCNT0(sfcsr);
> +            } while(max_iterations-- && (tfcnt0 == 0) && (tfcnt1 == 0));
> +        }
> +        if (max_iterations <= 0) {
> +            /*
> +             * The DMA definitely should have stuck at
> +             * least a word into the FIFO by now.  Report
> +             * an error, but continue on blindly anyway,
> +             * even though the SSI might not start right.
> +             */
> +            struct platform_device *pdev = ssi_private->pdev;
> +            dev_err(&pdev->dev, "max_iterations reached when"
> +                "starting SSI Tx\n");
> +        }

Looks like polling is the only way to safely kick off. It's okay.
But I would like to see how the change will be after merging the
simultaneous TE/RE work around. It may need go a long way with
other platform users.
