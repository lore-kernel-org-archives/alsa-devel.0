From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt1308: Add RT1308 amplifier
	driver
Date: Mon, 17 Jun 2019 11:22:32 +0100
Message-ID: <20190617102232.GL5316@sirena.org.uk>
References: <1560589487-6610-1-git-send-email-derek.fang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7047203550953115447=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C1CFF8075C
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 12:22:37 +0200 (CEST)
In-Reply-To: <1560589487-6610-1-git-send-email-derek.fang@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: derek.fang@realtek.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, bard.liao@intel.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7047203550953115447==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a8i0lXXx49qphuFT"
Content-Disposition: inline


--a8i0lXXx49qphuFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 15, 2019 at 05:04:47PM +0800, derek.fang@realtek.com wrote:

This looks mostly good, a couple of really small things which should be
easy to fix:

> +	return devm_snd_soc_register_component(&i2c->dev,
> +			&soc_component_dev_rt1308,
> +			rt1308_dai, ARRAY_SIZE(rt1308_dai));
> +}
> +
> +static int rt1308_i2c_remove(struct i2c_client *i2c)
> +{
> +	snd_soc_unregister_component(&i2c->dev);
> +
> +	return 0;
> +}

You used devm_snd_soc_register_component() so no need to explicitly
unregister and this function can go.

> +#if defined(CONFIG_OF)
> +		.of_match_table = rt1308_of_match,
> +#endif

of_match_ptr()

> +#if defined(CONFIG_ACPI)
> +		.acpi_match_table = ACPI_PTR(rt1308_acpi_match)
> +#endif

No need for the ifdef, that's what ACPI_PTR() does.

--a8i0lXXx49qphuFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HaegACgkQJNaLcl1U
h9CmlAf+N0YZDWtmDfQNB6YcGo68TkrITIn4ggltcQBiRUyRgyTGKNJk3WMLLbRN
z/rln7P2qEsILlvg7ANob+8nqONjtxYp+DrwL4sFgRBqPASG8eqnYhNkeW9GlRFP
Ns3LfGOAijTAMl35NIwD7qaonAaKQq4WPmbcDSp8SYSDAWf/G5KrG5RX05rMyTKv
Acbb4zbJfqtuPX1L6v+0rQjTGj/PYQTpjYUedyFc3xro8Ta5VriTc7UCHLdJG8pu
ceLO2SqmnE1eFxCgrKiJezC99ZrCgXn7BnD1/5SCvqlG3cvRco8fJxQBtASoEfcX
CVhKt9rU8bgJl4TIP5WpBLAHGSBprA==
=7JV6
-----END PGP SIGNATURE-----

--a8i0lXXx49qphuFT--

--===============7047203550953115447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7047203550953115447==--
