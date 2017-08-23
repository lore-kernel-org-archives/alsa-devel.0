From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 00:15:31 +0100
Message-ID: <20170823231531.7ttg6ngz3njzhbrr@sirena.org.uk>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <20170823092828.7ijy7rthvqkzcgtz@sirena.org.uk>
 <20170823223524.GW17193@bill-the-cat>
 <20170823224752.p3ebgenlnstkd5jg@sirena.org.uk>
 <20170823225452.GX17193@bill-the-cat>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ltnvoa3rytxvwldk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823225452.GX17193@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--ltnvoa3rytxvwldk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2017 at 06:54:52PM -0400, Tom Rini wrote:

> Ugh, typo on my part proving your point :)  I meant _a_36afb... which is
> "ASoC: rt5677: Introduce proper table for ACPI enumeration".  My gut

The code that's causing issues looks like it's generic ACPI code which
is worrying me, it looks like it's dying setting up the PM.  It could be
that the trace is a bit misleading or that it's the result of earlier
damage though.

> feeling (and I'd be happy to be told how to poke ACPI to confirm this..)
> is that the ACPI table is in fact not including some information that
> the code expects and that's why the original patch added an I2C ID not
> an ACPI ID.

I'm pretty sure it's just that the people writing the code didn't really
know how ACPI is supposed to work in Linux so used the fallback path
which appears to have been copied from OF for some reason.  It makes
sense with OF because the IDs OF uses include the name of the part like
the Linux internal IDs rather than just some random line noise like is
apparently idiomatic for ACPI (this one is one of the better ones!) so
there's a decent chance that a driver that gets found might do something
sensible.

--ltnvoa3rytxvwldk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmeDJIACgkQJNaLcl1U
h9D3Wwf+PyPZFcbf9jw931K3Ct2Vzls+O+WRJFUc8D6GWSseM5GtKPUpfxJXLCaR
t8fO+OMsLxj6t+pSXalpkJZFXjcZUBehZaC9eRetIEMvgyP6nf/IRudM7+wA4IhB
HeJrM8FanIFis6hTV7QgG1NiE9AQzL0wjm2qZT0tmYi0cqBGQaf6RZ2zxlK3Gkyg
McEduRsj3Ay+P5O5FiI1D6xVAmP400EZQTHqQ5QJ+beDyQXWfDSe5JW9PWOb1EuS
pDPRCGv3KjPjan/4MG+INNXw4zHYeTVYMUbCJyygcjIM8psImSYu59RGhkP1GXyR
HN9PtAa1IJ06uTn7Guk0r/KARCLgUg==
=JLBh
-----END PGP SIGNATURE-----

--ltnvoa3rytxvwldk--
