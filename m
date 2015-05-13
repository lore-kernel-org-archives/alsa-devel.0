From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: rockchip: add rockchip machine driver for
 max98090
Date: Wed, 13 May 2015 17:47:38 +0100
Message-ID: <20150513164738.GC2761@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-3-git-send-email-zhengxing@rock-chips.com>
 <20150512192636.GA3066@sirena.org.uk>
 <55535048.4030703@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y1+kC1Q2udlVMFpc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55535048.4030703@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhengxing <zhengxing@rock-chips.com>
Cc: Xing Zheng <acgzxing@gmail.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--y1+kC1Q2udlVMFpc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 09:23:20PM +0800, zhengxing wrote:
> On 2015=E5=B9=B405=E6=9C=8813=E6=97=A5 03:26, Mark Brown wrote:

> >This looks more like a normal and reasonable machine driver but then why
> >have you created the generic rockchip machine driver?  It seems like
> >this should just be a regular machine driver like other platforms have,
> >were it not for that this would be mostly fine apart from a couple of
> >nitpicks below.

> We just use rockchip_machine_driver to describe the supported codecs base=
 on
> origianl way, vendor machine driver(rockchip_max98090) will achieve
> functions.

Like I said in reply to the other message I just don't understand what
you're saying here - take a look at the various Tegra machine drivers
for example, they also have per-CODEC handling but they just use normal
machine drivers to do it.

--y1+kC1Q2udlVMFpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJVU4ApAAoJECTWi3JdVIfQv30H+LVf0ejTNvamTqrpMy1bTVc0
xJsYaPaqKJzSCm7PmV9gC18bDpvNt4zOibHtrgqjyM5lgsszF4YiNrU8UPw/Nc30
dwt6ve0WTS2Sof23ZqLz5DinP5h84TKAE0jnPBHBkMDrPJdN440G8QY7uIgyCggH
LSD0FmNmryXY/hjs4Kib0f5CutKdcl07QAEpI0KlnN1UrO8JOPX7NwNV09P7x/Qz
lnPtuXDZ6opJleCShsoFg+mSOQ1i5XlEmDIIf20ud3bBVgeuQQf0KePl4NviOkOk
NKUJznVRyJrIp4cE5qsYOgpW/Qr99EbSnkYDs3duQRNxEmCxc3JGffVjdC3DNA==
=Tiof
-----END PGP SIGNATURE-----

--y1+kC1Q2udlVMFpc--
