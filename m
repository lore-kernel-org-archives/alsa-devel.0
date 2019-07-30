From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 7/7] ASoC: dt-bindings: Introduce
 compatible strings for 7ULP and 8MQ
Date: Tue, 30 Jul 2019 15:02:30 +0300
Message-ID: <CAEnQRZAUOzmP2yPb4utyDTnYUDNyqesXJPb5-Ms0tfPy8TMBig@mail.gmail.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-8-daniel.baluta@nxp.com>
 <20190730080135.GB5892@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730080135.GB5892@Asurada>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Devicetree List <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Fabio Estevam <festevam@gmail.com>, Mihai Serban <mihai.serban@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2019 at 11:02 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Jul 28, 2019 at 10:24:29PM +0300, Daniel Baluta wrote:
> > For i.MX7ULP and i.MX8MQ register map is changed. Add two new compatbile
> > strings to differentiate this.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > index 2b38036a4883..b008e9cfedc1 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > @@ -8,7 +8,8 @@ codec/DSP interfaces.
> >  Required properties:
> >
> >    - compatible               : Compatible list, contains "fsl,vf610-sai",
> > -                       "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
> > +                       "fsl,imx6sx-sai", "fsl,imx6ul-sai",
> > +                       "fsl,imx7ulp-sai", "fsl,imx8mq-sai".
>
> A nit, could have that 'or' :)

I removed the 'or' on purpose because I don't want to move it
around each time we add a new compatible.

Anyhow, I can put it back if this is the convention.
