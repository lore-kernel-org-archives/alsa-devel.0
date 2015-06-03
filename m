From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7] ASoC: rt5677: clean up gpiolib callbacks
Date: Wed, 3 Jun 2015 12:38:56 +0100
Message-ID: <20150603113856.GE14071@sirena.org.uk>
References: <1433200158-6890-2-git-send-email-vz@mleia.com>
 <20150602193818.GG14071@sirena.org.uk>
 <556E1467.9030406@mleia.com>
 <20150602205017.GY14071@sirena.org.uk>
 <556E260E.2030507@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RTD9Hr/VfB+mRRII"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <556E260E.2030507@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org


--RTD9Hr/VfB+mRRII
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 12:54:22AM +0300, Vladimir Zapolskiy wrote:

> Of course I'm not a C standard writer, but I have a feeling that one day
> bool type may become quite distinct from int (or in other words bool
> type will not be one of integer types). This may explain why C99 and C11
> has "_Bool" type, not a hypothetically finalized in future "bool" type.
> Also C99 clearly states that macro "false" and "true" may be undefined
> and redefined to any arbitrary values.

You're confusing several different things here - it's just the same as
the handling of NULL and 0.  An implementation can make NULL be anything
that amuses it (so long as nothing standards conforming can tell) but if
you write 0 in a pointer context it has to be a NULL pointer, and if you
use a NULL pointer in an integer context it must evaluate to 0.  The in
memory representation is potentially a separate thing to what the source
code does, though practically speaking people are unlikely to implment
anything too extravagent.

I suspect you'll find that the use of _Bool in current standards is
simply to avoid breaking existing standards conforming code that uses
bool by suddenly making that a keyword.

--RTD9Hr/VfB+mRRII
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbudPAAoJECTWi3JdVIfQxMIH/0Cn7+fCI/jQm4+RlKETKGRd
mQFiryxO1ZGvs7eWLf/75XsoHz/SIXzkDeOG32BFHC37grAmpfYj96WiCmlOrPNO
0VVr2Bm8BlIymvjxoModEfHvAFUoHFr/RIeYTeCNqKc5PvkauFvCpbnb0V75VVM3
c9P2CWY3hOqeQoAg2Err700Uby4VLBTfApnFQZ4RxVhyPASqqEyUYYFCu7Omfp3C
L2VpnMlUkS4x8OWPYyzEOoFzjksoSwpT7GyL7fGLWjvQ0I4y5CmX3bC6iTH/qJVA
hVURDGicwAhMY9Ia5AQzEfyt1Q37bWuGyOj+ITYXP9skXYC8pv+aVADBvSfDqjE=
=f2Cq
-----END PGP SIGNATURE-----

--RTD9Hr/VfB+mRRII--
