From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: Re: [PATCH] ASoC: DaVinci: Added support for stereo I2S
Date: Fri, 25 Jun 2010 10:03:46 +0200
Message-ID: <AANLkTinyQSbZm59JZvPvLVnJMELws1VAK7G5XRZyFFg_@mail.gmail.com>
References: <1277303635-5675-1-git-send-email-lamiaposta71@gmail.com>
	<1277326259.31686.57.camel@vega>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0925926302=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1277326259.31686.57.camel@vega>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: davinci-linux-open-source@linux.davincidsp.com, Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Troy Kisky <troy.kisky@boundarydevices.com>, Davide Bonfanti <davide.bonfanti@bticino.it>, Raffaele Recalcati <raffaele.recalcati@bticino.it>, Chaithrika U S <chaithrika@ti.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============0925926302==
Content-Type: multipart/alternative; boundary=001485f9a704dca66b0489d635b1

--001485f9a704dca66b0489d635b1
Content-Type: text/plain; charset=ISO-8859-1

Hi Liam,

2010/6/23 Liam Girdwood <lrg@slimlogic.co.uk>

> On Wed, 2010-06-23 at 16:33 +0200, Raffaele Recalcati wrote:
> > From: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> >
> >       Added audio playback support with [frame sync master - clock
> master] mode
> >       and with [frame sync master - clock slave].
> >       Clock slave can be important when the external codec need system
> clock
> >       and bit clock synchronized.
> >       In the clock master case there is a FIXME message in the source
> code, because we
> >       (Davide and myself) have guessed a frequency of 122000000 that
> seems the base
> >       to be divided.
> >       This patch has been developed against the
> >
> http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
> >       git tree and has been tested on bmx board (similar to dm365 evm,
> but using
> >       uda1345 as external audio codec).
> >
> > Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> > Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>
>
> Had a quick check, it looks like you have made some unintended
> formatting changes that make the patch look more complex than necessary.
>

I was making correction for keeping aligned my lines like these...
+                       srgr = DAVINCI_MCBSP_SRGR_FSGM |
+                              DAVINCI_MCBSP_SRGR_CLKSM;

and so I changed some existing ones...
but looking at CodingStyle and Greg notes, seems that, when breaking lines,
we need to keep alignment.
So maybe, if I'm right, in the future, we'll need to re-align all the file
with another patch..
I'll change anyway the code back to be simpler to be understood.


>
> > ---
> >  arch/arm/mach-davinci/include/mach/asp.h |    7 ++
> >  sound/soc/davinci/davinci-i2s.c          |  141
> ++++++++++++++++++++++++++----
> >  2 files changed, 129 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/include/mach/asp.h
> b/arch/arm/mach-davinci/include/mach/asp.h
> > index 834725f..b1faeb9 100644
> > --- a/arch/arm/mach-davinci/include/mach/asp.h
> > +++ b/arch/arm/mach-davinci/include/mach/asp.h
> > @@ -63,6 +63,13 @@ struct snd_platform_data {
> >       unsigned sram_size_playback;
> >       unsigned sram_size_capture;
> >
> > +     /*
> > +      * This define works when both clock and FS are output for the cpu
> > +      * and makes clock very fast (FS is not simmetrical, but sampling
> > +      * frequency is better approximated
> > +      */
> > +     int i2s_fast_clock;
> > +
> >       /* McASP specific fields */
> >       int tdm_slots;
> >       u8 op_mode;
> > diff --git a/sound/soc/davinci/davinci-i2s.c
> b/sound/soc/davinci/davinci-i2s.c
> > index adadcd3..8811d25 100644
> > --- a/sound/soc/davinci/davinci-i2s.c
> > +++ b/sound/soc/davinci/davinci-i2s.c
> > @@ -68,16 +68,23 @@
> >  #define DAVINCI_MCBSP_RCR_RDATDLY(v) ((v) << 16)
> >  #define DAVINCI_MCBSP_RCR_RFIG               (1 << 18)
> >  #define DAVINCI_MCBSP_RCR_RWDLEN2(v) ((v) << 21)
> > +#define DAVINCI_MCBSP_RCR_RFRLEN2(v) ((v) << 24)
> > +#define DAVINCI_MCBSP_RCR_RPHASE             (1 << 31)
> >
> >  #define DAVINCI_MCBSP_XCR_XWDLEN1(v) ((v) << 5)
> >  #define DAVINCI_MCBSP_XCR_XFRLEN1(v) ((v) << 8)
> >  #define DAVINCI_MCBSP_XCR_XDATDLY(v) ((v) << 16)
> >  #define DAVINCI_MCBSP_XCR_XFIG               (1 << 18)
> >  #define DAVINCI_MCBSP_XCR_XWDLEN2(v) ((v) << 21)
> > +#define DAVINCI_MCBSP_XCR_XFRLEN2(v) ((v) << 24)
> > +#define DAVINCI_MCBSP_XCR_XPHASE     (1 << 31)
> >
> > +
> > +#define CLKGDV(v)                            (v)     /* Bits 0:7 */
>
> Should you not have a DAVINCI prefix here too ?
>

Sorry, CLKGDV was not more used.
So I'm deleting it in the new patch coming today.


>
> >  #define DAVINCI_MCBSP_SRGR_FWID(v)   ((v) << 8)
> >  #define DAVINCI_MCBSP_SRGR_FPER(v)   ((v) << 16)
> >  #define DAVINCI_MCBSP_SRGR_FSGM              (1 << 28)
> > +#define DAVINCI_MCBSP_SRGR_CLKSM     (1 << 29)
> >
> >  #define DAVINCI_MCBSP_PCR_CLKRP              (1 << 0)
> >  #define DAVINCI_MCBSP_PCR_CLKXP              (1 << 1)
> > @@ -144,8 +151,17 @@ struct davinci_mcbsp_dev {
> >        * won't end up being swapped because of the underrun.
> >        */
> >       unsigned enable_channel_combine:1;
> > +
> > +     int i2s_fast_clock;
> > +};
> > +
> > +struct davinci_mcbsp_data {
> > +     unsigned int    fmt;
> > +     int             clk_div;
> >  };
> >
> > +static struct davinci_mcbsp_data mcbsp_data;
> > +
>
> This struct should be part of the dai private data.
>

done.


>
> >  static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev
> *dev,
> >                                          int reg, u32 val)
> >  {
> > @@ -255,24 +271,27 @@ static int davinci_i2s_set_dai_fmt(struct
> snd_soc_dai *cpu_dai,
> >       unsigned int pcr;
> >       unsigned int srgr;
> >       srgr = DAVINCI_MCBSP_SRGR_FSGM |
> > -             DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE * 2 - 1) |
> > -             DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
> > +            DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE * 2 - 1) |
> > +            DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
> > +     /* Attention srgr is updated by hw_params! */
> >
> > +     mcbsp_data.fmt = fmt;
> >       /* set master/slave audio interface */
> >       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > +     case SND_SOC_DAIFMT_CBS_CFM:
> >       case SND_SOC_DAIFMT_CBS_CFS:
> >               /* cpu is master */
> >               pcr = DAVINCI_MCBSP_PCR_FSXM |
> > -                     DAVINCI_MCBSP_PCR_FSRM |
> > -                     DAVINCI_MCBSP_PCR_CLKXM |
> > -                     DAVINCI_MCBSP_PCR_CLKRM;
> > +                   DAVINCI_MCBSP_PCR_FSRM |
> > +                   DAVINCI_MCBSP_PCR_CLKXM |
> > +                   DAVINCI_MCBSP_PCR_CLKRM;
> >               break;
> >       case SND_SOC_DAIFMT_CBM_CFS:
> >               /* McBSP CLKR pin is the input for the Sample Rate
> Generator.
> >                * McBSP FSR and FSX are driven by the Sample Rate
> Generator. */
> >               pcr = DAVINCI_MCBSP_PCR_SCLKME |
> > -                     DAVINCI_MCBSP_PCR_FSXM |
> > -                     DAVINCI_MCBSP_PCR_FSRM;
> > +                   DAVINCI_MCBSP_PCR_FSXM |
> > +                   DAVINCI_MCBSP_PCR_FSRM;
>
> These two just look like unintended formatting changes.
>

in next patch I'll remove these changes.


>
> >               break;
> >       case SND_SOC_DAIFMT_CBM_CFM:
> >               /* codec is master */
> > @@ -372,6 +391,17 @@ static int davinci_i2s_set_dai_fmt(struct
> snd_soc_dai *cpu_dai,
> >       return 0;
> >  }
> >
> > +static int davinci_i2s_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
> > +                             int div_id, int div)
> > +{
> > +     struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
> > +     int srgr;
> > +
> > +     mcbsp_data.clk_div = div;
> > +     return 0;
> > +}
> > +
> > +
> >  static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
> >                                struct snd_pcm_hw_params *params,
> >                                struct snd_soc_dai *dai)
> > @@ -380,11 +410,12 @@ static int davinci_i2s_hw_params(struct
> snd_pcm_substream *substream,
> >       struct davinci_pcm_dma_params *dma_params =
> >
> &dev->dma_params[substream->stream];
> >       struct snd_interval *i = NULL;
> > -     int mcbsp_word_length;
> > -     unsigned int rcr, xcr, srgr;
> > +     int mcbsp_word_length, master;
> > +     unsigned int rcr, xcr, srgr, clk_div, freq, framesize;
> >       u32 spcr;
> >       snd_pcm_format_t fmt;
> >       unsigned element_cnt = 1;
> > +     struct clk *clk;
> >
> >       /* general line settings */
> >       spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
> > @@ -396,12 +427,60 @@ static int davinci_i2s_hw_params(struct
> snd_pcm_substream *substream,
> >               davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
> >       }
> >
> > -     i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
> > -     srgr = DAVINCI_MCBSP_SRGR_FSGM;
> > -     srgr |= DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1);
> > +     master = mcbsp_data.fmt & SND_SOC_DAIFMT_MASTER_MASK;
> > +     fmt = params_format(params);
> > +     mcbsp_word_length = asp_word_length[fmt];
> >
> > -     i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_FRAME_BITS);
> > -     srgr |= DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1);
> > +     if (master == SND_SOC_DAIFMT_CBS_CFS) {
> > +             clk = clk_get(NULL, "pll1_sysclk6");
> > +             if (clk)
> > +                     freq = clk_get_rate(clk);
> > +             freq = 122000000; /* FIXME ask to Texas */
>
> This frequency should either be passed in as platform data or by your
> machine driver calling snd_soc_dai_set_sysclk().
>

First I need to understand its meaning.
Reading sprufi3a-1.pdf (TMS320DM36x DMSoC Multichannel Buffered Serial Port
(McBSP) Interface) at "2.5.3 Data Clock Generation" paragraph this info not
appears really clear if we are in the case of "McBSP internal input clock".
I hope some Ti developer can help me.


> > +             if (dev->i2s_fast_clock) {
> > +                     clk_div = 256;
> > +                     do {
> > +                             framesize = (freq / (--clk_div)) /
> > +                                         params->rate_num *
> > +                                         params->rate_den;
> > +                     } while (((framesize < 33) || (framesize > 4095))
> &&
> > +                              (clk_div));
> > +                     clk_div--;
> > +                     srgr = DAVINCI_MCBSP_SRGR_FSGM |
> > +                            DAVINCI_MCBSP_SRGR_CLKSM;
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FWID(mcbsp_word_length *
> > +                                                     8 - 1);
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FPER(framesize - 1);
> > +             } else {
> > +                     /* simmetric waveforms */
>
> symmetric
>

thx


>
> > +                     srgr = DAVINCI_MCBSP_SRGR_FSGM |
> > +                            DAVINCI_MCBSP_SRGR_CLKSM;
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FWID(mcbsp_word_length *
> > +                                                     8 - 1);
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
> > +                                                     16 - 1);
> > +                     clk_div = freq / (mcbsp_word_length * 16) /
> > +                               params->rate_num * params->rate_den;
> > +             }
> > +             clk_div &= 0xFF;
> > +             srgr |= clk_div;
> > +     } else if (master == SND_SOC_DAIFMT_CBS_CFM) {
> > +             /* Clock given on CLKS */
> > +             srgr = DAVINCI_MCBSP_SRGR_FSGM;
> > +             clk_div = mcbsp_data.clk_div - 1;
> > +             srgr |= DAVINCI_MCBSP_SRGR_FWID(mcbsp_word_length * 8 - 1);
> > +             srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length * 16 -
> 1);
> > +             clk_div &= 0xFF;
> > +             srgr |= clk_div;
> > +     } else {
> > +             i = hw_param_interval(params,
> SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
> > +             srgr = DAVINCI_MCBSP_SRGR_FSGM;
> > +             srgr |= DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1);
> > +             pr_debug("%s - %d  FWID set: re-read srgr = %X\n",
> > +                     __func__, __LINE__, snd_interval_value(i) - 1);
> > +
> > +             i = hw_param_interval(params,
> SNDRV_PCM_HW_PARAM_FRAME_BITS);
> > +             srgr |= DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1);
> > +     }
> >       davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
> >
> >       rcr = DAVINCI_MCBSP_RCR_RFIG;
> > @@ -426,22 +505,45 @@ static int davinci_i2s_hw_params(struct
> snd_pcm_substream *substream,
> >                       element_cnt = 1;
> >                       fmt = double_fmt[fmt];
> >               }
> > +             if (master == SND_SOC_DAIFMT_CBS_CFS ||
> > +                             master == SND_SOC_DAIFMT_CBS_CFM) {
> > +                     rcr |= DAVINCI_MCBSP_RCR_RFRLEN2(0);
> > +                     xcr |= DAVINCI_MCBSP_XCR_XFRLEN2(0);
> > +                     rcr |= DAVINCI_MCBSP_RCR_RPHASE;
> > +                     xcr |= DAVINCI_MCBSP_XCR_XPHASE;
> > +             } else {
> > +                     /* FIXME ask to Texas */
> > +                     rcr |= DAVINCI_MCBSP_RCR_RFRLEN2(element_cnt - 1);
> > +                     xcr |= DAVINCI_MCBSP_XCR_XFRLEN2(element_cnt - 1);
> > +             }
> >       }
> >       dma_params->acnt = dma_params->data_type = data_type[fmt];
> >       dma_params->fifo_level = 0;
> >       mcbsp_word_length = asp_word_length[fmt];
> > -     rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(element_cnt - 1);
> > -     xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(element_cnt - 1);
> > +
> > +     if (master == SND_SOC_DAIFMT_CBS_CFS ||
> > +                     master == SND_SOC_DAIFMT_CBS_CFM) {
> > +             rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
> > +             xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
> > +     } else {
> > +             /* FIXME ask to Texas */
> > +             rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(element_cnt - 1);
> > +             xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(element_cnt - 1);
> > +     }
> >
> >       rcr |= DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
> > -             DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
> > +            DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
>
> more unintended formatting ?
>
> >       xcr |= DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
> > -             DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
> > +            DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
>
> ditto
>


I'll remove these changes.



>
> >
> >       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> >               davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
> >       else
> >               davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
> > +
> > +     pr_debug("%s - %d  srgr=%X\n", __func__, __LINE__, srgr);
> > +     pr_debug("%s - %d  xcr=%X\n", __func__, __LINE__, xcr);
> > +     pr_debug("%s - %d  rcr=%X\n", __func__, __LINE__, rcr);
> >       return 0;
> >  }
> >
> > @@ -500,7 +602,7 @@ static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
> >       .trigger        = davinci_i2s_trigger,
> >       .hw_params      = davinci_i2s_hw_params,
> >       .set_fmt        = davinci_i2s_set_dai_fmt,
> > -
> > +     .set_clkdiv = davinci_i2s_dai_set_clkdiv,
>
> the formatting is different to rest of struct here.
>

ok. fixing


>
> >  };
> >
> >  struct snd_soc_dai davinci_i2s_dai = {
> > @@ -548,6 +650,7 @@ static int davinci_i2s_probe(struct platform_device
> *pdev)
> >       }
> >       if (pdata) {
> >               dev->enable_channel_combine =
> pdata->enable_channel_combine;
> > +             dev->i2s_fast_clock = pdata->i2s_fast_clock;
> >               dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].sram_size =
> >                       pdata->sram_size_playback;
> >               dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].sram_size =
>
> The subject of the patch looks wrong as I can't really see where you are
> adding stereo support to  the DAI. This patch looks likes it adds more
> clocking options only,
>

there are these supports added.

1. SND_SOC_DAIFMT_CBS_CFS (the cpu generates clock and frame sync)
I need to clarify how is clocked McBSP interface internally.
i2s_fast_clock switch can be used to have better approximate or symmetric
waveforms.

2. SND_SOC_DAIFMT_CBS_CFM (the cpu get clock from external pin and generates
frame sync)
this is important for uda1345.

3. We haven't changed the evmdm365 support (due also to CPLD that doesn't
help to understand)
We don't know in this mode if audio stereo works on evmdm365.
Probably it does.



> Thanks
>
> Liam
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
>
>

The better (I hope) patch we'll come today.

Bye,
Raffaele and Davide.

--001485f9a704dca66b0489d635b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Liam,<br><br><div class=3D"gmail_quote">2010/6/23 Liam Girdwood <span di=
r=3D"ltr">&lt;<a href=3D"mailto:lrg@slimlogic.co.uk">lrg@slimlogic.co.uk</a=
>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt =
0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Wed, 2010-06-23 at 16:33 +0200, Raffaele Recalcati wro=
te:<br>
&gt; From: Raffaele Recalcati &lt;<a href=3D"mailto:raffaele.recalcati@btic=
ino.it">raffaele.recalcati@bticino.it</a>&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 Added audio playback support with [frame sync master - clo=
ck master] mode<br>
&gt; =A0 =A0 =A0 and with [frame sync master - clock slave].<br>
&gt; =A0 =A0 =A0 Clock slave can be important when the external codec need =
system clock<br>
&gt; =A0 =A0 =A0 and bit clock synchronized.<br>
&gt; =A0 =A0 =A0 In the clock master case there is a FIXME message in the s=
ource code, because we<br>
&gt; =A0 =A0 =A0 (Davide and myself) have guessed a frequency of 122000000 =
that seems the base<br>
&gt; =A0 =A0 =A0 to be divided.<br>
&gt; =A0 =A0 =A0 This patch has been developed against the<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 <a href=3D"http://git.kernel.org/pub/scm/l=
inux/kernel/git/khilman/linux-davinci.git" target=3D"_blank">http://git.ker=
nel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git</a><br>
&gt; =A0 =A0 =A0 git tree and has been tested on bmx board (similar to dm36=
5 evm, but using<br>
&gt; =A0 =A0 =A0 uda1345 as external audio codec).<br>
&gt;<br>
&gt; Signed-off-by: Raffaele Recalcati &lt;<a href=3D"mailto:raffaele.recal=
cati@bticino.it">raffaele.recalcati@bticino.it</a>&gt;<br>
&gt; Signed-off-by: Davide Bonfanti &lt;<a href=3D"mailto:davide.bonfanti@b=
ticino.it">davide.bonfanti@bticino.it</a>&gt;<br>
<br>
</div>Had a quick check, it looks like you have made some unintended<br>
formatting changes that make the patch look more complex than necessary.<br=
></blockquote><div><br>I was making correction for keeping aligned my lines=
 like these...<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 srgr =3D DAVINCI_MCBSP_SRGR_FSGM |<br>
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 DAVINCI_MCBSP_SRGR_CLKSM;<br><br>and so I changed some exis=
ting ones...<br>but looking at CodingStyle and Greg notes, seems that, when=
 breaking lines, we need to keep alignment.<br>So maybe, if I&#39;m right, =
in the future, we&#39;ll need to re-align all the file with another patch..=
<br>
I&#39;ll change anyway the code back to be simpler to be understood.<br>=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0arch/arm/mach-davinci/include/mach/asp.h | =A0 =A07 ++<br>
&gt; =A0sound/soc/davinci/davinci-i2s.c =A0 =A0 =A0 =A0 =A0| =A0141 +++++++=
+++++++++++++++++++----<br>
&gt; =A02 files changed, 129 insertions(+), 19 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-=
davinci/include/mach/asp.h<br>
&gt; index 834725f..b1faeb9 100644<br>
&gt; --- a/arch/arm/mach-davinci/include/mach/asp.h<br>
&gt; +++ b/arch/arm/mach-davinci/include/mach/asp.h<br>
&gt; @@ -63,6 +63,13 @@ struct snd_platform_data {<br>
&gt; =A0 =A0 =A0 unsigned sram_size_playback;<br>
&gt; =A0 =A0 =A0 unsigned sram_size_capture;<br>
&gt;<br>
&gt; + =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0* This define works when both clock and FS are output for=
 the cpu<br>
&gt; + =A0 =A0 =A0* and makes clock very fast (FS is not simmetrical, but s=
ampling<br>
&gt; + =A0 =A0 =A0* frequency is better approximated<br>
&gt; + =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 int i2s_fast_clock;<br>
&gt; +<br>
&gt; =A0 =A0 =A0 /* McASP specific fields */<br>
&gt; =A0 =A0 =A0 int tdm_slots;<br>
&gt; =A0 =A0 =A0 u8 op_mode;<br>
&gt; diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davin=
ci-i2s.c<br>
&gt; index adadcd3..8811d25 100644<br>
&gt; --- a/sound/soc/davinci/davinci-i2s.c<br>
&gt; +++ b/sound/soc/davinci/davinci-i2s.c<br>
&gt; @@ -68,16 +68,23 @@<br>
&gt; =A0#define DAVINCI_MCBSP_RCR_RDATDLY(v) ((v) &lt;&lt; 16)<br>
&gt; =A0#define DAVINCI_MCBSP_RCR_RFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&=
lt; 18)<br>
&gt; =A0#define DAVINCI_MCBSP_RCR_RWDLEN2(v) ((v) &lt;&lt; 21)<br>
&gt; +#define DAVINCI_MCBSP_RCR_RFRLEN2(v) ((v) &lt;&lt; 24)<br>
&gt; +#define DAVINCI_MCBSP_RCR_RPHASE =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; =
31)<br>
&gt;<br>
&gt; =A0#define DAVINCI_MCBSP_XCR_XWDLEN1(v) ((v) &lt;&lt; 5)<br>
&gt; =A0#define DAVINCI_MCBSP_XCR_XFRLEN1(v) ((v) &lt;&lt; 8)<br>
&gt; =A0#define DAVINCI_MCBSP_XCR_XDATDLY(v) ((v) &lt;&lt; 16)<br>
&gt; =A0#define DAVINCI_MCBSP_XCR_XFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&=
lt; 18)<br>
&gt; =A0#define DAVINCI_MCBSP_XCR_XWDLEN2(v) ((v) &lt;&lt; 21)<br>
&gt; +#define DAVINCI_MCBSP_XCR_XFRLEN2(v) ((v) &lt;&lt; 24)<br>
&gt; +#define DAVINCI_MCBSP_XCR_XPHASE =A0 =A0 (1 &lt;&lt; 31)<br>
&gt;<br>
&gt; +<br>
&gt; +#define CLKGDV(v) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(v) =A0 =A0 /* Bits 0:7 */<br>
<br>
</div></div>Should you not have a DAVINCI prefix here too ?<br></blockquote=
><div><br>Sorry, CLKGDV was not more used.<br>So I&#39;m deleting it in the=
 new patch coming today.<br>=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); =
padding-left: 1ex;">

<div class=3D"im"><br>
&gt; =A0#define DAVINCI_MCBSP_SRGR_FWID(v) =A0 ((v) &lt;&lt; 8)<br>
&gt; =A0#define DAVINCI_MCBSP_SRGR_FPER(v) =A0 ((v) &lt;&lt; 16)<br>
&gt; =A0#define DAVINCI_MCBSP_SRGR_FSGM =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 &lt;&=
lt; 28)<br>
&gt; +#define DAVINCI_MCBSP_SRGR_CLKSM =A0 =A0 (1 &lt;&lt; 29)<br>
&gt;<br>
&gt; =A0#define DAVINCI_MCBSP_PCR_CLKRP =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 &lt;&=
lt; 0)<br>
&gt; =A0#define DAVINCI_MCBSP_PCR_CLKXP =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 &lt;&=
lt; 1)<br>
&gt; @@ -144,8 +151,17 @@ struct davinci_mcbsp_dev {<br>
&gt; =A0 =A0 =A0 =A0* won&#39;t end up being swapped because of the underru=
n.<br>
&gt; =A0 =A0 =A0 =A0*/<br>
&gt; =A0 =A0 =A0 unsigned enable_channel_combine:1;<br>
&gt; +<br>
&gt; + =A0 =A0 int i2s_fast_clock;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct davinci_mcbsp_data {<br>
&gt; + =A0 =A0 unsigned int =A0 =A0fmt;<br>
&gt; + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 clk_div;<br>
&gt; =A0};<br>
&gt;<br>
&gt; +static struct davinci_mcbsp_data mcbsp_data;<br>
&gt; +<br>
<br>
</div>This struct should be part of the dai private data.<br></blockquote><=
div><br>done.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-lef=
t: 1ex;">

<div><div></div><div class=3D"h5"><br>
&gt; =A0static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev=
 *dev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0int reg, u32 val)<br>
&gt; =A0{<br>
&gt; @@ -255,24 +271,27 @@ static int davinci_i2s_set_dai_fmt(struct snd_so=
c_dai *cpu_dai,<br>
&gt; =A0 =A0 =A0 unsigned int pcr;<br>
&gt; =A0 =A0 =A0 unsigned int srgr;<br>
&gt; =A0 =A0 =A0 srgr =3D DAVINCI_MCBSP_SRGR_FSGM |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE=
 * 2 - 1) |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE=
 - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE =
* 2 - 1) |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE =
- 1);<br>
&gt; + =A0 =A0 /* Attention srgr is updated by hw_params! */<br>
&gt;<br>
&gt; + =A0 =A0 mcbsp_data.fmt =3D fmt;<br>
&gt; =A0 =A0 =A0 /* set master/slave audio interface */<br>
&gt; =A0 =A0 =A0 switch (fmt &amp; SND_SOC_DAIFMT_MASTER_MASK) {<br>
&gt; + =A0 =A0 case SND_SOC_DAIFMT_CBS_CFM:<br>
&gt; =A0 =A0 =A0 case SND_SOC_DAIFMT_CBS_CFS:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* cpu is master */<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcr =3D DAVINCI_MCBSP_PCR_FSXM |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_FSRM |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_CLKXM |<br=
>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_CLKRM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_FSRM |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_CLKXM |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_CLKRM;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; =A0 =A0 =A0 case SND_SOC_DAIFMT_CBM_CFS:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* McBSP CLKR pin is the input for the Sam=
ple Rate Generator.<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* McBSP FSR and FSX are driven by the S=
ample Rate Generator. */<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcr =3D DAVINCI_MCBSP_PCR_SCLKME |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_FSXM |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_FSRM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_FSXM |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_FSRM;<br>
<br>
</div></div>These two just look like unintended formatting changes.<br></bl=
ockquote><div><br>in next patch I&#39;ll remove these changes.<br>=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

<div><div></div><div class=3D"h5"><br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; =A0 =A0 =A0 case SND_SOC_DAIFMT_CBM_CFM:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* codec is master */<br>
&gt; @@ -372,6 +391,17 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc=
_dai *cpu_dai,<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static int davinci_i2s_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int div_id, =
int div)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct davinci_mcbsp_dev *dev =3D cpu_dai-&gt;private_data;<=
br>
&gt; + =A0 =A0 int srgr;<br>
&gt; +<br>
&gt; + =A0 =A0 mcbsp_data.clk_div =3D div;<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; =A0static int davinci_i2s_hw_params(struct snd_pcm_substream *substrea=
m,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
snd_pcm_hw_params *params,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
snd_soc_dai *dai)<br>
&gt; @@ -380,11 +410,12 @@ static int davinci_i2s_hw_params(struct snd_pcm_=
substream *substream,<br>
&gt; =A0 =A0 =A0 struct davinci_pcm_dma_params *dma_params =3D<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &amp;dev-&gt;dma_params[substream-&gt;stream];<br>
&gt; =A0 =A0 =A0 struct snd_interval *i =3D NULL;<br>
&gt; - =A0 =A0 int mcbsp_word_length;<br>
&gt; - =A0 =A0 unsigned int rcr, xcr, srgr;<br>
&gt; + =A0 =A0 int mcbsp_word_length, master;<br>
&gt; + =A0 =A0 unsigned int rcr, xcr, srgr, clk_div, freq, framesize;<br>
&gt; =A0 =A0 =A0 u32 spcr;<br>
&gt; =A0 =A0 =A0 snd_pcm_format_t fmt;<br>
&gt; =A0 =A0 =A0 unsigned element_cnt =3D 1;<br>
&gt; + =A0 =A0 struct clk *clk;<br>
&gt;<br>
&gt; =A0 =A0 =A0 /* general line settings */<br>
&gt; =A0 =A0 =A0 spcr =3D davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_RE=
G);<br>
&gt; @@ -396,12 +427,60 @@ static int davinci_i2s_hw_params(struct snd_pcm_=
substream *substream,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP=
_SPCR_REG, spcr);<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; - =A0 =A0 i =3D hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BI=
TS);<br>
&gt; - =A0 =A0 srgr =3D DAVINCI_MCBSP_SRGR_FSGM;<br>
&gt; - =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1)=
;<br>
&gt; + =A0 =A0 master =3D mcbsp_data.fmt &amp; SND_SOC_DAIFMT_MASTER_MASK;<=
br>
&gt; + =A0 =A0 fmt =3D params_format(params);<br>
&gt; + =A0 =A0 mcbsp_word_length =3D asp_word_length[fmt];<br>
&gt;<br>
&gt; - =A0 =A0 i =3D hw_param_interval(params, SNDRV_PCM_HW_PARAM_FRAME_BIT=
S);<br>
&gt; - =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1)=
;<br>
&gt; + =A0 =A0 if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 clk =3D clk_get(NULL, &quot;pll1_sysclk6&quo=
t;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (clk)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq =3D clk_get_rate(clk);<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 freq =3D 122000000; /* FIXME ask to Texas */=
<br>
<br>
</div></div>This frequency should either be passed in as platform data or b=
y your<br>
machine driver calling snd_soc_dai_set_sysclk().<br></blockquote><div><br>F=
irst I need to understand its meaning.<br>Reading sprufi3a-1.pdf (TMS320DM3=
6x DMSoC Multichannel Buffered Serial Port (McBSP) Interface) at &quot;2.5.=
3 Data Clock Generation&quot; paragraph this info not appears really clear =
if we are in the case of &quot;McBSP internal input clock&quot;.<br>
I hope some Ti developer can help me.<br><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(20=
4, 204, 204); padding-left: 1ex;">
<div class=3D"im"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (dev-&gt;i2s_fast_clock) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_div =3D 256;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 framesize =
=3D (freq / (--clk_div)) /<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 params-&gt;rate_num *<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 params-&gt;rate_den;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (((framesize &lt; 33=
) || (framesize &gt; 4095)) &amp;&amp;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(clk_div)=
);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_div--;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 srgr =3D DAVINCI_MCBSP_SRGR_=
FSGM |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DAVINCI_MCBSP=
_SRGR_CLKSM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR=
_FWID(mcbsp_word_length *<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8 - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR=
_FPER(framesize - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* simmetric waveforms */<br=
>
<br>
</div>symmetric<br></blockquote><div><br>thx<br>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 srgr =3D DAVINCI_MCBSP_SRGR_=
FSGM |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DAVINCI_MCBSP=
_SRGR_CLKSM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR=
_FWID(mcbsp_word_length *<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8 - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR=
_FPER(mcbsp_word_length *<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16 - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_div =3D freq / (mcbsp_wo=
rd_length * 16) /<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 params-&=
gt;rate_num * params-&gt;rate_den;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 clk_div &amp;=3D 0xFF;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D clk_div;<br>
&gt; + =A0 =A0 } else if (master =3D=3D SND_SOC_DAIFMT_CBS_CFM) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* Clock given on CLKS */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 srgr =3D DAVINCI_MCBSP_SRGR_FSGM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 clk_div =3D mcbsp_data.clk_div - 1;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR_FWID(mcbsp_word=
_length * 8 - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR_FPER(mcbsp_word=
_length * 16 - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 clk_div &amp;=3D 0xFF;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D clk_div;<br>
&gt; + =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 i =3D hw_param_interval(params, SNDRV_PCM_HW=
_PARAM_SAMPLE_BITS);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 srgr =3D DAVINCI_MCBSP_SRGR_FSGM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR_FWID(snd_interv=
al_value(i) - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;%s - %d =A0FWID set: re-read =
srgr =3D %X\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, __LINE__, snd_inte=
rval_value(i) - 1);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 i =3D hw_param_interval(params, SNDRV_PCM_HW=
_PARAM_FRAME_BITS);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 srgr |=3D DAVINCI_MCBSP_SRGR_FPER(snd_interv=
al_value(i) - 1);<br>
&gt; + =A0 =A0 }<br>
&gt; =A0 =A0 =A0 davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr)=
;<br>
&gt;<br>
&gt; =A0 =A0 =A0 rcr =3D DAVINCI_MCBSP_RCR_RFIG;<br>
&gt; @@ -426,22 +505,45 @@ static int davinci_i2s_hw_params(struct snd_pcm_=
substream *substream,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 element_cnt =3D 1;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt =3D double_fmt[fmt];<b=
r>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS ||<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 master =3D=
=3D SND_SOC_DAIFMT_CBS_CFM) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcr |=3D DAVINCI_MCBSP_RCR_R=
FRLEN2(0);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xcr |=3D DAVINCI_MCBSP_XCR_X=
FRLEN2(0);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcr |=3D DAVINCI_MCBSP_RCR_R=
PHASE;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xcr |=3D DAVINCI_MCBSP_XCR_X=
PHASE;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME ask to Texas */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcr |=3D DAVINCI_MCBSP_RCR_R=
FRLEN2(element_cnt - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xcr |=3D DAVINCI_MCBSP_XCR_X=
FRLEN2(element_cnt - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 dma_params-&gt;acnt =3D dma_params-&gt;data_type =3D data_=
type[fmt];<br>
&gt; =A0 =A0 =A0 dma_params-&gt;fifo_level =3D 0;<br>
&gt; =A0 =A0 =A0 mcbsp_word_length =3D asp_word_length[fmt];<br>
&gt; - =A0 =A0 rcr |=3D DAVINCI_MCBSP_RCR_RFRLEN1(element_cnt - 1);<br>
&gt; - =A0 =A0 xcr |=3D DAVINCI_MCBSP_XCR_XFRLEN1(element_cnt - 1);<br>
&gt; +<br>
&gt; + =A0 =A0 if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS ||<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 master =3D=3D SND_SOC_DAIFMT=
_CBS_CFM) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 rcr |=3D DAVINCI_MCBSP_RCR_RFRLEN1(0);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 xcr |=3D DAVINCI_MCBSP_XCR_XFRLEN1(0);<br>
&gt; + =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME ask to Texas */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 rcr |=3D DAVINCI_MCBSP_RCR_RFRLEN1(element_c=
nt - 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 xcr |=3D DAVINCI_MCBSP_XCR_XFRLEN1(element_c=
nt - 1);<br>
&gt; + =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 rcr |=3D DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |<br=
>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length)=
;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);=
<br>
<br>
</div></div>more unintended formatting ?<br>
<div class=3D"im"><br>
&gt; =A0 =A0 =A0 xcr |=3D DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |<br=
>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length)=
;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);=
<br>
<br>
</div>ditto<br></blockquote><div><br><br>I&#39;ll remove these changes.<br>=
<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt=
 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im"><br>
&gt;<br>
&gt; =A0 =A0 =A0 if (substream-&gt;stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP=
_XCR_REG, xcr);<br>
&gt; =A0 =A0 =A0 else<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP=
_RCR_REG, rcr);<br>
&gt; +<br>
&gt; + =A0 =A0 pr_debug(&quot;%s - %d =A0srgr=3D%X\n&quot;, __func__, __LIN=
E__, srgr);<br>
&gt; + =A0 =A0 pr_debug(&quot;%s - %d =A0xcr=3D%X\n&quot;, __func__, __LINE=
__, xcr);<br>
&gt; + =A0 =A0 pr_debug(&quot;%s - %d =A0rcr=3D%X\n&quot;, __func__, __LINE=
__, rcr);<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0}<br>
&gt;<br>
&gt; @@ -500,7 +602,7 @@ static struct snd_soc_dai_ops davinci_i2s_dai_ops =
=3D {<br>
&gt; =A0 =A0 =A0 .trigger =A0 =A0 =A0 =A0=3D davinci_i2s_trigger,<br>
&gt; =A0 =A0 =A0 .hw_params =A0 =A0 =A0=3D davinci_i2s_hw_params,<br>
&gt; =A0 =A0 =A0 .set_fmt =A0 =A0 =A0 =A0=3D davinci_i2s_set_dai_fmt,<br>
&gt; -<br>
&gt; + =A0 =A0 .set_clkdiv =3D davinci_i2s_dai_set_clkdiv,<br>
<br>
</div>the formatting is different to rest of struct here.<br></blockquote><=
div><br>ok. fixing<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); paddin=
g-left: 1ex;">

<div class=3D"im"><br>
&gt; =A0};<br>
&gt;<br>
&gt; =A0struct snd_soc_dai davinci_i2s_dai =3D {<br>
&gt; @@ -548,6 +650,7 @@ static int davinci_i2s_probe(struct platform_devic=
e *pdev)<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 if (pdata) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;enable_channel_combine =3D pdata-&=
gt;enable_channel_combine;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;i2s_fast_clock =3D pdata-&gt;i2s_fas=
t_clock;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;dma_params[SNDRV_PCM_STREAM_PLAYBA=
CK].sram_size =3D<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata-&gt;sram_size_playba=
ck;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;dma_params[SNDRV_PCM_STREAM_CAPTUR=
E].sram_size =3D<br>
<br>
</div>The subject of the patch looks wrong as I can&#39;t really see where =
you are<br>
adding stereo support to =A0the DAI. This patch looks likes it adds more<br=
>
clocking options only,<br></blockquote><div><br>there are these supports ad=
ded.<br><br>1. SND_SOC_DAIFMT_CBS_CFS (the cpu generates clock and frame sy=
nc)<br>I need to clarify how is clocked McBSP interface internally.<br>
i2s_fast_clock switch can be used to have better approximate or symmetric w=
aveforms.<br><br>2. SND_SOC_DAIFMT_CBS_CFM (the cpu get clock from external=
 pin and generates frame sync)<br>this is important for uda1345.<br><br>
3. We haven&#39;t changed the evmdm365 support (due also to CPLD that doesn=
&#39;t help to understand)<br>We don&#39;t know in this mode if audio stere=
o works on evmdm365.<br>Probably it does.<br><br><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px soli=
d rgb(204, 204, 204); padding-left: 1ex;">

<br>
Thanks<br>
<br>
Liam<br>
<font color=3D"#888888">--<br>
Freelance Developer, SlimLogic Ltd<br>
ASoC and Voltage Regulator Maintainer.<br>
<a href=3D"http://www.slimlogic.co.uk" target=3D"_blank">http://www.slimlog=
ic.co.uk</a><br>
<br>
</font></blockquote></div><br><br>The better (I hope) patch we&#39;ll come =
today.<br><br>Bye,<br>Raffaele and Davide.<br><br>

--001485f9a704dca66b0489d635b1--


--===============0925926302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0925926302==--
