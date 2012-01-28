From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/3] regmap: Properly round reg_bytes and
	val_bytes
Date: Sat, 28 Jan 2012 02:14:03 +0100
Message-ID: <20120128011403.GA6669@pengutronix.de>
References: <1327677023-29310-1-git-send-email-w.sang@pengutronix.de>
	<20120127162837.GB18572@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4770702725867490442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2841B103840
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2012 02:14:09 +0100 (CET)
In-Reply-To: <20120127162837.GB18572@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4770702725867490442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2012 at 04:28:37PM +0000, Mark Brown wrote:
> On Fri, Jan 27, 2012 at 04:10:21PM +0100, Wolfram Sang wrote:
> > For the upcoming 2/6-format, we don't see debugfs output otherwise,
> > since the current division results in 0. I'd think 10/14 is broken
> > currently, too.
>=20
> This looks good but could you please rebase on top of topic/core, it
> conflicts with the support for padding bytes.  It's not really entirely
> incorrect, the bytes values aren't terribly well defined for register
> sizes that aren't integer numbers of bytes as they were never intended
> to be used then.  The assumption did leak out into debugfs though.

I wondered if you'd save reg_bits and val_bits there (converting to *_bytes
when needed), you could replace all the format_x_y-functions with a few gen=
eric
functions doing (reg << y) | val. Unsure if it is worth it...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8jS9sACgkQD27XaX1/VRt1bQCdHXDI0c3HFZiqhbs7ow7RxcN7
PjIAoJoh+50BtZIKsGuJcNPmaRDT4UHB
=V/HS
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============4770702725867490442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4770702725867490442==--
