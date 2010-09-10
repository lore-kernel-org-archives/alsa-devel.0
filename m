From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Modify the
	name of I2S driver
Date: Sat, 11 Sep 2010 00:40:42 +0300
Message-ID: <201009110040.49213.anarsoul@gmail.com>
References: <4C4CEDE1.5010605@samsung.com>
	<20100909132259.GF25855@rakim.wolfsonmicro.main>
	<AANLkTimV8hQ6L2j2djDdCp6XJGDj3Hjq2Dv4iLnGJHQ1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6556789745360451194=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F7E0245ED
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 23:41:40 +0200 (CEST)
Received: by eye27 with SMTP id 27so1076663eye.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 14:41:40 -0700 (PDT)
In-Reply-To: <AANLkTimV8hQ6L2j2djDdCp6XJGDj3Hjq2Dv4iLnGJHQ1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kyungmin Park <kmpark@infradead.org>, Joonyoung Shim <jy0922.shim@samsung.com>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, ben-linux <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============6556789745360451194==
Content-Type: multipart/signed;
  boundary="nextPart4963731.jHWOAOipjx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4963731.jHWOAOipjx
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
10 =D1=81=D0=B5=D0=BD=D1=82=D1=8F=D0=B1=D1=80=D1=8F 2010 11:43:14 =D0=B0=D0=
=B2=D1=82=D0=BE=D1=80 Jassi Brar =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> On Thu, Sep 9, 2010 at 10:22 PM, Mark Brown
>=20
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Sep 09, 2010 at 09:56:23PM +0900, Jassi Brar wrote:
> >> I would like to have points to consider from every stakeholder.
> >=20
> > I don't really have anything myself, though I may have some comments on
> > the actual proposal I guess.
>=20
> Btw, AC97, PCM and DMA were easy kill.
>=20
> It's I2S that's PITA.
> I am thinking of leaving 24xx-i2s, i.e pre-64xx(shared with 2412),
> unchanged and letting
> them die of old age (obsoleted and dropped duly if no stakeholder keeps
> up).

Does it mean there's no one to support s3c24xx-i2s (for s3c24xx socs)?

--nextPart4963731.jHWOAOipjx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyKpeEACgkQRM6pQpltKE4UZACcDXT4EQRXecN9kYwMk1DqnX1W
mY4AoNGRS04KmM2gUrLB32I4SbqZgv9l
=1pIs
-----END PGP SIGNATURE-----

--nextPart4963731.jHWOAOipjx--

--===============6556789745360451194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6556789745360451194==--
