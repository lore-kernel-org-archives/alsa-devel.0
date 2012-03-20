From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: buffer size
 constraint only applies to playback stream
Date: Tue, 20 Mar 2012 15:26:51 +0000
Message-ID: <20120320152649.GC3445@opensource.wolfsonmicro.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5165532435502361353=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B5A910426F
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 16:26:54 +0100 (CET)
In-Reply-To: <1332242021-7494-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5165532435502361353==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 01:13:39PM +0200, Peter Ujfalusi wrote:
> In capture stream the buffer size does not need to be constrained to be
> bigger then the McBSP FIFO.
> In capture the FIFO content is taken out in period length burst, this
> enusres that the FIFO is not going to overflow.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.comm>

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKGlAAoJEBus8iNuMP3dddQP/RDciKrxMe7dJTtQTS6DI8T7
zw8O3vGncsSVK9ui7F5wSCNETdAKm1laBwQaXIx4Pe62hb+IqOMtMawq5DGmoZDY
XrKg/w6/gBgjoNYugYXE+uYh9dEnNbBSb/4ow6rqSPX1FqWsdkV/tLiZy80gjUTd
FQbY+Pkt1XJfuJbWypXVxPVDdQEtffhnlO08cE9Yg+ryMZGZ0Aq9Uogk3DqoeR0n
dBegvTowIyA/SO09d+QnwExWoxZpCrY6ovZfcrYqZd2DJqxkZjfpcFsIanybw9CT
OTYSCnKB6E+5AZulJioekf0/DXPlOCcokZYeVjrV828nqWH0LRiOcE11x96NFke/
kNpt7/p2XWhmWo9prNcAPuGTGgdmsnmx1xfbRaRCdJUvLmLgM9mWEe1QLC04Na2R
oMnKxQHV6l8sHPhnE/5MPwJltKn+TW2U2VNP9qMAMy37n8JwSZ39bAAMlSMxCF2N
KxF8yiv0yEwt3L/mYJNtoBatrR2//qS+Vo9ebK2Fa3i9hBBseTE1FECma1jCjhC0
3n7jFCjD5vN0m5mIwm0fUeoiH9HTjNp60c/lldC+qutMWK9JxIRC41yWJibTYec1
vu8ACTzBiwM4AeccX+8XOsi+DaUZFsQgyopGTSx1G/D9riD50V6ESuaNs8v/g/wE
7/3bFmMZxWGm+Za8SR9m
=AB+3
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--

--===============5165532435502361353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5165532435502361353==--
