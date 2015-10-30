From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Fri, 30 Oct 2015 11:10:28 -0700
Message-ID: <CAG5mAdySHyZUnXhzwrFNkvbo9Cc2GOYHNLQYeArdaFPoL4CDtg@mail.gmail.com>
References: <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX> <56332A4E.3010704@invoxia.com>
 <20151030154946.GA3505@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 329C926067B
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 19:10:48 +0100 (CET)
Received: by wmff134 with SMTP id f134so17714308wmf.1
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 11:10:48 -0700 (PDT)
In-Reply-To: <20151030154946.GA3505@Asurada-CZ80>
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

On Fri, Oct 30, 2015 at 8:49 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Fri, Oct 30, 2015 at 09:29:02AM +0100, arnaud.mouiche@invoxia.com wrote:
>
>> At imx50 age, I remember one workaround was to fill the fifo
>> manually, writing directly a number of samples (equal to the number
>> of slots for one frame to keep the synchronization), and then,
>> enable the TMDAE.
>> This just allow to not have to wait an undefined period of time for
>> the DMA to be ready.
>> But, on the other hand, if the time to wait the DMA is short enough,
>> it should not be an issue.
>
> Nice input. This reminds me of the zero-filling step inside the
> ESAI startup procedure:
>
>         case SNDRV_PCM_TRIGGER_START:
>         case SNDRV_PCM_TRIGGER_RESUME:
>         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>                 regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
>                                    ESAI_xFCR_xFEN_MASK, ESAI_xFCR_xFEN);
>
>                 /* Write initial words reqiured by ESAI as normal procedure */
>                 for (i = 0; tx && i < channels; i++)
>                         regmap_write(esai_priv->regmap, REG_ESAI_ETDR, 0x0);
>
>                 regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>                                    tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
>                                    tx ? ESAI_xCR_TE(pins) : ESAI_xCR_RE(pins));
>                 break;
>
> It's exactly the same thing to prevent underrun. This might be
> a reasonable alternative option due to no polling overhead and
> timeout handling.
>
> Thanks
> Nicolin

Interesting, but in the SSI case, the # channels can easily be larger
than the fifo size.  For example, I'm using 16 channels, and the fifo
size is only 15.  Of course, with the dual fifo enabled, then this
restriction is eased to a maximum # of slots of 30.

I'll do a quick check this morning with Nicolin's suggested patch, and
see how many loops it needs to poll before the fifo gets a word.  My
suspicion is that Nicolin's hunch is correct: that is,  that the
context switch provides enough time for the DMA to push a word.

Will check back shortly.

Then, we'll have the problem that Arnaud bring up -- when starting the
Rx after Tx, we will have fresh new problems.  In fact, I'm 100% sure
we will -- I already see it with a portaudio program that must bring
up tx and rx separately.  I think I'll start a new thread for that
problem once this one is put to bed.

-Caleb
