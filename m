From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fallback to PIO mode if DMA
	mode was failed
Date: Mon, 10 Nov 2014 14:54:27 +0000
Message-ID: <20141110145427.GU3815@sirena.org.uk>
References: <87389rogaw.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8580685229737657249=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B65F426155D
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 15:55:42 +0100 (CET)
In-Reply-To: <87389rogaw.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============8580685229737657249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IZo0yZFqN3M7MR32"
Content-Disposition: inline


--IZo0yZFqN3M7MR32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2014 at 08:00:58PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current Renesas R-Car sound driver probe will be failed
> if it try to use DMA mode and it couldn't use for some reasons.

Applied, thanks.

--IZo0yZFqN3M7MR32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYNGiAAoJECTWi3JdVIfQyTgH/1YjUxcexnpeIUfkcQPd2924
JxDgfrxBORJLY4Q4JLNeNRRrBaUOXJRmxIjsuogaYc2IpSbAtnkse5Sg/qTdu0Xb
kubjzxnzQNpqMk0Ccpea98hW6BpG06IPxPCaTLnybQXlo9x+3DE1KIlsMtYmRGua
sQsW9kdnh+St5T4QF9z//D0SRBXvEPdQYJ6FbCPRlrY28lvnGztJkdosvZ4t4xS9
1kpst0RlWVGulmiWOkl7+uu1p96nbw/unlSY2/el2qkh+zSQh0n3MnNOd1jheyPJ
eVXAjdRI3/LkvmKiYjKlPjyCvLZ7eSBo1b6C7FNKamecPcrZUWW9AWupUhs3wCM=
=sV5T
-----END PGP SIGNATURE-----

--IZo0yZFqN3M7MR32--

--===============8580685229737657249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8580685229737657249==--
