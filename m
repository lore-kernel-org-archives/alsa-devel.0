From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v4 1/3] ASoC: uda1380: make driver more
	powersave-friendly
Date: Sun, 29 Aug 2010 21:13:07 +0300
Message-ID: <201008292113.21777.anarsoul@gmail.com>
References: <1283101872-6410-1-git-send-email-anarsoul@gmail.com>
	<1283101872-6410-2-git-send-email-anarsoul@gmail.com>
	<201008291937.03205.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8639549462787768696=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B8531037E3
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 20:13:41 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2754477eyd.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 11:13:40 -0700 (PDT)
In-Reply-To: <201008291937.03205.marek.vasut@gmail.com>
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

--===============8639549462787768696==
Content-Type: multipart/signed;
  boundary="nextPart1352842.H4DDiAdo7A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1352842.H4DDiAdo7A
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
29 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2010 20:37:03 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Marek Vasut =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
 > > +	void *control_data;
>=20
> It's already in codec->control_data, isn't it ?
>

I'm using priv->control_data as temporary storage to initialize codec-
>control_data later, as there's no snd_soc_codec in i2c_probe
=20
> > @@ -145,7 +185,6 @@ static void uda1380_flush_work(struct work_struct
> > *work) uda1380_read_reg_cache(uda1380_codec, reg));
> >=20
> >  		clear_bit(bit, &uda1380_cache_dirty);
> >  =09
> >  	}
> >=20
> > -
>=20
> Remove

It improves code formatting.
=20
> > @@ -560,18 +599,40 @@ static int uda1380_set_bias_level(struct
> > snd_soc_codec *codec, enum snd_soc_bias_level level)
> >=20
> >  {
> > =20
> >  	int pm =3D uda1380_read_reg_cache(codec, UDA1380_PM);
> >=20
> > +	struct uda1380_platform_data *pdata =3D codec->dev->platform_data;
> > +
> > +	if (codec->bias_level =3D=3D level)
> > +		return 0;
> >=20
> >  	switch (level) {
> >  	case SND_SOC_BIAS_ON:
> >=20
> >  	case SND_SOC_BIAS_PREPARE:
> > +		/* ADC, DAC on */
> >=20
> >  		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS | pm);
> >  		break;
> >  =09
> >  	case SND_SOC_BIAS_STANDBY:
> > -		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS);
> > -		break;
> > -	case SND_SOC_BIAS_OFF:
> > +		if (codec->bias_level =3D=3D SND_SOC_BIAS_OFF) {
> > +			if (pdata->gpio_power !=3D -EINVAL) {
> > +				gpio_set_value(pdata->gpio_power, 1);
> > +				uda1380_reset(codec);
> > +			}
> > +
> > +			uda1380_sync_cache(codec);
> > +		}
> >=20
> >  		uda1380_write(codec, UDA1380_PM, 0x0);
>=20
> Maybe some comment won't hurt here about what that 0x0 does.

Well, code explain it pretty well, it puts codec into stand-by mode :)
=20
> >  		break;
> >=20
> > +	case SND_SOC_BIAS_OFF:
> if (pdata->gpio_power =3D=3D -EINVAL)
> 	break;
> ...code...
>=20
> might help your alignment below.

Ok
=20
> > +		if (pdata->gpio_power !=3D -EINVAL) {
> > +			int reg;
> > +			gpio_set_value(pdata->gpio_power, 0);
> > +
> > +			/* Mark mixer regs cache dirty to sync them with
> > +			 * codec regs on power on.
> > +			 */
> > +			for (reg =3D UDA1380_MVOL; reg < UDA1380_CACHEREGNUM;
> > +				reg++)
> > +				set_bit(reg - 0x10, &uda1380_cache_dirty);
> > +		}
> >=20
> >  	}
> >  	codec->bias_level =3D level;
> >  	return 0;
> >=20
> > @@ -651,16 +712,6 @@ static int uda1380_suspend(struct snd_soc_codec
> > *codec, pm_message_t state)
> >=20
> >  static int uda1380_resume(struct snd_soc_codec *codec)
> >  {
> >=20
> > -	int i;
> > -	u8 data[2];
> > -	u16 *cache =3D codec->reg_cache;
> > -
> > -	/* Sync reg_cache with the hardware */
> > -	for (i =3D 0; i < ARRAY_SIZE(uda1380_reg); i++) {
> > -		data[0] =3D (i << 1) | ((cache[i] >> 8) & 0x0001);
> > -		data[1] =3D cache[i] & 0x00ff;
> > -		codec->hw_write(codec->control_data, data, 2);
> > -	}
> >=20
> >  	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> >  	return 0;
> > =20
> >  }
> >=20
> > @@ -671,29 +722,32 @@ static int uda1380_probe(struct snd_soc_codec
> > *codec)
> >=20
> >  	struct uda1380_priv *uda1380 =3D snd_soc_codec_get_drvdata(codec);
> >  	int ret;
> >=20
> > +	uda1380->codec =3D codec;
> > +
> >=20
> >  	codec->hw_write =3D (hw_write_t)i2c_master_send;
> >=20
> > +	codec->control_data =3D uda1380->control_data;
> >=20
> > -	if (!pdata || !pdata->gpio_power || !pdata->gpio_reset)
> > +	if (!pdata)
> >=20
> >  		return -EINVAL;
> >=20
> > -	ret =3D gpio_request(pdata->gpio_power, "uda1380 power");
> > -	if (ret)
> > -		return ret;
> > -	ret =3D gpio_request(pdata->gpio_reset, "uda1380 reset");
> > -	if (ret)
> > -		goto err_gpio;
> > -
> > -	gpio_direction_output(pdata->gpio_power, 1);
> > -
> > -	/* we may need to have the clock running here - pH5 */
> > -	gpio_direction_output(pdata->gpio_reset, 1);
> > -	udelay(5);
> > -	gpio_set_value(pdata->gpio_reset, 0);
>=20
> if (gpio_is_valid(...gpio...)) {
>=20
> }

Will not work for s3c24xx:

static inline int gpio_is_valid(int number)                                =
                                                        =20
{                                                                          =
                                                        =20
        /* only some non-negative numbers are valid */                     =
                                                        =20
        return ((unsigned)number) < ARCH_NR_GPIOS;                         =
                                                        =20
}

> > +	if (pdata->gpio_reset !=3D -EINVAL) {
> > +		ret =3D gpio_request(pdata->gpio_reset, "uda1380 reset");
> > +		if (ret)
> > +			goto err_out;
> > +		gpio_direction_output(pdata->gpio_reset, 0);

> Handle return value and dont depend on this setting the GPIO value, use
> gpio_set_value() too please.

This code handles reset-less machines (for example, h1940).=20
gpio_direction_output is neccessary here to ensure that pin is in output mo=
de.

> > +	}
> >=20
> > -	ret =3D uda1380_reset(codec);
> > -	if (ret < 0) {
> > -		dev_err(codec->dev, "Failed to issue reset\n");
> > -		goto err_reset;
> > +	if (pdata->gpio_power !=3D -EINVAL) {
> > +		ret =3D gpio_request(pdata->gpio_power, "uda1380 power");
> > +		if (ret)
> > +			goto err_gpio;
> > +		gpio_direction_output(pdata->gpio_power, 0);
> > +	} else {
> > +		ret =3D uda1380_reset(codec);
> > +		if (ret) {
> > +			dev_err(codec->dev, "Failed to issue reset\n");
> > +			goto err_reset;
> > +		}
> >=20
> >  	}
>=20
> Ditto.

Handling here machine which lacks power pin.
=20
> > +	uda1380->control_data =3D i2c;
>=20
> So is this needed ? Can't you access codec->control_data ?

See comment above.

> >  		kfree(uda1380);
> >=20
> > +
>=20
> Remove

It improves formatting.
=20
> >  	return ret;
> > =20
> >  }
>=20
> Cheers

thanks,

Regards
Vasily

--nextPart1352842.H4DDiAdo7A
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx6o0EACgkQRM6pQpltKE61qACcCJrN7x1J7iavY8aF35p+1D1M
CNYAnRw74v6tBB4D/yUY7TO4OhujCaYC
=nju4
-----END PGP SIGNATURE-----

--nextPart1352842.H4DDiAdo7A--

--===============8639549462787768696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8639549462787768696==--
