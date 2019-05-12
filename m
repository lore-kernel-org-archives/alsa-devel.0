From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the current
 substream
Date: Sun, 12 May 2019 17:27:26 +0900
Message-ID: <20190512082726.GL21483@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
 <20190506095815.24578-3-jbrunet@baylibre.com>
 <20190508070058.GQ14916@sirena.org.uk>
 <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
 <20190508085758.GE14916@sirena.org.uk>
 <5b677f1581565bd8c915a14cd91352ec4bcabdd7.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5b677f1581565bd8c915a14cd91352ec4bcabdd7.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2019 at 10:11:48AM +0200, Jerome Brunet wrote:
> On Wed, 2019-05-08 at 17:57 +0900, Mark Brown wrote:

> > Probably using a mutex for the flag is clearer.  I'd rather keep things
> > as simple as absolutely possible to avoid people making mistakes in
> > future.

> I received a notification that you applied this patch.
> Just to confirm, you expect a follow up patch to re-introduce the mutex, right ?

Right.

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX2O4ACgkQJNaLcl1U
h9DTqgf+PkO76Y2CBGrPX0MuFUXOjE2QlNeHbqPtBweMBUAI8bHZbVVwZzd4RWQc
MO9Na+UlPDBKHaxlfkC8HqV5Tud6PMmAcXYj/qJCiGewOTwVI+C472JBLfsYfont
dfAkAhqUE+XZ/WlF1MELpoXCWAY3AP/i8RLP7it1dD0Y58HZl3/ofjtB0eIXevAr
HnPMmyv9VzSA9RmD7bEwzeuURho3714tlQs45grB3UtW6h39hDUWHanl8v+uet1u
gyHtxg9tE90edoV83T8lkqwiRuO7Pd+V0XVKM1bvGpNVMEAgR6iAQ02UUgULBzh9
qVZx8lrwwvTjCIQVH+VUw2B5NwV1Rw==
=m9x5
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--
