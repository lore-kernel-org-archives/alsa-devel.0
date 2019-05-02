From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled
 bclk/wclk case
Date: Thu, 2 May 2019 10:30:22 +0900
Message-ID: <20190502013022.GN14916@sirena.org.uk>
References: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
 <20190427171955.GH14916@sirena.org.uk>
 <AM5PR1001MB0994EA351AEF82224D9AA6BF80390@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TN8pJM9vJMHHFgJc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994EA351AEF82224D9AA6BF80390@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Akshu Agrawal <Akshu.Agrawal@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--TN8pJM9vJMHHFgJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2019 at 09:16:08AM +0000, Adam Thomson wrote:
> On 27 April 2019 18:20, Mark Brown wrote:

> > Don't we need to validate that the rounded rate is actually viable for
> > the parameters we're trying to set here?  If there's missing constraints
> > causing something to try to do something unsupportable then we should
> > return an error rather than silently accept.

> Thanks for directing my gaze to this again. Actually I don't think the SR should
> be rounded at all. If it doesn't match exactly it should fail so I'll remove the
> rounding here. Not sure what my brain was doing there.

Yeah, rounding is dubious with sample rate.  Many applications will be
able to tolerate *some* variation as there's tolerances in the crystals
if nothing else but intentionally allowing it is a bit different.

--TN8pJM9vJMHHFgJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKSCsACgkQJNaLcl1U
h9DXvAf+P9971wrO2YV773UVMXkelPV+MmTYvPVA/VL4bLD1Mg7EU4Q42Xm2TrC+
p6me4v618rDTK6qjyHbVW2naAgUgMEMYWmY53WO50rDBM6CcmLdpp0U0jqZTd2La
/fVKdYNXJf3ZUpoe6OqJ05GpD/Ah3yq4iEdCTHCkiEjsRuSO3PbZxZvlU6QqOXeJ
doBoeBlBU0XT/bjO/W9tzUUVQFtBQWHG19mzuSosxosl4AVMjBzajSITE9QsjGQE
0xRfb1ClDpLFyypsOBhM7cuTuPCcnJvWHbJeKy8lrr8TpZ+LE0AxRLUX/d5oLdqN
0Z+RhTSeFWZpThbExo/oc9/sqBSDaA==
=XOH+
-----END PGP SIGNATURE-----

--TN8pJM9vJMHHFgJc--
