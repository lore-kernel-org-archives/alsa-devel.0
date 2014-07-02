From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: add driver for Rockchip RK3xxx I2S controller
Date: Wed, 2 Jul 2014 12:16:36 +0100
Message-ID: <20140702111636.GD410@sirena.org.uk>
References: <1404203860-30712-1-git-send-email-xjq@rock-chips.com>
 <1404204458-30881-1-git-send-email-xjq@rock-chips.com>
 <20140701170747.GA15028@sirena.org.uk>
 <53B359FD.3080809@rock-chips.com>
 <53B3E5AA.9060300@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53B3E5AA.9060300@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianqun <xjq@rock-chips.com>
Cc: Huang Tao <huangtao@rock-chips.com>, heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, zhangqing@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, zhenfu.fang@rock-chips.com, cf@rock-chips.com, kfx@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 02, 2014 at 06:57:46PM +0800, Jianqun wrote:
> Hi Mark:

Don't top post.

> Since regmap_update_bits is int style, I have to error check every time after call it.
> Also I find that the tegra_i2s.c call the function without error checking,

> Could you tell me the right way to handle the regmap_update_bits ?

With memory mapped I/O there's no real point in checking for errors so
if you kno0w your device is memory mapped you can get away with just
ignoring them.

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTs+oRAAoJELSic+t+oim9RkIP/0FOx1emtxT47e3/VqSWsJLM
hIOOZ5Hc1P9k0YHfUcNJNKJnDHhrivpfl8xVz4cSeXp72GYG4SPf/KnwtHzJa5oR
kTzVWvlp3OPgb0mfNPIpCSLgG5LRwwrgD81qlhccDwM4Sg+3pStXmz5jKea3zdMf
jcqBQ5PhlfH+vMOqHy+O6RjlEq7iBF7MZn/LeyfNrlIrJ3TDIiTJvkPiq1F7gEDy
nEKCGOqZAlTGdcljcMAFchnKaUZGpJVKA4XdF+FA9mbYpHPKXFDaKtR0PqtIEyyJ
BMEpBKBUXnY5jKoQYnxsf1Y+CmV17WKQ8rRFEl0hAe9si3IX4LynhZMxERpmQiU2
a9Q9rA5+klJAqOd1FQLpNfRdFTmpz1HHwxIP+PJzr89Cz3WqT3O5XmXHtvld3by6
uW4JqGS5WgZjMkpxZhbNSIuF6ZoGOGhin4Lb8A3kju9Y5Joa38Td84jlLjMlnEcc
JIP+zb34PsFdXQ1q/uajUgvUpFVBFF0f+PRw0AF651JQeWJIRWVues31OlG4jVTI
MqbgKIv7GRCtuFqEjuJaLAk+RFt9hKdH1AhFSLvpHFTSGr9CWrhZHJzqRZnV2iFN
30Axuzqp1a+rIEDCrBizt+TO9/cHUJvEGNsXmtpIsZLIhhA82HvD6kyi+fx/B8eZ
7Ishkn/gmsk7GmjfKEW0
=W4rm
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
