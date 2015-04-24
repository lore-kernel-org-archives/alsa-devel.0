From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Fri, 24 Apr 2015 10:28:39 +0100
Message-ID: <20150424092839.GI22845@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org>
 <20150418113632.GE26185@sirena.org.uk>
 <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
 <CAJzqFtYZ8=k7ETGyXYoDTpjNdPQ7oRrMxO+kG++3diFif6Ox1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y+dl6OcicAkN96vR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtYZ8=k7ETGyXYoDTpjNdPQ7oRrMxO+kG++3diFif6Ox1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--y+dl6OcicAkN96vR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 05:47:49PM -0700, Kevin Cernekee wrote:

> This is mostly working OK, but regcache_sync() assumes that the
> hardware registers have been reset back to the default values.  The
> "pdn" GPIO doesn't actually reset the state of the tas571x; it just
> makes I2C inaccessible and inhibits audio output.  So if the factory
> default for mute is 0, corner cases like this fail:

...

> Aside from unnecessarily pulsing the reset GPIO when transitioning
> back from SND_SOC_BIAS_OFF or overriding regcache_default_sync(), can
> you think of a way to work around this?

Do you need to work around it?  If the register map is being perserved
you don't need to sync so just don't do it - it's just that the normal
expectation would be that power down would cause the register map to be
reset.

--y+dl6OcicAkN96vR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOgzHAAoJECTWi3JdVIfQ7hkH/1+Yd8imLUyeL3ROffmFUfAn
fN7AhxP5HE/fmyFrUHx09FT18qpPfcP/ijQdiey0YE0UhEITWnzE1jWZ8YB9PNU6
iMDKQ561LCIw6xThw16Y9PGWkaqnpqXZjVy3i1QVdh7f6eclrbL6hxihxxkw/5kX
6IoYzFB0TMKBpLo9/CfLDK9ZjBBRdxsaCx7EZrP1y6qT7u0NMPSinVMNEfvwvvuY
Q3L92jFNEAd8Tj5xycPBd5nMBgyltMTLUQngjEkXfqGVJkwxpzhN/oqtkIRXBzmI
zdvr/VSEo6HWCwBV3h6fXQ0uHGU6A/wpMneqqP4OtSY3jFan25DNB+oNwupV1Ck=
=f0W7
-----END PGP SIGNATURE-----

--y+dl6OcicAkN96vR--
