From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] ASoC: fsi: add master clock control
	functions
Date: Tue, 6 Nov 2012 09:56:44 +0100
Message-ID: <20121106085644.GE5044@opensource.wolfsonmicro.com>
References: <87mwz3mjou.wl%kuninori.morimoto.gx@renesas.com>
 <87k3u7mjmp.wl%kuninori.morimoto.gx@renesas.com>
 <20121101144729.GN4413@opensource.wolfsonmicro.com>
 <874nl4271g.wl%kuninori.morimoto.gx@renesas.com>
 <20121105080336.GA28886@opensource.wolfsonmicro.com>
 <87objb799z.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2809834576307708936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B29C261719
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 09:56:48 +0100 (CET)
In-Reply-To: <87objb799z.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2809834576307708936==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2012 at 06:30:38PM -0800, Kuninori Morimoto wrote:
> Current FSI driver required set_rate() platform callback function
> to set audio clock if it was master mode,
> because it seemed that CPG/FSI-DIV clocks calculation depend on
> platform/board/cpu.

Applied, thanks.

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmNC/AAoJELSic+t+oim9ru8P/1f+aYNoEeRw2b4Q+oh90o7e
0/2hx1GZ8SQInhMsTuv3NNisgRii5TpQs1nLhofglr1hX00CCNE8CTVsX3B2vIjl
QXQWJIx6fl0cm5AJxyDTJB+j0zW4kbuWiOmgMvjg71qu5u07JjHcXDnkIA8U9hZW
TJroJ9kZndWQ/jDk57HBAHsPq66tOk95RNZsKDaFOZAjQnrlDd3dtFOaO3XvRn9k
WLPirn9aXO4WK+0gGtaINUrHs2haAI9PZRZDRnJhr8sHQIXWB/G4yH05eO2TaydT
iavg9ZGZcOpxpaLQ2UMNbOddcfddZK1XPH2swGS99auwtYUkJ6pK/HmCfrf3dZo6
D67R5KrJHEfypg9UcdcmuXN/wbKOsXD8RmeRN5HblZRsydmakHkWDwJ4xIwCeyPc
Ek00SNFbrPUbyPFg6M3MXirkmwfIhN+Q3Cn8KYIGcQkgk2kK+cpJJvlShZSPZHpS
O6pTV3g1F4lcHe39OO9qw8pqjiC7HmEJX8TNwaGTw0uOTcuBPcpVQEsLqZxnc7o6
bYg9jeHC9xk4prTS+VnUIxnBZFESgzG+JtXY6OygfZvlkaT2fI9vf/gLtQa5WvMK
qUSTipxZuLS+C+Nat3l6rHRPl+B0aVY9hdJDqqeucGsE8/2v6rx0zfX8ThHhP5CH
uNBFMUxoaJ9utLP+mcDr
=OIMA
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--

--===============2809834576307708936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2809834576307708936==--
