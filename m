From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode
 support for SSI on i.MX series
Date: Fri, 13 Jun 2014 11:21:20 +0800
Message-ID: <20140613032119.GA15609@MrMyself>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
 <CAOZdJXWsxMq19-wNTKv6d45K4d79ASpMbSbofM+DMoTOKW2JJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 by alsa0.perex.cz (Postfix) with ESMTP id B10E92610A0
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 05:35:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOZdJXWsxMq19-wNTKv6d45K4d79ASpMbSbofM+DMoTOKW2JJA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Sir,

On Thu, Jun 12, 2014 at 10:24:55PM -0500, Timur Tabi wrote:
> On Thu, Dec 12, 2013 at 4:44 AM, Nicolin Chen
> <Guangyu.Chen@freescale.com> wrote:
> >
> > +static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> > +                                 int clk_id, unsigned int freq, int dir)
> > +{
> > +       struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> > +       struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> > +       int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
> > +       u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
> > +       unsigned long flags, clkrate, baudrate, tmprate;
> > +       u64 sub, savesub = 100000;
> > +
> > +       /* Don't apply it to any non-baudclk circumstance */
> > +       if (IS_ERR(ssi_private->baudclk))
> > +               return -EINVAL;
> > +
> > +       /* It should be already enough to divide clock by setting pm alone */
> > +       psr = 0;
> > +       div2 = 0;
> > +
> > +       factor = (div2 + 1) * (7 * psr + 1) * 2;
> > +
> > +       for (i = 0; i < 255; i++) {
> > +               /* The bclk rate must be smaller than 1/5 sysclk rate */
> > +               if (factor * (i + 1) < 5)
> > +                       continue;
> > +
> > +               tmprate = freq * factor * (i + 2);
> > +               clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
> > +
> > +               do_div(clkrate, factor);
> 
> This do_div() call causes this warning on PowerPC:
> 
>   CC      sound/soc/fsl/fsl_ssi.o
> sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_set_bclk':
> sound/soc/fsl/fsl_ssi.c:593:3: warning: comparison of distinct pointer
> types lacks a cast
> sound/soc/fsl/fsl_ssi.c:593:3: warning: right shift count >= width of type
> sound/soc/fsl/fsl_ssi.c:593:3: warning: passing argument 1 of
> '__div64_32' from incompatible pointer type
> include/asm-generic/div64.h:35:17: note: expected 'uint64_t *' but
> argument is of type 'long unsigned int *'
> 
> The comments in do_div() say that clkrate should be 64-bits.  Changing
> clkrate to a u64 does fix this problem, but I'm wondering if anyone
> else has seen this.  This code has been around for months.

It compiles well with my ARM cross compiler. I guess it might be related
to the compiler's version? But we should fix it anyway. Would you mind if
I submit a patch? Or you do it directly?

Thank you,
Nicolin
