From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl_sai: Enable data lines based on input channels
Date: Wed, 14 Aug 2019 17:02:31 +0300
Message-ID: <CAEnQRZAQGdci_WtCKHqR-h9zid-COO1FaWWv-MPUkE_sYFszmg@mail.gmail.com>
References: <20190811195545.32606-1-daniel.baluta@nxp.com> <20190814013916.GB13398@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814013916.GB13398@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Takashi Iwai <tiwai@suse.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 14, 2019 at 4:39 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Aug 11, 2019 at 10:55:45PM +0300, Daniel Baluta wrote:
> > An audio data frame consists of a number of slots one for each
> > channel. In the case of I2S there are 2 data slots / frame.
> >
> > The maximum number of SAI slots / frame is configurable at
> > IP integration time. This affects the width of Mask Register.
> > SAI supports up to 32 slots per frame.
> >
> > The number of datalines is also configurable (up to 8 datalines)
> > and affects TCE/RCE and the number of data/FIFO registers.
> >
> > The number of needed data lines (pins) is computed as follows:
> >
> > * pins = channels / slots.
> >
> > This can be computed in hw_params function so lets move TRCE bits
> > seting from startup to hw_params.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 34 +++++++++++++---------------------
> >  sound/soc/fsl/fsl_sai.h |  2 +-
> >  2 files changed, 14 insertions(+), 22 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 69cf3678c859..b70032c82fe2 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
>
> > @@ -480,13 +483,17 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>
> > -     regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << channels) - 1));
> > +     regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << slots) - 1));
>
> Would this break mono channel audio?

Indeed, this isn't good for mono. I see in our internal tree that we
have min(channels, slots).
This would fix mono, let me think if this is really the right solution.

>
> >  static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
>
> > @@ -881,6 +872,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
> >               return -ENOMEM;
> >
> >       sai->pdev = pdev;
> > +
>
> Seemly unnecessary

Oh, ok. Will fix in next version.
