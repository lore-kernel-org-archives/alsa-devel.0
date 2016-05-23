From: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: pcm5102a: Add support for PCM5102A
 codec
Date: Mon, 23 May 2016 22:37:18 +0200
Message-ID: <312f8476-a437-04d9-3d16-38d7c7c233ad@laposte.net>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
 <1463130853-25096-2-git-send-email-kernel@martin.sperl.org>
 <34ab107e-10dc-fbd3-28d1-203c6411851c@laposte.net>
 <20160523170853.GB8206@sirena.org.uk>
Reply-To: emmanuel.fuste-QFKgK+z4sOrR7s880joybQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160523170853.GB8206-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Le 23/05/2016 =E0 19:08, Mark Brown a =E9crit :
> On Sun, May 22, 2016 at 11:29:55PM +0200, Emmanuel Fust=E9 wrote:
>
>> There is nothing PCM5102A specific here, and it is pretty generic.
>> Wouldn't it be better to write instead a simple-i2s-codec for all th=
e
>> classics I2S "hifi" DACs which will get the I2S/DAI parameters from =
DT ?
>> PCM510x, PCM5122 in HW mode, ES9023, a bunch of ES90xx implementatio=
ns
>> etc... will use exactly the same code with only format and rate vari=
ation.
>> And for the rate, it is implementation dependent, even in the case o=
f
>> pcm5102a.
>
> If we do that then we have no idea what the hardware actually is and
> we're creating more effort on the DT side, the DT has to specify all
> the parameters for the device rather than just the name.  Given how
> trivial the code is it's not clear that this is a win.
>
All the parameters are only rate and format.
And even rate is implementation dependent. Knowing the name of the=20
hardware give nothing. You still have to look at the schematic or look=20
at the board to know valid rates.
Actually is anything but a PCM5102A codec driver. It is a driver for an=
=20
I2S device accepting PCM rate from 8khz to 192khz with bck rate of 48fs=
=20
or 64fs (32fs is normally supported too by the hw mode used in hifiberr=
y).

Yes this push more effort on the DT side, but I think this is better to=
=20
describe in DT the actual "I2S only" hardware capabilities of the=20
implementation of the device guided by wiring or design choice.
Doing code cut&paste and two static assignment adjustment to create a=20
"new" driver is completely overkill and nonflexible.

instead of the proposed dt, we could have :

/* pcm5102a in HW mode with external SCK (4wire mode)
  * at 128fs, 192fs or 256fs
  */
	pcm5102a-4w: pcm5102a {
		compatible =3D "simple-i2s-codec";
		rate =3D <SNDRV_PCM_RATE_8000_192000>;
		format =3D < SNDRV_PCM_FMTBIT_S16_LE
			|SNDRV_PCM_FMTBIT_S24_LE
			|SNDRV_PCM_FMTBIT_S32_LE>;
	};
or
/* pcm5102a in HW mode with PLL on BCK (3wire mode)
  * 16to384khz but only with bck rate of 64fs
  */
	pcm5102a-4w: pcm5102a {
		compatible =3D "simple-i2s-codec";
		rate =3D <SNDRV_PCM_RATE_8000_192000
			^ SNDRV_PCM_RATE_8000>;
		format =3D <SNDRV_PCM_FMTBIT_S32_LE>;
	};
Or
/* ES9023 in asynchronous mode mclk > 37Mhz
  * I did not try bck rate <64fs as the sabre family did not generally
  * support it.
  */
	es9023: es9023 {
		compatible =3D "simple-i2s-codec";
		rate =3D <SNDRV_PCM_RATE_8000_192000>;
		format =3D <SNDRV_PCM_FMTBIT_S32_LE>;
	};

We could use I2S friendly property instead of "format" :
		bckrates =3D <48, 64>;


With two or tree more property (gpio for mute, de-emphasis and filter=20
selection), you could cover 98% of I2S DAC with hardware only=20
interfaces. It cover too startup mode of most hifi I2C or SPI=20
controllable DAC. Which is a good starting point for chip for which a=20
driver is not already written.

Emmanuel.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
