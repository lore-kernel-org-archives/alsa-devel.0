From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Failed to create DAPM debugfs
Date: Wed, 8 Apr 2015 20:44:25 +0100
Message-ID: <20150408194425.GJ6023@sirena.org.uk>
References: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4693934111494196258=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24AE92606E2
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 21:44:43 +0200 (CEST)
In-Reply-To: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============4693934111494196258==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ch8qj2ziA8vqoyHg"
Content-Disposition: inline


--ch8qj2ziA8vqoyHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2015 at 03:31:44PM -0300, Fabio Estevam wrote:

> On a imx6q-hummingboard the following warning is seen when running
> linux-next 20150408:

> [    2.270006] imx-spdif sound-spdif: ASoC: Failed to create DAPM
> debugfs directory

> Looking at sound/soc/fsl/imx-spdif.c and sound/soc/fsl/fsl_spdif.c I
> am not sure how to avoid such warning.

> Any ideas?

Some slightly larger hints as to the analysis you did which makes you
think this is unavoidable might help here, as would information about
when this stopped working...  it looks like one of those is a card
driver and the other is a DAI driver both for separate devices which is
a configuration I'd expect to work?  I only looked at this for a couple
of minutes so far.

--ch8qj2ziA8vqoyHg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJYUYAAoJECTWi3JdVIfQZtIH/AhP6+tEs8XL1rkOjYSfSDCv
fAwlXt/JyljayLd6QrRTmNSWj5e/clICPljsnFNUE6Sc+OxjWsGa2GBN4JLfGJc1
ceXx/Vij8KIEBaWmBqEP4RhkWi6R9FDDotvTFy7uG9JSt5UMV2veZDuawLK99YRU
jWHMZ/xZqe5lN99p5luA4Yaox+PtCNjXkRPf9pA40gwliQtfD47xVY2I/zW1Gsre
oiJ0xPMQS7ii6EwvxRMc2z/wTHTn/dFxsoSuOWgZ2d1kuZNWjomSvZFcI7K7+WAF
OnpnMjSZDjwWVzXynSLftvG4bWoh9Bj8azuLRP2DNrEVvM+ULqyVuC6AM2AAnaE=
=D5HI
-----END PGP SIGNATURE-----

--ch8qj2ziA8vqoyHg--

--===============4693934111494196258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4693934111494196258==--
