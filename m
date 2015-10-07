From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: fix build warning
Date: Wed, 7 Oct 2015 15:05:27 +0100
Message-ID: <20151007140527.GK12635@sirena.org.uk>
References: <1444220532-14199-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zkC76Fx3DIm/XDBj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444220532-14199-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--zkC76Fx3DIm/XDBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2015 at 05:52:12PM +0530, Sudip Mukherjee wrote:
> We were getting build warning about "Section mismatch".
> dmi_platform_intel_broadwell is being referenced from the probe function
> rt5645_i2c_probe(), but dmi_platform_intel_broadwell was marked with
> __initdata.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

> -static struct dmi_system_id dmi_platform_intel_broadwell[] __initdata =
=3D {
> +static struct dmi_system_id dmi_platform_intel_broadwell[] =3D {

This doesn't seem like the obvious fix - why are we not annotating the
probe function suitably (or alternatively if we can't why does
__initdata still exist)?

--zkC76Fx3DIm/XDBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFSanAAoJECTWi3JdVIfQUugH/RNy0673Y8cD7yitDUhKGqPh
bOvMxlJxrxvqlQSRCNY0Lm28Nm64BxdWW6tA9b4VUUcK1/5l2ToOAewL5HRjo2Pb
77reSQKw6g8dbvs06lOwD8pZvemSUpNuJcz3973eHXuQbrAteJHZveaI7MIaTmwM
ysBKlUZe/M6y44TwoP21zW0MUtWBOOIDvnchG7dZeEeN1FjdER9dvbi1kvUS4aE5
vPlJRyMZMMN5yJaEGgshXPHMSB0wGGgSZnjg5L6GnUEe6qs0xqvtx0QZTZGub3gl
7wYVX9mTd718nqY5YKugF+GaWTKX97Dy6Owy86oCVxb1ey3NOXXJSWh5rJIGIqo=
=pOMm
-----END PGP SIGNATURE-----

--zkC76Fx3DIm/XDBj--
