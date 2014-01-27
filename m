From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/6] ASoC: tlv320aic32x4: Fix mono
	playback
Date: Mon, 27 Jan 2014 18:13:57 +0000
Message-ID: <20140127181357.GB11841@sirena.org.uk>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3821965049339572083=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AD9F260859
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 19:14:08 +0100 (CET)
In-Reply-To: <1390824190-18376-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============3821965049339572083==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 01:03:05PM +0100, Markus Pargmann wrote:
> Playback of a mono stream should output the same stream on both
> channels. At the moment only the left analog signal is valid, the right
> one is just noise.

Applied, thanks.

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5qHiAAoJELSic+t+oim9fpIP/0vMrApJzNwjRpNAF4dS2K+r
CcTybmDr75WiHyWIvnJiEL3R97YyGp7vBvabF2piPYcGSK4gfG8l1UBn9ovodnmY
vfaijDYU3aG3IBSTbozptjdqNIg3QqODEd2jl0hKKYOsOKWOkh6yHCRdDTvA6FrX
dZtxA2wKrcjVm2/UAYBdQTjSGzS32cmNB5fZpRsuSi66dILcOK3QxXdLfH8vZOPU
R0xSwGMgdSFAnaQtY7cduV9Hp6VOcgScfSNABEjJ2N6T1zHES8b1Ob+ruMIBLO66
vaM3nlZ0Kfrn7bGUGRdya7gQuedhgyjxnveqcOcYQ3eU4gGSG4qI4t/iVhrj7dUR
N6oGIa5COSpl0IJzxj45A9K79DSa7AlBhFrip2Vvnn4MSh/G/DiVt/LZQ3D2589B
WRlMU6I99+vxoHwWmlO92i+vZ6qIjsPAkmdX2RRUSLyFFnNSNuQnZZtUoaZUXR/c
Ka9Tm5BtJUjP8MZcop0u4AipZoUl45plqadih4K/wrMvbaHe+8FPGDh4i3CN5d5n
CqIKGYZrks+B2vcgL8ya7c/fir6S9rbwQFl5PHVRDlyrQOgtpywO/CV6yIyfmvV8
dsO2Z2THiW2gSNttycubjlaiNRyb3ZFUvQglFeX9683uvjVse0ujrX+NRATV7F/y
0gY97p4wLOtuYdQ+o+kT
=q7/3
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

--===============3821965049339572083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3821965049339572083==--
