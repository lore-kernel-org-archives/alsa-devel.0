From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/19] ASoC: rsnd: move rsnd_mod_call()
	macro
Date: Mon, 3 Mar 2014 10:19:42 +0900
Message-ID: <20140303011942.GC2411@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <87a9df90s1.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7206269875505587056=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71ADE265514
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 02:59:07 +0100 (CET)
In-Reply-To: <87a9df90s1.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============7206269875505587056==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 10:14:41PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> core.c is the only user of rsnd_mod_call() macro.
> Move it to core.c from rsnd.h

Applied, thanks.

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9irAAoJELSic+t+oim9OQIQAIFAMUz15f31kW8Fy4HhgEMH
CIxN3RM4heVbMeCaGy4/TBAEvKBdqDBoxTIvHGBFKtsvHPyBjoNs9H5J7H6Kjbzq
UJ0nlzRrgZcxd5NLDPB1YM2A67CRYi74/yFwrjmgSXlSeuDL9d/TNVatQMj8eiqy
n3tdC7CIvcHYkDz3zCNPQn7iEanOfNu08T4hK9Qq3RwmMwnPS9jsis24/RL/DgE2
nxXWoL9pHgLw6k3RMyHt3F6PQv3Vr5GaJoe6vrp4ng35bPY2dP+rk5RJsLVTlvlV
BxGaxCAry4a+x4OHh8zzqpIgmbuTIbFfzCD+6zOtve9tiJfNNMtnpQCP71vXKXVM
jdItsKMQZ3//mrMstd6v+0XaievhIE+DMpUr7I6EEsdeNNWw/QRUwo3j1mDXMOKF
57/+lwSQpTHvn4q9eD14D37Ul4eKsbsOnecQ7jxzwnb7x6wQw/PRVW6zYm9SGXJg
GkIH8v7McxlBFv2ml1rRNNkHMZEeiS5lpNlnKwnusn1MMM+2A4T9D4QkEk02IjTt
otyFnOlYe9ul829/4ch+FEopbec1lloXcTV4Q5cxzruLlhKi4irBi9ePecHgYal4
ipX3lXMsJapDrxk41Kwzqf38SUIKyvPQWMAzgYwZnLFmNarazVjNZF9R81W/9H6q
5FYTYUSh9QXE+TJHOela
=FgZZ
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--

--===============7206269875505587056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7206269875505587056==--
