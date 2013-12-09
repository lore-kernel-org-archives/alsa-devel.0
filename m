From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 2/3] ASoC: don't leak on error in
 snd_dmaengine_pcm_register
Date: Mon, 9 Dec 2013 18:43:48 +0000
Message-ID: <20131209184347.GU29268@sirena.org.uk>
References: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
 <1386105994-16373-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1022589850173640213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 688232650B8
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 19:43:50 +0100 (CET)
In-Reply-To: <1386105994-16373-2-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1022589850173640213==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8gs9RsbElyYeG6Yn"
Content-Disposition: inline


--8gs9RsbElyYeG6Yn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2013 at 02:26:33PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> If snd_dmaengine_pcm_register()'s call to snd_soc_add_platform() fails,
> all objects allocated during registration are leaked. Fix this by adding
> error-handling code.

Applied, thanks.

--8gs9RsbElyYeG6Yn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpg9gAAoJELSic+t+oim9J9gP/jag/O3jtRlgUyTXX57B9Cqa
JQGwij6exLwr180PQsFn1mlZ6OCASsHi52Qz6rADAKrDYUDiNta7lOv+6SakAMsn
T2DKcJ5F614n2ZrDFgSLYc19n0bZLGBBwd0cGoq8EASf6vKqgn3RPeYboF8WY4DD
gjm7HE9+0CS2ZBzQy+MDz6qepU3NYa/04oRzKARL6ou+eFmngwVAbiBx2KVruybW
GaDdoSDN1GKZLlNgbRsYRJDVT2uwQfd1XSrIyMcy2oHfQvnUBm5QJJrFq0dL4ivi
TIShzThzzPJb8rqe79EU3KIPn/TC1Oh8wU7nkg58kTDmdZQaoeKPNYROJ+sGEGrQ
2yhb8OkPCtMk9sr04nQnV2cvooHJs9C1ZNnhrFomEo6zSjRy0gHz14//GAZxXPL2
rqYq/BR3kcYctfU2kpu9b0wh/dOlQNnWpczObgdW+GlzJxvWBq1Vbdj1axYGZp9U
rrMOobww8IYhwKcdEFGufZDMp4vViARiJ9UZHypVo+BBWkxPYF9SSS7+gSysc9HO
F5Y7SyU4v7RVvhHKpjTCxe80uV8HyYxFN8MEViPtqSJvP/cJbzSoLGwLG2Lwmowb
tEXZ1y7+ZZXoVp1es0vWU4gi3AZAvarc1pVJZNjC1B7k8nFywcPARqgXZrpgLWAT
F5NuEi+ystV8ydbM2mdI
=DT+L
-----END PGP SIGNATURE-----

--8gs9RsbElyYeG6Yn--

--===============1022589850173640213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1022589850173640213==--
