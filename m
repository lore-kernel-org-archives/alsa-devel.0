From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/14] ASoC: codecs: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 13:16:04 +0100
Message-ID: <20170818121604.ulehlr7bjxcsle3a@sirena.org.uk>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1503057971-16033-3-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6kloznh3yswae52"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503057971-16033-3-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--a6kloznh3yswae52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 05:35:59PM +0530, Arvind Yadav wrote:

>  sound/soc/codecs/cs42l42.c             | 2 +-
>  sound/soc/codecs/es8316.c              | 2 +-
>  sound/soc/codecs/hdac_hdmi.c           | 2 +-
>  sound/soc/codecs/inno_rk3036.c         | 2 +-
>  sound/soc/codecs/max9867.c             | 2 +-
>  sound/soc/codecs/max98926.c            | 2 +-
>  sound/soc/codecs/msm8916-wcd-analog.c  | 2 +-
>  sound/soc/codecs/msm8916-wcd-digital.c | 2 +-
>  sound/soc/codecs/rt5616.c              | 2 +-
>  sound/soc/codecs/rt5663.c              | 2 +-
>  sound/soc/codecs/tas5720.c             | 2 +-
>  sound/soc/codecs/zx_aud96p22.c         | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)

You sent individual patches for the rest of the drivers but not for any
of these...  It's fine but some consistency would be nice.

--a6kloznh3yswae52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmW2oMACgkQJNaLcl1U
h9B5Mwf7B80C4Wc53hPDSdoh5YCjTju9FK2KKyuuT6TnCM6JTJS1Lu5hz/CHlQ+N
3vEi0NrOax5PlkdaSPqSDiwQO8kLOG7VF6bT587hBww4rR3XMlZF0DuaHinHiSEb
6gFIzsbhi/QKtsn7m/eMFKvtkvfz9c3rJKj45Ev7UOAjQMZ5qjNzqfc/O1tnqnz8
H6LSZeHXBPOtE8qOAeEwSt8hYkUt4Z/6NotARx6TgxR0ir1rvbxLK/4zTD55aY37
1tzHkwSP9dzXPii6E8RE2jwIUGH3UZUAJshBFveXxL/zcI6KuS0fPuBTvjL113DO
DTlAEELa1zi/xad97vfPWC6SPOG6Lw==
=DNLH
-----END PGP SIGNATURE-----

--a6kloznh3yswae52--
