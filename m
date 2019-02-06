From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: ssm2602: switch to SPDX
	identifier
Date: Wed, 6 Feb 2019 16:57:51 +0000
Message-ID: <20190206165751.GE17630@sirena.org.uk>
References: <20190206152947.2789-1-m.felsch@pengutronix.de>
 <20190206153244.GB17630@sirena.org.uk>
 <20190206165105.phye4het2dywu3ez@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1277723234137636520=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A184426792A
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 17:57:52 +0100 (CET)
In-Reply-To: <20190206165105.phye4het2dywu3ez@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Marco Felsch <m.felsch@pengutronix.de>, kernel@pengutronix.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1277723234137636520==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 05:51:05PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Feb 06, 2019 at 03:32:44PM +0000, Mark Brown wrote:

> > Please convert the entire comment to C++ style so it looks more
> > intentional and is consistent with other ASoC stuff.

> I don't know about how ASoC is special here, but I've seen the style
> picked by Marco quite often and considered that the "usual" style.
> Usually kernel code mandates C style comments and I though only the
> SPDX-specifier is special.

> So ASoC is different in this aspect?

I'm doing the same for other subsystems - I was getting patches from
people converting the SPDX headers back to C comments and it just looks
ugly to me anyway to mix the styles on adjacent lines.

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbEg4ACgkQJNaLcl1U
h9AABQf9H43AapQEeGwQpZWWb0BaKOK3szUjq3ZSg5NH4XPpQH2Xi0CNKJuahT2e
lpqahmnkz5wZYxKDKjfBxK/XbHJrQdK6uhhph8wUOYf/rkkDP4cGl+f0GnOYeAaf
sdUJXcGt5kKA4wdoA23yZQynUC5IyEyVVmntsPVyETaWgQxhPaWnqC7P7uk2+oKq
/99L76L17vbm0gy7LGIHQpiFneJQPkX25X21KmSwCKvbacPxW2BLXXwujXGgWMye
yD7MCAkB/RtWhbimzD7Mk1fOtkh65T/aQxfdzEQ/hOFPK/WU0ydVKi4Jr7InO73T
HM2J/t5x/uQlVA201LInUU9wxQ0IlA==
=GnVU
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--

--===============1277723234137636520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1277723234137636520==--
