From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: wm8960: Let wm8960 codec
 driver manage its own MCLK
Date: Wed, 14 Jan 2015 19:19:11 +0000
Message-ID: <20150114191911.GG3043@sirena.org.uk>
References: <1420615905-4078-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8481428500324956147=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C0B92619D7
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 20:19:27 +0100 (CET)
In-Reply-To: <1420615905-4078-1-git-send-email-zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Zidan Wang <b50113@freescale.com>, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============8481428500324956147==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 03:31:44PM +0800, Zidan Wang wrote:
> From: Zidan Wang <b50113@freescale.com>
>=20
> When we want to use wm8960 codec, we should enable its MCLK in machine dr=
iver.
> It's reasonable for wm8960 codec driver to manage its own MCLK.

Applied, thanks.

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtsEuAAoJECTWi3JdVIfQ/P0H/1+h4uWTLkQ2R4eGJLMzFKA2
d3R48lCthLcJMSU+zECQwZZNnCA0uafBOqSRBfgJcZXAaoLQ+Mg0oAJaM1UUuaxP
ZaBua7bS0AnZGhITAwMQIWGyiCMODudVyl7e2TyMC3ijiEVBc7TCNautYYtomX12
DL20QGvhdYS6bh3SqlMJVQvoNxnWr3+aXp9QHWe31AEMMPV0p3MfxgnkR/qY8V5T
AN1NgwR5UGg7gN4k+QjvPTCAwB5Q9V4AKm4ghB/piF+o5RTLQaqpBplT5TyF4uBZ
lsPkiKAYL4gzAR0AAC3Q2rj4Fg85+9HrgmLIUzpp0nVfbiMjx0XKVPt3Q/1Bet8=
=DLme
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--

--===============8481428500324956147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8481428500324956147==--
