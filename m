From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 3/3] uda1380: make driver more
	powersave-friendly
Date: Sun, 27 Jun 2010 00:07:26 +0300
Message-ID: <201006270007.34271.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<1277565285-11563-4-git-send-email-anarsoul@gmail.com>
	<0FF1255A-5069-426F-9521-A8E0787081D8@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8208921999414674050=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 92AD6244EE
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 23:07:38 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1132336bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 14:07:38 -0700 (PDT)
In-Reply-To: <0FF1255A-5069-426F-9521-A8E0787081D8@opensource.wolfsonmicro.com>
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

--===============8208921999414674050==
Content-Type: multipart/signed;
  boundary="nextPart2058960.RcW3iL2vgA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2058960.RcW3iL2vgA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
26 =D0=B8=D1=8E=D0=BD=D1=8F 2010 23:45:12 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ma=
rk Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> Please remember to CC Liam on ASoC patches.

Ok, I'll do
>=20
> > +	for (reg =3D UDA1380_MVOL; reg < UDA1380_CACHEREGNUM; reg++)
> > +		set_bit(reg - 0x10, &uda1380_cache_dirty);
>=20
> This seems odd, I'd expect the cache to be being marked as clean
> immediately after sync?

Nope, it is not. Only i2c and clock related regs of uda1380 can be modified=
=20
when there's no i2s clock, i.e. mixer regs should be updated right after i2=
s=20
clock was enabled, so we marking mixer-related regs cache as dirty, to make=
=20
sure they'll be updated when possible.
=20
> > 		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS | pm);
>=20
> Like I said previously you really should look at using DAPM here, this
> should make the code simpler and will let you
>=20
> You might also want to consider snd_soc_update_bits().

Hmm, uda134x driver does pretty same things as in my patch... And it seems=
=20
part of your sentence is lost :(
=20
> > 		break;
> > =09
> > 	case SND_SOC_BIAS_STANDBY:
> > -		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS);
> > +		if (codec->bias_level =3D=3D SND_SOC_BIAS_OFF) {
> > +			pdata->set_power(1);
> > +			uda1380_reset(codec);
>=20
> The reset here seems unneeded and possibly wasteful if there is no power
> control on the system. It'd seem better to do something like just power u=
p,
> flagging the cache as dirty if there was a callback. I'd strongly expect
> that if you are actually controlling power the device will be in the
> default state anyway.

Ok

> > +			switch (pdata->dac_clk) {
> > +			case UDA1380_DAC_CLK_SYSCLK:
> > +				uda1380_write_reg_cache(codec, UDA1380_CLK, 0);
> > +				break;
> > +			case UDA1380_DAC_CLK_WSPLL:
> > +				uda1380_write_reg_cache(codec, UDA1380_CLK,
> > +					R00_DAC_CLK);
> > +				break;
> > +			}
>=20
> Why is this being managed every time the device is enabled? Surely the
> setting can be done once at startup.

Yep, just need to mark cache of this reg as dirty here...
=20
> > -	ret =3D uda1380_reset(codec);
> > -	if (ret < 0) {
> > -		dev_err(codec->dev, "Failed to issue reset\n");
> > -		goto err_reset;
> > -	}
> > -
>=20
> The reason for the reset at startup is that we don't know what state the
> device is in when Linux gets control.

It's softreset and it's performed by writing some value to some reg. i2c xf=
ers=20
is not possible when codec is not enabled (it is not at this point)

Regards
Vasily

--nextPart2058960.RcW3iL2vgA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwmbBYACgkQRM6pQpltKE5tVQCcDeYe2kyqACSXH6ny03xbDccb
JFMAoI+yElYf9EwHhq/N3W79BlzJ3371
=RgZv
-----END PGP SIGNATURE-----

--nextPart2058960.RcW3iL2vgA--

--===============8208921999414674050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8208921999414674050==--
