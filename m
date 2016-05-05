From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] ASoC: rockchip-max98090: Fix the Headset Mic route.
Date: Thu, 5 May 2016 20:18:44 +0100
Message-ID: <20160505191844.GL6292@sirena.org.uk>
References: <1462435421-21205-1-git-send-email-enric.balletbo@collabora.com>
 <1462435421-21205-5-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FC52J0nKTzya17Ed"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462435421-21205-5-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org


--FC52J0nKTzya17Ed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2016 at 10:03:38AM +0200, Enric Balletbo i Serra wrote:
> Since commit e409dfbfccf9a49 ("ASoC: dapm: Add a few supply widget
> sanity checks") the following error is seen:


>  rockchip-snd-max98090 sound: Connecting non-supply widget to supply widget is not supported (Headset Mic -> MICBIAS)
>  rockchip-snd-max98090 sound: ASoC: no dapm match for Headset Mic --> (null) --> MICBIAS
>  rockchip-snd-max98090 sound: ASoC: Failed to add route Headset Mic -> direct -> MICBIAS
>  input: ROCKCHIP-I2S Headset Jack as /devices/platform/sound/sound/card0/input3

> Invert the route between the Headset Mic and the bias in order to fix it.

This isn't just noise, this is telling you that the route has always
been broken...

--FC52J0nKTzya17Ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXK5yUAAoJECTWi3JdVIfQ1CkH/0c+++cCuT13A+zKyKlrwUKH
zxAqk1bXr2zmWlY90zYFcPCQRFH4kD1KCi485BSDaxM6sPOMF2LUst1m+XqGFobq
2Shd7Ro/XQCZZ+QpDXvdJ/VD22MTSSn7EuwwWw9WXSjCkt9lhRJp8mmOY2VAvDba
3xCBkPMjim6Y3l+uxLJVceKxPEt6QkhzVqYt3LAf+wHl9z5oJhDPB8PPbrqUIIC5
2z2Ac0MpBuHo9yXKJC6Iw2VdRpakoq95gLKlx9LokqA8ynO7JeuI/ZsveBCuKyG+
qygPKJlpzr11PIrw+Bj21LlC3ygxfS1neosUr99DRX6m3Im+gW53p1rdIlG+AYw=
=6ivC
-----END PGP SIGNATURE-----

--FC52J0nKTzya17Ed--
