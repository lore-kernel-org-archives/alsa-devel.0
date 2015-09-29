From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix DAI hardware signal
 inversions
Date: Tue, 29 Sep 2015 16:35:12 +0100
Message-ID: <20150929153512.GX30445@sirena.org.uk>
References: <1442504814-16965-1-git-send-email-benoit@wsystem.com>
 <20150917175927.GB2544@Asurada-CZ80>
 <CA+sos78+6yEo5j0qqP24_N-OOsLFTLoRkB-dbJw1H5vzvBGUYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2676912427089061088=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F91E2657B8
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 17:35:20 +0200 (CEST)
In-Reply-To: <CA+sos78+6yEo5j0qqP24_N-OOsLFTLoRkB-dbJw1H5vzvBGUYw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau.dev@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit@wsystem.com>
List-Id: alsa-devel@alsa-project.org


--===============2676912427089061088==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zq1NejLgb6rxdd6z"
Content-Disposition: inline


--Zq1NejLgb6rxdd6z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2015 at 09:36:49PM +0200, Beno=EEt Th=E9baudeau wrote:

> >>       case SND_SOC_DAIFMT_NB_NF:
> >> -             strcr &=3D ~SSI_STCR_TFSI;
> >> -             strcr |=3D SSI_STCR_TSCKP;
> >>               break;
> >>       }

> Adding the ASoC maintainers to the Cc list.

Please send patches directly to maintainers as covered in SubmittingPatches,
I can't do anything with a quoted reply to an e-mail.

--Zq1NejLgb6rxdd6z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWCq+wAAoJECTWi3JdVIfQag4H+wU9vL//tS4ZdVVYG4wZf+yR
ruhdtmyvN3WVy3EUrgwYcnPBxst/wD/EQBARP08AWctXnkLwWtgmudk8q8zmUM5x
ObS9RkBEJbtiwGEl6ppZ7FLrP/o73CK/wIaMByKFRgMkk9JslsKWn2YeZeAeOB7W
LW6IEf1pZLRFLL2GGNbBXXk1Pj3WrzryVP9iwZvUT59cyCMCIl2TfdVwCkLWazG9
xeuMTGml54X5fZz5fbYcYYZYfipY4UXoug3EqUwTkR5feCUskFT4+scoIjVYxomM
ZPQJ/Q3UyrjxKCwX7CCXFpAtjqxjVk2yXr1l70faHoCqiLqtmw6IEdHzQMFCIEs=
=XHtL
-----END PGP SIGNATURE-----

--Zq1NejLgb6rxdd6z--

--===============2676912427089061088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2676912427089061088==--
