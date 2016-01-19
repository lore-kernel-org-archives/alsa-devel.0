From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: pcm179x: Add I2C interface driver
Date: Tue, 19 Jan 2016 16:32:08 +0000
Message-ID: <20160119163208.GN6588@sirena.org.uk>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
 <1453132657-18678-3-git-send-email-jacob@teenage.engineering>
 <CAOf5uwnEuUPdUn5hdpX2VytDb8qHP8c56ipEM+Qsu7q_zWGbEw@mail.gmail.com>
 <20160118165657.GE3169@localhost>
 <20160119122524.GM6588@sirena.org.uk>
 <20160119141144.GB12069@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9BKWpuyYU3lIWAUF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160119141144.GB12069@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Jacob Siverskog <jacob@teenage.engineering>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--9BKWpuyYU3lIWAUF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 19, 2016 at 03:11:44PM +0100, Johan Hovold wrote:
> On Tue, Jan 19, 2016 at 12:25:24PM +0000, Mark Brown wrote:

> > This does seem like something that the modules code should be able to
> > cope with - we have a reference from the driver struct to the table
> > which you'd really expect it to be using.  We already have some issues
> > there with userspace not handling multiple modaliases terribly well IIRC.

> That reference is only used for matching, while the aliases are
> generated from the MODULE_DEVICE_TABLE macro (and elf magic).

Sure, but there's no reason we can't change that.

--9BKWpuyYU3lIWAUF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWnmUHAAoJECTWi3JdVIfQix0H/jYYpGuakqqKTb6XsxX4SdtS
9xL3VWHCo2s/lDfk+Z69WmN9fA4K+NBJKdVkxehWt+dAu+yMqLr7okgMZRm32Y3F
Dji3VP6MFFCG8c3B1LiaPF9mVJ5ar7NQyJpidRADAEbaGsOMqc46gKvICoDr/jMo
4cLUItvG+pKLogTZuLAhIpMP88runyG/GyaHCsjIwzYxF1Knt1izXY5PGPiL7iXu
wXQJwIOVoqE3x3kxj6h+BD6ZhjchwAPcxA+5c8S88a+E0qfesUlJRIGyyNUnC8/G
sH28UDvrkBmAgU58Egdj6YzBVSqTDKvL7I0Ieno4ujR0TEbKCuWwUifq9WKKIEw=
=oU2F
-----END PGP SIGNATURE-----

--9BKWpuyYU3lIWAUF--
