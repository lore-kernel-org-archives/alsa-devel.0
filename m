From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
Date: Tue, 9 Apr 2019 23:37:14 -0700
Message-ID: <20190410063714.GA4156@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada>
 <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Viorel Suman <viorel.suman@nxp.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Viorel Suman <viorel.suman@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>"linux-kernel@vger.kernel.org" <linu>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 10, 2019 at 09:20:29AM +0300, Daniel Baluta wrote:
> Hi Nicolin,
> 
> On Wed, Apr 10, 2019 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > > Use "of_device_id.data" to specify the machine driver
> > > instead of "model" DTS attribute.
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> >
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> >
> > > ---
> > >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
> > >  1 file changed, 23 insertions(+), 20 deletions(-)
> >
> > > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> > > +                                                0);
> >
> > Would you please send a separate patch to replace "pdev->dev"?
> 
> I am not sure exactly how to explain this change in the commit message. It does
> make code easier to read and avoids dereferencing pdev pointer each time.
> 
> Is it enough for commit description?

You mean this? https://lore.kernel.org/patchwork/patch/862610/
