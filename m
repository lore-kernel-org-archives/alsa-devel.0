From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Wed, 25 Apr 2012 09:11:09 +0100
Message-ID: <20120425081109.GD3195@opensource.wolfsonmicro.com>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329071700.GA18127@zzm-ubuntu>
	<20120329105831.GC3668@opensource.wolfsonmicro.com>
	<20120329140420.GD19506@S2101-09.ap.freescale.net>
	<20120329141019.GQ3668@opensource.wolfsonmicro.com>
	<CANg6MZggQA7_Nm0WijFKDFiReCC0hi5tUFa5YU8CF0+Qkh9NKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7367118413273797022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24A4A1047DD
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 10:11:11 +0200 (CEST)
In-Reply-To: <CANg6MZggQA7_Nm0WijFKDFiReCC0hi5tUFa5YU8CF0+Qkh9NKA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7367118413273797022==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2012 at 10:08:05AM +0800, Richard Zhao wrote:

> > =A0 =A0 =A0 =A0{ "Mic Jack", NULL, "Mic Bias" },
> > =A0 =A0 =A0 =A0{ "MIC_IN", NULL, "Mic Bias" },

> "MiC Bias" --> "Mic Jack" should be enough.
> Why do we have "Mic Bias" --> "MIC_IN" ?

Probably because I've misread what you're trying to do above - if it's
just a single variation.

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPl7GXAAoJEBus8iNuMP3d1qMP/1ioQX9e6ohjkRcKAN8gGHwX
uWiSIT/hSZcrVsaoCxOOMbFmPCWp5iaMoZPtLoHXo3InFuPiKXNSFPh6/bUOJCvN
vr0QMJhqSkC3o5kDMOvIt/QJLM6PKy3xhTsXLwPJ7Z1C60+D0rdI6bhqdWe3y6H3
2ZXGj46K1uHpdPrhl0W6TNZRJp6lceeFI9dNo0boBhdrMyvfynjFd0Yu+s3jD1f8
iEg4xL0+AJ1qIRzFVqLHeBq8/CvhDI5RQ7RRewg3IaySuZ16kkrMJIjpd4bVtcCi
LZBkwPdSS6wPfiIIgCoSY7feZD8F9D6BwzHJdstdrpKYx7FOtFEXtMUFR1D2mJ/E
aNhyrzXHg/P55IZjZdFEim88+FS0Pwz4d9lE8d9csPu+qLkUx5RHn8xe/4v6HiuP
qHEXkwwMe8g1kI41TdeTFaQCLyx+ViKX7TB6qno24AiU7+6l2ASSb5Ry6o1E+nBO
mPEF+bavGCoYT0Vs0a06kGeX21lmujA9o2awaB37rQTYBkDSBxoOF3R8plP0Re+J
Nb3hcoa4ehtHQzKV8awvZ/8M1RxCi+h3sK+EyK0O/2RUPud3ngizTUvMgnEQd+qj
Y654ShtAZEeP9/eRYxUFtnoSVYMdo29zja84Cc6L4GbKuL75V7hDMSzQYxHbEqz9
abpLtB/zy3mqidjJd7Fa
=+U30
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--

--===============7367118413273797022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7367118413273797022==--
