From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: Samsung: Fix build regressions
 due to gpio re-org
Date: Wed, 22 Jan 2014 11:43:13 +0000
Message-ID: <20140122114313.GE17314@sirena.org.uk>
References: <1390371213-21643-1-git-send-email-sachin.kamat@linaro.org>
 <1390371213-21643-2-git-send-email-sachin.kamat@linaro.org>
 <CACRpkdZ05LPRB_MdM4ZaJtSYRVM294aW4h9DC04wc__8rSyxjA@mail.gmail.com>
 <CAK9yfHxRAfTYnPHJC3dkzBaCf13-RxeJeJ=4fAY+1wfDYK0BGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7476581000880694316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24AF7261B35
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 12:43:28 +0100 (CET)
In-Reply-To: <CAK9yfHxRAfTYnPHJC3dkzBaCf13-RxeJeJ=4fAY+1wfDYK0BGA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Patch Tracking <patches@linaro.org>, Sangbeom Kim <sbkim73@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============7476581000880694316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PirNdcX87PK7+kHx"
Content-Disposition: inline


--PirNdcX87PK7+kHx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 01:40:06PM +0530, Sachin Kamat wrote:
> On 22 January 2014 13:26, Linus Walleij <linus.walleij@linaro.org> wrote:

> >> sound/soc/samsung/smartq_wm8987.c:112:3: error: implicit declaration o=
f function =E2=80=98S3C64XX_GPL=E2=80=99

> > And I *really* tried to catch all these, could we make this driver
> > part of the defconfig
> > if it isn't?

> They aren't enabled by default. But makes sense to have them enabled
> for better compile coverage.

Given that they mostly have so few users it doesn't seem to fit with
what a defconfig is supposed to do - allXconfig is usually the way one
gets coverage (yes, it's a bit slow but build times seem to be
increasing faster than kernel size these days).

--PirNdcX87PK7+kHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS367NAAoJELSic+t+oim9ZqsQAIVA6ow+zvcCX0ZJsX6zKC5R
9zipEnwSbbv45soRwXkW+5U59Sd8UGFpxIAIJufjRfFRJdR4ZDNRmkdIH1O+BZo0
SB8LGldERrV/OOMsuEDB8tN2L4QJPYMK84nAyy7l7iipGOM8r6Mxdlsdl3FeVjBW
gPhvDBfpjAwkt8O9/mpraYekezZFjZSQR4lbjU31GbEthAYN0XgAT3vdPDK+lmo1
MCZgPs819pczfqLeONRm7etOLDRg7vr+D7El9vzvyxEJ6PzDXD5J7vD74IzGu42R
yumFKmXk8sqlbIYAXnI2QREtMRYOmCi9tKfHFyzTgr3HDMt8D9/RSb12G7TQ/IEA
/LQ+lMKXMTY7R9MdtkjdmyD8krUVPLqFUkjHFnUaWN8Bf2i8/uVb8cRcMIoRCkfN
Su5S77FAQGaJ3rey12S7xGH4ZomhMFRKejDjbz1Fy8j1eRzwA1VSAbsg/AO+WcK/
pX9ZzXBz8BCRB8N3LPJA3v9KQRuHpoonT0i59qoa0OGMz0pzseskwhkASaIz5fVo
Dt4iMxTXmFulP4hLkhod76R0jSCZ4bDPUlL7o1qqLnZ+63UMaWE99bbixKKLe/kT
Iqf+GJP/1qIc9tS/wy5ZAevd3v0kPTb2VUMpfPHsHIFCypVILDVxeDK+ggzT31gH
l2HWCk6jY5GESTcoQZYo
=j/Z1
-----END PGP SIGNATURE-----

--PirNdcX87PK7+kHx--

--===============7476581000880694316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7476581000880694316==--
