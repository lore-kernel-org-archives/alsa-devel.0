From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ak4642: fixup HeadPhone L/R dapm
	settings
Date: Tue, 21 Feb 2012 10:01:10 +0000
Message-ID: <20120221100110.GE3079@opensource.wolfsonmicro.com>
References: <87d3989623.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3360202922735299116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84F172417B
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 11:01:15 +0100 (CET)
In-Reply-To: <87d3989623.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3360202922735299116==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2012 at 08:14:16PM -0800, Kuninori Morimoto wrote:
> Current ak4642 driver had wrong dapm settings for headphone L/R.
> If you select headphone L, and select R after that,
> headphone L setting was removed by R settings.

Applied, thanks.

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPQ2tfAAoJEBus8iNuMP3dLG8P/jlDpLkvuM7uk0eFpueSj5N9
ONUHBwQEz1TtK9H1z9kNLzWWvlDO9JsaWTl7NSl2DDLf2/I6bkvyvVoRptnwY2u7
KbFqviURUAOkfczeetypHve1aZxPedOI+BnlvYrilQvc2fLa7GcLQZp5YsA8SxlH
mJbYPxJk9MC0t/n5nnRHVhrvoVDu23MdGN6vE3y4r8uTn+Zoua3cnF/KajyvL5Vo
xmkoiLR5EB/kvSWhtN5FyRG5ArC6YXMRt7pGTFmUXHH0cW4TU1SoRLSL9kSptbc6
9AoJjnQeUgPCDSeI7tXuCH7KmTO6O6YQEVkVtDAIMmkbwgTd7w4GvFNgcrL3303v
IDgplOqoY1/HjAIlVomhu4nsbxYKZQELk4oxE0IZFVIjT7B4+t/5WrWDLCcFTyOE
cot4GXxnKjhyI6h7eYcgYMOZljPWU0vr72lP2l3sokHxTrmBJdcsqfgYvFzp7rr3
pOj1D1ZKyMaFuJXEppSXybNISbtZm+wDoEdkYX5c18N3/2NJa2eC0A1BH0qeiLry
dZED2j8A34JIopN26A9426LxW3BEwns/rukcFWkR5+1lj0vV6OX1a94R63//T0iB
6y5Ao7DttvXwTomCxzJoWM3qPX4a+iIMOY8K24IiD61YcqEFkYVMjJvTizh1Tl5L
vSTTHlwbR+ZuF5nVAJ7w
=yFQc
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--

--===============3360202922735299116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3360202922735299116==--
