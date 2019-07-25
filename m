From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH 08/10] ASoC: dt-bindings: Document fcomb_mode property
Date: Thu, 25 Jul 2019 09:02:22 +0300
Message-ID: <CAEnQRZBW7LNZ7=c_h_ef4ZDcbFzEt61h4VAJSLo2Fb80kBqtpw@mail.gmail.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-9-daniel.baluta@nxp.com>
 <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Viorel Suman <viorel.suman@nxp.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 2:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:31PM +0300, Daniel Baluta wrote:
> > This allows combining multiple-data-line FIFOs into a
> > single-data-line FIFO.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++++
>
> This should be sent to devicetree mail-list also.
>
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > index 59f4d965a5fb..ca27afd840ba 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > @@ -54,6 +54,10 @@ Optional properties:
> >                         represents first data line, bit 1 represents second
> >                         data line and so on. Data line is enabled if
> >                         corresponding bit is set to 1.
> > +  - fsl,fcomb_mode   : list of two integers (first for RX, second for TX)
> > +                       representing FIFO combine mode. Possible values for
> > +                       combined mode are: 0 - disabled, 1 - Rx/Tx from shift
> > +                       registers, 2 - Rx/Tx by software, 3 - both.
>
> Looks like a software configuration to me, instead of a device
> property. Is this configurable by user case, or hard-coded by
> SoC/hardware design?

Indeed this is a software configuration and configurable by user case.
Will think of a another way to specify it.
