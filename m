From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add a configuration
 option for LDO2_POW pin
Date: Wed, 17 Sep 2014 09:57:54 -0700
Message-ID: <20140917165754.GN7960@sirena.org.uk>
References: <1410931739-6088-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1278874047372829007=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D221261AED
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 18:58:24 +0200 (CEST)
In-Reply-To: <1410931739-6088-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1278874047372829007==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6HoVBnoRn/ylzab8"
Content-Disposition: inline


--6HoVBnoRn/ylzab8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2014 at 10:28:58PM -0700, Anatol Pomozov wrote:

> +	if (gpio_is_valid(rt5677->pow_ldo2)) {
> +		ret = devm_gpio_request_one(&i2c->dev, rt5677->pow_ldo2,
> +					    GPIOF_OUT_INIT_HIGH,
> +					    "RT5677 POW_LDO2");
> +		if (ret < 0) {
> +			dev_err(&i2c->dev, "Failed to request POW_LDO2 %d: %d\n",
> +				rt5677->pow_ldo2, ret);
> +			return ret;
> +		}
> +		msleep(10);
> +	}

This doesn't disable the GPIO on remove which I'd expect, along with
management at at least suspend and resume if not at runtime.  The
removal is the most important one though.

--6HoVBnoRn/ylzab8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGb2RAAoJECTWi3JdVIfQw/8H/3M9REyqZ26nEpzSNHFonV1z
frgZdUHlWP14ffDe53xWiv6h0aCGYah4v93L7CDw1nmwqG5NWwOh/iyPP5EsLX2a
AAMe2tk242WMDGRfRB4bas3uizLDqnNpARajE1dPL2ogl/0+94Mt6kPo7uaFU5WC
0vDIiojn+51PMkiABn1iy+hwlPwdToPc/kDdtwydwhk4TdLQqxeu0+T/+Nr8ii5d
lDd++3dNM46OyuQoUxCFtQhzMQFiLWOxApLmW+VRfitU9tc54QNRBKxFFXJgO5t3
FgIbRFF6h74yO4TeHAfdcf6OOYxzsMFcNA1ixRdDjTLfmHXGeueS9rUhPOkYV7c=
=izRO
-----END PGP SIGNATURE-----

--6HoVBnoRn/ylzab8--

--===============1278874047372829007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1278874047372829007==--
