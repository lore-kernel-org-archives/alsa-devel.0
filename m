From: Ricard Wanderlof <ricard.wanderlof-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: pcm5102a: Add support for PCM5102A
 codec
Date: Tue, 24 May 2016 16:44:20 +0200
Message-ID: <alpine.DEB.2.02.1605241640250.19416@lnxricardw1.se.axis.com>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org> <1463130853-25096-2-git-send-email-kernel@martin.sperl.org> <34ab107e-10dc-fbd3-28d1-203c6411851c@laposte.net> <20160523170853.GB8206@sirena.org.uk>
 <312f8476-a437-04d9-3d16-38d7c7c233ad@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <312f8476-a437-04d9-3d16-38d7c7c233ad-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Emmanuel_Fust=E9?= <emmanuel.fuste-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


On Mon, 23 May 2016, Emmanuel Fust=E9 wrote:

> /* pcm5102a in HW mode with external SCK (4wire mode)
>  * at 128fs, 192fs or 256fs
>  */
> 	pcm5102a-4w: pcm5102a {
> 		compatible =3D "simple-i2s-codec";
> 		rate =3D <SNDRV_PCM_RATE_8000_192000>;
> 		format =3D < SNDRV_PCM_FMTBIT_S16_LE
> 			|SNDRV_PCM_FMTBIT_S24_LE
> 			|SNDRV_PCM_FMTBIT_S32_LE>;
> 	};
> or
> /* pcm5102a in HW mode with PLL on BCK (3wire mode)
>  * 16to384khz but only with bck rate of 64fs
>  */
> 	pcm5102a-4w: pcm5102a {
> 		compatible =3D "simple-i2s-codec";
> 		rate =3D <SNDRV_PCM_RATE_8000_192000
> 			^ SNDRV_PCM_RATE_8000>;
> 		format =3D <SNDRV_PCM_FMTBIT_S32_LE>;
> 	};
> Or
> /* ES9023 in asynchronous mode mclk > 37Mhz
>  * I did not try bck rate <64fs as the sabre family did not generally
>  * support it.
>  */
> 	es9023: es9023 {
> 		compatible =3D "simple-i2s-codec";
> 		rate =3D <SNDRV_PCM_RATE_8000_192000>;
> 		format =3D <SNDRV_PCM_FMTBIT_S32_LE>;
> 	};
>=20
> We could use I2S friendly property instead of "format" :
> 		bckrates =3D <48, 64>;
>=20
>=20
> With two or tree more property (gpio for mute, de-emphasis and filter
> selection), you could cover 98% of I2S DAC with hardware only interfa=
ces. It
> cover too startup mode of most hifi I2C or SPI controllable DAC. Whic=
h is a
> good starting point for chip for which a driver is not already writte=
n.

It seems to me that this only covers the cases where the is codec runni=
ng=20
in slave mode with MCLK derived from the BCLK, but not cases where the=20
codec is master and needs to have its MCLK configured appropriately (in=
=20
terms of device-specifc clock source and PLL settings), or am I missing=
=20
something?

/Ricard
--=20
Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
