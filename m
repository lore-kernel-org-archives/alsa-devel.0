From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: dmaengine_pcm: Reset pointer
 position when starting a stream
Date: Mon, 12 Mar 2012 19:04:23 +0000
Message-ID: <20120312190423.GA30146@opensource.wolfsonmicro.com>
References: <1330952535-30614-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6489642268769500667=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7EBE243F0
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 20:04:30 +0100 (CET)
In-Reply-To: <1330952535-30614-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, Vinod Koul <vinod.koul@linux.intel.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6489642268769500667==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 02:02:14PM +0100, Lars-Peter Clausen wrote:
> From: Mika Westerberg <mika.westerberg@iki.fi>
>=20
> Otherwise a wrong position will be reported after restarting a stream and=
 the
> first few samples might be skipped.

Applied both, thanks.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXkinAAoJEBus8iNuMP3d3csP/2v9+6IzFL6WaMsuaiUM9vo5
YkEDxl1qPvWPgCJxuydWSBRQPPjr3/GMkTXclqffgw/BQKJI7mYLSO0QBQynivgd
GfnWsjBp5VNBiakbxM6n8FmmlcFZWL0N/bSUjig4W0qTpOQJJfISRdmzcOXqh5Os
Q8xkkQiNuYNgPtzc216ru+G+OSgBlnEtofegr/CptVPdcD3cc3Lgibi+gg8mtVNL
P0ddhjAynjJWYAC6aY65Y1q8Ds0oPNEZS9+r4QF8xxWXc/OCsoxJ8WRJKKuXHQl/
xIy4KnwWquS7cP6+9cC1WrtaEUywLHQ2+dHRlgud/SwUkMSW1hghRB99CDY/jPPI
zDgxPDkQEwfPeBBTt74p1A2cixBxyWcFg/lCM7jIVJ9pUZqocbDKDrI8ZOTYSZs+
JTPZdWkGkNLkGBUisrWSaM6O5VQky7g10l3odb6EMT5CKM9tBmTsuGssJ3QO6GaB
hISTC3/13K0dHSn0TMNf1M/59LSNDmgnv69cw/gv9bBghrwRY2918G3RgVfvuV19
j6bMcQc4e7mR/mwgFD2Eo4/OtTpb/1iqrg0/xyy8wud/ldjPvtwSX8O+/5V6w5o1
cB/DAxBqPdhUQMI4spBhVKwVBPKpxoth6KC3ReGiCoFzGkld35UeRTL6jynAGXuY
c8n4rz4Q4/B+9QkcWIDP
=dVaK
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--===============6489642268769500667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6489642268769500667==--
