From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: kirkwood: Fix the CPU DAI rates
Date: Tue, 17 Dec 2013 14:10:38 +0000
Message-ID: <20131217141038.GJ3185@sirena.org.uk>
References: <20131127211024.52e5ae1b@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5387814055887470292=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 69CBA26162E
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 15:10:43 +0100 (CET)
In-Reply-To: <20131127211024.52e5ae1b@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5387814055887470292==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H97thLd5/wxpNVcA"
Content-Disposition: inline


--H97thLd5/wxpNVcA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 09:10:24PM +0100, Jean-Francois Moine wrote:
> This patch fixes the rates declared in the CPU DAI parameters:
> - SNDRV_PCM_RATE_KNOT and the discrete rates SNDRV_PCM_RATE_xxx should
>   not be used with SNDRV_PCM_RATE_CONTINUOUS,
> - SNDRV_PCM_RATE_CONTINUOUS asks for rate_min and rate_max,
> - the device may do streaming down to 5512Hz.

Applied, thanks.

--H97thLd5/wxpNVcA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsFtbAAoJELSic+t+oim9LjMP/j60MMc9JmSBfqOKjw6eo8ey
nJvNakM8CtuzuI2LGmdvFByeE5zZBW433o1r0E/vjF2DSwxCMtet5J6vxFVo5GQT
hQr0YAlMbxlA8RGkK+GemsvxCtW/0fzpMpM8yEMml40M2YpF5wAIXTPgKd8ukzW+
QZlPGJIplMpbKW5zpTQmmTuEjS6/I5PW7ykFnI3PHIAw1wV+7gHRr/CZNIHBObaZ
FwIzvc2KHj+2GDkngDzaXJRUA/HSlX9yLT0EwVlwCurqdiTdnuzbzuYlRN2qVteE
Da9ND8uTkh6/QNqYWzFpebaSvebYY/pF73wSDSh1+1ZuZs9SUgFcMg5RFbNzAS/n
cckV971f5HzRNYB5ILHJ90cwzjYvpIfDH9ZJJKRwOR2/FkNf6Eao20TkEgukZrX4
DIAcPt4hbAH/KuxE200mYe0ji+ONZfXsaXHspf57vdxdBDWAUUcBhcVrujC0iaQk
5siyhGrWXF6UtNpppboCBAvSRUci7mhZWDplKlBsHumeOljakVLwZt61Z4q/x1m8
31e3+ZPAANswS53GNKc9It7SurVWJkvT4AIdWmuHY7d+B/l8PAXvlSwJZUfbdFzX
2462aVM9+VYDqPx6jAgLGrqWo5OjYPv/m48OAXTGxJz/wixiinPFfuEdXzU+Tz3d
GXSDZuuDKkIvN6oHw38Y
=N3iE
-----END PGP SIGNATURE-----

--H97thLd5/wxpNVcA--

--===============5387814055887470292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5387814055887470292==--
