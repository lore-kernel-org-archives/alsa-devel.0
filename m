From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Fri, 31 Mar 2017 18:20:40 -0700
Message-ID: <20170401012039.GA31667@Asurada-Nvidia>
References: <1490998503-1191-1-git-send-email-festevam@gmail.com>
 <20170331235329.GA7627@Asurada-Nvidia>
 <CAOMZO5AYLcXyD9K5KoO1Wcr2wrmFbJEe0ad3r3L0nLY6R10fSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id BE92F2668F6
 for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2017 03:20:42 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id 79so20772061pgf.0
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 18:20:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AYLcXyD9K5KoO1Wcr2wrmFbJEe0ad3r3L0nLY6R10fSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Fabio Estevam <fabio.estevam@nxp.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Mar 31, 2017 at 09:59:46PM -0300, Fabio Estevam wrote:

> >> +#define FSLSSI_SSIEN_WORKAROUND (CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | \
> >> +                              CCSR_SSI_SCR_RE)
> >
> > Enable RE??
> 
> Yes, same idea as in f8fdf5375e2005f2 ("ASoC: fsl-ssi: add SSIEN
> errata work around").
> 
> The idea here was not to restrict the erratum to AC97 mode only.

I understood. Just enabling RE anyway (for I2S) had confused me.

> >> @@ -559,7 +562,8 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
> >>                       int i;
> >>                       int max_loop = 100;
> >>                       regmap_update_bits(regs, CCSR_SSI_SCR,
> >> -                                     CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
> >> +                                        FSLSSI_SSIEN_WORKAROUND,
> >> +                                        FSLSSI_SSIEN_WORKAROUND);
> >>                       for (i = 0; i < max_loop; i++) {
> >>                               u32 sfcsr;
> >>                               regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
> >
> > If this change is made, the whole "if (enable)" part here seems
> > to be meaningless (or even worse) as it aimed to set TE later
> > than SSIEN so as to offset the delay from DMA TX.
> >
> > Check: https://patchwork.kernel.org/patch/9091051/
> >
> > If this errata is mandatory, we probably should revert that the
> > commit and find other solution/workaround for Arnaud and Caleb.
> 
> Reverting 61fcf10a0ee44763e0 ("ASoC: fsl_ssi: Fix channel slipping in
> Playback at startup") still causes channel swaps on my tests, so
> better not to revert it.

That sounds weird to me. Prior to that commit, the code was setting
SSIEN and TE at the same time if I am not wrong. You could try to
revert it and check the SCR value before/after the last line:
    regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
