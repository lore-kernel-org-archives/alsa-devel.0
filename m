From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Add HP iPAQ RX1950 support
Date: Sat, 28 Aug 2010 12:28:19 +0300
Message-ID: <201008281228.24097.anarsoul@gmail.com>
References: <1282984632-12665-1-git-send-email-anarsoul@gmail.com>
	<1282985666-13973-1-git-send-email-anarsoul@gmail.com>
	<20100828090604.GB9324@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0552991184297114815=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 867B6103838
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 11:28:41 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2483184ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 02:28:41 -0700 (PDT)
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

--===============0552991184297114815==
Content-Type: multipart/signed;
  boundary="nextPart4977862.brlzPJmau9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4977862.brlzPJmau9
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
>=20
> > +static int rx1950_startup(struct snd_pcm_substream *substream)
> > +{
> > +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> > +
> > +	runtime->hw.rate_min =3D hw_rates.list[0];
> > +	runtime->hw.rate_max =3D hw_rates.list[hw_rates.count - 1];
> > +	runtime->hw.rates =3D SNDRV_PCM_RATE_KNOT;
> > +
> > +	return snd_pcm_hw_constraint_list(runtime, 0,
> > +					SNDRV_PCM_HW_PARAM_RATE,
> > +					&hw_rates);
> > +}
>=20
> Where does this constraint come from?  It's the sort of thing that
> sounds like it comes from one of the chips so I'd expect their drivers
> to be figuring it out.  Let's see below...
>=20
> > +static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
> > +				struct snd_kcontrol *kcontrol, int event)
> > +{
> > +	if (SND_SOC_DAPM_EVENT_ON(event))
> > +		gpio_direction_output(S3C2410_GPA(1), 1);
> > +	else
> > +		gpio_direction_output(S3C2410_GPA(1), 0);
> > +
> > +	return 0;
> > +}
>=20
> We should really make a standard GPIO DAPM thing.  Not a problem for
> this driver, though.

Ok

> > +	switch (rate) {
> > +	case 16000:
> > +	case 48000:
> > +		clk_source =3D S3C24XX_CLKSRC_PCLK;
> > +		fs_mode =3D S3C2410_IISMOD_384FS;
> > +		div =3D s3c24xx_i2s_get_clockrate() / (384 * rate);
> > +		if (s3c24xx_i2s_get_clockrate() % (384 * rate) > (182 * rate))
> > +			div++;
> > +		break;
> > +	case 44100:
> > +	case 88200:
> > +		clk_source =3D S3C24XX_CLKSRC_MPLL;
> > +		fs_mode =3D S3C2410_IISMOD_256FS;
> > +		div =3D clk_get_rate(xtal) / (256 * rate);
> > +		if (clk_get_rate(xtal) % (256 * rate) > (128 * rate))
> > +			div++;
> > +		break;
>=20
> ...right, it's the CPU driver which is a bit more manual than is ideal.
> OK, again not a problem for this driver.

These constraints are machine-specific. They depends on what clock source f=
or=20
i2s machine can provide, for rx1950 it's ~49.9mhz and 299mhz, so I doubt th=
at=20
these constraints can be integrated into s3c24xx-i2s driver

Regards
Vasily

--nextPart4977862.brlzPJmau9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx41rgACgkQRM6pQpltKE5dcQCg09bxY5kmhl7yTXnYnxMR3Mrn
ACgAoMOq4174cA6+oSmwjpX5V9UV3Hsu
=KsHw
-----END PGP SIGNATURE-----

--nextPart4977862.brlzPJmau9--

--===============0552991184297114815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0552991184297114815==--
