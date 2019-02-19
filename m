From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Date: Tue, 19 Feb 2019 17:18:03 +0000
Message-ID: <20190219171803.GC20883@sirena.org.uk>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
 <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
 <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Codrin.Ciubotariu@microchip.com, lgirdwood@gmail.com, dannenberg@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 19, 2019 at 11:06:48AM -0600, Andrew F. Davis wrote:

> Did this work for you before? Strange it would if reversed, I wonder if
> the SLEEP bit is really doing anything here. Can investigate later, for
> this patch:

Thinking about it some more I'm wondering if it gets overridden by
something else (ie, the CODEC actually being asleep requires this being
set and some other thing being turned off).

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxsOkoACgkQJNaLcl1U
h9C8cgf/bElHXfzIqyP2DfbS7VJ8xR8goYpHDclWxxsbAmGZzhUt1T3BOkcSIG66
QtUabn0AxqGUIywyf/2eFleKxlXrAQFrgYEzQagBqu/umyf4/kkTvcl1qEaYXIOD
7dLB1oYPa3Ey5NPkcNXGjBv3debezssjQHp7aLBnAqKvbV1y6u2iJxZqlGKHfHmu
zWidKOEBUqrr2EkzybpxNSg1eGBcFbFL80uTlAajklBMMuDSC0+6ZyWUTfUtpx2t
tvh7b7ch4XYJGHI/MrSzkonkQ0SiOWJI8NquV+yIz0fditA70i81YZJLvMJGxliC
DlOLBEeD/YGnF53GNmeH60kH2eWLlw==
=YvJQ
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
