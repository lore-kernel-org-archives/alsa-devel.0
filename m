From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: uda1380: make driver more
	powersave-friendly
Date: Sat, 28 Aug 2010 12:17:39 +0300
Message-ID: <201008281217.47892.anarsoul@gmail.com>
References: <1282981776-10014-1-git-send-email-anarsoul@gmail.com>
	<201008281208.01273.anarsoul@gmail.com>
	<20100828091435.GC9324@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2171589188757205397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AF081038DF
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 11:18:05 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2481699ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 02:18:04 -0700 (PDT)
In-Reply-To: <20100828091435.GC9324@opensource.wolfsonmicro.com>
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

--===============2171589188757205397==
Content-Type: multipart/signed;
  boundary="nextPart2300188.mtyuCAnbtf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2300188.mtyuCAnbtf
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
28 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2010 12:14:46 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Mark Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> On Sat, Aug 28, 2010 at 12:07:54PM +0300, Vasily Khoruzhick wrote:
> > It seems that you misunderstood me, chip defaults are ok for first power
> > up, but resume is not first power up and codec defaults differ from
> > cache, so we want to sync cache with codec regs on resume, but it is not
> > possible to sync mixer regs until i2s clock is not applied, so we just
> > mark them as dirty to sync them later (just before playback, when i2s
> > clock is already applied)
>=20
> The normal flow for this is to mark things as dirty when you cut the
> power rather than in one particular restore path - that is more robust
> against code changes which alter the set of situations which can turn
> off the power.

Ok, sounds reasonable.

Regards
Vasily

--nextPart2300188.mtyuCAnbtf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx41DsACgkQRM6pQpltKE5u9wCePC/CnQSFAPqO7hljDC/nRrd0
XoMAoIriD4cI/tz54j3brD4XG25O5Wqn
=5JN6
-----END PGP SIGNATURE-----

--nextPart2300188.mtyuCAnbtf--

--===============2171589188757205397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2171589188757205397==--
