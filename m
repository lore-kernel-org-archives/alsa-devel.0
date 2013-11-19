From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: fixup
	dma_async_issue_pending() timing
Date: Tue, 19 Nov 2013 19:07:32 +0000
Message-ID: <20131119190732.GM2674@sirena.org.uk>
References: <87k3g677if.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8780441735387605525=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B7F1A2607D7
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 20:07:40 +0100 (CET)
In-Reply-To: <87k3g677if.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============8780441735387605525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t3tFFy74pA5/PEcJ"
Content-Disposition: inline


--t3tFFy74pA5/PEcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2013 at 06:45:16PM -0800, Kuninori Morimoto wrote:
> DMAEngine will stall without this patch
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.

--t3tFFy74pA5/PEcJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi7bxAAoJELSic+t+oim903wP/A5gupcqHcHbJtErJnBHWXe4
oPlQSfuDjRKgnxRpTEH7yc2KBmP6ZsASup0M/pLdSxkW0gciOiZi5SDW9CvRaB3V
2Roz9hWHtucw9+ZXicakYNzXOxBGV9cFyfeOe8xAbkh71PnZD7glZp6pTmtVjkab
VgbTDkG67qnbU8A2LIVBv5CrGmzpZHq517XKtaY0yPC3CmkJwb8T7+K5W8zidghd
aHdGyylLEu5cvcQmxZGCww7JA05FXIfBT162Ev0/8WJhJUsL15XDXutiBAZORd+g
raHjDjRktI1rSjHESjpxUqv4trwA4UO1GnAmSueuLYmuH/IlTo2/PNbVfNLC1gdP
OnAj/yTS7rRQEYltRMLuYHIrVOY5IlXo+sEIGtQ7XJO7UfQD3kDLBfu6KYloLvM8
kIElbYKnIPC2GhrE+j9u3sN/c7E1ALgDzfy/cP5TrFcTEU7WYmEDL6aeLAwLD7//
H/fmjMsz9GTPIQXIbW3Xj2exTcT4Ud9ms8tmHn7tYEM3C6aLm4hL0Q1vcLf07H/0
JJvpWjlAs5IGz/9AE5GgTqCZyxh3ivVlG/TvmXcBvV5Ou9TMCPlMTsuTSAKP81FJ
nV31G+de14TeiEfWv1HrjuJ0EfJtqK6E1aTXlU6t3yApCGkAh5TENyXrGXvFp231
+NNszCBhu3NNicoZkun9
=wwj9
-----END PGP SIGNATURE-----

--t3tFFy74pA5/PEcJ--

--===============8780441735387605525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8780441735387605525==--
