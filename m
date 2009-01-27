From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 22:32:11 +0200
Message-ID: <200901272232.17752.anarsoul@gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200901271822.32537.anarsoul@gmail.com>
	<74d0deb30901271149g40ac1842wfc28828377c27794@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7751811008167857821=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f11.google.com (mail-ew0-f11.google.com
	[209.85.219.11]) by alsa0.perex.cz (Postfix) with ESMTP id 517BF243B8
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 21:36:46 +0100 (CET)
Received: by ewy4 with SMTP id 4so3961888ewy.8
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 12:36:45 -0800 (PST)
In-Reply-To: <74d0deb30901271149g40ac1842wfc28828377c27794@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

--===============7751811008167857821==
Content-Type: multipart/signed;
  boundary="nextPart1890061.m4D20Z2vN1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1890061.m4D20Z2vN1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 27 January 2009 21:49:01 pHilipp Zabel wrote:

> The uda1380 data sheet says that the reset time should be at least 1
> =B5s - could that be a problem?
>
> regards
> Philipp

Nope, added mdelay(10) in reset sequence, but it didn't help.

Regards
Vasily

--nextPart1890061.m4D20Z2vN1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl/b1EACgkQRM6pQpltKE5r4wCg2HRQNPXErx7ARcEyZdMG97o+
nE8An2vrw2l9oMawPBDQ4ZaLstvV+omV
=gon4
-----END PGP SIGNATURE-----

--nextPart1890061.m4D20Z2vN1--

--===============7751811008167857821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7751811008167857821==--
