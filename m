From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs-saif: check BUSY bit in hw_params() only if
 not mclk_in_use
Date: Fri, 5 Feb 2016 13:37:12 +0000
Message-ID: <20160205133712.GC12311@sirena.org.uk>
References: <1454505500-30384-1-git-send-email-mans@mansr.com>
 <20160205131944.GB12311@sirena.org.uk>
 <yw1x60y3i94n.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yw1x60y3i94n.fsf@unicorn.mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 01:23:20PM +0000, M=E5ns Rullg=E5rd wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Please remember to CC the maintainers for the driver when sending
> > patches. =20

> I CCd everybody scripts/get_maintainers.pl suggested.  How am I supposed
> to know who the maintainers are if they're not listed in MAINTAINERS?

By looking at people working on the driver in git and the authors listed
in the driver (get_maintainer --git will do most of this for you, though
you do have to think about false positives).  As previously advised this
is not something that can be fully automated, you need to think about
who you are sending things to and why.

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtKWHAAoJECTWi3JdVIfQO3YH/A+XgbhfAAWWc0lGIKLNcAJs
R+uwuXNu23hqii/XXIVfpdGGE+eEC+v0Z+PYfErcObntd0Fd98BDInc3ng4rmJcr
IYbKUjXm8X0+O5V5OqD7j/EQCyBP7+wb1ixdmu/8NMidOt11mBcrWD6xVcdQh6XR
uci10NXiqRMP2O9Y20+DQwVgU2tJBjJL2zc+PL3yZC10FcdeTCkchNGYkSMa3Fra
cO7bWpQkMN7qdjhyE9peaEOhxBQtglJd/wWJ+xJIWYf4ocuMmIriDCHWa7PUt/+u
L948ZB66RAykdILLRxKJy6CITntsTlDFEtSmgig5nfp1HBjdRiihOJ6J+VyFWQA=
=szS9
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
