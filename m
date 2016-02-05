From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: cs53l30: Add support for Cirrus
	Logic CS53L30
Date: Fri, 5 Feb 2016 18:37:13 +0000
Message-ID: <20160205183713.GA4455@sirena.org.uk>
References: <1453763683-10009-1-git-send-email-tim.howe@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5577845728027994064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A97C8260698
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 19:37:24 +0100 (CET)
In-Reply-To: <1453763683-10009-1-git-send-email-tim.howe@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tim.howe@cirrus.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============5577845728027994064==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MoMqJSZefcPDZlII"
Content-Disposition: inline


--MoMqJSZefcPDZlII
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 25, 2016 at 05:14:43PM -0600, tim.howe@cirrus.com wrote:
> From: Tim Howe <tim.howe@cirrus.com>

I'd have got to this sooner but there was an unreplied mail from the
0day bot...  anyway, a few fairly minor issues here:

> +	default:
> +		pr_err("Invalid event = 0x%x\n", event);
> +		return -EINVAL;
> +	}

dev_err().

> +	regmap_read(priv->regmap, CS53L30_MCLKCTL, &mclk_ctl);
> +	mclk_ctl &= ~MCLK_DIV;
> +	mclk_ctl |= cs53l30_mclkx_coeffs[mclkx_coeff].mclkdiv;
> +
> +	regmap_write(priv->regmap, CS53L30_MCLKCTL, mclk_ctl);

This is open coding regmap_update_bits(), several other bits of the
driver seem to be doing something similar.

> +		regmap_read(priv->regmap, CS53L30_IS, &reg); /* Clr status */
> +		for (i = 0; i < inter_max_check; i++) {
> +			usleep_range(1000, 1000);
> +			msleep(1);

So we do a usleep_range() for 1ms then a msleep() for 1ms...  why not
just do one or the other for 2ms?  It at least looks weird and needs a
comment.

> +/* CS53L30_ADCDMIC1_CTL1  */
> +#define ADC1B_PDN		(1 << 7)
> +#define ADC1A_PDN		(1 << 6)

These constants really need namespacing - a lot of them have pretty
generic names so look like they might end up colliding with a kernel
header.

--MoMqJSZefcPDZlII
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtOvYAAoJECTWi3JdVIfQ2JcH/277AC66PrxdfR6CurcOA6KZ
/cCblLHFFLwtje/H3nDx4z2CIPv35mTrEqCQvtbQWrdANRZmuMEr27sBn6jSyDwR
571F7r8zlKTkbsOvGywkyUro8rhprlyuaVJYpAIPBfRAb5epywv21MPUYn1LNsrX
1zqzy9yDvQp3/sH41tvPaDu+DPDI2crkT/kaWXiDYzUszHPTRnpn7cxRHUYifiNt
rELLKwwMj3WEacB1bexrQT3lXv7hdIjvT3y3CfU+F1NmIp1DtpcMsQLGel4WqkGR
yZAkABhlLY/YGzHpI5oUXZ7DgdEw/ThlBqBnmwHePQNYErOtOyouJU263vmILVg=
=7w9h
-----END PGP SIGNATURE-----

--MoMqJSZefcPDZlII--

--===============5577845728027994064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5577845728027994064==--
