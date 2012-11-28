From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: mic bias for tlv320aic3x?
Date: Wed, 28 Nov 2012 09:35:34 +0000
Message-ID: <20121128093534.GK32691@opensource.wolfsonmicro.com>
References: <alpine.DEB.2.01.1211271808130.20477@pmeerw.net>
 <20121127175326.GB13065@sirena.org.uk>
 <alpine.DEB.2.01.1211280927500.26303@pmeerw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0306782708038371689=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADC3D261570
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 10:35:35 +0100 (CET)
In-Reply-To: <alpine.DEB.2.01.1211280927500.26303@pmeerw.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0306782708038371689==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2012 at 10:28:53AM +0100, Peter Meerwald wrote:

> I am missing the overall strategy how this is supposed to work

> is there a good reference driver?

Currently nobody is implementing this dynamically, it's always
configured via platform data.

> per default, Mic Bias is off

Well, of course...  it's just a normal thing in DAPM.

> there already are some mic bias definitions in tlv320aic3x:

> 	/* Mic Bias */
> 	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2V",
> 			 MICBIAS_CTRL, 6, 3, 1, 0),
> 	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2.5V",
> 			 MICBIAS_CTRL, 6, 3, 2, 0),
> 	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias AVDD",
> 			 MICBIAS_CTRL, 6, 3, 3, 0),

> however, those are not referenced anywhere and it is not clear how to=20
> access those from the machine driver

I'm not clear what the above is intended to do but I think you're
supposed to pick the MICBIAS you want to use in your board when you're
hooking it up.

> as for the use case: user wants to connect either a microphone or line-in=
=20
> to a connector, hence mic bias selection is necessary -- this doesn't=20
> sound so unusual

Normally this sort of thing would be done automatically by the kernel
detecting what's plugged in, not manually by an application.

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtdqzAAoJELSic+t+oim9TCQQAIbKopIbmBIJS3wj/mhzPudk
5m6YZRw85Nuf5F8yd45aBEK2ldVqGYEUvQ+lVRZqQjiso8tSPxP6j6s5YPebMRfu
oAUZS0XCfPL9kAy821DR9FhS/2i3hkcBWRM0vsyHG9a90FfggzYKiqmeEeULDkgK
Fc6/raitV8jYnn+58XcwsrnPclGL2NyScB9A+mfMfdA+Bw13ITTPZQFUj3g7Dmhy
PoUEj6BkmA9AuuB6bYfKXtw9dc02FElzPWjqhbT/8KwkPrYmdew21ybJxFqgz+8i
4KlA/kKghWkkuwoBNx+AYnWjjdVefX0pYJwpPsaqPi0ZKD0zxIzVgyI/RjQ94VXr
W8m7T7mi30oY7u5KGHVFKQqaizbO7BeRDgDOZV4UPQmHUL+o5acPocFdZI7hmyHV
RcLBHzB0i9eYnxrQdTZv3PchEzHkinzn8pck8hM9bzXio6aovHBVbs95Qm/vWK7R
8m87moodkGCHXqf49yv+2dvIde2PqXM4uFSkzLIgARLrbs8trd7hkPgBj2Gw8TL2
XjYmWyLB4vaZwRKiq1kVMYcUdkhTCqEapdrgUwpWvQpxAn5r5T+X6u+Jr8/inMKX
7EIwAzB5HTA9CY1ERB98udoHeG5G9wVDmraEJRZUivZpZr9C3nF/5Td3BMEzOQ0x
MSXL4EWimtwdG7U2bkqt
=L4b0
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--

--===============0306782708038371689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0306782708038371689==--
