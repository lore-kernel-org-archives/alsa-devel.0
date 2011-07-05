From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] MFD: twl6040: Add irq variable for
	slave devices
Date: Tue, 5 Jul 2011 15:09:06 +0300
Message-ID: <3328261.Ltcx4CEcHA@barack>
References: <1309857266-3663-1-git-send-email-peter.ujfalusi@ti.com>
	<1309857266-3663-2-git-send-email-peter.ujfalusi@ti.com>
	<20110705112245.GA2820@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FC7B24651
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 14:09:16 +0200 (CEST)
In-Reply-To: <20110705112245.GA2820@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 05 July 2011 13:22:46 Balbi, Felipe wrote:
> Hi,
> =

> On Tue, Jul 05, 2011 at 12:14:22PM +0300, Peter Ujfalusi wrote:
> > Add new variable to pass the irq number for the slaves
> > devices of twl6040.
> > The irq number configuration is done in the twl6040-core
> > at probe time, so machine drivers do not need to be
> > modified.
> > =

> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > =

> >  drivers/mfd/twl6040-core.c |    2 ++
> >  include/linux/i2c/twl.h    |    2 ++
> >  2 files changed, 4 insertions(+), 0 deletions(-)
> > =

> > diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
> > index cfaedb5..8607793 100644
> > --- a/drivers/mfd/twl6040-core.c
> > +++ b/drivers/mfd/twl6040-core.c
> > @@ -501,6 +501,7 @@ static int __devinit twl6040_probe(struct
> > platform_device *pdev)
> > =

> >  	if (pdata->codec) {
> >  	=

> >  		cell =3D &twl6040->cells[children];
> >  		cell->name =3D "twl6040-codec";
> > =

> > +		pdata->codec->plug_irq =3D twl6040->irq_base + TWL6040_IRQ_PLUG;
> =

> are the slave devices platform_devices ?? If so, you could use struct
> resource to pass IRQs as that's the "approved" way to do so. Then, on
> child driver, you could either rely on a particular order of the
> resources or assign them names and use platform_get_irq_byname() to
> fetch the correct one (if you have more than one, that is).

You mean something like this:

static struct resource twl6040_codec_rsrc[] =3D {
	{
		.flags =3D IORESOURCE_IRQ,
	},
};

...

@@ -501,6 +501,7 @@ static int __devinit twl6040_probe(struct platform_devi=
ce =

*pdev)
		if (pdata->codec) {
			cell =3D &twl6040->cells[children];
			cell->name =3D "twl6040-codec";
+			twl6040_codec_rsrc[0].start =3D twl6040->irq_base + TWL6040_IRQ_PLUG;
+			twl6040_codec_rsrc[0].end =3D twl6040->irq_base + TWL6040_IRQ_PLUG;
+			cell->resource =3D twl6040_codec_rsrc;
+			cell->num_resources =3D ARRAY_SIZE(twl6040_codec_rsrc);
			cell->platform_data =3D pdata->codec;
			cell->pdata_size =3D sizeof(*pdata->codec);
			children++;


-- =

P=E9ter
