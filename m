From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Wed, 5 Mar 2014 09:55:01 +0800
Message-ID: <20140305015501.GS13126@sirena.org.uk>
References: <cover.1393941102.git.jsarha@ti.com>
 <ba9718f573ca9195c80075a15fe114e0d4557da0.1393941102.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cbvl/UgeRTPlujdB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ba9718f573ca9195c80075a15fe114e0d4557da0.1393941102.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--Cbvl/UgeRTPlujdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 03:54:49PM +0200, Jyri Sarha wrote:

> +- ai31xx-micbias-vg - MicBias Voltage required.
> +        MICBIAS_OFF - MICBIAS output it not powered

Same comment as last time - why is this something which can be selected
in the binding?

> +        MICBIAS_2_0V - MICBIAS output is powered to 2.0V
> +        MICBIAS_2_5V - MICBIAS output is powered to 2.5V
> +        MICBIAS_AVDD - MICBIAS output is connected to AVDD

The numbers still need to be defined in the binding, the point with the
defines is to make both code and DTs more readable but we need to know
what is actually going to go into the binary.

> +	/* Mic Bias */
> +	SND_SOC_DAPM_SUPPLY("Mic Bias", SND_SOC_NOPM, 0, 0, mic_bias_event,
> +			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),

The idiomatic thing would be to use the pin name.

> +	/* Make ADC turn on when recording even if not mixed from any inputs */
> +	{"ADC", NULL, "Internal ADC Source"},

Don't do this (or the equivalent from the DACs) - we don't do this for
any other drivers, we shouldn't do it for this one.  If we're going to
do something like this it should be generic not per driver hacks.

> +	case SND_SOC_BIAS_STANDBY:
> +		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
> +			aic31xx_set_power(codec, 1);
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		aic31xx_set_power(codec, 0);
> +		break;

Just inline the set power function, or at the very least split it into
separate on and off functions - there is zero shared code between the
power on and off paths.

--Cbvl/UgeRTPlujdB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFoPyAAoJELSic+t+oim9/lsQAJJxdUHcqmEjN1zX7CeZXTTP
KzTU7cvi1+WToD/WDpDn5mYUHomJBPv+bxsPoU/PLLPanffkO5McVv+TH7oo075g
s2JDKKGWhvngttz8nE7a64dHw5zf84uFTuBZVXsd/WguuNsHvWTPp5MDr7mJtR32
i6ZQfq+BglhoMX/6LHPd3RMiXnzryvVVGpBNX3Rii7lOafawvCVwfttVjZzBaf5r
IRY99V5P4G5p5jwtvIaSrOTwk1aqgV35PnZtgKU8iMxcOfipfI/MrlpboZCXnL63
x3EXyYHWJq0ThlJ5ZFRpjYuvEhs+HCd0bw+bJ2Yl+9V4ZcY+jUDtLKJLvA+yNQrE
AOIQjJby5NhKLulk+UwcJ/qWUja8hAC15v5lDF4mqfZhqk1XRjMBRpFo8uTk0FwV
eiyLllUNo7eTxRhybtlVhSZFYfkOqeT4qOgS+gTIc6p8Iss0Da6hkmQu1rh4zB9t
5NVRe6/FDNhaYkDtLhbhwn+HxxvPcNe76WBzFltF+BRmLCFo9XNvc8e4N0Q0KsK2
iwJ+168f3XZuX1xckSzH+tXwbl+SXatrGeIk/AxM2n68fEJHOeo/xsO59YjpngO1
FOx4ILoyHkXN9duZqPukqR3MF1lerY8znxVJyIFMhfAFs4y61mC6K7DFAH7IZXVq
UgEGm7Ou0MBKZsOpVggr
=6MKt
-----END PGP SIGNATURE-----

--Cbvl/UgeRTPlujdB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
