From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH 05/10] ASoC: fsl_sai: Add support to enable
 multiple data lines
Date: Wed, 24 Jul 2019 11:58:04 +0300
Message-ID: <CAEnQRZB+g0pmv_Kkf37Vj_Ln_gPSc6cq77yAZQQ+9yUzhhMT5A@mail.gmail.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-6-daniel.baluta@nxp.com>
 <1563800148.2311.9.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1563800148.2311.9.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Viorel Suman <viorel.suman@nxp.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 22, 2019 at 3:58 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Montag, den 22.07.2019, 15:48 +0300 schrieb Daniel Baluta:
> > SAI supports up to 8 Rx/Tx data lines which can be enabled
> > using TCE/RCE bits of TCR3/RCR3 registers.
> >
> > Data lines to be enabled are read from DT fsl,dl_mask property.
> > By default (if no DT entry is provided) only data line 0 is enabled.
> >
> > Note:
> > We can only enable consecutive data lines starting with data line #0.
>
> Why is the property a bitmask then? To me this sounds like we want to
> have the number of lanes in the DT and convert to the bitmask inside
> the driver.

Actually my comment might be wrong. I have read the documentation again
and it seems that: We can only enable consecutive data lines
*ONLY* if combine mode is enabled.

Thus, if combine mode is disabled we can independently enable any data
line. I will clarify this with IP owner and correct the patch accordingly.

>
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 10 +++++++++-
> >  sound/soc/fsl/fsl_sai.h |  6 ++++--
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 768341608695..d0fa02188b7c 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> >
> > >     regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> > >                        FSL_SAI_CR3_TRCE_MASK,
> > > -                      FSL_SAI_CR3_TRCE);
> > > +                      FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
> >
> > >     ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
> > >                     SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
> > @@ -887,6 +887,14 @@ static int fsl_sai_probe(struct platform_device *pdev)
> > >             }
> > >     }
> >
> > > +   /* active data lines mask for TX/RX, defaults to 1 (only the first
> > > +    * data line is enabled
> > +      */
>
> Comment style not in line with Linux coding style.

Will fix. Thanks Lucas for review.
Should be like this, right?
/*
 * comment
 */

checkpatch.pl warned me only about the end of the comment :).
