From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4 v2] ASoC: rsnd: spin lock for interrupt handler
Date: Thu, 21 May 2015 11:59:40 +0100
Message-ID: <20150521105940.GV21577@sirena.org.uk>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
 <87382qtwto.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="87MiR7gHvrw39A9h"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87382qtwto.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--87MiR7gHvrw39A9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 03:50:23AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Renesas R-Car driver interrupt handler was not locked before.
> But now, SSI/SRC interrupt handler calls restart function
> which should be called under spin lock.
> Below error might happen witout this patch.

This looks fine but I guess it depends on patch 1 otherwise more errors
will be introduced?

--87MiR7gHvrw39A9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXbqcAAoJECTWi3JdVIfQCroH/29G/PQMVeqOX+wgFatlYVn0
wBPiWzz2fqgPbsd3q+/cjziyg9WzxJjWvLO97K7XouXKAx4yGdAN1p7m24sCDAuj
w73cfFVyMz4p6cEAbS3/VVaBCHpM8vEyBXJJgJsUZbhtEr/shAuC20ZWPXC4b7Ej
57F8hF/3mz+85VRHlLlSzrUTsG51uEVYCE9BBKy6dvXnXEN5LGHbcCGCglHrKxEK
uNpSGjWxtWiGpoTUBJwGSWGn8pBIJdZz1rWhEhbkpIiwumj+P9CeI31leWE838IU
ddWk7N3RDQuesuQcZL83I1KrNyXu/VrlhIW0bq8/SpKUgCD3LYJAVVzTIj12pI0=
=V6Ee
-----END PGP SIGNATURE-----

--87MiR7gHvrw39A9h--
