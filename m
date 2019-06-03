From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] Revert "ASoC: core: use component driver name as
 component name"
Date: Mon, 3 Jun 2019 16:27:27 +0100
Message-ID: <20190603152727.GU2456@sirena.org.uk>
References: <1559298842-15059-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9pXJW6w71JX4l3T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1559298842-15059-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org


--s9pXJW6w71JX4l3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2019 at 12:34:02PM +0200, Krzysztof Kozlowski wrote:
> Using component driver as a name is not unique and it breaks audio in
> certain configurations, e.g. Hardkernel Odroid XU3 board where following
> components are registered:

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--s9pXJW6w71JX4l3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1PFwACgkQJNaLcl1U
h9DFewf+Nrpc5dIbkdtpXJkd+/r3A72X4Qa3bSaqMe32ihQnjGEheNTX/QRKVJRI
2CPV6hCZ21/kjRHjjPZh7wnz3/2ICFPbVFT0oqw7ODSgYB9mbKfJG22awJVr1xtY
jncb8BwIddJhKu2wmP0kFqvZZ4bUhspqeQ5pStUhlrkpy2Vgk3KCzvhDcOaDaMv1
1/+eGxpQfFQyHD6MFK+ilSePDl9ZYm+tnzjtAP7ztdjJaRQRiRhwHTUEHUf+ViAL
Gd789UwaU9no7R0/MxgHHWB/0+qd/JTp91XzVCTJBFu7dlwoLynN4kVAIVrvUDTl
mhhtur3Rm0khwJ2jfqvuVqv8Rwq5ag==
=vsht
-----END PGP SIGNATURE-----

--s9pXJW6w71JX4l3T--
