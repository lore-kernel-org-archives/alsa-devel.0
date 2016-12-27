From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: Intel: boards: Add Baytrail
 RT5660 machine driver
Date: Tue, 27 Dec 2016 11:29:46 +0800
Message-ID: <1482809386.3862.5.camel@canonical.com>
References: <20161219135147.24208-1-shrirang.bagul@canonical.com>
         <20161219135147.24208-3-shrirang.bagul@canonical.com>
         <20161219155509.qs7o5tdnz5z6ksuw@sirena.org.uk>
         <a712abe0-4fc0-8b7f-b819-2903564b88c6@linux.intel.com>
         <20161219164402.g4knszgpgowfxelb@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dHkWy03rRZUvakHdOSxu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219164402.g4knszgpgowfxelb@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Ramesh Babu <ramesh.babu@intel.com>, Ben Zhang <benzh@chromium.org>, John Keeping <john@metanate.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Colin Ian King <colin.king@canonical.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--=-dHkWy03rRZUvakHdOSxu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-12-19 at 16:44 +0000, Mark Brown wrote:
> On Mon, Dec 19, 2016 at 10:30:09AM -0600, Pierre-Louis Bossart wrote:
>=20
> > All this code seems to be largely a copy-paste of the bytcr_rt5640 mach=
ine
> > driver and the same comments would apply there. This patch did miss the=
 last
>=20
> Yes, there's a lot of room for cleanups in the existing code too (and of
> course if there's such a large amount of cut'n'paste that implies that
> there should be some code reuse going on).
Thank you for the review and valuable comments. Following the discussion so=
 far,
I feel the proper way would be to adapt bytcr_rt5660  machine driver to man=
age
RT5660 codec.
>=20
> > correction merged by Mark to deal with errors "ASoC: Intel: bytcr_rt564=
0:
> > fallback mechanism if MCLK is not enabled" and the same error handling =
would
> > be needed.
>=20
> There was a cut back version of it I thought?
Will try and include the MCLK fallback patch in ver. 2 of the patch.
--=-dHkWy03rRZUvakHdOSxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQI6BAABCAAkBQJYYeAqHRxzaHJpcmFuZy5iYWd1bEBjYW5vbmljYWwuY29tAAoJ
ELlj3b/+u+hkF9QQAIJjUZEZwxAwSiI1dqeIMuQ8lHDtU/jHA91D2dJbCxaGNE41
LPnbRoSnf2cnOqAU4bH+/tBzXRXL8e6NDFQPPJK0BBSdyNm9FSS6+R/1sh5ow9g+
SXqrPVS3aNTcPndFcS+NK/bc4elMiBfL0fhSwNVPTpVyVW52rbKEKJR3UN/p0P/j
3FhJkTpWkJU5W5MqrALolcSg2mHlbpbw3kxuW143Vbcq5434PqXNDMYy/ReVwauY
wh18LEDiQ/BD61MEYLyFKHIH1yCWySpmLcMdQbaUoLd9HH670/9xt0m1qOuhAN0j
LR42gtYWsXIJafWa2KWMvVznSmwyqFQ7pjqnFJklYw8YR4nH+r/B3M0+KLSA3S7j
xuP7mSgRfxypkqwph5B1Bd/uT/g4WG9VwVVmH8q/rou8Q/Z4Q8R/25eSo27X7cf9
dAxLdjVFbeZRYvZUx+XJP39aeDim0NbU6stlOY7nq9mRPFmglbSO6n3RQVeur+bR
vnl6DVEduHWRVu80ppoXGAhg33l86UszniXIs/7fAVDD3WErvxto0jgqW2Id4uRY
ESR3FoIlFD9dzGPJqKNGwioTArt+lnfrsQokXrXkzItGHsBM4qor5+JDuh7Ph8dF
ukgWjjrRw4GJM62u2JfRWMKPZiftXs3BcX5nCSUY/clXDOIakvXgR6/3vbNA
=KsFp
-----END PGP SIGNATURE-----

--=-dHkWy03rRZUvakHdOSxu--
