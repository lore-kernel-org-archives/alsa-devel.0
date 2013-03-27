From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ARM: clk: imx35 sound admux_gate bugfix
Date: Wed, 27 Mar 2013 15:50:11 +0000
Message-ID: <20130327155011.GY18316@opensource.wolfsonmicro.com>
References: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
 <1364383352-27267-3-git-send-email-mpa@pengutronix.de>
 <1364385420.5442.12.camel@pizza.hi.pengutronix.de>
 <20130327123659.GT18316@opensource.wolfsonmicro.com>
 <20130327150420.GB6347@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A2lxmwzFepEIu8KR"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130327150420.GB6347@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--A2lxmwzFepEIu8KR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2013 at 04:04:20PM +0100, Markus Pargmann wrote:
> On Wed, Mar 27, 2013 at 12:37:00PM +0000, Mark Brown wrote:

> > This is a patch to the ASoC driver?  I just ignored it since it said it
> > was an ARM patch...  Anyway, what I'd expect should be happening here is
> > that the clock API walks up the tree enabling supply clocks - that would
> > mean that either that code isn't there or there's a missing parent child
> > relationship in the data.

> It changes some things in imx-ssi, sorry, perhaps I should have
> splitted it into two patches.

> admux clock does not seem to be a physical parent of the ssi clock, so
> I don't think it should be a parent in the clock tree. But imx-ssi (or
> some other evice) needs this clock to work. As mentioned in the other
> response, I will put it directly into clk-imx35.c so this won't be a
> patch for ASoC in the next version.

If it's the IP that needs the clock then I'd expect the IP to be
requesting it so changing the driver does make sense.  Do we actually
know what the clock does?

--A2lxmwzFepEIu8KR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUxT4AAoJELSic+t+oim9A+cP/i2bFM8bCU3qFx9c/jZ1cG9n
1U9/GJTkXm7lx2CL04AmrfUqPi1kZ+28jB5lYoTeBAh+RFsqF87a5A9Ac+qHda8M
Nz7IeQMmPZEZ9Du3cvxVVyt5IC6mp9JmaR4S5BU5IwGBGFULcgXrnrBWV/xE6Zvh
KV+4zVZyZ7XKAp6MxrGsFuZBrsVeD+qZOIzJAEjpvnd+VlHI99zlYnMm4LENklUf
l2yLyUy9mhFQxM97TmKBSx04ICHpyeaL7nMLHY3RGiX2iATJchRSZfa0fdu293Em
xh6h/WbConJvQVEJTJw3kL1zwKXvQaWadAyMTI2qASc32TVYG6FwRAnoLwSM04S7
2EtXROoViZm/tZwwpyLpyK2OfYP9e9ra7i+JFs2hK9aqDLZlCc4vTKpYW+NZi7IH
umfRMBAUKpyBOLopTtACKFduPMv0djedZjZtb0ELmmc2JcF0XLAQXnlma8APvIXe
pTI7aEnI32xD8YEI0F6w+Lrghmp6iHNZkzvfOEW17Am86k3o4Mww1kSFbVLAs7V9
mwoO76ul9mkTwycoLR7C6OKi9iaGQHtmueMPkTTPen7weyvom7WXUzmSSjWtyVzG
59QvFe64eOzG+FbBD+Sa0CSN/5qpT8gOnrOVaoSKOz5QvTdRgFmeyDC8Mg46ddZu
OfDKTyojGy9ZtX0zcP9o
=Z+oG
-----END PGP SIGNATURE-----

--A2lxmwzFepEIu8KR--
