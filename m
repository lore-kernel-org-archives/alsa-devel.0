From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/11] ASoC: bf5xx-tdm-pcm: Staticize non
	exported struct
Date: Wed, 15 May 2013 08:50:41 +0400
Message-ID: <20130515045041.GF24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8689231095064309298=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 487BD265166
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:50:46 +0200 (CEST)
In-Reply-To: <1368562797-10440-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8689231095064309298==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:53PM +0200, Lars-Peter Clausen wrote:
> The bf5xx_tdm_pcm_ops struct is only used in bf5xx-tdm-pcm.c, so make it static.

Applied, thanks.

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxQeAAoJELSic+t+oim9uzAP/RZ+PnkOSl2AfIayzN4tf6Xx
59Dqsq8OKkIM6N+xHwjM1YlIMSdvmErbhVVw4YVQ2UygXVI/Cs0FKtHrv5u3Jppn
RExd4eWh1R9JQdye69a61LZT6Sx+gpVvWk2Wnyauph6RaXbKfTfFNNrXPMf4QBw1
FJ/M2gfr77V+g+0PIaSrEzEfQOBdrPYAHLcPTVZBa585uWLUehBeioWEOCmr+HLC
8FXZ4GXqr+ANKqhSUfUWs1nqvpR9jOFHKXXwg9Zsm1zR4NPK4Oy2sm2YY5FoHAes
oNYEcnTZCRsAZgR3GTSS60Q597y6HT9udkFzrqsm09ORk3N5SEc7fgLldXe4s4rm
bNunv8g/Bt8NS+v32ozGKpy49lV9cbzbufvP6UFf7pnNLtlgNSoy5eisBRtB/FZv
og1j9BVBlE71X2+ug7CxeGtPgYi6VXEnT4z2J/x+O7Pa3HFFp7jQe9+nF9/+dSez
4T4TbCEZDYVZblEoJwNHBe6i9QYIUb2gd0n69+KP0AOKwaEow7OI4kNHFiyp4x5x
6g1M+vIARZnOCICex3prqPsOS6JT8VuE6fBUqa2FRhikt4y4k7putMJM8U0BECC/
C2X7+2ZpuF5RDN+4gW9a+tQuuUGY2RzHq64wrzhgt31QG4GlBnStpP6zfrUZ5fVA
rfsqOjT3zgnW0uaSDnQt
=0prN
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--

--===============8689231095064309298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8689231095064309298==--
