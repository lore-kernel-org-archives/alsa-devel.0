From: Mark Brown <broonie@kernel.org>
Subject: Re: Problems with i.MX233 driver in 3.12rc2
Date: Tue, 1 Oct 2013 12:41:27 +0100
Message-ID: <20131001114127.GN19304@sirena.org.uk>
References: <CAG8Y82pXO3ZFGG75fY4ggSTpNQ4wF2j=mmVuw3XmWxKSdT2Y=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4917791535019907063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 053E7262610
 for <Alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 13:41:35 +0200 (CEST)
In-Reply-To: <CAG8Y82pXO3ZFGG75fY4ggSTpNQ4wF2j=mmVuw3XmWxKSdT2Y=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Trevor Page <trevg60@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4917791535019907063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kM4gEFU/49KOGupy"
Content-Disposition: inline


--kM4gEFU/49KOGupy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2013 at 07:43:43AM +0100, Trevor Page wrote:

> First post to this list - I hope this is the appropriate place to ask for
> this assistance.

You probably want to CC people working on the driver too - I've added a
few, git will probably help you find more.  Things just on the list can
easily get missed with all the traffic.

> I'm using the Olinuxino Maxi board with the i.MX233 processor. I'm using
> the 3.12rc2 kernel at the moment because this has recently introduced the
> drivers for this processor's audio. I understand that the drivers for this
> chip's audio are:

>  sound/soc/codecs/mxs-builtin-codec.c
> sound/soc/mxs/mxs-builtin-audio.c
>  sound/soc/mxs/mxs-builtin-dai.c
> sound/soc/mxs/mxs-builtin-pcm.c

These aren't in mainline?

--kM4gEFU/49KOGupy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSrTkAAoJELSic+t+oim93vUP/2TlvXAM96EzvAABKME8tLYQ
l+yokgoPIt2oQoVrytvYZZtlToTkUpAJWlU2sC+L+JaK4JyckZSeIXFp9IAu24VI
GCftKRYJV7gx1JRTEO/kWr4Xp+dbpx0XB77UJpymSuxhTPDvcBfT7IQJXKtxMkag
qH2DLpdSUnrPH17kmxIUOapGynE3gR2NDYMH4n0YmZ3jz/bjAgun4GXyLAH9fxKI
FGEVClNNHJ8rAWYmcH8K73H/FC1EHoPe/+oZAqgHhkcYDkbL1KedAzf3YSyuWMAo
qHooNRe+8ZJHb//F3OZxn4Sr3N8Dzjui+DFIZ2/FeyZ39SgYZFAGiZEXYm7odMEA
dMN6giQDWXEPlSXY5/E1LN7X2bCvtt/ypT7dVYZn8KwqlmSNxQsJwaVeXEhA/rLc
dnNGsNNLcBGS+OewD3Kah5cVNl0LHl7diFIEBQVa+UihJ9eNNvYX2DYeW+4fDdfS
WopchocdqSRTlyLF+pDKO7XAnvXHHNfbaBSBzG00yxJA2LMT5NiHLgiz32V/Qw7w
2kXUag0Qr9EVtXfgLIsQHuyeYmbJqDGe7MSvtoMm3PqsvlyJpoPhnWtqxlcvGiYH
tWgnHEN+FwhYg2HQxf/lzqOu03nr0yPRkx65PbUvQCnuGDcMwbbRB7MA9q2yVP/I
I4dq5pHgTtE8xcoIuZ3H
=OFUt
-----END PGP SIGNATURE-----

--kM4gEFU/49KOGupy--

--===============4917791535019907063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4917791535019907063==--
