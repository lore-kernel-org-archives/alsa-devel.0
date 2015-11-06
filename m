From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: rockchip: i2s: share tx/rx lrck when
 symmetric_rates enabled
Date: Fri, 6 Nov 2015 12:02:42 +0000
Message-ID: <20151106120241.GI18409@sirena.org.uk>
References: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
 <1446773891-32174-4-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fh0SynPkUvrWGMR0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446773891-32174-4-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Fh0SynPkUvrWGMR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 09:38:11AM +0800, Sugar Zhang wrote:
> we share lrck_tx to lrck_rx only if when both i2s symmetric_rates and
> dai_link symmetric_rates enabled.

This looks good but seems to depend on patch 1 so I can't apply it yet.

--Fh0SynPkUvrWGMR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPJbhAAoJECTWi3JdVIfQmW4IAIFnSP5z+e9eg6HWpSAyeYCW
UPXVGTrAmK+tdiMXJCRX9ivDJsJesYnY7kaeTIF4SApYcnkYApm6aztMmKE1lH+O
6bXnm8R0EML6vWv3xL78Cyr239NaXKFAt3JPScoLbNJXYdJDuTwK7kI2iiZQMBsd
7T2ykOug+RmRpx7HGyYG70gfaxSTliErLYTa5eMJfUR1nqFjem0SOCNDnKBbyp0F
WLMNnTaF3scosqNjAfK8jnkHwmP6LCl6HA4INfT4lJLdzFH0VVMYZ1x/vBbg4DA2
ZVH03YnEoIi/1kgIo0uV3vKXRXQEBE+HeHVzGmIQ1ZLeAL832tbyTbkb2mJbAJI=
=JRo2
-----END PGP SIGNATURE-----

--Fh0SynPkUvrWGMR0--
