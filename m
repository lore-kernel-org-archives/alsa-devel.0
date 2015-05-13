From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
Date: Wed, 13 May 2015 17:42:51 +0100
Message-ID: <20150513164250.GB2761@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk>
 <55535035.5070608@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jE+K4o1MICf3EEet"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55535035.5070608@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhengxing <zhengxing@rock-chips.com>
Cc: Xing Zheng <acgzxing@gmail.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--jE+K4o1MICf3EEet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 09:23:01PM +0800, zhengxing wrote:
> On 2015=E5=B9=B405=E6=9C=8813=E6=97=A5 03:22, Mark Brown wrote:

> >Is it not possible to extend simple card to handle your use cases?
> >Given the very generic naming and the fact that things like jack
> >detection and so on should depend on the CODEC and board usually rather
> >than on the SoC it doesn't sound like this is Rockchip specific.

> >This also looks like you're reimplementing some device model enumeration
> >stuff which probably shouldn't be happening but let's understand the
> >problem you're trying to solve here before going too far into the code.

> Because we are trying to bring rt5650 in the project, so we intend to
> describe supported codecs with DTS via only a rockchip machine driver fil=
e,
> others remain pre-implement(like max98090 / rt5645 that vendor machine
> driver).

I don't undertand what you're saying here, sorry - why is this not just
a case of writing multiple machine drivers?

> I communicated with Dylan, and he told me that the jack detection is an
> issue in the simple-card, and suggested we are better to send them at
> present.

But what are these issues?

--jE+K4o1MICf3EEet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU38KAAoJECTWi3JdVIfQmAEH/A1AlFmVqq+7EFeJfhOPW8e4
eqCNFM+cvW+gukhi5pOP4gW56+RF00LMmMrNNwR0WrIvRQognI87qteklfa6JWuG
Auwmhp+kLfjdz2DlK69mCewjbImNmbZoCPRFjY8dDjmvyKZzeaCHgTVl7PH9YOaV
4EPbSStnQ5IMxfiD5yKN9SDKiKxwrN8oA+FoBpuORAE838NqQDT/ps9C4PtjGpb0
asKBdN/xCaG0g7l+pTny4WlJnfPt8VYtciRQrb6YMCKzSSUd0/MDUJxGjSfnbwyY
FAvkZW2X1akolUr5VrnAhf4cVWYBBUAwnJlt13A2tnwoY0aQLSmAFigTjkc29w8=
=1T9p
-----END PGP SIGNATURE-----

--jE+K4o1MICf3EEet--
