From: Simran Rai <simran.rai@broadcom.com>
Subject: Re: [PATCH resend v5 2/3] ASoC: cygnus: Add Cygnus
	audio DAI driver
Date: Wed, 30 Mar 2016 16:50:59 -0700
Message-ID: <CAES42NYpsV-1eePzoee+JO_FnAVyzM2z_mUuT4g7AvdwwVHdTA@mail.gmail.com>
References: <1459277192-10942-1-git-send-email-simran.rai@broadcom.com>
 <1459277192-10942-3-git-send-email-simran.rai@broadcom.com>
 <20160329221634.GQ2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id E964D266610
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 01:51:39 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id o62so37761857oig.1
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 16:51:39 -0700 (PDT)
In-Reply-To: <20160329221634.GQ2350@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lori Hikichi <lhikichi@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Kumar Gala <galak@codeaurora.org>, Arun Parameswaran <arunp@broadcom.com>, linux-arm-kernel@lists.infradead.org, Simran Rai <ssimran@broadcom.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, Mar 29, 2016 at 3:16 PM, Mark Brown <broonie@kernel.org> wrote:

> On Tue, Mar 29, 2016 at 11:46:31AM -0700, Simran Rai wrote:
>
> A few issues here, a lot of them are stylistic though there's what look
> like a couple of small bugs here too.
>
> > +static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio,
> > +                     struct cygnus_audio *cygaud)
> > +{
> > +     u32 value, i = 0;
> > +     u32 mask = 0xf;
> > +     u32 sclk;
> > +     bool found = false;
> > +     const struct _ssp_clk_coeff *p_entry = NULL;
> > +
> > +     if ((!aio->lrclk) || (!aio->bit_per_frame)) {
> > +             dev_err(aio->cygaud->dev, "First set up port through
> hw_params()\n");
> > +             return -EINVAL;
> > +     }
>
> This function is only ever called from one site in hw_prams().  What is
> this defending against?  A check like this seems very worrying, if it
> ever goes off that seems to indicate either something is seriously wrong
> or we should be recording something then coming back and trying again
> later.
>
Will remove it.
>
>
> > +     for (i = 0; i < ARRAY_SIZE(ssp_clk_coeff); i++) {
> > +             p_entry = &ssp_clk_coeff[i];
> > +             if ((p_entry->rate == aio->lrclk) &&
> > +                             (p_entry->sclk_rate == aio->bit_per_frame)
> &&
> > +                             (p_entry->mclk == aio->mclk)) {
>
> Why the strange indentation here?
>
Will fix this.
>
>
> > +     /* Set sclk rate */
> > +     if (aio->port_type == PORT_TDM) {
>
> switch statment here for extensibility.
>
Will replace if statement with switch statement
>
>
> > +             /* Configure channels as mono or stereo */
> > +             if (params_channels(params) == 1) {
> > +                     value = readl(aio->cygaud->audio +
> > +                             aio->regs.bf_sourcech_cfg);
> > +                     value |= BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
> > +                     value &= ~BIT(BF_SRC_CFGX_BUFFER_PAIR_ENABLE);
> > +                     writel(value, aio->cygaud->audio +
> > +                             aio->regs.bf_sourcech_cfg);
> > +             } else {
> > +                     value = readl(aio->cygaud->audio +
> > +                             aio->regs.bf_sourcech_cfg);
> > +                     value &= ~BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
> > +                     writel(value, aio->cygaud->audio +
> > +                             aio->regs.bf_sourcech_cfg);
> > +             }
>
> Either this should be a switch statement or the comment should say we
> support more than stereo.  It's also not clear to me how
> BUFFER_PAIR_ENABLE gets set again if we go from mono to stereo.
>
Will change to switch statement. Thanks for exposing the bug related to
BUFFER_PAIR_ENABLE. Will fix it.
>
>
> > +     if (!aio->is_slave) {
> > +             if (aio->clk_trace.cap_clk_en)
> > +                     clk_prepare_enable(aio->cygaud->
> > +                                     audio_clk[aio->pll_clk_num]);
>
> Should check the return value of clk_prepare_enable().
>
Will do.
>
>
> > +     .playback = {
> > +             .channels_min = 2,
> > +             .channels_max = 2,
> > +             .rates = CYGNUS_TDM_RATE | SNDRV_PCM_RATE_88200 |
> > +                     SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
> > +                     SNDRV_PCM_RATE_192000,
> > +             .formats = SNDRV_PCM_FMTBIT_S16_LE |
> > +                     SNDRV_PCM_FMTBIT_S32_LE,
>
> According to hw_params() the driver also supports S8 and S24.

 SSP and TDM playback supports S8, S16 and S32. SSP and TDM capture supports
S16 and S32. SPDIF playback supports S16 and S32. Will fix the code to
reflect this.

> > +     if (port_type == PORT_TDM) {
>
> > +     } else { /* SPDIF case */
>
> switch statement...
>
Will do.

Thanks,
Simran
