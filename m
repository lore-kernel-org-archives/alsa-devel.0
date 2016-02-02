From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Add support for
	SNDRV_PCM_RATE_KNOT
Date: Tue, 2 Feb 2016 19:30:02 +0000
Message-ID: <20160202193002.GV4455@sirena.org.uk>
References: <1454431084-21411-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2496780726962780167=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A7B2265104
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 20:30:07 +0100 (CET)
In-Reply-To: <1454431084-21411-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2496780726962780167==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DFFMAMYvrfM3lt66"
Content-Disposition: inline


--DFFMAMYvrfM3lt66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 02, 2016 at 04:38:04PM +0000, Charles Keepax wrote:

> +#define ARIZONA_48K_RATES 12000, 24000, 48000, 96000, 192000, 4000, 8000, \
> +			  16000, 32000

This just looks wrong.  It's valid code but with the combination of the
split line and the list without any sort of parenthesis it sets off
alarm bells.  Duplicating might not be the worst thing ever...

--DFFMAMYvrfM3lt66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWsQO5AAoJECTWi3JdVIfQ6D0H/j0jSmqlgQyh9XF+J+SkQgli
xMzoX0fv6PwfzaI3pbpwYXMsRomcCBmpkgTXCtlH7xgQh+7YfaP0T00hTwflsW9A
6A0FCORJ9SFYlpj2AYWdstTapqIWJ3IvOMjKbdmvVryv5qdmvOGSunNWbGJ6W1Jx
0MAmQHazXtLLOGgNIvf8DjtZBzU2EvBGmGcpVYoQMAST5vCxBK5bZMb4X6zw1Yc4
JlW+21qUnJuQgeg06VsMVTAytR3Nb3837b1WSKs7gFYspGkXcvDXA3PAfm5Uh5Hx
cm7WePdOqaqrPkfjhlKsFNc6Ai6r2gwozHgJWnpBS+1Jalmt5V2/056bzlAPr+k=
=ZxuJ
-----END PGP SIGNATURE-----

--DFFMAMYvrfM3lt66--

--===============2496780726962780167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2496780726962780167==--
