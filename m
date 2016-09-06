From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rockchip: spdif: restore register during
 runtime_suspend/resume cycle
Date: Tue, 6 Sep 2016 11:30:16 +0100
Message-ID: <20160906103016.GI3950@sirena.org.uk>
References: <1473125035-74895-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4uQRTjNk52FNqRv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473125035-74895-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: dianders@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--G4uQRTjNk52FNqRv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2016 at 09:23:55AM +0800, Sugar Zhang wrote:

>  	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
> -	int ret;
> +	int ret = 0;

Same here.

--G4uQRTjNk52FNqRv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzpq3AAoJECTWi3JdVIfQ3swH/133Um5yZ0xntQdHGV+Igplp
EDr2KNfP5x7ZtSr2568zUDNJyFQknwFOmSIzSLqlUHPtIeyVKlINl5b1gYY7qmep
VWLudttlrKZbBLQr8ckGhQCg5CJ8fHytgY6DdDlbixeBS7ZKWOcuU6ao94Tce936
JKdrSJIsc0ruAr1nNc6qrVZpn5jGRGFpliBil5uRaEmIYsDALUlom3HiL9cCPlHa
QTUCAICCLJbTy3V2eFvQg1HDhwUkGU8E4hfu3qXpw/lH3FmYm49CcLA6iftbRABu
WQLCw/bnEKDFV5eUHotkgk8SJe/MsiLaLEvcSs1EO6ChJTd0pZBge7/p2Xc2v14=
=haJh
-----END PGP SIGNATURE-----

--G4uQRTjNk52FNqRv--
