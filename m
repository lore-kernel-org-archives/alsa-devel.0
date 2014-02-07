From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rsnd: use device dependency clock
Date: Fri, 7 Feb 2014 17:42:15 +0000
Message-ID: <20140207174215.GI1757@sirena.org.uk>
References: <87wqhg6228.wl%kuninori.morimoto.gx@gmail.com>
 <20140204182749.GR22609@sirena.org.uk>
 <87siryv15f.wl%kuninori.morimoto.gx@gmail.com>
 <20140205172640.GF32298@sirena.org.uk>
 <87ppmzb8y9.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1938015973286765288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B91A265372
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 18:42:22 +0100 (CET)
In-Reply-To: <87ppmzb8y9.wl%kuninori.morimoto.gx@gmail.com>
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


--===============1938015973286765288==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Content-Disposition: inline


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 12:53:06AM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current R-Car sound driver is using device
> independent audio clock, but it is not good
> design for DT support.

Applied, thanks.

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9RrzAAoJELSic+t+oim9nVYP/j2Md/70j1Rnl8nPtgmJ9nBo
jDRtP/hqg01rrZ+5EEKS3MyeP00cDC7tWi93VHlQg4E3laWunrn9OjnuzjlXPAQ5
SC+NXM8luwvhZdWTBRh15tft/hAo+p6YOFm80dVSMSEZPBNCaIqnGHrSe21A1zwK
sgAVNmoNbrBVxFSYts0Sxmb7OohTe1j1+bCqGfygCpg5PDYnOinIWzI/pYGpXcvt
/SBTp4wqodlb2jmCdmjqWXZzb84OwdgAEq7PmrfjoPYIg+GOOjauZtsG4L0hS7hN
3U2S9ykfpYcQ0tej82F+LdtzEJV/g1I6jRequZAjteNK/efsfOtsSPGb7sNd887p
fUzwpNiJf6FxGPd/QVQgRumrORlhD3wjdCDpNswX1Uo6lT23cES7FjfbaxFhaa3t
wSz72EF4gLH6Qd2WZ3nGSt2X+qnyw0MUlAEhUGyBTxYGYkYyAA3FR/7bvLcEC02o
2JQPWBSPRL3gVM0/8gOd6aHFDYyyupGBaRUK7N9ZI2EiYVZ7ItIEqY4anQXhx5hW
Y9HtRZPjSA29nomuK14IwCyKReg3xUE4yQV+SrPUc27jGVKDow1wKOO/6Q9HG0N4
yEleD6HE5FHoXVDiorgpylKvEaaU/bVWvsPPyVi3rpwfErFolqI8Lx/uh0eOBIFP
5/GvmM3KADzwaCDS6el0
=Q9fd
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--

--===============1938015973286765288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1938015973286765288==--
