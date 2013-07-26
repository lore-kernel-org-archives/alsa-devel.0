From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 4/4] ASoc: kirkwood: add DT support
Date: Fri, 26 Jul 2013 11:09:13 +0200
Message-ID: <20130726110913.0a193918@armhf>
References: <20130725111459.145a4aa4@armhf>
	<20130725191905.GR9858@sirena.org.uk>
	<20130725230533.GH24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130725230533.GH24642@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Jul 2013 00:05:33 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Jul 25, 2013 at 08:19:05PM +0100, Mark Brown wrote:
> > On Thu, Jul 25, 2013 at 11:14:59AM +0200, Jean-Francois Moine wrote=
:
	[snip]
> > > -	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> > > +	priv->clk =3D devm_clk_get(&pdev->dev, "internal");
> > >  	if (IS_ERR(priv->clk)) {
> > > -		dev_err(&pdev->dev, "no clock\n");
> > > +		dev_err(&pdev->dev, "no internal clock\n");
> > >  		return PTR_ERR(priv->clk);
> > >  	}
> >=20
> > Does the code providing it already name the clock?  If not are upda=
tes
> > needed to do that?

I don't know. I will reset the clock name to NULL when no DT, so it
will be compatible.

> > > -	priv->extclk =3D clk_get(&pdev->dev, "extclk");
> > > +	priv->extclk =3D clk_get(&pdev->dev, "external");
> >=20
> > Is the clock actually called extclk in the datasheet and so on?  If=
 so
> > it seems better to stick with that name.  Do any boards need update=
s for
> > the new name?
>=20
> "AU_EXTCLK" is the exact name (pasted out of the documentation).
> I don't see any purpose to this name changing.

On Tue, Jul 23, 2013 at 02:59:06PM +0200, Sebastian Hesselbarth wrote:
> As Sascha Hauer pointed out, clocks should be distinguished by names
> (clock-names property) instead of position and then use
> devm_clk_get(&pdev->dev, "internal") and
> devm_clk_get(&pdev->dev, "external") respectively. =20
>=20
> This will possibly also require to update platform_data and legacy
> users of kirkwood-i2s or have different setup functions for non-DT
> and DT. =20

The A510 documentation uses the names "DCO PLL" for the internal clock
and "AU_EXTCLK" for the external clock. So, what about "dcopll" and
"extclk"?


--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
