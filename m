From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "ASoC: rsnd: make sure it uses lock
 when it calls rsnd_dai_call"
Date: Tue, 12 May 2015 11:44:45 +0100
Message-ID: <20150512104445.GS2761@sirena.org.uk>
References: <87y4kubltz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1007728025834146829=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47438265705
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 12:44:52 +0200 (CEST)
In-Reply-To: <87y4kubltz.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org


--===============1007728025834146829==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRtLtq+kfJNLc57H"
Content-Disposition: inline


--QRtLtq+kfJNLc57H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 01:57:50AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> This reverts commit 'e9c390df671f ("ASoC: rsnd: make sure it uses lock wh=
en
> it calls rsnd_dai_call)' The additional locks make 1") lock issue when bo=
ot
> 2) lock issue when unbind/rmmod. And there is no problem without these
> locks. This patch revert it.

Applied, thanks.  Please use normal subject lines even for reverts.

--QRtLtq+kfJNLc57H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUdmdAAoJECTWi3JdVIfQG9EH/1KvE3si3o94AOfWWDoFutWf
TibhvMDYLX2eLp4EZjOuOBRMpI6I12nlB8xi2Zh1GcHe3ZBrNSm5SgnP+zkQe3B9
u+Ri7JRafZoZay6+tATY0uW/a0I5EVuhv2Od9ypr7K6LR+4FNeGr/KX/nbf3P8Ga
dQ3qNIsXiMn7SFQmCG7AXgP0CUQMZfm7wTA6jQE+EYSsWP3qiRzuX3hXHXgTNn9z
IZTdyvHz8fG4hiMkIRlifr5q+q7agzNKqbH748lc31sVRmmeHDH+/vbEdGpKB/Oe
Rz8+hHbnkF7U2blaQYH092cu16nBr7isIXO5MTUZwJGehCMA3siSNEA7rrm+4WA=
=uE5d
-----END PGP SIGNATURE-----

--QRtLtq+kfJNLc57H--

--===============1007728025834146829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1007728025834146829==--
