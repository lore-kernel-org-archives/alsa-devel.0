From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fix clock prepare/unprepare
Date: Fri, 11 Apr 2014 12:10:58 +0100
Message-ID: <20140411111058.GB28800@sirena.org.uk>
References: <87ob08oebr.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6214372313461430292=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A4AD2656D9
 for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2014 13:11:10 +0200 (CEST)
In-Reply-To: <87ob08oebr.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6214372313461430292==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2014 at 06:16:33PM -0700, Kuninori Morimoto wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
>=20
> As with the previous commit, before a clock can be used it must be prepar=
ed
> for use. Change from clk_enable() and clk_disable() to the versions of the
> calls which also prepare and un-prepare the clocks.
>=20
> Will fix warnings from the clock code when this is used.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Sorry, for some reason I misread this as being sent by Ben - applied,
thanks.

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTR82/AAoJELSic+t+oim90pcQAJz4kxTJRBenIsio+lrSdzq0
xMqg21wglPFlSRzlNb92AJRNmQ44BgXHL9yHkBCG10KOMta5sp02ibNFR3epJmVI
ZAPAn4KNez+Tdt6tjug7j0DoeDej4+BPrLjBAeSoxjPoWe4V2zgCeLZ4coirWLlq
zGQMjuBpLTWB1N8G27y105NFybJ9LUjfKkeTiRG63o5t8Hdf2VFP2FDJf85uOHgE
lfaT+IlW3LUHQwQO58Q5MqSt4TtiAtGz61V44fp/uTErmYCWUejjOEozgzfCp7bh
mQbDS+QKVihU3AYzH1JOTurOmGOG0eRPeHDItb4+Aqpiioqoy4KAdL8uQjNOJt+D
0h4wQbzRFZi2JuLuptFKvcifMjMb/uZmf8YulW1n6Kk2dEn7Zrtf1p8BlsQTjQWL
1JVE97DiCucNmC/CfbAHFzyhNRITZoDbsOzIjM+UrwxIibATfMO1wcd463hxIeKB
FqH9vZOVU3bVR3DezSJyWCIpNYe/uCjA4AQneIgt3tpn/xkFy1gn/IX5KN03reRe
GvC1FxsgaX8voAg72ZC2QhSLzqWRnuE+XY1CoK/dpeVxk1odgklanbgmiIvEaPzy
LB0YHAyp/FXP2OO1WKJjmY1A//hOnn4olTo42urrztZGTyO+h6jxD6VgMUcstsQK
ULissi5ZuaY3IqI+3FpG
=nfij
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

--===============6214372313461430292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6214372313461430292==--
