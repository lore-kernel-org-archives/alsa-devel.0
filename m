From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5660: Add ACPI support
Date: Mon, 19 Dec 2016 15:44:28 +0000
Message-ID: <20161219154428.qedy4fxmtsvownvh@sirena.org.uk>
References: <20161219135147.24208-1-shrirang.bagul@canonical.com>
 <20161219135147.24208-2-shrirang.bagul@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ywiii3h3xx2p3oha"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161219135147.24208-2-shrirang.bagul@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--ywiii3h3xx2p3oha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 19, 2016 at 09:51:46PM +0800, Shrirang Bagul wrote:

> +static const struct acpi_gpio_params audio_wake_intr_gpio = { 0, 0, false };
> +static const struct acpi_gpio_params lineout_mute_gpio = { 1, 0, true };

Can we please write these in a fashion more idiomatic for the kernel and
useful for human readers with named struct fields?

--ywiii3h3xx2p3oha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhYAFwACgkQJNaLcl1U
h9DERAf+PRU0DH+T6GFoz6QN9gNCy5aN6NOSbJJdB5Ui1smP9BRG0+hoYAjmIGCQ
E2i4YqbNpkLBMeU0v9mgmTIP4Gx+l4OrHm76L7hOKnUbB2xi996fSHBjWeFl++XQ
Xz2GYQoKYms3jY1JA3FUWU2T5bLmDjM6GEtA7dMwvm+RHcmVPn2qKoNYT4sA9gdB
/cWD70IGOHDUqi7vraS6bPQWWLB5kmzS3PGnkyh4x6H09S3Y7GWprzkD7K+Fgb35
zLuHBsxAsXQDK7TxAS9UeIJLqV7l2iKmsjUmk9rPZwRR3NgW7lf37pQdDamAD+L3
9/0jpxM2aFkJ4Hf2a4fYPSV8n9rGsA==
=6VZM
-----END PGP SIGNATURE-----

--ywiii3h3xx2p3oha--
