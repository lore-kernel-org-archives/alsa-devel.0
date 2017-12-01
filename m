From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 10/19] ASoC: tlv320aic31xx: Add MICBIAS off setting
Date: Fri, 1 Dec 2017 17:43:00 +0000
Message-ID: <20171201174300.hoocutyi6c7jtfx3@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-11-afd@ti.com>
 <20171201133028.svemo5qedyfqrt7y@sirena.org.uk>
 <afa96737-d17a-c854-b3a8-30730e06dd99@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zvyefnnbzf3kwr2l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <afa96737-d17a-c854-b3a8-30730e06dd99@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--zvyefnnbzf3kwr2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2017 at 08:56:31AM -0600, Andrew F. Davis wrote:

> Personally I wouldn't have put MicBias voltage in DT to begin with, it
> is runtime configurable and depends on user runtime inserted microphone,
> not really a hardware description :/

Usually the system as a whole is specified to have some particular kind
of microphone attached (or soldered in) and this follows from that.
There's typically also soldered down analogue components that are
selected based on the bias voltage so a specific system likely won't
have the full flexibility.

> The enable/disable is controlled by a DAPM and should be wired to enable
> whenever we are recording from the related microphone pin. So then
> without MICBIAS_OFF the user is forced to select from the above voltages
> whenever recording, which may not be correct if they are using a mic
> that doesn't need bias.

That'd depend on someone having a board that was able to detect that a
line input was plugged in or a user control for this.  If the board was
permenantly set up for line input presumably the bias wouldn't even be
wired up.

--zvyefnnbzf3kwr2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohlKMACgkQJNaLcl1U
h9BQSAgAg1QaEZmgNMhIy9+/1qv6q++jghnEYt5WehUwUBLMGrVkIFeLLdm9D4ri
E+4ds/VqVP/u0H00gqGj6QDQ/I49QSpElm8cGlWGMF8rR5/CxTCTbWHnxStQxZ0B
Q/HPT8wCEOwC2rk58tsLsn2qSwB5MWgo8zIGzVP43z5LB+JmUGunIrzgdKLQ3B1Z
RXQspBS/pZez2YUJpZPSyFpKgfCdU0ZYixX1DMHX2Dgqu+UQ/SMfJamSSMrBVqga
SESbjYZ5p4jAcrkxEvYHD116fJRpC3beKqfmjE9f/CvUIYpQwEH37fz/u1RObsUv
8UYjSP5rzIdBFvnLWLzT42F4hfe9vA==
=2cYJ
-----END PGP SIGNATURE-----

--zvyefnnbzf3kwr2l--
