From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap McBSP: Clear rx_irq at probe
	time for OMAP4
Date: Wed, 7 Mar 2012 11:40:12 +0000
Message-ID: <20120307113938.GC3107@opensource.wolfsonmicro.com>
References: <1331111839-14778-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5665946850640186287=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5BD301045B2
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 12:40:14 +0100 (CET)
In-Reply-To: <1331111839-14778-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============5665946850640186287==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 11:17:19AM +0200, Peter Ujfalusi wrote:
> On OMAP4 we have one interrupt line per McBSP port.
> At proble time tx, and rx irq value will be -ENXIO,
> and only the tx irq will get corrected.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV0kNAAoJEBus8iNuMP3dGL8P/AkHsGk5bi6hT8QY55csVZ6w
++bpjP2x17RgZYKp4g3oHhgzODKnKpcZ3EIAn9C3jnKPkLUiho+rSU9WwejqHoBa
xYiR6vROOoLyU9Q8JOvpUJVjmGwFuyYBVYKtOYoRZvFKaUsoAaXvfskRO8eenOmd
ZF7kzJAtYNAv1DDNp8Fwqz4PXG91e+OY8E2zviIk8v1JMbeIGzyFnQpkRUefiEWJ
265ackrdqKveEukNhuR1aeC544k2khalepLjTCGFu4yOexV/a3mhmhrATxXeV/zD
UKlkcBFlxBLmAykmb+EoVW1XKtiVB4sjXTphECU61xvf6pPStEdnl4mL7PqFO5RI
DpF4uRHlW/YpAfd0IRJMCyuFctnN26uqcLoq0mxArJTs/AOxFQCduIfbr970lAnm
yr2gTFCRo6EFe0UmK5/7b2wei0+GVDZpyZSm4Yntn4E9hCGnx0s5R9VXeMZpSro4
ZRMSI0lf3C/d4IoMjjC3lBKzKCSvTG3YK/cR0m03OHZrIRWiWOx2qPOEKpu4H323
/K7R5ziytsFo2yuyrLVEuNCfa5wZB1QyuGmn68jDItY3ENVDTUAqx4mkl2+bLtAQ
Z4Ljn2TuNQK/QD8YhIW89eYZf3xCz1G3r3PYxmZmjud29D32iZUfpDaLWuEsLTVN
5X7iafF3KvOTOZSEUc/b
=cXwj
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--

--===============5665946850640186287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5665946850640186287==--
