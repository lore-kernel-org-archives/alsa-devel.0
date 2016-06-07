From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 5/9] ASoC: mediatek: add structure define
 and clock control for 2701
Date: Tue, 7 Jun 2016 17:15:08 +0100
Message-ID: <20160607161508.GC7510@sirena.org.uk>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-6-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A1Iwnsx6rNfRhs6P"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464929784-5489-6-git-send-email-garlic.tseng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com, PC.Liao@mediatek.com, ir.lian@mediatek.com
List-Id: alsa-devel@alsa-project.org


--A1Iwnsx6rNfRhs6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 03, 2016 at 12:56:20PM +0800, Garlic Tseng wrote:

> +void mt2701_init_clock(struct mtk_base_afe *afe)
> +{
> +	struct mt2701_afe_private *afe_priv = afe->platform_priv;
> +	int i = 0;
> +
> +	for (i = 0; i < MT2701_CLOCK_NUM; i++) {
> +		afe_priv->clocks[i] = devm_clk_get(afe->dev, aud_clks[i]);
> +		if (IS_ERR(aud_clks[i]))
> +			dev_warn(afe->dev, "%s devm_clk_get %s fail\n",
> +				 __func__, aud_clks[i]);
> +	}
> +}

This looks like we just ignore the error but I'm not seeing anything
that stops us trying to use the clocks or handle deferred probe?

--A1Iwnsx6rNfRhs6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVvMKAAoJECTWi3JdVIfQxVwH/07WVeSMtr01glAbOu6pRavZ
8nFU8OLku8EG0bExCn32XpcVuNLBTagYDkIZwZ1qqkfa457BgKW6oxABc9MgmwQU
gInncSxpdbT/H9Q8RMDMOi/OBym//XxkyIF6W9N5iwRm3in4tdUA+n+0DLIDi4n1
QAqXXWxX+dbEw945ouJJf8FxlZTcFU5SXBlJBNWluhvDLPIc1nMWk4++WNXJuaya
n2O2kMFgTckiIpKgPYOtjEVufXm0tvhHTpwEGZDxaS96ThhM8a1SXhqNlJC5OLaJ
8gWwqmmygjLQ5G2RDzlXdlYtgtVhd3aV1BRedFOBnpEBUoE7eb0wtu7U7SF4LA0=
=zp2Z
-----END PGP SIGNATURE-----

--A1Iwnsx6rNfRhs6P--
