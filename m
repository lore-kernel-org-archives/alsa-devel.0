From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 11/16] ASoC: fsl-ssi: Fix register
 values when disabling
Date: Fri, 4 Apr 2014 08:52:36 +0200
Message-ID: <20140404065236.GD20621@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-12-git-send-email-mpa@pengutronix.de>
 <20140403221143.GH14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5665597390071982539=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D675C265565
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 08:52:43 +0200 (CEST)
In-Reply-To: <20140403221143.GH14763@sirena.org.uk>
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


--===============5665597390071982539==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 03, 2014 at 11:11:43PM +0100, Mark Brown wrote:
> On Sat, Mar 15, 2014 at 01:44:19PM +0100, Markus Pargmann wrote:
> > The bits we have to clear when disabling are different when the other
> > stream is still active.
>=20
> If this is a bug fix I'd have expected to see it at the start of the
> series so we could merge it prior to the rest of the series (which is
> new development) - what practical issues does this bug cause?

I can put it to the beginning of the series. The only 'bug' I could
observe was a enabled SSI unit although all streams were stopped. But I
could not observe any malfunctions through that.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTPla0AAoJEEpcgKtcEGQQGnYP/35GLWenXaxZpTETjuj0bEZl
m0x2HimqsEXV2/dN5ZI7iAUQvboeMbPm4UYslXUoBVROFqhWO4FrSvg5rj9C2wJN
17sJ0ol6XcEp4mQ+cF5txDYuX33Xw+dB5Xe1xSQMzGuBhcw3dfZXEOQs4TZtAhDl
uNinuIfQp8jDfmSGqbAsL9/vbShS+JiKA40cRuxzhoCnXQS3K/dlPAg8dNtkyg6/
MVJEkT957oah9fphydtpn7wqVW1RuqPcEyJwbS6zi7/QrmOFsdj1ngap8VzBZVU4
pBmSiNK+Kh+ozTpd01fH9AAPkCQKiyN0FYGM/BaeTGVPhhtz6IjvCstaZ2DUwLBS
DqOFkhahTIluaZewblbVH2/OnryZQcpFkNevy+Kj3ImNXHh551Yb15AwUGYko8ud
Ajhkbhr7adoyMOuZYG/q4uj6RMJcCpMiKUKbpQf6IzgMQ07JtURxZlmGdZ9CSZG8
8MMt1rnqnRs/NTEJL2tTJBanwia3xontWGvW6x+6n2hq9L3iJzVoxVKTxw0nL+ws
gCH6o+xhe+ARjv1S+iLbOPkVLsyqrNTUT2qNfv4RN2narUrDEKnwSsVjm6KXMZsG
FfEPllwXdGlCXXC5JkuwEBpN3olPNwMYrdQU61Nb30qnymQOkKXVgyHnNrDNx6u6
CYebNTksjoQ+NAkhPyiH
=OFVZ
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

--===============5665597390071982539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5665597390071982539==--
