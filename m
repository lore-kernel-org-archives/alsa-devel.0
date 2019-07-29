From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/7] ASoC: fsl_sai: Add registers
 definition for multiple datalines
Date: Mon, 29 Jul 2019 22:57:43 +0300
Message-ID: <CAEnQRZDmnAmgUkRGv3V5S7b5EnYTd2BO5NFuME2CfGb1=nAHzQ@mail.gmail.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-2-daniel.baluta@nxp.com>
 <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Devicetree List <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Fabio Estevam <festevam@gmail.com>, Mihai Serban <mihai.serban@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2019 at 10:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:
> > SAI IP supports up to 8 data lines. The configuration of
> > supported number of data lines is decided at SoC integration
> > time.
> >
> > This patch adds definitions for all related data TX/RX registers:
> >       * TDR0..7, Transmit data register
> >       * TFR0..7, Transmit FIFO register
> >       * RDR0..7, Receive data register
> >       * RFR0..7, Receive FIFO register
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 76 +++++++++++++++++++++++++++++++++++------
> >  sound/soc/fsl/fsl_sai.h | 36 ++++++++++++++++---
> >  2 files changed, 98 insertions(+), 14 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 6d3c6c8d50ce..17b0aff4ee8b 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
>
> > @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
> >       case FSL_SAI_TCR3:
> >       case FSL_SAI_TCR4:
> >       case FSL_SAI_TCR5:
> > -     case FSL_SAI_TFR:
> > +     case FSL_SAI_TFR0:
> > +     case FSL_SAI_TFR1:
> > +     case FSL_SAI_TFR2:
> > +     case FSL_SAI_TFR3:
> > +     case FSL_SAI_TFR4:
> > +     case FSL_SAI_TFR5:
> > +     case FSL_SAI_TFR6:
> > +     case FSL_SAI_TFR7:
> >       case FSL_SAI_TMR:
> >       case FSL_SAI_RCSR:
> >       case FSL_SAI_RCR1:
>
> A tricky thing here is that those SAI instances on older SoC don't
> support multi data lines physically, while seemly having registers
> pre-defined. So your change doesn't sound doing anything wrong to
> them at all, I am still wondering if it is necessary to apply them
> to newer compatible only though, as for older compatibles of SAI,
> these registers would be useless and confusing if being exposed.
>
> What do you think?

Yes, I thought about this too. But, I tried to keep the code as short
as possible and technically it is not wrong. When 1 data line is supported
for example application will only care about TDR0, TFR0, etc.
