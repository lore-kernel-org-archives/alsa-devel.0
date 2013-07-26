From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: adau1701: type bug with ADAU1707_CLKDIV_UNSET
Date: Fri, 26 Jul 2013 17:02:53 +0100
Message-ID: <20130726160253.GQ9858@sirena.org.uk>
References: <20130725164016.GA4027@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cgcPEDKc2RK7mT+z"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130725164016.GA4027@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, device-drivers-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--cgcPEDKc2RK7mT+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 07:40:17PM +0300, Dan Carpenter wrote:
> ADAU1707_CLKDIV_UNSET is always compared against an unsigned int and
> not an unsigned long.  The current tests are always false.

Applied, thanks.

--cgcPEDKc2RK7mT+z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8p2qAAoJELSic+t+oim9IXwP/1+9FOHIzan33tzY8IeACcaw
JkVUzc1oa2ZuQ/UXECm/wyS0MU1CeZVIKNIk+FFsGlu+0oBuySv87Z41/wH68mGG
iWcg7LbKLmQeUM95yr3Gpjwodu1XwnPcSG4grdtMx/uyHpbiSfem32GT3uMupntc
sXCrHgryTLhngJ1OwvZTQ1fmEApP6WHGdPFsI4VaosW2rzDa737GCn6JpRaEq7Gx
CN6d2Y2xBWDV9rS67d9Y0Htv5DSmiqW1MaikgCT0eIemxuLedM9RYWWExMaUmiMx
4oVOd5BMeQTMUsx2brjrh9LqSIq5p8iaz7CyhMpwWKLmW9PzhVsNR/hM8JUVAwLn
rynFS6t5jQWXmWPnhQkHyDlt6FS7lidOuLqpypatLCwTql1IU2hTI7pnij7AcCoF
C7CZS0cmwAVCJEmOL5pynJRKSGiMbpqJwM/TMrJPan8sxR4L7u7lhC1RFD5MioAT
zNebnGjfnRvlphnYSP9kOEfKc8UirkVfjlytPciKOL870+zwkp655MQxCEzBRvCk
XpPPsFoessOKAwRb6WU8FIuZcR8q6kbfz7IhNTnzsS+CiqezWZdW1K234XpM/Hjl
pTcIBw/SbC17c3enolL6KkFa1debq96Wy3d70rDfcOGPFxe6KJhjU3CL+awHdEgP
PxaV3HCGuwh9KCjlj47O
=cikR
-----END PGP SIGNATURE-----

--cgcPEDKc2RK7mT+z--
