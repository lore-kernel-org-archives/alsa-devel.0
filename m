From: Mark Brown <broonie@kernel.org>
Subject: Re: [Resend] [PATCH v1 3/4] ASoC: dapm: Avoid creating
 kcontrol for params
Date: Fri, 22 Sep 2017 10:19:21 +0100
Message-ID: <20170922091921.kpl4r3fuutgaoizw@sirena.org.uk>
References: <1506066940-56758-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2986427596783705248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E8636267662
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 11:19:23 +0200 (CEST)
In-Reply-To: <1506066940-56758-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yesanishhere@gmail.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2986427596783705248==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2mtmewbfkm53day"
Content-Disposition: inline


--d2mtmewbfkm53day
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 12:55:40AM -0700, yesanishhere@gmail.com wrote:
> From: anish kumar <yesanishhere@gmail.com>
>=20
> Currently in codec to codec dai link if there are multiple
> params defined then dapm can use created kcontrol to
> decide which param to apply at runtime.

You've sent me patch 3/4 and only patch 3/4.  What's going on with the
other three patches?  Please remember that the entire purpose of
numbering patches is to order them in a series, if you're not sending a
series there's no need to number things and if you're sending a series
the numbering should reflect what you're sending now, not any previous
versions of the patches.

--d2mtmewbfkm53day
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnE1ZgACgkQJNaLcl1U
h9AmGgf+LmcAA+OjbLZDiq+9hcRPjJMEJOegvz1VcrARZvgpFb/sYIHpokMyvTFo
PdIDsgu0+KELqpzuFxR5A9FiOrToGKmg1aYOSFeL4rtcEzxPjezYCzzhKpocMa3r
TsXqpZ41sT9NzrJ2TgzzxNjZ8mhOxPBUw0w8e05ISZ8BobEM9DkN8RBk/6ufmwex
HhK4YrDwAo1aHNW/bUJd5QAt2+EYaT/diP5LVdogc30r+SHRLr1xCVBiE4soeZkL
pC19BCDw7sMkSZ9G4K6PcuSwviEWUkCDsoVp//IrkZ3clBPl5UlG6O7AxHSteBXZ
87ZbzcxoWe9RVvTOC7XYDy2YfjCozg==
=e22D
-----END PGP SIGNATURE-----

--d2mtmewbfkm53day--

--===============2986427596783705248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2986427596783705248==--
