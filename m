From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
Date: Fri, 4 Apr 2014 12:51:11 +0200
Message-ID: <20140404105111.GE20621@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <20140403221406.GI14763@sirena.org.uk>
 <20140404064932.GC20621@pengutronix.de>
 <20140404100351.GM14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3237191797428808074=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A99D82657B0
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 12:51:18 +0200 (CEST)
In-Reply-To: <20140404100351.GM14763@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3237191797428808074==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2014 at 11:03:51AM +0100, Mark Brown wrote:
> On Fri, Apr 04, 2014 at 08:49:32AM +0200, Markus Pargmann wrote:
>=20
> > Thanks for applying this series, but could you please drop it for the
> > moment? We found some issues with the baud clock setup for i2s master
> > mode and have some fixed patches for the series. So it would be nice to
> > get this in without fixups if that's still possible? I could send a v3
> > next week.
>=20
> I've dropped everything after "fsl-ssi: Move debugging to a separate
> file" since that didn't compile anyway (though I'll add the binding
> document update as a fix).  In future please don't wait until after your
> patches have been applied before saying things like this, it's not good
> to rebase branches normally.

Thank you. Sorry for the extra work and rebase. I will send the new
version next week.

Regards,

Markus



--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTPo6eAAoJEEpcgKtcEGQQ1x8QAIlTI2G4O8u0Rf5rRNbqSSxp
plp+9o3QCA54hwUWxNELiNvlkMnZ6CnW15CZbxP4JupCebs1myvfocTTuEACiWl2
HIH206StHLgzOrV9n607gxkB5iXHgAcfkTUBmmV/PoOatv59l0hrVcm4B59gr3lh
oKV5TIeEg9jlMpdpFD/JRzTB8vjmHRglPuetdqFKAQE8aXKnZcoj0B/W0gPs7Are
wMC3HtUbR57c3SR1fOjmLm2rvVl7hN8LYXvm4vK/Wj7IcqCm8AItYesUu9HSdQPp
78pXWSs4QFgIXgQvPUckf+D96HmO/bJMsr1mQhP4iLpTVtECBnhhkyoM5txRe7qZ
3BiNoVsSTWvALHVxTiccuyxT6JC3CoKZuk5nzT1DUR0og/mRDs9+uZe/IbhU2QkN
dMHsi1c9ui7ugq8tBgiTp6EA0FiAHPOWnJCgmTvlMVQXkF7Ed4ar7VnTg+SEySRA
C8AVFqKSD3W00Mt8IVgaw6CBKvhBtYK59zaFcNspTlpOzFkllRrLkpqMA7deNP9R
X/GB+Vo6fFQIA7OPbGNn+I0obYoWe9mI1m4HKlhYZXnOEa4EyEEqp2/J9Fzi/6m1
ZGH9X+uK+xol0J9/pSGT4ucaum8LE6E4cD1fUmmsG6JaQAgiy9tQK7k6bbp+JplA
Zrh12VjHDnVRFBHH/caM
=OYBf
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

--===============3237191797428808074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3237191797428808074==--
