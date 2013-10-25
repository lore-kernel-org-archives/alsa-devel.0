From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND 1/2] ASoC: cs42l52: Add support for
 platform data reset GPIO
Date: Fri, 25 Oct 2013 10:06:21 +0100
Message-ID: <20131025090621.GO18506@sirena.org.uk>
References: <1382624947-10678-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7282514979432804806=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B86C264FFF
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 11:06:30 +0200 (CEST)
In-Reply-To: <1382624947-10678-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7282514979432804806==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Content-Disposition: inline


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2013 at 09:29:06AM -0500, Brian Austin wrote:
> This patch adds support for grabbing a reset GPIO from platform data and resetting the codec

This doesn't seem to apply against Linus' tree for me and I don't appear
to currently be carrying any changes to it.  Can you check please?  The
issue appears to be include/sound, looks like you've got some extra
platform data in your tree.  Also...

> +	dev_info(&i2c_client->dev,
> +		 "Cirrus Logic CS42L52, Revision: %02X\n", reg & 0xFF);

...this is fine but should be a separate patch, likewise...

> -#define CS42L52_MAX_REGISTER			0x34
> +#define CS42L52_MAX_REGISTER			0x47

...this.

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSajSJAAoJELSic+t+oim9JJAP/0p5C0cO/HIIOAj8NAG2h2th
EESbRK/wMSp1/SGH5W/TTXTscuRzFFwSKiJhnwy2jdBktrpCiQBtkCl9XVV3Lc96
+UeIvXxwVg0eCgMH4CQlMw5gmIly3pZ2cp5y1vD0T1X72Y75pQhGLxvCClpOdBXR
LUApTwX2c2sGxzwgi1AxIJ0669b01EsN5yTl4PL7vqAbPSu7I08GytUPFWp04SOk
2OA+y0QhH+TL/G4+An/bBW4CY3847Uf+Cg2QWRD1rzcL7VJcuymweVbhNjJAQ8NX
Mf5CXpQGZivW6CH+sFlp5F3Zj1Up1/aXdfUQYXJvbp9kXWiE7CgmgCEXfHpEH/tK
cRNEPPZ8cs4rksNpaLUxHflQlt/DSp3Z/kOiD9tMCEVj41gaQK6Otx8fY+26KBC0
6rkRvR8W9jSn+xrqsiysJcFvV7GMo4mlDGA2tdaPz+rtEKZVGZYMeihoqpPW41HB
hw9OFarBuUFNNzcGts8pDEcCJbqAK3W+NcO1P+cZ1gxx8h/Obd7MorasYMXm2DsL
VdbOUYfK4JuM7Sbcb7RbQyLWgTx5EzTzpT6GrJm/8ZOzyx9Jh/QmtN9YM3k4y7qR
UT/d0kW2jDlP2oOYB6pKofY0mlijXGuAyWzpBZQJg5+Oo/Nn6wd8KAyYIanh5ipS
ii+JV+1B5/5G6UeMclv9
=LrVq
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--

--===============7282514979432804806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7282514979432804806==--
