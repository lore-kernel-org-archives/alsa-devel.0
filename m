From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7] ASoC: cs53l30: Add codec driver support for Cirrus
 CS53L30
Date: Fri, 27 May 2016 21:38:39 +0100
Message-ID: <20160527203839.GE29837@sirena.org.uk>
References: <1464205114-17202-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464205114-17202-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: robh+dt@kernel.org, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, lgirdwood@gmail.com, Tim.Howe@cirrus.com, somduttar@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 12:38:34PM -0700, Nicolin Chen wrote:

A few minor issues but this is mostly OK so I'll apply - please send
followup patches.

> +	SOC_DOUBLE_R_TLV("ADC1 Pre Amp Gain", CS53L30_ADC1A_AFE_CTL,
> +			 CS53L30_ADC1B_AFE_CTL, CS53L30_ADCxy_PREAMP_SHIFT,
> +			 2, 0, pga_preamp_tlv),
> +	SOC_DOUBLE_R_TLV("ADC2 Pre Amp Gain", CS53L30_ADC2A_AFE_CTL,
> +			 CS53L30_ADC2B_AFE_CTL, CS53L30_ADCxy_PREAMP_SHIFT,
> +			 2, 0, pga_preamp_tlv),

Volume controls should end Volume.

> +	regcache_cache_only(cs53l30->regmap, false);
> +	regcache_sync(cs53l30->regmap);

Should really check the return value here.

> +MODULE_AUTHOR("Paul Handrigan, Cirrus Logic Inc, <Paul.Handrigan@cirrus.com>");

I'd have much preferred to have seen Paul's signoff on the patch.

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXSLBNAAoJECTWi3JdVIfQLSUH/junjyaLyyfuGLTobR16nNS0
1Nd0++dm+mC8+oM9LWdPpu5fRBgGXav9wQfG+gECY7eEnZSUgGgIPKKMmt2nr+rz
SJ+Gv9mfd/3xuk0vZCI7q61+FRSXSW6Y0vZ7gxYkX14EIJpFJ0ZplT9bv9Gfbvuu
jdAp5CNkuqEfQihRcN8J9n2pyf4bq4NgXvqlLYw8M70LHVmGmlaLBaGjgQJKY6qO
l+/OhTJsRaSRyAkvpyj9ZnX//c2UPQYuEZmOMwk0UUdkEZfQ1CL0ORzmrXSW7CgN
H1yMWVg6JF8COhc7gcZJK+fkMFgPO2qBp7FP1Uv8gAMtcopbAU6PmDtyr/rQ/Nk=
=zhI3
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
