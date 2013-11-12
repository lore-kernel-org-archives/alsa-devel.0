From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: fixup mod access before
	checking
Date: Tue, 12 Nov 2013 11:19:04 +0000
Message-ID: <20131112111904.GK2674@sirena.org.uk>
References: <20131108100206.GP27977@elgon.mountain>
 <87habjda6g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1247169406926011960=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 49FBC26171E
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 12:19:12 +0100 (CET)
In-Reply-To: <87habjda6g.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1247169406926011960==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rnP2AJ7yb1j09OW/"
Content-Disposition: inline


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 10, 2013 at 05:00:42PM -0800, Kuninori Morimoto wrote:
> rsnd_dai_connect() is using mod before NULL checking.
> This patch fixes it up

Applied, thanks.

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSgg6lAAoJELSic+t+oim92CQP/2GCokTmZc6fuNXDoGfMvabA
8aKEOzsCgvmiH49s1wv76/VEa1LvrHNCguQs0YK/9Pe8vVv3DfvRjEqHziWCiVG/
vTN2prJ23tjqyfYRaD7Od0eYNfJaZpAoXu86MGkFcq8SIxeRs+oCeQqeJ8D4c2p8
op0g9lEhwKCCBSUC++pmVBukEZ+KrZMCD3YC3h+OwoJb3Fvk8xFSXghoM+7gg9SV
/gqhbTcM5Q5nJq6nlkfhQ3bCu0gxOSRm1SiyFSlSeTWZxXqfTGVPZVebYgIvPc//
DUswdH6I09Pv4vQxBySQ73+gHvH7TVtci+4KW4uTZHWHtsEAWRrhkVJM26H3PSh3
dz3A82itDGrsTdKFewH/toEwbD1aLk8oDkXIW2NkcM59GDkwdRGhtq4O3fE2xck/
aaD3WU4Zj9yQzDX4F7cH9aku8FOalZHWTJ9u+7Sk6hgZCerCKgVxKn1w+ClyRLTl
ICQc9oTfS9O1JLXP6oR1j2vWmoTvn67VSzaNmNmQlxkkDnGqmj+sun+jFUJ4aDUq
1f5LCvsd/0P2vopMNGAvTRDZA2Zzmp6kdVyUUF/6cyvtQ1ignFTBr08M1f1pi1Ct
sj5gLQcnyT2biUycCT+cPOaoFowwYKsZK2QeCKdFILSGfUkCoK3088rIt7MjWycc
7hbIEdnFiOkamaFH5c2G
=eyOT
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--

--===============1247169406926011960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1247169406926011960==--
