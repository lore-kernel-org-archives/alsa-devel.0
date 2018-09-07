From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Date: Fri, 7 Sep 2018 11:15:25 +0800
Message-ID: <20180907031525.GA28772@rodete-laptop-imager.corp.google.com>
References: <20180907002728.112770-1-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180907002728.112770-1-grundler@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Ryan Lee <ryans.lee@maximintegrated.com>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, bleung@chromium.org
List-Id: alsa-devel@alsa-project.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Thu, Sep 06, 2018 at 05:27:28PM -0700, Grant Grundler wrote:
> Commit ca917f9fe1a0fab added use of usleep_range() but not
> the corresponding "include <linux/delay.h>". The result is
> with Chrome OS won't build because warnings are forced
> to be errors:
> mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:7=
34:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimp=
licit-function-declaration]
>         usleep_range(10000, 11000);
>         ^
>=20
> Including delay.h "fixes" this.
>=20
> Signed-off-by: Grant Grundler <grundler@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks!

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAluR7UsACgkQHwn1ewov
5ljaCQ//Vj0U9MYJssR7jVXYrlHFK79ST8WCc4w4xL4ffdrmH9QyTx2dNu/mpwRu
v9YAAPTqwCsbuH4tTMbQXLB/gi9bTRhda3auqcYCdpLoJ7SWIScQDjTBSpDU0fe8
MU6IxI5Aq++p/mMo46OVhUwnqfdPXB/zjTPXpHPxB5Z2mGbFmYh8C1uuun1SMxvr
iJg0rZRoaABVFXW0pVC20levdAWDh0iax49XbYQswVIrfXQAXf2gSanfL/+SxOeW
D/228n9YZ8DUDB3rCs2E0FfhI/XqskgAXtXwHJ1QNTiYpdTTONphUBjPrTiD4Stv
bt5YR7A4XUFPhDgcU4Q6I54x3qKYk64i4PcEx9Mlz9XRvqmGrIr0FV3p7fjPklBh
WsKmaFStb9jdevEgBT87ZgsIupqGSp9A/FIGl1eI7726Ta6SOllBsVywjQ54k1VN
YkkQFfixRZeffUtYzHdDR+Qyoz1mg9zUSG4XdfsI75uRhZYX93Xn0N8SwOA2qwTP
CHdYf0NVWMTxxjbNyD7RIz5/j6y4T1PA9ISoRoJCrOZF9s0VYk6MXcJZej9938km
touyk4i0HsT88C76JBcuKlwbK9gGJw+4n2RaE/brJuHPZLtHKYDLQoDsDX1aZrPC
Gm8lXNDxwmLcdh60S0LObXeq14lYzzDg89kKAHTA/6zPfJ92Yfg=
=zIvs
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
