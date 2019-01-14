From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: cs4341: fix waring
	unused-function
Date: Mon, 14 Jan 2019 11:24:43 +0000
Message-ID: <20190114112443.GA11073@sirena.org.uk>
References: <20190114095540.22956-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8947750329222035596=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B002266860
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 12:24:48 +0100 (CET)
In-Reply-To: <20190114095540.22956-1-anders.roxell@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============8947750329222035596==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2019 at 10:55:40AM +0100, Anders Roxell wrote:
> The driver cs4341 can be built with SPI and/or I2C, but it has to be one
> of them at least. When I2C is set as a module we see the warning below:

I'm missing patches 2 and 3 of this series and there's no cover letter.
What's the story with dependencies?

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw8cXoACgkQJNaLcl1U
h9AJHwgAgiocrClStcUh92WnpSwD5nQrZmRdfx6j4EVsN+EA+bRasylhwousCfCQ
vk/8h6FWqMkjGuIAdHw8X0OBgSAfOzFz8YJD68CAgFpWmH0FMwBDFny+uAkKm/tA
O8xQcfLZRpQbD/0+9Tw/EL6AfreE3x6g/h3EB1Uz5JEhBGMQB6rAZTmNpb9Yj0ow
sYE9KZVW2DDo557PAAVBPOvgjTYuXi+L0YsHzI7AUjPDjBEEnq/P1eWkUIIhZexJ
PQg1nGXw/FTmvgokIKi/DLiHC2Vh7LFZDsUjxbahMyu3cAc93m+cNvUc1OoP37Dg
ono2CIsZYCht49G3n0ly2eyxfqznaQ==
=WnUQ
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

--===============8947750329222035596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8947750329222035596==--
