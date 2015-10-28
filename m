From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: wm9713: convert to regmap
Date: Thu, 29 Oct 2015 08:47:15 +0900
Message-ID: <20151028234715.GG28319@sirena.org.uk>
References: <1445983102-15490-1-git-send-email-robert.jarzmik@free.fr>
 <20151028124351.GK10520@ck-lbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yHmUJ2Jgby4Rx//r"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151028124351.GK10520@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--yHmUJ2Jgby4Rx//r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2015 at 12:43:51PM +0000, Charles Keepax wrote:
> On Tue, Oct 27, 2015 at 10:58:21PM +0100, Robert Jarzmik wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> Why is the necessary? I can't see an obvious sign that these
> writes bypass the cache in the non-regmap version, am I missing
> something? Also if this is necessary I would quite like it to be
> accompanied by a comment in the code to explain why it is safe to
> do this here. Regarding the inherent dangers of cache bypass I
> explained in my last email.

It's probably worth pointing out that the functionality in the regmap
API is essentially the same as the functionality in the old ASoC cache
code, a conversion should pretty much be a case of directly translating
API calls.

--yHmUJ2Jgby4Rx//r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMV6CAAoJECTWi3JdVIfQyJUH/RZEzqvI+AsFLiddYxAab9Bv
6QbFEAZgyM7W8jH34D2/FZ28n33t8jif3d56OtYLi7nEVIFzpEyIyT9WT7uvtqWH
y10t5SF6zErVoggXDhCXxLK6OTuqQ2tTpIyq2ZvGtkunvs+KJlXGHETaSxuPrzdx
BFOsGKdL4g03fEUCrWAZZoiQ/6MezB2Yxqr+pIa+rJY2SlAe4s0AQ/edaqLyIlUX
QcaeWrVg3YIY0gEzDGVIqGIUj1lop60CdsPs7Jo2bx8aqcGA1zJ6FBkAlZzQ0+9x
2merXEDRlqvwzhEd/C50wDbCaRZYxzsJXc3LAtSAVcEYZ3Mv5CLjmv43Lv1WrjA=
=lcar
-----END PGP SIGNATURE-----

--yHmUJ2Jgby4Rx//r--
