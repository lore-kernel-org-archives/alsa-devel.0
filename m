From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic23: remove incorrect __exit markups
Date: Mon, 9 Mar 2015 18:24:52 +0000
Message-ID: <20150309182452.GV28806@sirena.org.uk>
References: <20150309181814.GA27608@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eRJUXWYUKFXpoo3g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150309181814.GA27608@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--eRJUXWYUKFXpoo3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2015 at 11:18:14AM -0700, Dmitry Torokhov wrote:
> Even if bus is not hot-pluggable, the devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.

Applied, thanks.

--eRJUXWYUKFXpoo3g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eVzAAoJECTWi3JdVIfQcxgH/RVi/Kruc9OqyqcHLhwhQ3pS
wTc2LhYG75fnTP6pBLcdSabfoJS1lJa95qUpJseYUJP9qOAGs7BZD1amFfztKA9S
vdllb5JCVpSdvbr9MrD9/rKa6r3Iq82dfHe3m66lC9U8p5D4uW9iWXf3sS1F3mDa
uRgJ3v+wN6N4iLqJRNA5217o0AHHfI8ppH6obDkhfPMEyvW1ljs9p52cF4Cr9gyN
GIK/k7NQaiwGd4QPZ8u0HhwmOcZ1PYqgbL/0QOBO7TjQopUO9jTl+t4U6UfCmjqA
znFIN4XuR44IFAUe4GeJRPQAHWIaNQx+ueyd3xtKcD67uGXJQkTLfHAPqWdHJ2g=
=hxkt
-----END PGP SIGNATURE-----

--eRJUXWYUKFXpoo3g--
