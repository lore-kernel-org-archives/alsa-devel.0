From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/3] ASoC: rt5677: allow multiple interrupt sources
Date: Thu, 9 May 2019 11:32:47 +0900
Message-ID: <20190509023247.GT14916@sirena.org.uk>
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-2-fletcherw@chromium.org>
 <20190508073623.GT14916@sirena.org.uk>
 <CAOReqxgYV3SdXot84Xa4X7=MCZdzWmb2N+jaWzjxgmdoMRx5Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sOuRR0jXHR3ukxKL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOReqxgYV3SdXot84Xa4X7=MCZdzWmb2N+jaWzjxgmdoMRx5Mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Curtis Malainey <cujomalainey@google.com>
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--sOuRR0jXHR3ukxKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 02:39:32PM -0700, Curtis Malainey wrote:

> Pixelbooks (Samus Chromebook) are the only devices that use this part.
> Realtek has confirmed this. Therefore we only have to worry about
> breaking ourselves. That being said I agree there is likely a better

And there are no other parts that are software compatible enough to
share the same driver?

> way to handle general abstraction here. We will need the explicit irq
> handling since I will be following these patches up with patches that
> enable hotwording on the codec (we will be sending the firmware to
> linux-firmware as well that is needed for the process.)

OK.  Like I said it might also be clearer split into multiple patches,
it was just really difficult to tell what was going on with the diff
there.

--sOuRR0jXHR3ukxKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzTkU4ACgkQJNaLcl1U
h9DsMgf8DlzUF2AXtzerym+DDHSpdLJct9B0sDS+4a3l7aJ0l4BGoN8UBK9D9bks
KJq5h9X/JaOojry4WTfrdZtm2rFTa0ztIvtIsNBahAHzYGplUafHmr3lOdsWviUa
IyQk8XARXYWfm0mB0Pdfe58BDY+Y74naM1H6WypF5S1nfCmg2vo4++C1DmV7L56J
7ZdDnceJqVUpW6hyCsp1dRP6Ot8ICzKbUWZABTYVWj/a/CcowwUl+P5/eX5zhM1A
Iy2LN3nZcQE/C7OcG1HB8rZhz+enKCURNLGHHWKmfOuDa8yZR7MS0Q8fFTTwbwow
kPYJXq28b3JoVxlrpjiAFcNg5JUiZQ==
=izHs
-----END PGP SIGNATURE-----

--sOuRR0jXHR3ukxKL--
