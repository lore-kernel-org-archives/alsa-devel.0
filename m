From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
Date: Mon, 28 Apr 2014 10:54:53 +0200
Message-ID: <20140428085453.GC15179@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <20140424114403.GN12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9048948357251049639=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4104E2615A6
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 10:55:08 +0200 (CEST)
In-Reply-To: <20140424114403.GN12304@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============9048948357251049639==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 24, 2014 at 12:44:03PM +0100, Mark Brown wrote:
> On Mon, Apr 14, 2014 at 03:35:30PM +0200, Markus Pargmann wrote:
>=20
> > This series is a cleanup of the fsl-ssi driver.
>=20
> There's been some review comments on this series but only negative ones
> and I've not seen any testing reports either.  Are the other patches OK
> for people?
>=20
> > There is no DT binding for regmap yet, as this should be solved in the =
regmap
> > framework first. The current configuration should at least work on the =
same
> > SoCs it was previously used. As soon as we have a common DT binding to =
set the
> > endianess we replace it in this driver.
>=20
> I'm really not convinced that this is a good idea to be frank - I would
> expect devices to still need to be involved to set defaults.

What do you think of some framework function like
of_regmap_parse_endianess()? This would offer a common devicetree
binding and the driver would still be involved.

Regards,

Markus


--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTXhdcAAoJEEpcgKtcEGQQBpkP/Rpkxd6iX1eMsNWEKGXzkVFM
pZqzB7sxLUWTSBHqwHyLukscGxdJO+Fvb6dUodgOzQqwZqaT+sazCaoWdriaa1Hb
BnLg+fU5f5IAyzCCdlJHNnGwmCkVgfq/gD49R0LAdG0TtT8JVfqpU/ts6w4xTJYb
LEsLCy+ZTrf4hnON5lnXq81mOvanCYi426aK0sFpCUlTAGLNqKrmC2yitmUkEvy+
1dJnLHn/41jE4Xm3ATuPpdytOL9xegchoa9xTwsgkolErZSPaX1nbLoUWZZZLkRp
eIIOR07UxXxU36HZId8fSpWDs40yEEb5ZU0FB4516z2Q+s44oWnUQMaV7GlCBa7P
e6bo8IH6vNIcQnZL6fcHGpe9yensVqpWBbq2wcEvDFyBctg6bsqiH1jLOzVGRAej
gtGlqPBgkzfbMTQqlIYiL39zusAdQyoiKr03PGHWD+dJmSTydTIjHA/mF676I4Yd
HkWvYjJB/73RYVbHephzJ1GWrFJQaOx+JoysyNEe2tCS4FADj8MvoJsppEzSvdtt
DUF2dkDacJ/XByAN7u5l1RLGid1Z3xErgSbw6OtJI49jOSjcpviGPI5skgenAMyq
GAh32CllcGLFtwhsLBCXyL+AQYSDEzTrK2Yv3YrhtbO7sVYeXSu/fjfCJZXuJGMk
p8MZrJkIojOVewDSUt9m
=FKkw
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

--===============9048948357251049639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9048948357251049639==--
