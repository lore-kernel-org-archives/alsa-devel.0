From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: Intel - Convert to use
 acpi_dev_get_first_match_name()
Date: Fri, 12 Jan 2018 19:03:12 +0000
Message-ID: <20180112190312.GD21458@sirena.org.uk>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
 <20180105160935.48588-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180105160935.48588-4-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 05, 2018 at 06:09:35PM +0200, Andy Shevchenko wrote:
> Instead of home grown snd_soc_acpi_find_name_from_hid() use
> acpi_dev_get_first_match_name().

This doesn't apply against current code (even after pulling Raphael's
pull request) - can you please check and resend?

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpZBm8ACgkQJNaLcl1U
h9CZDQf+PiyzQu3xKSmImSpyK7LEbagpUO0JZQm8kWvvlnWsqe3CYPIKo746unXy
6QYDMeWXoh5Rawvy2k8x7jYcsDBrgx66OEf8GR1oJgoVo5QVJGAwPSb8Z95LIg7B
oih3vR3xlRIE5fcLMtwyVTuN6edfyIFc/Ku7leZ69NhVvSSEsR/gOvj1JkOW2ak2
gRRuSjy4WdScnR+t4Rv4trH+ZFf4eQcfjhv/GvDr/XgbrppZ9MBRIvCX7WFM8tM8
lS7W2CaHIQAeZdSY0C/7w1gREKVoWB3GMwW9Cb804bt8+d53MB6GYhbQ/3Eehsd8
dOVc//625ub5j1NGjs7y2eDAQsrt+Q==
=OFbF
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
