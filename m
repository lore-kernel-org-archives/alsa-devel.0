From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RESEND v6 1/3] ASoC: uda1380: make driver
	more powersave-friendly
Date: Mon, 30 Aug 2010 12:18:46 +0300
Message-ID: <201008301218.52125.anarsoul@gmail.com>
References: <1283156889-5544-1-git-send-email-anarsoul@gmail.com>
	<1283156889-5544-2-git-send-email-anarsoul@gmail.com>
	<201008301043.22165.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6997946296012494327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4D9A9243E6
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 11:19:21 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2948612ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 02:19:21 -0700 (PDT)
In-Reply-To: <201008301043.22165.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ben Dooks <ben-linux@fluff.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============6997946296012494327==
Content-Type: multipart/signed;
  boundary="nextPart1645913.c0YqpMDjWj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1645913.c0YqpMDjWj
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
30 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2010 11:43:22 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Marek Vasut =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> Dne Po 30. srpna 2010 10:28:07 Vasily Khoruzhick napsal(a):
> > Disable some codec modules in standby mode, completely disable
> > codec in off mode to save some power.
> > Fix suspend/resume: mark mixer regs as dirty on resume to
> > restore mixer values, otherwise driver produces no sound
> > (master is muted by default).
> >=20
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>=20
> Please have my:
>=20
> Acked-by: Marek Vasut <marek.vasut@gmail.com>

Does it mean I should resend patches with this line included? :)

--nextPart1645913.c0YqpMDjWj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx7d3wACgkQRM6pQpltKE7htACgxlmcRTircfk91EXpY3ugnHvC
bg8AoL3+F2KwV9NukK3QB+oN7D01v6jC
=9PRi
-----END PGP SIGNATURE-----

--nextPart1645913.c0YqpMDjWj--

--===============6997946296012494327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6997946296012494327==--
