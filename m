From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] sound: soc: add alias for tlv320aic3x
Date: Wed, 1 Feb 2012 12:39:48 +0000
Message-ID: <20120201123947.GB17170@opensource.wolfsonmicro.com>
References: <1328058380-29360-1-git-send-email-felipe.contreras@gmail.com>
	<1328058380-29360-2-git-send-email-felipe.contreras@gmail.com>
	<CAF+7xWnDPQEXQM_Qtb=700OscztcHJGszDE6fHdE0LkPkQUr2w@mail.gmail.com>
	<CAMP44s2iq-RNNNNeFTZYBJbobEPE7sCOyduh=J--hhRghXkVJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1517177037553987920=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55470103BA1
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 13:39:50 +0100 (CET)
In-Reply-To: <CAMP44s2iq-RNNNNeFTZYBJbobEPE7sCOyduh=J--hhRghXkVJg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, axel.lin@gmail.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1517177037553987920==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2012 at 01:57:56PM +0200, Felipe Contreras wrote:
> On Wed, Feb 1, 2012 at 3:56 AM, Axel Lin <axel.lin@gmail.com> wrote:

> >> +MODULE_ALIAS("i2c:tlv320aic3x");
> > This is not required because "tlv320aic3x" is already in the aic3x_i2c_id table.
> > MODULE_DEVICE_TABLE will automatically setup this modalias.

> Since when? Last time I checked that was not the case. I will try
> again with v3.2 final, but I think on some of the rc's the alias
> wasn't there.

Since it was introduced, this is really nothing new (which is why you'll
not find I2C drivers with MODULE_ALIAS).  This is the whole point of having
MODULE_DEVICE_TABLE.

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKTKNAAoJEBus8iNuMP3dedMP/3xMX3d8TZe5q5IXPE19z9E/
49oA34SIsnI9TfO3ePVybuEA0yQIw/U+JToXvMDJHF5HzSO1+9x3Eo+GpsBiY8wq
Gluk9MFj3vJCj+1UM28eHjoKXn1609Th71+31arzxYsEIJc5AS9PoqYKk3cKTMtD
P+hPWFKmasm4C2xwDe6yPELnROravDvaq0I5lFKRKHQshNOXOhiJgJtRfrigSlXw
NPMQc5kweK0sBjl2XSdmWwJn5NeU8UUiDv/RKM4weF2CfIF6bA9UzwqQCEoKAQJQ
xF+09ILY9SDM8t6w50bZfcXLn1GuCE01+3/hGL1NPSdik+F9rSUTD06l8qh/SF3D
UYzn5Enrmu2MCXhPWVfimNwLUaz+SBTxDSBUC+LOgaQkvab6GQb8Zxqc6wehpOAZ
FobGpF/sX8/A9Zn5tKV54JBq/xw6hBcJ2e1ypp15umm3h4Crm8VV22Tfp2JvTlbB
6NJONRiuZyNVOiPY/pGrIFct+DEnRunBYX0kbHWj2j8gGfiKohF3oa4jYP89ThjF
MXhESBAyMvlhnzdVYP1TJz2yciJ9UcNBvcGVb25AWo3uYT0XxmQdFgXvGcaf/0j+
VonptoTiWu0CCrzdlrHIejbn4NlnMvvBbsQpa9+G90X7iN0Kf4ZX9cDkrkSw1rww
VhSqi/IzWVyGWMcAisAX
=oA20
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

--===============1517177037553987920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1517177037553987920==--
