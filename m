From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl500.txt: Document the required
	supplies
Date: Wed, 15 Oct 2014 11:25:22 +0200
Message-ID: <20141015092522.GW27755@sirena.org.uk>
References: <1413295862-2613-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4782763332859688663=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C35142604CC
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 11:25:49 +0200 (CEST)
In-Reply-To: <1413295862-2613-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4782763332859688663==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="krZS3EFpRWg3Z7I7"
Content-Disposition: inline


--krZS3EFpRWg3Z7I7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 11:11:02AM -0300, Fabio Estevam wrote:
> sgtl5000 has two required supplies: VDDA and VDDIO and one optional suppl=
y:
> VDDD, so document this properly.
>=20
> Not passing VDDA and VDDIO prevents the driver to probe successfully.

Applied, thanks.  Note that with current kernels the regulator API
should assume that most regulators are provided even if not explicitly
listed in DT.

--krZS3EFpRWg3Z7I7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPj2BAAoJECTWi3JdVIfQwtYH/2d0yCuNXBOiPA1reI+hIyc2
GpAOY1znHYH87/MlJ/yBA2yUUaULsrQT0N+Ix6ZqJiw7j4bPl+Xm2n07EPBxc33e
xf6WghXyoJsgK4wnUtMoksWaRdoSIQhVC3F/amf2zMyiiUy/82i86UJiXaSQsh3t
aBX+YvcaHlPh1V7HNEjID0D5nikVzv3gLWtatk5BTA2XvwEXTpxsY2WJFTNH+7ww
I5cKhns3gycQv3ffboXuEZOpUXVk7rECcg6Fule4XKjj9Ojiv1x1J8MvTmajhm3X
DeQ8AZNHUA1Z+maPFlRGYztXA2TlzsdFEJ840UvpClY4XKS+ylJTAtvUWsNR/a8=
=Rfds
-----END PGP SIGNATURE-----

--krZS3EFpRWg3Z7I7--

--===============4782763332859688663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4782763332859688663==--
