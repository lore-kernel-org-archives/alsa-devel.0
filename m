From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] ASoC: wm8903: generalize GPIO control register bits
Date: Thu, 4 Jun 2015 11:34:18 +0100
Message-ID: <20150604103418.GC14071@sirena.org.uk>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-3-git-send-email-vz@mleia.com>
 <CACRpkdaGf+oQA3OF5HnVGXh5exz2L8RSye1Fj=r-=wzsMay_ag@mail.gmail.com>
 <20150604091924.GZ14071@sirena.org.uk>
 <20150604092439.GC3902@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o+hUPwk7FawzfnFh"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150604092439.GC3902@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Liam Girdwood <lgirdwood@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--o+hUPwk7FawzfnFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 10:24:39AM +0100, Charles Keepax wrote:
> On Thu, Jun 04, 2015 at 10:19:24AM +0100, Mark Brown wrote:

> > There's that as well, but more generally I'm not sure if there's even
> > any use of those defines for the driver (without looking at the source
> > to check).

> Many of the drivers contain a gpio defaults style entry in the
> pdata, which basically is doing what pin control should be and
> setting up the pulls/functions etc. But replacing that in all
> the legacy CODECs would be a massive task.

Sure, I just don't know without looking if this particular driver ever
bothered doing that.  The defines aren't pinctrl support by themselves
they're just mechanically generated defines.

To be honest I'm not sure pinctrl is actually making life easier for
these devices, especially without ACPI bindings given that people are
now deploying ACPI based systems.  There's also the whole MFD thing.

--o+hUPwk7FawzfnFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcCmqAAoJECTWi3JdVIfQDdYH/iy4ghGKuGhPM06DfTBYHpc5
M1cnPiCfiO/nLBcy+1ppan7btjBtR4skSoSXbWgE7ZGlgZl87N3TP79t9spReR+L
+SZKwFJFwv4C62BIuoGjhexfCAYyXboJ7Yi4N43jd3w4AzRxnTgoLIg45CkaHz+S
g1sLamlQfRVusFWmQGAPpWypn7Cqh/XGw3FDEh5+vR0KLVzmC/KGFsQJD/OnRV7H
hYpc44e4fRMYrZW8EFf1cXcpbrq/iDoU/I1sh7dfmGMQzxLKT6MnDIzbJFd7T66s
1WGUlufX1tNiIleUYsw4e7VcnadYGuk+0EW3QNt5uQpZ4YH5MQ6SEQSczeLjzR0=
=gUTm
-----END PGP SIGNATURE-----

--o+hUPwk7FawzfnFh--
