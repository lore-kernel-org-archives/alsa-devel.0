From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 00:02:17 +0100
Message-ID: <20170823230217.4fsouadwhdheth63@sirena.org.uk>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <20170823092828.7ijy7rthvqkzcgtz@sirena.org.uk>
 <20170823223524.GW17193@bill-the-cat>
 <20170823224752.p3ebgenlnstkd5jg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3qtgyeuhcaugqdqw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823224752.p3ebgenlnstkd5jg@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--3qtgyeuhcaugqdqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2017 at 11:47:52PM +0100, Mark Brown wrote:

> > support for the Chromebook), I think that 36afb0ab648 and 55e59aa0525a
> > are wrong and should be reverted.  It seems like they're an attempt to
> > make 89128534f925 be done 'properly' but it also seems like the

> Please be more specific.  The only obvious issue with the original patch
> "ASoC: rt5677: Add ACPI support" is that it adds an I2C ID instead of an
> ACPI ID.  I don't have 36afb0ab648 so I've no idea what it is and
> 55e59aa0525a is "ASoC: rt5677: Move platform code to board file" which
> is a code motion patch and looks more like stylistic faff around the
> shambles that is ACPI than anything else.

My best guess if you're using mainline is that this is triggered by
a36afb0ab6488ea (ASoC: rt5677: Introduce proper table for ACPI
enumeration) causing the ACPI core code to run and explode on whatever
you've got in the tables on that system.  Someone who knows what ACPI is
up to should probably dig into what's going on, even if reverting fixes
it that looks worryingly like we might explode on other devices.

--3qtgyeuhcaugqdqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmeCXkACgkQJNaLcl1U
h9ClKQf+Ou6cJ9u3fHGxbcMFUZi1TLaVryjG640IIK/uqya3PJhW4qtELfgWH+NT
TIOPjL9NgkifLTvqC/xvBKLljkHxWz2x7KIjIRkFOpk394EDRmgDiFUPU7bIdRro
+Mta6jGdKPwlWLypLgxvMyNGrUjKcrh6olhWd49+QsjyZcrDFWA7Pls3hoIEpi8j
vhadZEiLe4WWYl7teSS56BDzeWozh71DM8kePhgqpKmrSN0NNcLR2j73jWzVZrA3
816oxF2fZWT3uuj5aKqi/8SeuyeFyRZjUWJKhMS8DKVuWsvTM981s1KdSXuTe66L
zDSs2rDLUszukABK2rpClIXJUH79/Q==
=zVLA
-----END PGP SIGNATURE-----

--3qtgyeuhcaugqdqw--
