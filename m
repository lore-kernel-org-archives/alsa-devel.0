From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Add HP iPAQ RX1950 support
Date: Sat, 28 Aug 2010 14:37:18 +0300
Message-ID: <201008281437.30109.anarsoul@gmail.com>
References: <1282984632-12665-1-git-send-email-anarsoul@gmail.com>
	<1282985666-13973-1-git-send-email-anarsoul@gmail.com>
	<20100828090604.GB9324@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8954347010789624005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A70D4243E3
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 13:37:47 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2526728eyd.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 04:37:47 -0700 (PDT)
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

--===============8954347010789624005==
Content-Type: multipart/signed;
  boundary="nextPart1311554.QrrIr9IzRU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1311554.QrrIr9IzRU
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

Ok, I'll rework it, but can you merge just uda1380 patch (v2) for now?

Thanks for quick response and review! :)

Regards
Vasily

--nextPart1311554.QrrIr9IzRU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx49PoACgkQRM6pQpltKE6WogCcDdkei2UDdfPtLC3WUwVnetLz
iEQAnRFNjMaGk9WnzxINi5uC3r0rw+dX
=IUQT
-----END PGP SIGNATURE-----

--nextPart1311554.QrrIr9IzRU--

--===============8954347010789624005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8954347010789624005==--
