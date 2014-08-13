From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa-ssp: drop SNDRV_PCM_FMTBIT_S24_LE
Date: Wed, 13 Aug 2014 21:12:16 +0100
Message-ID: <20140813201216.GR17528@sirena.org.uk>
References: <1407959466-3690-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1327069352857965757=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30E1B2655BA
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 22:12:21 +0200 (CEST)
In-Reply-To: <1407959466-3690-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1327069352857965757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G20u0iTTYyGqPKvM"
Content-Disposition: inline


--G20u0iTTYyGqPKvM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2014 at 09:51:06PM +0200, Daniel Mack wrote:
> This mode is unsupported, as the DMA controller can't do zero-padding
> of samples.

Applied, thanks.

--G20u0iTTYyGqPKvM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT68acAAoJELSic+t+oim9dGAP/2mTkIPfoMCpq/v2MCAALNzl
GDsg8QjqZbNFHTHSDec1XnYnqO9dNrTvya1mQk4spE8xa7tfxcxaJaPss2iwpygd
V3dpiOk7n0noMhhHhMQBOr7voCGXQIOknaniF3i34nqiuEZ/oXULocJqyp8IA18D
IrrX+q4poL5m5Qlp/qmSx9206jxAAsgo8vQVKCWQwyDOdiHRFprv1oVJRPkTRRlK
3JsqyJqBKvG8O2rS9n24aDDaSXeIoClV6UkvSh+zlFXY0pe2gFALTevuiDjcbzLE
cCcplMxiy4OA8LzuK5Eusv5fIHBuQV5gX5hqFGjjcchKSTI1xzFIOkXTbR8O7BT4
WcUtssmnyfbjh6sSeW/JhcETdJLYvkeVp4jJKMwdFC/3a4QewFb+FG2i3sQYwNco
eN4R3L95j6VnwEGAYF3rQ2nwUIaQcXjZo+P5saYGdbfzjFgD2hxczZJTYmtpEx4t
UPZWGLCuJaYsRpjuAVyNYbbXo1BNQbiuvaACNtbt3ScbEzEnIAtohPsL+KB537iH
b7ejmqTpomWstiRKEfNFjLnbthjAVv1GX5ZN6UApHDS2lDyAnUslKYF8YzApBq+N
M3wp2sWkQS9TJmbkVOBSK//NJx4aZeYo9oqJ1dwPpk0aKLxtijeyxfDCw9Teo8Su
dE/4cfcJfjYv0J7do76a
=QhN6
-----END PGP SIGNATURE-----

--G20u0iTTYyGqPKvM--

--===============1327069352857965757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1327069352857965757==--
