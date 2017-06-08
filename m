From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: simple_card_utils: add
 asoc_simple_card_clk_enable/disable()
Date: Thu, 8 Jun 2017 15:50:08 +0100
Message-ID: <20170608145008.qmlsthf6lxs6qslp@sirena.org.uk>
References: <8760g84pe4.wl%kuninori.morimoto.gx@renesas.com>
 <874lvs4pd4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="542t6zc3chzg6kq7"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874lvs4pd4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--542t6zc3chzg6kq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 07, 2017 at 12:29:05AM +0000, Kuninori Morimoto wrote:

> +#define asoc_simple_card_clk_enable(dai) clk_prepare_enable((dai)->clk)
> +#define asoc_simple_card_clk_disable(dai) clk_disable_unprepare((dai)->clk)

Could we make these static inline functions instead please?  It
shouldn't make any difference to the generated code but it's a bit more
type safe.

--542t6zc3chzg6kq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk5ZCAACgkQJNaLcl1U
h9C/nwf8DY47X3M/71gjbQnmDzqmdGUOhgm913warEOUM/dTvPH/63GpRZwrsemB
793Vi7mCT9qATY/PQkardNF28t65D3qbKaTIZ2DAiTSCVENhds/F41TOSd9WXWMM
9wjOYF9E7zlPtDrmIZmauDXrH6oi8tacAaUW5M+MwMkZaKl9GbaUTheBBS79d+8m
giw1Sc/8W1HDjsHA5gS0/1e6lMhM9Ga6KQPJWAXQuKxvRgPhSC15ri9NQoATNuYo
m7pQIPG8V4xXipjZonghmJR5f9S/kCMV6JKJEIQH7nSYKrE4QraUzJdsl/aSbYW2
MRCxGnzrZetDqepgEM9EeRJd1i3Rcw==
=dZT2
-----END PGP SIGNATURE-----

--542t6zc3chzg6kq7--
