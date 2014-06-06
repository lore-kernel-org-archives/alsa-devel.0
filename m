From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: wm8904: switch to CCF
Date: Fri, 6 Jun 2014 10:57:06 +0100
Message-ID: <20140606095706.GB2520@sirena.org.uk>
References: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
 <1401963572-10953-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KVy3XSgRgEDVTe6j"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401963572-10953-3-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, boris.brezillon@free-electrons.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--KVy3XSgRgEDVTe6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2014 at 06:19:29PM +0800, Bo Shen wrote:

> +		if (wm8904->mclk)
> +			clk_prepare_enable(wm8904->mclk);

There's no point in having checks for MCLK here since...

> +	wm8904->mclk = devm_clk_get(&i2c->dev, "mclk");
> +	if (IS_ERR(wm8904->mclk)) {
> +		ret = PTR_ERR(wm8904->mclk);
> +		dev_err(&i2c->dev, "Failed to get MCLK\n");
> +		return ret;
> +	}

...we require a clock here.

--KVy3XSgRgEDVTe6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkZBuAAoJELSic+t+oim9Yd8P/0bveP3jCD0awlAvdLvlYGEY
51R72y+hXwGCn9GlBigvogmOWhfdmZKAqRUgbeyFIFXyrbhJNfIo5ucYIiybFTxv
XxWNxeYolRdk7crmFark2vt5u+wkmtmvSIlfxaO1+qIrYHerGAUcyW+TC9WTS0ba
6gdwa2MI89G6g+A0ip6lByp3LGyBBFcpV9ZDVjwWj9tZCDzxyR/XuQaK7zQpZpoh
TdAzIxxVb0OKy84PBPx1WQrAieUcOGZKApoRZfmkEQOjSH1L6Y62uxRmWKKB2OG2
3qqj96vZmZt0pRuuwDDo/CKv4+/qSslqlMUBSbcOmbwB3FElt8zLNXwhGonNldAp
N5ZQB3o5hKBQanFu9OWVw1pAoAPAs92uZq/5ORVYRr33qTTKIKZrDxXg2kMgtIzd
4hbGPQvzBX4VNY0BGt5JaXDtAGvmUpnzWgF4cehPqNEmKwa8bdS0uNbUFDpLjmcq
ozCT3NHZZhwuSWYTOog5mxvq7sItgu+D70b8NrUHf9n+4LZLLTNHPiqC0PGBHa0Z
PMoA/IB658PeT9OUflL87qgeHW4OCQWAcyMUaElLXW0vW+QKo3QXTv0Y0LELl8hL
HA+w9ldzvPBA6ix5gC7TH0eTxzX34e9GQ3qAkn7i7nW47YGl2CRbiVcRQx4r0t0N
yq0P8mV2yf4AKTTD3sAl
=W9Rd
-----END PGP SIGNATURE-----

--KVy3XSgRgEDVTe6j--
