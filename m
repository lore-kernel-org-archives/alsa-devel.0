From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 18/20] ASoC: rsnd: add salvage support for
 under/over flow error on SSI
Date: Sun, 7 Dec 2014 13:45:59 +0000
Message-ID: <20141207134559.GQ11764@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87h9xl83s2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4493787047675704143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F237226066C
 for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2014 14:46:15 +0100 (CET)
In-Reply-To: <87h9xl83s2.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4493787047675704143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RCJLo13VlymhPcEi"
Content-Disposition: inline


--RCJLo13VlymhPcEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 08:07:47AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> L/R channel will be switched if under/over flow error happen on
> Renesas R-Car sound device by the HW bugs. Then, HW restart is required
> for salvage. This patch add salvage support for SSI.

Applied, thanks.  Normally in English this'd be called "recovery" rather
than "salvage".

--RCJLo13VlymhPcEi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhFoWAAoJECTWi3JdVIfQ7BEH/3h1brvHl+V3ZjW3ucNdi1t+
LxBJfuffWZ9LJ25ubIm6wxQRMMKUsXNZWoNkYoI+zosjpcg/PJrW5W2tVGL3n6l6
lJ26lcFD2NbQ22AY8xQYmojqg8YTy0hgqHaTQY8JxYBSHfyooHoZoSJzOO6YHAnT
UgBZcIaGSJ2OP7xaYQfUMiX6GvPWolIBQkK/W5hJ7Ao/hKxBJO8pSuLgW+mH2OD3
lbTiyA4OqQzdNe3k73jo7ay8vjrwmCqxNYWsKbDxJrIdU8cCkWue6dW3JV0nrNAF
YyYTq2oTWRwH2LhnDly3Kdos1Upsjs6eYkgKBF/g80VUNrjB3Q9RGZMLSjDnqAc=
=XpQf
-----END PGP SIGNATURE-----

--RCJLo13VlymhPcEi--

--===============4493787047675704143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4493787047675704143==--
