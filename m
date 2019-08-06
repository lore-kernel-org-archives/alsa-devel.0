From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 3/7] ASoC: fsl_sai: Add support to enable multiple data lines
Date: Tue, 6 Aug 2019 18:23:27 +0300
Message-ID: <CAEnQRZBN5Y+75cpgS2h3LwDj5BkF5cesqu6=V3GuPU4=5pgn6A@mail.gmail.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-4-daniel.baluta@nxp.com>
 <20190729202154.GC20594@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729202154.GC20594@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Mihai Serban <mihai.serban@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Viorel Suman <viorel.suman@nxp.com>, Timur Tabi <timur@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2019 at 11:22 PM Nicolin Chen <nicoleotsuka@gmail.com> wrot=
e:
>
> On Sun, Jul 28, 2019 at 10:24:25PM +0300, Daniel Baluta wrote:
> > SAI supports up to 8 Rx/Tx data lines which can be enabled
> > using TCE/RCE bits of TCR3/RCR3 registers.
> >
> > Data lines to be enabled are read from DT fsl,dl-mask property.
> > By default (if no DT entry is provided) only data line 0 is enabled.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 11 ++++++++++-
> >  sound/soc/fsl/fsl_sai.h |  4 +++-
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 637b1d12a575..5e7cb7fd29f5 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream=
 *substream,
> >
> >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> >                          FSL_SAI_CR3_TRCE_MASK,
> > -                        FSL_SAI_CR3_TRCE);
> > +                        FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
> >
> >       ret =3D snd_pcm_hw_constraint_list(substream->runtime, 0,
> >                       SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraint=
s);
> > @@ -888,6 +888,15 @@ static int fsl_sai_probe(struct platform_device *p=
dev)
> >               }
> >       }
> >
> > +     /*
> > +      * active data lines mask for TX/RX, defaults to 1 (only the firs=
t
> > +      * data line is enabled
> > +      */
> > +     sai->dl_mask[RX] =3D 1;
> > +     sai->dl_mask[TX] =3D 1;
> > +     of_property_read_u32_index(np, "fsl,dl-mask", RX, &sai->dl_mask[R=
X]);
> > +     of_property_read_u32_index(np, "fsl,dl-mask", TX, &sai->dl_mask[T=
X]);
>
> Just curious what if we enable 8 data lines through DT bindings
> while an audio file only has 1 or 2 channels. Will TRCE bits be
> okay to stay with 8 data channels configurations? Btw, how does
> DMA work for the data registers? ESAI has one entry at a fixed
> address for all data channels while SAI seems to have different
> data registers.

Hi Nicolin,

I have sent v3 and removed this patch from the series because we
need to find a better solution.

I think we should enable TCE based on the number of available datalines
and the number of active channels.  Will come with a RFC patch later.

Pasting here the reply of SAI Audio IP owner regarding to your question abo=
ve,
just for anyone to have more info of our private discussion:

If all 8 datalines are enabled using TCE then the transmit FIFO for
all 8 datalines need to be serviced, otherwise a FIFO underrun will be
generated.
Each dataline has a separate transmit FIFO with a separate register to
service the FIFO, so each dataline can be serviced separately. Note
that configuring FCOMB=3D2 would make it look like ESAI with a common
address for all FIFOs.
When performing DMA transfers to multiple datalines, there are a
couple of options:
    * Use 1 DMA channel to copy first slot for each dataline to each
FIFO and then update the destination address back to the first
register.
    * Configure separate DMA channel for each dataline and trigger the
first one by the DMA request and the subsequent channels by DMA
linking or scatter/gather.
    * Configure FCOMB=3D2 and treat it the same as the ESAI. This is
almost the same as 1, but don=E2=80=99t need to update the destination
address.

Thanks,
Daniel.
