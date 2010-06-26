From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Sat, 26 Jun 2010 19:53:15 +0300
Message-ID: <201006261953.43884.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<1277565285-11563-2-git-send-email-anarsoul@gmail.com>
	<F58F893B-1539-4999-817E-8B2C4E871FB7@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8917566215627895144=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id D475E2432C
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 18:53:49 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1071464bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 09:53:48 -0700 (PDT)
In-Reply-To: <F58F893B-1539-4999-817E-8B2C4E871FB7@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============8917566215627895144==
Content-Type: multipart/signed;
  boundary="nextPart5350449.Zl8IajSslh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5350449.Zl8IajSslh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
26 =D0=B8=D1=8E=D0=BD=D1=8F 2010 19:40:37 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ma=
rk Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> On 26 Jun 2010, at 16:14, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > Some machines require some tricks to enable/disable
> > codec, i.e. disable or enable i2s clock before enabling/disabling
> > codec, and just configuring gpio is not enough; some machines
> > have no reset pin (reset is performed on codec power on automatically).
> > Fix that issue by using machine-specific callback to enable codec power.
> >=20
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>=20
> This is fine but it'd be really nice to preserve the use of GPIOs since
> that will cover the majority of machines - for example, by providing a
> default callback if none is provided and GPIOs are. This will also
> avoid the need to update existing machine drivers (which needs to be
> done otherwise).

The only machine that uses uda1380 and supported by mainline kernel is=20
magician, rx1950 and h1940 sound support is not merged yet, so that's not a=
=20
problem to perform that change.
=20
> However, I do wonder if the more complex set_power() callbacks might
> not just end up as regulator API consumers?

Is it really necessary? Plain callback perfectly fits here, and same approa=
ch=20
is used for s3cmci driver. For example, rx1950_uda1380_set_power is not=20
complex and looks like this:

static void rx1950_uda1380_set_power(int enable)
{
	clk_disable(i2c_clk);
	gpio_direction_output(S3C2410_GPD(0), 0);
	gpio_direction_output(S3C2410_GPJ(0), enable);
	if (enable) {
		gpio_set_value(S3C2410_GPD(0), 1);
		mdelay(1);
		gpio_set_value(S3C2410_GPD(0), 0);
	}
	clk_enable(i2c_clk);
}

Regards
Vasily

--nextPart5350449.Zl8IajSslh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwmMJcACgkQRM6pQpltKE6z1QCgwoiVVvcYr9dXYU+YY0rm0XiA
M0IAoMEtZhfUDVzkXs3V4f+fhp5IoMxN
=olsi
-----END PGP SIGNATURE-----

--nextPart5350449.Zl8IajSslh--

--===============8917566215627895144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8917566215627895144==--
