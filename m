From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: uda1380: make driver more
	powersave-friendly
Date: Sat, 28 Aug 2010 12:07:54 +0300
Message-ID: <201008281208.01273.anarsoul@gmail.com>
References: <1282981776-10014-1-git-send-email-anarsoul@gmail.com>
	<1282981776-10014-2-git-send-email-anarsoul@gmail.com>
	<20100828085627.GA9324@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4820275262620735983=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DD2024630
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 11:08:18 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2506981eyd.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 02:08:18 -0700 (PDT)
In-Reply-To: <20100828085627.GA9324@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============4820275262620735983==
Content-Type: multipart/signed;
  boundary="nextPart3417240.aczi1zq7Hg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3417240.aczi1zq7Hg
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
28 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2010 11:56:36 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Mark Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> On Sat, Aug 28, 2010 at 10:49:35AM +0300, Vasily Khoruzhick wrote:
> > Disable some codec modules in standby mode, completely disable
> > codec in off mode to save some power.
> >=20
> > Fix suspend/resume: mark mixer regs as dirty on resume to
> > restore mixer values, otherwise driver produces no sound
> > (master is muted by default).
>=20
> This sounds like there's a pre-existing bug where the register cache
> defaults don't correspond to the chip defaults.  In general we always
> keep the initial chip defaults for user visible controls in the driver
> and let the application layer set the values it wants.  This avoids
> having to worry about defaults being inappropriate for some systems (eg,
> volumes far too loud or bad output path selection) - normally the chip
> defaults will be reasonable for first power up.

It seems that you misunderstood me, chip defaults are ok for first power up=
,=20
but resume is not first power up and codec defaults differ from cache, so w=
e=20
want to sync cache with codec regs on resume, but it is not possible to syn=
c=20
mixer regs until i2s clock is not applied, so we just mark them as dirty to=
=20
sync them later (just before playback, when i2s clock is already applied)

Regards
Vasily

--nextPart3417240.aczi1zq7Hg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx40fEACgkQRM6pQpltKE5vzQCfWy5XCl2q7fQ493nRJdkKk2+G
Ko0AnAuqeARU/Btfv+cVyE3NutwdVDfs
=l9JT
-----END PGP SIGNATURE-----

--nextPart3417240.aczi1zq7Hg--

--===============4820275262620735983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4820275262620735983==--
