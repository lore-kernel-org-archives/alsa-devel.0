From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: zx: fix platform_no_drv_owner.cocci warnings
Date: Thu, 4 Jun 2015 18:16:59 +0100
Message-ID: <20150604171659.GO14071@sirena.org.uk>
References: <201506050116.40gO5c34%fengguang.wu@intel.com>
 <20150604171126.GA226227@ivytown2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CYbV4jyGkzCEppMb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150604171126.GA226227@ivytown2>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Jun Nie <jun.nie@linaro.org>, kbuild-all@01.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--CYbV4jyGkzCEppMb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 01:11:27AM +0800, kbuild test robot wrote:
> sound/soc/zte/zx296702-i2s.c:428:3-8: No need to set .owner here. The cor=
e will do it.
>=20
>  Remove .owner field if calls are used which set it automatically

Applied, thanks.

--CYbV4jyGkzCEppMb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcIgLAAoJECTWi3JdVIfQkowH/2AJyHR8XJlv76FjCCD9QIKi
RfMV5edc/ulo3XbWCkl9LY3kWkt4nBCJFK4/YwhY2CIVLd7zskQ6HazFMzNei6If
pBWasL/97pbZ5nwGzgRfJs7pCol7+U5fjhpWfi5NjMYY7YhJuBlCGjOH8mfMmPqC
q3fffEW+2znb3BinzA3pp44bCPNyK98LNvE2/UQ8Yqy96ODGvsmmwUODbGHFxAiE
nfe4vkydHbUU/dLW11pxeI73s5kPH4V5ezgn6us7OeHse5fC+EhTshsCCGBdSmU7
TgYpyx4qiI6dg4e7LYz0swXVlCroat/GqnJlPV1bLIwDka7tXThnBrcX91G6pX4=
=dVI/
-----END PGP SIGNATURE-----

--CYbV4jyGkzCEppMb--
