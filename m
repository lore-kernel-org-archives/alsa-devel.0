From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: fixup refcount_t
 underflow
Date: Fri, 15 Feb 2019 17:02:57 +0000
Message-ID: <20190215170257.GE7897@sirena.org.uk>
References: <878syh8svy.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZD3CRzHDd-eGbVWqBUmNuqGaXJwTboQ3v1TnZAN3B_4bw@mail.gmail.com>
 <CAEnQRZC+jDPRLhNEY5xP9AFxvqFvjBVRDxVfNbgfURudXuO1FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5373043000902726618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 31A70266A9D
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 10:20:31 +0100 (CET)
In-Reply-To: <CAEnQRZC+jDPRLhNEY5xP9AFxvqFvjBVRDxVfNbgfURudXuO1FQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Vicente Bergas <vicencb@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============5373043000902726618==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 06:48:26PM +0200, Daniel Baluta wrote:

> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -445,7 +445,7 @@ static int simple_for_each_link(struct simple_priv *p=
riv,
>         /* Check if it has dai-link */
>         node =3D of_get_child_by_name(top, PREFIX "dai-link");
>         if (!node) {
> -               node =3D top;
> +               node =3D of_node_get(top);
>                 is_top =3D 1;
>         }
>=20
> Not sure if is correct, though.

That looks correct to me, of_get_child_by_name() takes a reference we'll
need to drop later so when we substitute in top we need to take a
reference as well as just assigning.  Can you or someone put together a
proper patch please?

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxm8MEACgkQJNaLcl1U
h9AVUwf6A8JCmYsPxSiw5g/OlaoBwV4f0dKwgaVH2QjNHvoBYi8GKipHn8+ncb5e
zpQnxaZwYKtDz/bCHJ9YmKUcAyk7XvIJWZnjBCl7s3tFQ60UvlpA6zNwsnHTrTTc
/+RhZr01z7XrA33uEida0PGxw51Bbev898166RrZe3pZMdn67nmdsRTSoq0SNdIw
nJEkoz77h6VXy/I1VYR4gUOYq9Nj/SOelTbvw+aNiWFLXJaoapB02sxWIG4/Gm07
7W12VgAHATo/ODcYiaigo0Bj/tW4p9BBIgOTAwBDjOSpc4nP3jN/jOkJ91H/crGW
tyEyKxcIrakfLmBAKunRoQNVAREr4g==
=L4qp
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

--===============5373043000902726618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5373043000902726618==--
