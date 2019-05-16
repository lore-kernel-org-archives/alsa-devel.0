From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND V3] ASoC: cs42xx8: add reset-gpio in binding
 document
Date: Thu, 16 May 2019 12:27:48 +0100
Message-ID: <20190516112748.GF5598@sirena.org.uk>
References: <c2118efa4ee6c915473060405805e6c6c6db681f.1558005661.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c2118efa4ee6c915473060405805e6c6c6db681f.1558005661.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 11:24:12AM +0000, S.j. Wang wrote:

> +Optional properties:
> +
> +  - reset-gpio : a GPIO spec to define which pin is connected to the chip's
> +    !RESET pin

gpio properties are supposed to be called -gpios even if there's a
single GPIO possible due to DT rules.  The code will accept plain -gpio
but the documentation should say gpios.

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdSTMACgkQJNaLcl1U
h9AI0wf9H/v9XOHLGG0s1+nmST8FhMRdMALRocSMlNs0hntuI+4uxBG9/dXi2ST1
Id5glMJZn5CDpvgp/RUiuTWBAwfejMgpbwxxLtDbrmdqBolGsO0bpnWoEiZTpOop
gVBPRVGueduh/5HWKPbCn9PRfHuyUKq/0uenLwDGEy9VN4dXP6926tOFzTAIewI2
BoFx+Chib3VXyep6aG6PuFzTPPLo4XeXckbROsUj5WNaOIP46A4E9e7nK3aRqd6M
YpPyJN7v/H7BesUV3v9DLZQLcaSCYGxLvfwl07Dz+zI0a3hRQ5eXohzPxWewfqXh
A6lcsDuR+5dafko56EbffC3HlkMhoA==
=692j
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
