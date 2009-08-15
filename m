From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: pxa-ssp.c,
 Automatically set TDM when needed
Date: Sat, 15 Aug 2009 08:48:17 -0300
Message-ID: <1250336897.18028.304.camel@brutus>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090812181724.GZ19257@buzzloop.caiaq.de>
	<1250266661.18028.249.camel@brutus>
	<20090815095120.GA29987@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5827589013503469207=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id BD407103800
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Aug 2009 13:48:11 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so635762qwf.56
	for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2009 04:48:10 -0700 (PDT)
In-Reply-To: <20090815095120.GA29987@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5827589013503469207==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-v9yKFjTKDkiVDriJ0WN+"


--=-v9yKFjTKDkiVDriJ0WN+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em S=C3=A1b, 2009-08-15 =C3=A0s 10:51 +0100, Mark Brown escreveu:
> On Fri, Aug 14, 2009 at 01:17:41PM -0300, Daniel Ribeiro wrote:
>=20
> > This should be able to deal with I2S when pxa is slave, on both pxa2xx
> > and pxa3xx, with set_tdm_slot(5, 5, 4, 16).
>=20
> > Or when pxa is master, on pxa3xx only, with set_tdm_slot(3, 3, 2, 16).
> > This still violates the "DMYSTOP must be clear on network mode" rule,
> > but as all slots are active its not really network mode. And it seems t=
o
> > work for you, so... ;)
>=20
> This seems really confusing from a usability point of view - the master
> and slave configurations should look the same.  I'd expec the slave mode
> configuration you quote above to be looking for twice as many clocks as
> the master mode one.  The driver should ideally encapsulate this.

Yes, this is really confusing. The hardware is weird and behaves
different when it is driving SFRM.

On both (slave/master) modes it will use the same clk cycles, its just
that on master half the clocks are skipped by DMYSTOP.

Maybe Daniel Mack can test a setup with PXA slave of SFRM, and if it
works for him, we can drop the pxa3xx-only I2S/master mode for now. It
is a mess and I don't see an easy way to solve this. :(

--=20
Daniel Ribeiro

--=-v9yKFjTKDkiVDriJ0WN+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqGoIAACgkQw3OYl0G0liSDqQCfZ4JtSVdV6dzK0h+p8evOtXYQ
yhAAoIJn3tPdp/corj5/7BKWGGKPRJcU
=qTcf
-----END PGP SIGNATURE-----

--=-v9yKFjTKDkiVDriJ0WN+--


--===============5827589013503469207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5827589013503469207==--
