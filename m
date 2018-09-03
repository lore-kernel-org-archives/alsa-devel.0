From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: tlv320aic31xx: Add overflow detection support
Date: Mon, 3 Sep 2018 14:03:18 +0100
Message-ID: <20180903130318.GH10302@sirena.org.uk>
References: <20180831182434.14499-1-afd@ti.com>
 <20180831182434.14499-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831182434.14499-2-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 01:24:32PM -0500, Andrew F. Davis wrote:
> Similar to short circuit detection, when the ADC/DAC is saturated and
> overflows poor audio quality can result and should be reported to the
> user. This device support Automatic Dynamic Range Compression (DRC)
> to reduce this but it is not enabled currently in this driver.

> +	if (value & AIC31XX_DAC_OF_LEFT)
> +		dev_err(dev, "Left-channel DAC overflow has occurred\n");
> +	if (value & AIC31XX_DAC_OF_RIGHT)
> +		dev_err(dev, "Right-channel DAC overflow has occurred\n");

So, this will sound terrible but I'm not sure that unconditionally
shouting in the logs is the right thing to do here - people do sometimes
put non-audio signals through sound cards (using them as generic DACs
and ADCs) and it seems like it could get very spammy.  Perhaps a lower
level warning message, some counters or even some control that allows
the warnings to be masked.

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNMRUACgkQJNaLcl1U
h9Cw3Af+LKV8HPNfxx3p6lOfB6mV5JYNxNsRu3kFxuD5QTioPyOX43gCZCU1WCel
5gg3+uX6ckeV+AuWgVYltO/xACZraf7EfgO1rE0n0rrvCpOJVjeNPalQ2H0xbFcQ
XICnzRCpMQsfLEfULjIg7viL+TFKrRmWFh8h8L5UWYNJvoKt2wERYske8b38MDzy
BL+LDxzxQlR+tt4Gq6oqytajCW2H9m3MdVZWr3KiWMe0xcE0d3q68XH3AGUGanay
iN6kEksVClMWf7R6pwdBRlfCqy6lqzs3v/lYcnCvJhATEkbZZlcs3mU9fLYaL14j
Hp4laiTMRn8gv8eLVWKjLjd6+ytBlQ==
=LiVE
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
