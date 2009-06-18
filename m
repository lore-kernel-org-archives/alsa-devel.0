From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [RFC] I2S and LEFT_J
Date: Thu, 18 Jun 2009 09:30:58 -0300
Message-ID: <1245328258.303.45.camel@brutus>
References: <20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
	<1245077824.24109.51.camel@brutus>
	<20090615150433.GF6106@sirena.org.uk>
	<1245086420.24109.159.camel@brutus>  <4A39F3A5.5030109@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4409758250591902344=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id C205D24466
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Jun 2009 14:31:05 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so494277qwj.56
	for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2009 05:31:04 -0700 (PDT)
In-Reply-To: <4A39F3A5.5030109@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4409758250591902344==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tEO9fJWMemRZ3Rj2ShD4"


--=-tEO9fJWMemRZ3Rj2ShD4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Qui, 2009-06-18 =C3=A0s 15:58 +0800, Eric Miao escreveu:
> Daniel,
>=20
> Could you give me an example of how can I setup the I2S in-compatible
> mode with S_16LE, 64bitfs with your current patch? Thanks.

Hi Eric,

If your codec can work with S16LE and 32bitfs, then i suggest you to use
this mode. If not, then you need to setup TDM.

For 2*16 on 32bitfs:
Don't call set_tdm_slot().

For 2*16 on 64bitfs:
Call set_tdm_slot(5, 5, 4, 16).

For 2*16 on 128bitfs:
Call set_tdm_slot(0x11, 0x11, 8, 16).

For 2*32 on 64bitfs:
Don't call set_tdm_slot().

For 2*32 on 128bitfs:
Call set_tdm_slot(5, 5, 4, 32).

Please note that I have _not_ tested the sample_width * channels !=3D
frame_width cases(only possible on PXA3XX), and maybe we still need to
amend these.

--=20
Daniel Ribeiro

--=-tEO9fJWMemRZ3Rj2ShD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko6M3oACgkQw3OYl0G0liTZwwCeNCLlhYQyhT6Jxz2VDEBmbH2n
upQAn2zOWp/CvNC8cU19ngAwJFd3TUZM
=AdzG
-----END PGP SIGNATURE-----

--=-tEO9fJWMemRZ3Rj2ShD4--


--===============4409758250591902344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4409758250591902344==--
