From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Add HP iPAQ RX1950 support
Date: Sun, 29 Aug 2010 12:31:54 +0300
Message-ID: <201008291232.01044.anarsoul@gmail.com>
References: <1282984632-12665-1-git-send-email-anarsoul@gmail.com>
	<1282985666-13973-1-git-send-email-anarsoul@gmail.com>
	<20100828090604.GB9324@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1754712468838164504=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 515CC24520
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 11:32:21 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2663388ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 02:32:20 -0700 (PDT)
In-Reply-To: <20100828090604.GB9324@opensource.wolfsonmicro.com>
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

--===============1754712468838164504==
Content-Type: multipart/signed;
  boundary="nextPart1473090.22YRleZU6z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1473090.22YRleZU6z
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
28 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2010 12:06:17 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Mark Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> On Sat, Aug 28, 2010 at 11:54:26AM +0300, Vasily Khoruzhick wrote:
>=20
> This is basically fine but needs to be redone against current ASoC due
> to Liam's multi-component work - the way the machine driver is
> registered with the system has changed.  See either -next or
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
> for-2.6.37
>=20
> for the latest code.

Hmm, it seems that s3c24xx-i2s is broken for multicomponent.

snd-soc-s3c24xx and snd-soc-s3c24xx-i2s are just drivers, but there's no=20
appropriate platform_device for them. So I'm getting this (with debug=20
enabled):

soc-audio soc-audio: CPU DAI s3c24xx-i2s not registered
soc-audio soc-audio: platform s3c24xx-pcm-audio not registered

Who should register platform_device for these drivers?

Regards
Vasily

--nextPart1473090.22YRleZU6z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx6KRAACgkQRM6pQpltKE5SxwCfZ+LswmVOaLYEwL2w8LNZ9rgH
JCYAn2+ZuDyThx0NQeTMAgzSyTyGn8kl
=p/h/
-----END PGP SIGNATURE-----

--nextPart1473090.22YRleZU6z--

--===============1754712468838164504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1754712468838164504==--
