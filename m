From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 7/7] ASoC: dt-bindings: Introduce
 compatible strings for 7ULP and 8MQ
Date: Tue, 30 Jul 2019 15:10:10 +0300
Message-ID: <CAEnQRZAfsQBjKcJm9e7VJ7aOLSBzgOQC+HWNs0XSLAT2L-GudA@mail.gmail.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-8-daniel.baluta@nxp.com>
 <20190730080135.GB5892@Asurada> <CAEnQRZAUOzmP2yPb4utyDTnYUDNyqesXJPb5-Ms0tfPy8TMBig@mail.gmail.com>
 <20190730120455.GA4264@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730120455.GA4264@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, Devicetree List <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Fabio Estevam <festevam@gmail.com>, Mihai Serban <mihai.serban@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2019 at 3:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 30, 2019 at 03:02:30PM +0300, Daniel Baluta wrote:
>
> > I removed the 'or' on purpose because I don't want to move it
> > around each time we add a new compatible.
>
> > Anyhow, I can put it back if this is the convention.
>
> You could convert to the YAML binding format and sidestep the problem a
> different way!

Someone needs to do that in the end, so will try to change to yaml
with the next version
of the patch series.
