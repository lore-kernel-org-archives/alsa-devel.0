From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: rockchip-i2s: fix registers' property of
 rockchip i2s controller
Date: Sat, 13 Sep 2014 09:36:13 -0700
Message-ID: <20140913163613.GI7960@sirena.org.uk>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xdAuejbAAr3yyIdQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--xdAuejbAAr3yyIdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 13, 2014 at 08:42:12AM +0800, Jianqun wrote:
> Reference rockchip I2S controller TRM, modify some registers' property
> I2S_FIFOLR: read / write, but not volatile, not precious
> I2S_INTSR: read / write
> I2S_CLR: volatile, register value will be cleared by read

Applied, again this is a bug fix (volatile and precious being wrong seem
like bugs) so should have been earlier in the series.

--xdAuejbAAr3yyIdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFHJ8AAoJECTWi3JdVIfQOOIH/1RYoC6gaC3D0a+Kshwm+JYZ
pZsZvJyMY6oysjfBiEUixjO7IdDjV4+lwkkQek4SGhufaZInl3jjXYp5+EyKf1Ex
bBufOUQVpzb42URFVTH7kKSlhj0Z6h1CzuUBYI5VQTEuraqk2VIqi2dt2tzCVQm2
uLisentGQ0lRfizGprfoI0GuqJGGCjkP9tfp5ivxP+tCaiGj/swTakFe3wuYDy2A
HLq9ToE3md7IyiQbLjueRq4vSmLjz14IYMmlTh+AXY3PeBGzGdIUcBJIbmC/KqWx
wwzCY6a7qzF2Gd0U4hIGIVwauaIp2t9vhhAYZSZJNyDKQf8z8vg9cYfwcwJrMrI=
=Ra7Z
-----END PGP SIGNATURE-----

--xdAuejbAAr3yyIdQ--
