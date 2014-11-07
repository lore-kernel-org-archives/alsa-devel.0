From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5645: Add combo jack support
Date: Fri, 7 Nov 2014 11:46:34 +0000
Message-ID: <20141107114634.GM8509@sirena.org.uk>
References: <1414741076-26685-1-git-send-email-bardliao@realtek.com>
 <1414741076-26685-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5905202679401495357=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 024652610A1
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 12:46:53 +0100 (CET)
In-Reply-To: <1414741076-26685-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5905202679401495357==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3KX/zl56xCkovX8U"
Content-Disposition: inline


--3KX/zl56xCkovX8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 03:37:56PM +0800, bardliao@realtek.com wrote:

> @@ -2573,6 +2573,12 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
> =20
>  	}
> =20
> +	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
> +			   RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
> +	regmap_update_bits(rt5645->regmap, RT5645_JD_CTRL3,
> +			   RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL,
> +			   RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL);
> +

Is it really a good idea to enable this unconditionally - doesn't it
depend on the system hardware if this should be set up or how (the _POL
looks like a polarity setting for example)?  I'd expect it to at least
waste power.

--3KX/zl56xCkovX8U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXLEZAAoJECTWi3JdVIfQrI4H/0b+woeCmTYeUovSqYar8c9T
xR8rVaVHWR3481EcB/JGlhOiI8Mk/NFrPOJZ9zFcXERCDnZp9mho509ZJAE9lOot
SaJnTTMkkbcOvydd0CzMmDYUz73ftoZONxLNpxzVLVlDTmSIRqJIULDRQYowlzJR
7YtE2yOYxlBc7Glny6MuIpa6QQ4XZsFKmHV040Xlfju5S+Aemp2RHXwStZP1MgA8
Sq/JEwxO9MGUP6olqlCfhtFkvj5CBgcW8uzMV1HYA8rawVqg8/wba/o1/ep6n6qE
zqb3NdTy9zmU6Fx2b+x9RjOcYwHVIUVXXvnxxsepKjaIpTwRvToF7kk/zxDcD7Q=
=7u/Q
-----END PGP SIGNATURE-----

--3KX/zl56xCkovX8U--

--===============5905202679401495357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5905202679401495357==--
