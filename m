From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tfa9879: Fix return value check in
 tfa9879_i2c_probe()
Date: Fri, 17 Apr 2015 14:21:14 +0100
Message-ID: <20150417132114.GA10513@sirena.org.uk>
References: <1429186666-20547-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429186666-20547-1-git-send-email-weiyj_lk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: weiyj_lk@163.com
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 08:17:46PM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> In case of error, the function devm_kzalloc() returns NULL
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.

Applied, thanks.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMQjJAAoJECTWi3JdVIfQXKEH/3NfZQRhj+HO9BG/vxWJo3ew
WIOvGnv9aZp5NWEyz7zrWuTWpX1GyaE69TU/TpnYgEtVYBm2kIslqtCtmjmhX9pO
mVqBbr0g90j2v4A9dQky/AIESMGVNA5xEyyJIq1Ahtg82d1FxNJ6yGPt3GL8W8xh
Ksru7o3WVOf4Io98evqQdDl2LQmu9W1cVBWk9MiTUGTFJDGtp246tvrOLmtlutEB
/9cMzQWLs3XalNStu17MnsHPEOqINyCoOKj5l+gB9hfiEswUATnjVgRMhhnBhYKD
tdJ9pyHmaR3D2FTRcNJWctC0dHQyH4ZPix+BYaHQpfZPzACn3N9CE83/8cSQNBI=
=AWJ3
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
