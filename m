From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Skylake: remove unused 'out_fmt' variable
Date: Thu, 8 Dec 2016 16:15:09 +0000
Message-ID: <20161208161509.34obcoanbsp5educ@sirena.org.uk>
References: <1481176902-131803-1-git-send-email-kirtika@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="czgko5yrvwl5deqz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481176902-131803-1-git-send-email-kirtika@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirtika Ruchandani <kirtika@chromium.org>
Cc: tiwai@suse.com, arnd@arndb.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hardik T Shah <hardik.t.shah@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--czgko5yrvwl5deqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 07, 2016 at 10:01:42PM -0800, Kirtika Ruchandani wrote:
> Commit 4cd9899f0d16 introduced struct skl_module_fmt* out_fmt without
> using it. Compiling with W=1 gives the below warning, fix it.

git can't parse this or your second patch, I can't immediately see
what's wrong but please check how you're sending things and retry.

--czgko5yrvwl5deqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhJhwwACgkQJNaLcl1U
h9DFQwf+Ki6nrtGLGFbBnhHnTBXrDYWct3TSAh/EYgd/zrP7Am0wViuE0JD/8znc
ajcPBnqfXy48E8BOeMTtrrgD05/eKBZL2LaMokjJHbCmUWvopv/LvouMEx/H6u4H
g+i8e5NqVxDglqkQ5/Q6GW3wmYO58Qvs7Td34vjDjs0mUYNtZEoyNYAshEC0jW+v
W8m8j3rRhMlvWXJbeZ0qGvrP2GZ/O0dM1ayfMs6bio5Hv6Ay3mZVEZAciTzaVDIA
UrMZKVl4pvS9wnEYlls2vmS9zpDIfR7glwwMTNRSdn8dVR3j5QAtg5LAhuY0VLMA
ubeOYfcpVExqgjUSmuzx7e0NgtL2hA==
=gFnj
-----END PGP SIGNATURE-----

--czgko5yrvwl5deqz--
