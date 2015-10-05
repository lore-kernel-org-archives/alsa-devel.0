From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC : dwc : support dw i2s in slave
	mode
Date: Mon, 5 Oct 2015 16:31:17 +0100
Message-ID: <20151005153117.GW12635@sirena.org.uk>
References: <1443217704-28814-1-git-send-email-alexander.deucher@amd.com>
 <1443217704-28814-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7089404967607749534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32EA12606DA
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 17:31:51 +0200 (CEST)
In-Reply-To: <1443217704-28814-2-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7089404967607749534==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6M1qd/2fGtHH53kd"
Content-Disposition: inline


--6M1qd/2fGtHH53kd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2015 at 05:48:22PM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> dw i2s controller can work in slave mode, codec being master.
> dw i2s is made to support master/slave operation, by reading dwc
> register.

I'll apply this but can you please send a followup implementing a
_dai_fmt() operation that checks to make sure that the mode we're
setting corresponds to what we read back from the hardware.

--6M1qd/2fGtHH53kd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEpfBAAoJECTWi3JdVIfQK4oH/1CzGOWShldjy3Hlo0EYVeb4
awIT8OIHRuKknVaADhWW/KJdBnBQC4tyZxuczvHIt0V2afAF0zhNMNFZ0jKJMofb
7Br1kx/brxKquhP8xo5IJYZB2w7lLaU+ZvYKTvZkRqzr9y0s72Y2xlPm7TlqgedM
LKuyt/dlOJY8utuX8e5ZdOxxBNaRmp2TU6R7y3824x9YV3RzpYbug0r/1lLJ6NoR
R73z0NVYFXIPN84dK4EI0g1JOytQ6pyT9RtvGVRauAzad3ivpgv9jV0gu+5Q/XVT
Bd38yh6vHxA965TuFgIIJI8X4c1U1B0dRFfteuU2N/+Q9L6fipCAVDv5maGSqjg=
=yMV2
-----END PGP SIGNATURE-----

--6M1qd/2fGtHH53kd--

--===============7089404967607749534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7089404967607749534==--
