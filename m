From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Wed, 23 Aug 2017 10:28:28 +0100
Message-ID: <20170823092828.7ijy7rthvqkzcgtz@sirena.org.uk>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ct75u5b6vovkseer"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503453106-5564-1-git-send-email-trini@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--ct75u5b6vovkseer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2017 at 09:51:46PM -0400, Tom Rini wrote:

> Not all devices with ACPI and this combination of sound devices will
> have the required information provided via ACPI.  Reintroduce the I2C
> device ID to restore sound functionality on on the Chromebook 'Samus'
> model.

>  	{ "rt5677", RT5677 },
>  	{ "rt5676", RT5676 },
> +	{ "RT5677CE:00", RT5677 },
>  	{ }
>  };

You're going to have to provide a clearer changelog here, that's
obviously an ACPI ID...

--ct75u5b6vovkseer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmdSrgACgkQJNaLcl1U
h9BFfwf+JP3IhxwtyOYCijR1XgpEWrvRIC3EXl3RA4en5NyWLOVu4+OrZXKJBrOV
2PF1voS+B7qNPJHbTgzrhoOzVP2PH17cO/h5FXv8mr36iSb8vH9GVeiZ4wFWBmXb
Pm7KZgjo4QNbKwQT7xefCUvlqxcJH+TLkkVUL7w6fnAW56f/6VnhsxcPvi+cFnnG
FwydDg2FLbzp7czcJqbydmOzRfbNstt+6satLXeoHBahrydrtTXtHaXkCVuyPkJN
2OY58+fYOMQIC5/PwipHgP9qvTbq6Hby5yRIw53dYNGe/ZJBbR8gCOaNrnAyBjIt
gWQx4y59zVCDv7SwPS1d6soWWsOUqA==
=XuVw
-----END PGP SIGNATURE-----

--ct75u5b6vovkseer--
