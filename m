From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: Intel: boards: Add Baytrail
 RT5660 machine driver
Date: Tue, 27 Dec 2016 11:32:35 +0800
Message-ID: <1482809555.3862.8.camel@canonical.com>
References: <20161219135147.24208-1-shrirang.bagul@canonical.com>
         <20161219135147.24208-3-shrirang.bagul@canonical.com>
         <20161219155509.qs7o5tdnz5z6ksuw@sirena.org.uk>
         <a712abe0-4fc0-8b7f-b819-2903564b88c6@linux.intel.com>
         <20161219164402.g4knszgpgowfxelb@sirena.org.uk>
         <1482809386.3862.5.camel@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PLsFVuXny3WXrwASMbbV"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482809386.3862.5.camel@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Ramesh Babu <ramesh.babu@intel.com>, Ben Zhang <benzh@chromium.org>, John Keeping <john@metanate.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Colin Ian King <colin.king@canonical.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--=-PLsFVuXny3WXrwASMbbV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2016-12-27 at 11:29 +0800, Shrirang Bagul wrote:
> On Mon, 2016-12-19 at 16:44 +0000, Mark Brown wrote:
> > On Mon, Dec 19, 2016 at 10:30:09AM -0600, Pierre-Louis Bossart wrote:
> >=20
> > > All this code seems to be largely a copy-paste of the bytcr_rt5640 ma=
chine
> > > driver and the same comments would apply there. This patch did miss t=
he
> > > last
> >=20
> > Yes, there's a lot of room for cleanups in the existing code too (and o=
f
> > course if there's such a large amount of cut'n'paste that implies that
> > there should be some code reuse going on).
>=20
> Thank you for the review and valuable comments. Following the discussion =
so
> far,
> I feel the proper way would be to adapt bytcr_rt5660=C2=A0=C2=A0machine d=
river to manage
> RT5660 codec.
typo, should be bytcr_rt5640
> >=20
> > > correction merged by Mark to deal with errors "ASoC: Intel: bytcr_rt5=
640:
> > > fallback mechanism if MCLK is not enabled" and the same error handlin=
g
> > > would
> > > be needed.
> >=20
> > There was a cut back version of it I thought?
>=20
> Will try and include the MCLK fallback patch in ver. 2 of the patch.
--=-PLsFVuXny3WXrwASMbbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQI6BAABCAAkBQJYYeDTHRxzaHJpcmFuZy5iYWd1bEBjYW5vbmljYWwuY29tAAoJ
ELlj3b/+u+hk1fkP+gJFPIOM653HnaI0G2JebIwAvN7sA/FjtElLCtRW/7JxEITd
i3lmv5LsV+e98ybsXnJF/Hkg0koH245oTBsFQq2erFWqdYFLejpe7vwzehoNcCAl
Z9p2NDOgAYz3p+0PHjNKPKzlWflaMl4JZ07Sizml6LlmIRft4+bgTmCCXDH7czVT
y6uQ114tlyXMADmX23XtR3zw+3kaAQauBCzSSRnqDUQmYnSdIZoWnqfLj22XzoN6
kQTdSaIoxarUrzzTCWHNNJHnPSttvCr8LyWFcbMkSyEtpJ+CPpDbeka1UvY+t/oU
qtOOb5b/LfQn75jgGzyGJ4BEjGwC/BpHju1y18EDRY7uTbakzHqjXGC1l7eNTTiz
lJHwHFgVxlmYTGl5opJF1IiSKRbbmro8GyUCFKBAYTd/JovNvTgFhlT9fGtznp++
Aa3Qj2lA4OO36fQrLx3N3hMgMffDUOZ0qeYCH3qzdCIZOdz3PpdUvVcvu3QlRa/3
tjdt/HhyrGcwjROEaXNBibjIjpRK2GlJUBPil9nquPgA8zWoEdU1mrCjOHZ+u6Ub
Ams6SKyDqTrognFyHUPcvNRGonMmZEBTOiafesjc5KoVoxH9mvmTIMUklr/aeRMe
JIU4xjti1DgELAFFE99S+/wNFCzN3DYhI1LRZF3Ch6uWCnLia6iBT5px9fs4
=6gJo
-----END PGP SIGNATURE-----

--=-PLsFVuXny3WXrwASMbbV--
