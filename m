From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
Date: Tue, 12 May 2015 20:22:15 +0100
Message-ID: <20150512192215.GZ3066@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jwJ6bIT+r2BZUD+c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <acgzxing@gmail.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, zhengxing <zhengxing@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--jwJ6bIT+r2BZUD+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 05:26:34PM +0800, Xing Zheng wrote:
> From: zhengxing <zhengxing@rock-chips.com>
>=20
> In most cases, we maybe use simple-card as generic machine driver
> on next kernel, but there are some issue that jack detection and
> widgets extandable on simple-card.
>=20
> Own machine drvier can select one valid codec from supported codecs,
> and add needful function from dts on rockchip platform.

Is it not possible to extend simple card to handle your use cases?
Given the very generic naming and the fact that things like jack
detection and so on should depend on the CODEC and board usually rather
than on the SoC it doesn't sound like this is Rockchip specific.

This also looks like you're reimplementing some device model enumeration
stuff which probably shouldn't be happening but let's understand the
problem you're trying to solve here before going too far into the code.

--jwJ6bIT+r2BZUD+c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUlLmAAoJECTWi3JdVIfQUWsH/2RfuqO5qDKCHu75wbBaxCI8
SoqbLs0DBBrtDgZB6XISgreOdG0syyPlJqb7Ceip0KtwN6aVapbmcckPpkAplHve
2BwiKrKZVbhncF4K3RJkBViLtACdSRc2tfJIFmOwBPn4Ju7jbLLk+e1oVrTc/bJm
gOk9k4WFZ8As8DmXYdbKMR0qnhNuiHNVi5XYWz/iLCIHo7bAfQIBHJpK6rQBsf7T
kfNlQLNzdnYe5wSoi8DMLanYZq/m+9TPmG7WA9qLrn6CKe20/7xnwz6GwKhZkv0G
pTMlni/82NhrDcvfor2dFJrJRstdxEPng14ehkllJ+If+MC+Llow1zpLu3EXawA=
=5MVp
-----END PGP SIGNATURE-----

--jwJ6bIT+r2BZUD+c--
