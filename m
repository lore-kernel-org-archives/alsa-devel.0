From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: allow multiple interrupt sources
Date: Tue, 2 Apr 2019 12:02:36 +0700
Message-ID: <20190402050236.GV2059@sirena.org.uk>
References: <20190401205519.34023-1-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mmR5Tf+WJGm+vTLg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401205519.34023-1-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@google.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--mmR5Tf+WJGm+vTLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 02:55:18PM -0600, Fletcher Woodruff wrote:
> From: Ben Zhang <benzh@chromium.org>
>=20
> This patch allows headphone plug detect and mic present
> detect to be enabled at the same time. This patch implements
> an irq_chip with irq_domain directly instead of using
> regmap_irq, so that interrupt source line polarities can
> be flipped to support irq sharing.

regmap-irq should support active high/low, and if it doesn't it can't be
a unique thing that only this device wants to implement so the common
code should be improved.

> +	mutex_lock(&rt5677->irq_lock);
> +	/*
> +	 * Loop to handle interrupts until the last i2c read shows no pending
> +	 * irqs. The interrupt line is shared by multiple interrupt sources.
> +	 * After the regmap_read() below, a new interrupt source line may
> +	 * become high before the regmap_write() finishes, so there isn't a
> +	 * rising edge on the shared interrupt line for the new interrupt. Thus,
> +	 * the loop is needed to avoid missing irqs.
> +	 *
> +	 * A safeguard of 20 loops is used to avoid hanging in the irq handler
> +	 * if there is something wrong with the interrupt status update. The
> +	 * interrupt sources here are audio jack plug/unplug events which
> +	 * shouldn't happen at a high frequency for a long period of time.
> +	 * Empirically, more than 3 loops have never been seen.
> +	 */
> +	for (loop =3D 0; loop < 20; loop++) {

This looks unrelated to the polarity of the interupt?

--mmR5Tf+WJGm+vTLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi7OkACgkQJNaLcl1U
h9Afkwf9FdntMljkuxjoO7lunLTOducb+/sCgTez1Cy1B56H0fZt54s0CAaHFK+9
qmaurcnS5BN4G4nEsLsYuMcgsGnIzUB6cgsg74F1V9YiO61mAieDQyC7WyIFwnPp
SK90F7ZZbbgqepooqtQLtRikLnuPOANRpxH1V44OKuKbsleUCkleJAQ8z7wT9Hnb
bw+b0vYVi6Zu0ylneUhjekCh3ICYwfMW87/pWlKxGWcKGcPMz23jfDHpHz1g1iCp
c2r8Z45+N4vc8/gDsX6g0Pef9MrRPl1IZXS6FuFlXoY+LDt0x/ng5cggaaXYkHi3
v8MhUyHQu7OOI7LS1+AHZ78vKSeKCA==
=k5Nd
-----END PGP SIGNATURE-----

--mmR5Tf+WJGm+vTLg--
