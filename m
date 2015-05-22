From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4 v2] ASoC: rsnd: spin lock for interrupt handler
Date: Fri, 22 May 2015 14:15:35 +0100
Message-ID: <20150522131535.GD21391@sirena.org.uk>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
 <87382qtwto.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VZLKKa0PG5KXlQhV"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87382qtwto.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--VZLKKa0PG5KXlQhV
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

Applied, thanks.

--VZLKKa0PG5KXlQhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyv2AAoJECTWi3JdVIfQNgAIAIK5c4/1r8BVsWwwu/JjEO4+
VLlizzzD9JU3Fk7TsU6y20ldn30Pu+5AFsGj1K50P4eQj5Wf4WKc9vL8LV1LSdmK
FLb1wIxOcV0o7ETI8WAXwqUSrhtTjDMjecP66XbiGWOyQVaeAlwP/JNs324pK095
tCLRiCZH92sX3yyhxAUHyTe6/MCDDMdyvog9B0K5UPdAnrfFQThYK0CoFbEiU2Oh
jzocsv4ihNbSAr2BrO1gOgaUhMcdnmuMszBPrLFfgo/WIjIkb/ooErausQnmgbWP
J6muqx9cCJ+ybGEsE8m2j7UNVtJG87zIV82BFsyM8hqxLMlQFkEiN4J0s+hooTE=
=5O2O
-----END PGP SIGNATURE-----

--VZLKKa0PG5KXlQhV--
