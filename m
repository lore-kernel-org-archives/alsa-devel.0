From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs35l36: Add support for Cirrus
 CS35L36 Amplifier
Date: Tue, 13 Nov 2018 11:25:56 -0800
Message-ID: <20181113192556.GI2089@sirena.org.uk>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5740456923395706044=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 40D7C26751A
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 20:26:04 +0100 (CET)
In-Reply-To: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============5740456923395706044==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K1SnTjlYS/YgcDEx"
Content-Disposition: inline


--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2018 at 12:49:16PM -0600, James Schulman wrote:

> +++ b/sound/soc/codecs/cs35l36-tables.c
> @@ -0,0 +1,315 @@
> +/*
> + * cs35l36-tables.c -- CS35L36 ALSA SoC audio driver
> + *
> + * Copyright 2018 Cirrus Logic, Inc.

Please use SPDX headers.

> +	SOC_SINGLE_TLV("AMP PCM Gain", CS35L36_AMP_GAIN_CTRL, 5, 0x13, 0,
> +			amp_gain_tlv),

All volume controls should end in Volume, see control-names.rst.

> +		regmap_read(cs35l36->regmap, CS35L36_INT4_RAW_STATUS, &reg);
> +		if (reg & CS35L36_PLL_UNLOCK_MASK)
> +			dev_crit(cs35l36->dev, "PLL Unlocked\n");

WARN_ON_ONCE?

> +	}
> +	return 0;
> +}
> +static const char * const cs35l36_chan_text[] = {

Missing blank line.

> +static const char * const cs35l36_boost_text[] = {
> +	"On",
> +	"Off",
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(boost_enum, SND_SOC_NOPM, 0,
> +		cs35l36_boost_text);
> +
> +static const struct snd_kcontrol_new cs35l36_boost_mux[] = {
> +	SOC_DAPM_ENUM("Boost Enable", boost_enum),
> +};

Simple on/off conttrols should be _SINGLE controls with Switch at the
end of their name.  It's not super clear why this is in DAPM as a widget
at all, the routing around it is:

+       {"BOOST Mux", "On", "Channel Mux"},
+       {"CLASS H", NULL, "BOOST Mux"},

which is a bit perplexing.  Possibly this should be handled in the event
for the main amplifier?

> +	if (cs35l36->sclk > 6000000) {
> +		fs1_val = 3 * 4 + 4;
> +		fs2_val = 8 * 4 + 4;
> +	}

These are just constants, why write out the operations?

> +
> +	if (cs35l36->sclk <= 6000000) {

if/else?

> +	/*
> +	 * Rev B0 has 2 versions
> +	 * L36 is 10V
> +	 * L37 is 12V

\o/

> +	}
> +
> +	return IRQ_HANDLED;

This unconditionally reports that it handled the interrupt, even if it
didn't.  This will stop the interrupt core handling for faulty interrupt
lines working and will disrupt any support that gets added for handling
shared threaded interrupts.

> +	if (pdata)
> +		cs35l36->pdata = *pdata;
> +	else {

Use { } on both sides of the if (see coding-style.rst)?

> +	cs35l36->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						      GPIOD_OUT_LOW);
> +	if (IS_ERR(cs35l36->reset_gpio)) {
> +		ret = PTR_ERR(cs35l36->reset_gpio);
> +		cs35l36->reset_gpio = NULL;
> +		if (ret == -EBUSY)
> +			dev_info(dev,
> +				 "Reset line busy, assuming shared reset\n");
> +		else {
> +			dev_err(dev, "Failed to get reset GPIO: %d\n", ret);
> +			goto err;
> +		}
> +	}

This doesn't handle -EPROBE_DEFER.

--K1SnTjlYS/YgcDEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrJUMACgkQJNaLcl1U
h9DFpgf+MAhdd4ZqN3hG39P3q28ff9wbHxlPgE0LvAjVeXZXhsijAIBxYsCyGvQJ
4p3s1ylY9Bb5LAA1C65+83SKDY4y4+x/3ZIHjV9duFqJhVBqxYkFd06QhLnnIRB0
asJbX0wL9a+vKolXvbXP3QTxB3VItztv9AclPAddTk6+4KelTWR+I9z13jtLMr5f
II5XPh1Pd1jYUAB0m5oXEj9lopQV3CiYPEZg0VgEghn5v5jCVDiSG79cecKPkWh8
t21QiCl+NqSDu1UC5MtRnw8anTbypoeI6imzvRiCoLhddQjFygdK55cY3GrCnQAQ
VJKER+DBrmkCdgyCKDIPRgB3gS5/lQ==
=72Ct
-----END PGP SIGNATURE-----

--K1SnTjlYS/YgcDEx--

--===============5740456923395706044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5740456923395706044==--
