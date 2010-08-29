From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v4 2/3] ASoC: Add HP iPAQ RX1950 support
Date: Sun, 29 Aug 2010 21:15:26 +0300
Message-ID: <201008292115.33770.anarsoul@gmail.com>
References: <1283101872-6410-1-git-send-email-anarsoul@gmail.com>
	<1283101872-6410-3-git-send-email-anarsoul@gmail.com>
	<201008291939.39530.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7838941353885538761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 39A391037E3
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 20:15:52 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2728330ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 11:15:52 -0700 (PDT)
In-Reply-To: <201008291939.39530.marek.vasut@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ben Dooks <ben-linux@fluff.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============7838941353885538761==
Content-Type: multipart/signed;
  boundary="nextPart3426657.Hu1ci84R08";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3426657.Hu1ci84R08
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
29 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2010 20:39:39 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Marek Vasut =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> > +static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
> > +				struct snd_kcontrol *kcontrol, int event)
> > +{
> > +	if (SND_SOC_DAPM_EVENT_ON(event))
> > +		gpio_direction_output(S3C2410_GPA(1), 1);
> > +	else
> > +		gpio_direction_output(S3C2410_GPA(1), 0);
>=20
> gpio_set_value()

Ok

> > +static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +	struct snd_soc_codec *codec =3D rtd->codec;
> > +	int err;
> > +
> > +	/* Add rx1950 specific widgets */
> > +	snd_soc_dapm_new_controls(codec, uda1380_dapm_widgets,
> > +				  ARRAY_SIZE(uda1380_dapm_widgets));
> > +
> > +	/* Set up rx1950 specific audio path audio_mapnects */
> > +	err =3D snd_soc_dapm_add_routes(codec, audio_map,
> > +				      ARRAY_SIZE(audio_map));
> > +
>=20
> Handle return values

Ok
=20
> > +	gpio_direction_output(S3C2410_GPA(1), 0);
>=20
> Again, use gpio_set_value() after this and handle return value of
> gpio_direction_output().

Second arg is value, gpio_set_value is not required.
=20
Regards
Vasily

--nextPart3426657.Hu1ci84R08
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx6o8UACgkQRM6pQpltKE7BjQCdEs8Ss4x6X2wR1I4le3m82I+6
mbMAoLGiYKkze5TqJuVRNfxnxOJBpXeG
=e/w4
-----END PGP SIGNATURE-----

--nextPart3426657.Hu1ci84R08--

--===============7838941353885538761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7838941353885538761==--
