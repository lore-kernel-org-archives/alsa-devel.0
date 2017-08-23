From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Wed, 23 Aug 2017 23:47:52 +0100
Message-ID: <20170823224752.p3ebgenlnstkd5jg@sirena.org.uk>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <20170823092828.7ijy7rthvqkzcgtz@sirena.org.uk>
 <20170823223524.GW17193@bill-the-cat>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdwx3g5mbnzdoxcy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823223524.GW17193@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--fdwx3g5mbnzdoxcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2017 at 06:35:24PM -0400, Tom Rini wrote:

> After looking at 89128534f925 (which introduced the above line, and thus

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> support for the Chromebook), I think that 36afb0ab648 and 55e59aa0525a
> are wrong and should be reverted.  It seems like they're an attempt to
> make 89128534f925 be done 'properly' but it also seems like the

Please be more specific.  The only obvious issue with the original patch
"ASoC: rt5677: Add ACPI support" is that it adds an I2C ID instead of an
ACPI ID.  I don't have 36afb0ab648 so I've no idea what it is and
55e59aa0525a is "ASoC: rt5677: Move platform code to board file" which
is a code motion patch and looks more like stylistic faff around the
shambles that is ACPI than anything else.

--fdwx3g5mbnzdoxcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmeBhcACgkQJNaLcl1U
h9BvqQf/XjM4VI+tobAUeYKBXrlmaJ8PhDHlVFjHG0S6P6F6NgM2HFZi5DWyGdC+
ZUrMncVYeQQUjlNB7TNjznjNoiYjMqFLiCvzQOTH8izTXLTLwP/UgU1aeOdLbItC
NV2yfhLYSDbTXZCoB+KO00mgwcd+Gh121cpo5lZrBwtZXVtFtbedUuDr/NeOKQyD
N9oYQ2CXY7JCgucjtqRPj5odPmazTHxukpv2C4VTbtTMlM6M6q8B/V0FMTlOdeWC
BZRLnOpeK18vXeCMYcqMrsgVoqmloFtffVyEhUJAA2LdryCbIzo0KcdfOMnsbBKI
gI8oUpw5XzYpGOIWOSAv3iHVug/QOA==
=bgbB
-----END PGP SIGNATURE-----

--fdwx3g5mbnzdoxcy--
