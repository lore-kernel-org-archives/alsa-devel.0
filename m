From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Allow DAPM registers to be
 unsigned int
Date: Thu, 8 Mar 2012 13:21:50 +0000
Message-ID: <20120308132149.GN3638@opensource.wolfsonmicro.com>
References: <1331210912-8106-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAOMZO5DHp3HegJ3C_HFj+M=amd6LdTtUcaXigG=ZpmPHG_TJ9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4037984715178747428=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1E3910BAB8
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 14:21:51 +0100 (CET)
In-Reply-To: <CAOMZO5DHp3HegJ3C_HFj+M=amd6LdTtUcaXigG=ZpmPHG_TJ9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4037984715178747428==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FrxVhwK/bNRjN48l"
Content-Disposition: inline


--FrxVhwK/bNRjN48l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2012 at 09:52:20AM -0300, Fabio Estevam wrote:
> On Thu, Mar 8, 2012 at 9:48 AM, Mark Brown

> > - =A0 =A0 =A0 short reg; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* negative reg =3D no direc=
t dapm */
> > + =A0 =A0 =A0 unsigned int reg; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* negative reg =3D no direct dapm */

> Maybe you should update the comment now that this is unsigned int.

Bah, humbug - no, it needs to be signed int and we don't support the
full 32 bits.

--FrxVhwK/bNRjN48l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWLJnAAoJEBus8iNuMP3deRIP/RVKUWPAtDl91zJDAv5q5r9X
8UeLYJ5eGWEsF3TtLds9ob5tdTMLpYe2w6VCPapkrEQZ9ydqZngZHRAsaA/wiIfk
N6GpT0N8ZqUGF9vwqrFDTlKGFW5HZ8CuruMr6UhUC7ccCsNn9JXYsYU7UGZ5Yc8I
ykiUgLK49Bvn9axNiKt7zvOOqb68ipmb183CpeSC55YEXwWu4z//rvPZmn9+9B1V
E7VZNOjMsYsoHa5P25f5IWwNHZ4BMMUezk+gAdJRFYTcPfcdDCez5Nn6Q1mGxDGE
7D71063kjWHOpOwjQfbCNn0+Y4nJF4GdXXmxa4aTqQE4hmFlBBFTz7/1uMBAlQiM
9MFxVevvfozaHJo2cLup1qUqOl3dk+qNFS66dLQkS1vqCOQfqsKa/a4QPle4Ms1H
PFqesTcuH8mHNeuFntvD2QDN3KCqeC8ZjNktj4dBApRlkz0Uw74npOQAJfs8Yjhn
98/aDYhJvnp/TL5QLakZp5VPJLkj6pk6jduRf5FOdbME2og0Y7DaBnvougR13Lmm
O1+q6i4MieMQlFPL9ueDzDTGmd2yVdaZapNe0MVp1Wp7aN3dfVg9rgxzM19an1KP
gNMIgzLl1wBC1F3qRyK50XBGujpPxDTvThFelhadgqs1KCsqN6ad/pU5fN74k/jL
DoLcVskeWo0DMxvZmOA+
=mmAr
-----END PGP SIGNATURE-----

--FrxVhwK/bNRjN48l--

--===============4037984715178747428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4037984715178747428==--
