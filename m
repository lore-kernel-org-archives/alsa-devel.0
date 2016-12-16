From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-lib][PATCH] ASoC: hdmi-codec: use unsigned type to
 structure members with bit-field instead of signed type
Date: Fri, 16 Dec 2016 12:27:24 +0000
Message-ID: <20161216122724.3r5n4zwealozyx7x@sirena.org.uk>
References: <20161216092654.7773-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1458093116=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20161216092654.7773-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Jie Qiu <jie.qiu@mediatek.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, perex@perex.cz, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, dri-devel@lists.freedesktop.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1458093116==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opjaugvoznyxbhy5"
Content-Disposition: inline


--opjaugvoznyxbhy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 16, 2016 at 06:26:54PM +0900, Takashi Sakamoto wrote:

> This is a fix for Linux 4.10-rc1.

This...

> CC: stable@vger.kernel.org
> Fixes: 09184118a8ab ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")

...and this don't add up (though it is something that should go to
stable, good catch).  Please also try to keep your subject lines much
shorter.

--opjaugvoznyxbhy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhT3awACgkQJNaLcl1U
h9CQIQf+IgvSzJlRtUvanmvWb96y/at5tB3+oqP1SzRS3RETUXaxDEmiWQZvGc82
vi+r5ngq0HSvrshNTnLGU3pPuBKkM4GwwZkI+C5wR2xiCpDgB+G1vN2UPrdm6MbA
+nNvK7eBwkd2qt41Wjc/ssAruOlgyXP8mpmWSARoMca1uIJB2+yclLlad3e1X/F2
XqcgJFbg/Kd/qGgyHzWXi8RqP8bIkogTHoeaDrs/ACeSqxbtM0mIIvkyXVF/xDl1
NYtAr4CnW2Ui05z0Db8flJYCnzNFyf0dV9Vx/Asyy1sFAExjroy1MxOygZhhkx7F
b7RcG75Sf/tTgyxkFhOIVSGj++hNPg==
=ELAy
-----END PGP SIGNATURE-----

--opjaugvoznyxbhy5--

--===============1458093116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1458093116==--
