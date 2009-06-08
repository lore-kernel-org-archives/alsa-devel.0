From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH] ASoC: Allow 32bits registers
Date: Mon, 08 Jun 2009 08:01:54 -0300
Message-ID: <1244458914.30582.12.camel@brutus>
References: <1244353751.9532.5.camel@brutus>
	<20090608095031.GB7858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2445948355466168302=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 60D07244BC
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 13:03:14 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1532050qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 04:03:13 -0700 (PDT)
In-Reply-To: <20090608095031.GB7858@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, openezx-devel <openezx-devel@lists.openezx.org>
List-Id: alsa-devel@alsa-project.org


--===============2445948355466168302==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-3DHqpjjol0fkk1oHbz+B"


--=-3DHqpjjol0fkk1oHbz+B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-06-08 =C3=A0s 10:50 +0100, Mark Brown escreveu:
> On Sun, Jun 07, 2009 at 02:49:11AM -0300, Daniel Ribeiro wrote:
> > Replace the remaining unsigned shorts with unsigned ints.
> > Tested with pcap2 codec (25 bits registers).
> >=20
> > Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
>=20
> Thanks, I've applied this.  Given that the merge window is *very* close
> and this is a fairly high risk change (in that it could affect a lot of
> drivers) I've created a for-2.6.32 branch and applied it there.  I think
> the change is perfectly safe but I'd rather be cautious.

ACK. And no driver on mainline needs >16bits at the moment...

> BTW, there was one unrelated coding style change in there.

Oops, sorry. My 'vim' highlights most coding style mistakes, I changed
it without noticing.

--=20
Daniel Ribeiro

--=-3DHqpjjol0fkk1oHbz+B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkos75sACgkQw3OYl0G0liQHKwCgm+BKRONutP4ksVZnTtuCEDHu
3LsAn1ydo9yzh6kA5QyHGm0N1IYPoMFF
=c8Vy
-----END PGP SIGNATURE-----

--=-3DHqpjjol0fkk1oHbz+B--


--===============2445948355466168302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2445948355466168302==--
