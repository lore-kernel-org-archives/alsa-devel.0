From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: max98927: Removed obsolete variables
Date: Thu, 31 Aug 2017 12:53:59 +0100
Message-ID: <20170831115359.bjw3wbihjzcuh3nh@sirena.org.uk>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
 <1503963061-14763-5-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xu6zc3r5huj2vbz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503963061-14763-5-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org


--2xu6zc3r5huj2vbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2017 at 04:30:57PM -0700, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>

Why are these variables obsolete?  If their use was removed in earlier
patches in the series they should be handled in that patch, if they're
just unused say so.  In general your changelogs could really benefit
=66rom being a bit longer and explaining why changes are being made.

>  mode change 100644 =3D> 100755 sound/soc/codecs/max98927.h

This also changes the permissions to be executable which isn't what we
want.

--2xu6zc3r5huj2vbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn+NYACgkQJNaLcl1U
h9DKHwgAgxiQ+BPpJqoVBHq2jCx+bf63FCdSLRmtlRifXyCmYtMXrKIYOMfypBS0
eMa+iorl+lG4sprZ1k3+Cxt4WiiNu4WHk1Ej7Z9kbU+3F8+K8uaI6Juj6WGSIKSK
UXU8QjecdPwEMc7+ii9lr4xehfCjkUL0FtrtCqwHl22BeztcAe3w+3xGw/ydtLLd
zalQcpiSRkJdVirY+sK/43dR08nktuuO638HgDG02/pXi9KKK7mYhmzn6rmngfP+
fn0yvxrbd04/+zRgNv4NOHWOgYH1Cey1/rWBHiMrObbVC3CJpKJwO65IGJsmcHDR
7nsDa+5aHB/anAX+4oAL82qJiaWHYw==
=5ISB
-----END PGP SIGNATURE-----

--2xu6zc3r5huj2vbz--
