From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: rockchip: i2s: add 8 channels capture
 support
Date: Fri, 6 Nov 2015 12:00:20 +0000
Message-ID: <20151106120020.GH18409@sirena.org.uk>
References: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
 <1446773891-32174-2-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="saTAHnV464s+57Yq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446773891-32174-2-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--saTAHnV464s+57Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 09:38:09AM +0800, Sugar Zhang wrote:

> +	/* refine capture channels */
> +	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
> +		if (val >= 2 && val <= 8)
> +			rockchip_i2s_dai.capture.channels_max = val;
> +		else
> +			rockchip_i2s_dai.capture.channels_max = 2;
> +	}

You should make a copy of the rockchip_i2s_dai struct in your driver
data and modify that rather than modifying the original - what happens
if sommeone makes a SoC with two I2S DAIs, one with many channels and
another with only two?  Samsung SoCs often have an arrangement like that
for exmaple.

--saTAHnV464s+57Yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPJZTAAoJECTWi3JdVIfQo20H/jGKYOMeM67k5I3Iq4a1+qXH
HETY0sBnUf5WlvtyfOzgC56UmGgfX8mZQB1bkGERgXATDga0AsQYF+uqaHP1lZcA
Z51gle6FWZT5v0g66BiAkPU+aKVlwazZohOQKriMSA1dUMPgu6KPLQby6sOFAViG
JfzT8OrerJYIohTANI8l7hX6PZWSq0XiK7Zxrmd+7KiCZSKRGZK9IrSDWoWYNePN
SC15/7uRDGQPjCRXvOFFgMeP3kqxIcSdC8e1PmOp0T8508TIxEJlYxHB5fuabCbr
VI5JLT6HtNnvAXIi+JyyZBfd4AV/y3CRPBT/mOJ3QQyaxagfMnDiMa1ucC+5ONM=
=Lb5c
-----END PGP SIGNATURE-----

--saTAHnV464s+57Yq--
