From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5660: add rt5660 codec driver
Date: Wed, 14 Sep 2016 17:31:14 +0100
Message-ID: <20160914163114.GB27974@sirena.org.uk>
References: <1471930423-9619-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1170889996676130015=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C9BD261B03
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 18:31:23 +0200 (CEST)
In-Reply-To: <1471930423-9619-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1170889996676130015==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2016 at 01:33:43PM +0800, Oder Chiou wrote:

> +- realtek,use-ldo2

This would more normally be done by making LDO2 a regulator via the
normal regulator framework - look at how the arizona drivers handle
DCVDD for an example, it provides a default supply mapping which makes
things really easy for users.  Right now it's not clear to me looking at
the code that the driver works for systems that don't use an internal
LDO as there's nothing that enables MICVDD.

> +static int rt5660_probe(struct snd_soc_codec *codec)
> +{
> +	struct rt5660_priv *rt5660 = snd_soc_codec_get_drvdata(codec);
> +
> +	/* Check if MCLK provided */
> +	rt5660->mclk = devm_clk_get(codec->dev, "mclk");
> +	if (PTR_ERR(rt5660->mclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

This should be in the I2C level probe so we don't have the device
showing as probing there without the resources it needs being present as
that makes things confusing for people.

> +	if (rt5660->pdata.dmic1_data_pin) {
> +		regmap_update_bits(rt5660->regmap, RT5660_GPIO_CTRL1,
> +			RT5660_GP1_PIN_MASK, RT5660_GP1_PIN_DMIC1_SCL);
> +
> +		if (rt5660->pdata.dmic1_data_pin == RT5660_DMIC1_DATA_GPIO2)
> +			regmap_update_bits(rt5660->regmap, RT5660_DMIC_CTRL1,
> +				RT5660_SEL_DMIC_DATA_MASK,
> +				RT5660_SEL_DMIC_DATA_GPIO2);
> +		else if (rt5660->pdata.dmic1_data_pin == RT5660_DMIC1_DATA_IN1P)
> +			regmap_update_bits(rt5660->regmap, RT5660_DMIC_CTRL1,
> +				RT5660_SEL_DMIC_DATA_MASK,
> +				RT5660_SEL_DMIC_DATA_IN1P);
> +	}

We do a reset when we unregister at the CODEC level - that'll overwrite
these settings won't it?

Otherwise this looks good.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2XtRAAoJECTWi3JdVIfQXCkH/jMoyWm68Qj6G0MHriNdnD21
6cTyG4OsowHzaZ0VG+LNh2O539uFep3LjPTl6OB6CKQ8ic/p2EaVhJq0iKSW9uV9
AGCI/GcScH0H2W9NOmiwwjBUU+zHHA/M+PJzD2X4PWL8cjZAbo5jqHl1BkJ95yEd
dZjW26vAS2eKejOFmhLw1qcFuLdC6ll3eqrJnLsSDijnrNX76aQu1wUuEAKLJ2o3
rU+398XvRkE4+URaBckckpuhQ03cfRotYWRYRzvLIVn6p4bjNcPZxqgQYlLcCPad
G+22mEQtWrcqoswS+041NI+/1uucI4jswqwSyUchB38nX/4MEQ7haFnAlZ9EyiY=
=WstS
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

--===============1170889996676130015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1170889996676130015==--
