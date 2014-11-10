From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: davinci-mcasp: Active slots
 depend on active serializers
Date: Mon, 10 Nov 2014 15:00:33 +0000
Message-ID: <20141110150033.GZ3815@sirena.org.uk>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615540-28981-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4462312384065206111=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C39326155D
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:01:50 +0100 (CET)
In-Reply-To: <1415615540-28981-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4462312384065206111==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yImwRA5k0rgsu8pT"
Content-Disposition: inline


--yImwRA5k0rgsu8pT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 12:32:17PM +0200, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> Active slots count depends on the number of channels in the stream
> and the number of active serializers. Each serializer will handle
> at most the number of channels specified via 'tdm-slots' parameter
> in DT.

Applied, thanks.

--yImwRA5k0rgsu8pT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYNMRAAoJECTWi3JdVIfQVrAH/jZOHFScpWUeIGOd1++5EYuE
CKE5RrcW+rd+8JZoRSX0pRiSiPINhLqx4EYGBVfVpuZRfUZO9jQqFAfDe2uOKZ2E
bORnL4t+reiqfKXZzvqZq2PMMrlELO0bJ9tqgtulfDPYRxWm65FzeP7J2rPK+Fuj
pG2atQ7JJv83FOkxSEiJsMgT4mKGuqFtsxxl1XEXa7T3DSBOnxE1TWSb4J34tlIz
NlSwnm+LbPOGdyvAgYjsAmIhuwa41pIKzE4hoODDlZjV9JAusTw6QTAEu/EF9j8H
jvnOZQ2qgtodl9RdsR+sXcPBiFxMHprOLPAS7H7qNxAcCsvgRf4u/WlUiLyR1Kw=
=xxm2
-----END PGP SIGNATURE-----

--yImwRA5k0rgsu8pT--

--===============4462312384065206111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4462312384065206111==--
