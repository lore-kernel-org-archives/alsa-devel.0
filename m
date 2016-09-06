From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rockchip: i2s: restore register during
 runtime_suspend/resume cycle
Date: Tue, 6 Sep 2016 11:29:44 +0100
Message-ID: <20160906102944.GH3950@sirena.org.uk>
References: <1473124793-74625-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qp+4iQ/pA/lPyvuI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473124793-74625-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: dianders@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Qp+4iQ/pA/lPyvuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2016 at 09:19:53AM +0800, Sugar Zhang wrote:

>  	struct rk_i2s_dev *i2s =3D dev_get_drvdata(dev);
> -	int ret;
> +	int ret =3D 0;
> =20

Why are you initializing this?  All this will do is stop the compiler
warning you about use without initializaiton bugs.

--Qp+4iQ/pA/lPyvuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzpqXAAoJECTWi3JdVIfQRQgH/1mnJri6ikRLM2L57wLKHdFa
AVK+uulyNrtwi5BhpfTEvbYdiAGCqh5dm8iXlj0viPe5DkDJh9O9cuF0olLwdxlp
W4h4CSqDwZpq0fOHDorICJD2Woi85yt+9JX4Fr0BGHHHM2Hf6TKffUfptbU5qktl
Rl8Dvzoacnim+txD85jw6ejAN774bbCCpqSOeUeRxO0UGHcx3Mxo5NfQQ7d7Dl/g
vamCjxYXZNCJCVqCok3o6typke4velEOPvYeaIprkcrJSFfm4XdLcwolFZkxiKWp
FmFrxKfQvN+as7hCOlpa6zicSe41U9kHaWkhE/XJzMNghdrVjMr3CNV/ZfDsdoU=
=RooU
-----END PGP SIGNATURE-----

--Qp+4iQ/pA/lPyvuI--
