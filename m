From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 3/3] ASoC: rt5677: fall back to DT prop names on error
Date: Wed, 8 May 2019 18:04:06 +0900
Message-ID: <20190508090406.GG14916@sirena.org.uk>
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-4-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+if5tLMzDwmTCkiQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190507220115.90395-4-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--+if5tLMzDwmTCkiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 04:01:15PM -0600, Fletcher Woodruff wrote:
> The rt5677 driver uses ACPI-style property names to read from the
> device API. However, these do not match the property names in _DSD
> used on the Chromebook Pixel 2015, which are closer to the Device Tree
> style.  Unify the two functions for reading from the device API so that
> they try ACPI-style names first and fall back to the DT names on error.

This is OK and should probably be the first patch in the series since
it's much simpler than the other ones but depends on them.

--+if5tLMzDwmTCkiQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSm4UACgkQJNaLcl1U
h9BXYgf9HL6kgqhLX5BgKf3C1D9thjRYiOmKbp5R2x6lp5KlyJkhLSBNUFaJVciZ
6cshYtsU42VNjyT9ICN7OD3CoROo+HDvy5PaPfylSaNSUq180OQV6t4KE2SNrGZ8
5O1GpwPLUJ2Q+0biQMPOp4eic90mz3usZtSIFgg9K8i0ZsYtmV2t75OeSETJY1au
nxnYwLttQ1R73oRfaB7/uvYETekume/zHZ5BNi6xFPRgKY2cPoK+qUvWKH6CaaLa
WOufUF3Os1nB7azLSxLfZvhRleqVmpv95d/jHtdYOH4920YbHqsImkyInJc8Uh0z
tkxlqDjblH4PgakMTEmJ+T0M7JEAKA==
=gN76
-----END PGP SIGNATURE-----

--+if5tLMzDwmTCkiQ--
