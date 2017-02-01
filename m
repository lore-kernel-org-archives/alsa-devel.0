From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: bcm2835: Remove redundant channel
 checking code in hw_params
Date: Wed, 1 Feb 2017 11:14:15 +0000
Message-ID: <20170201111415.hdk432uddm3t3w4d@sirena.org.uk>
References: <1484443043-13623-1-git-send-email-flatmax@flatmax.org>
 <1485924303-30869-1-git-send-email-flatmax@flatmax.org>
 <20170201105329.vr4ro5bjf676dwtk@sirena.org.uk>
 <d91986b0-4deb-6d2a-6000-34b4072baed2@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3800085537232345481=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D7F1266957
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 12:14:25 +0100 (CET)
In-Reply-To: <d91986b0-4deb-6d2a-6000-34b4072baed2@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3800085537232345481==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pzi5uo6pd3tzhuka"
Content-Disposition: inline


--pzi5uo6pd3tzhuka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2017 at 10:05:18PM +1100, Matt Flax wrote:
> On 01/02/17 21:53, Mark Brown wrote:

> > If those cards add support for higher channel counts they should be
> > adding real support for that in the driver, not just hacking out
> > defensive code.  If the device can usefully do 8 channels then modify
> > the driver to do 8 channels.  Otherwise people are going to need to
> > modify the driver anyway to remove the limits in the constraints.

> Indeed the AudioInjector Octo sound card is currently operating @ 8 channels
> out on the bcm2835 silicon. It has been tested on both the Pi 2 and Pi 3.

> Do you mean that I should increase bcm2835_i2s_dai.channels_max to 8 ?

Yes, implementing it properly is fine.

--pzi5uo6pd3tzhuka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliRwwYACgkQJNaLcl1U
h9Bfwgf+MDymsKyI27OX1zQU+aZ44kw8i4CkiSLeHXxNw+q7P+C+ERpcerA7A02j
SRLrZPZNZYIgK2eAPWKAzkCKK2XptI219dXUFRweu5QBYUcqU+OsN2zbY3wW2T0x
ruDaRXluztANO3JgUoGBN+WYFTWWRD/jYa8ALehdJ3oOZqcKOG9SRXZnKc618Aar
WChJfT8gWtm2x+rX89KrQUMru+SVfuNVPOs4oXhwH/PnUrrHDM9etnVzJxsLlgpy
sLI9TvTliHcxJfBWqC/XCxzk9X5sR3H1FBOUNvVnMQhMN7MlIgoKwo2ZTX2Xi6mV
PmRCAqLHM1eBUafg4QnwYVVKGJye8A==
=U1y7
-----END PGP SIGNATURE-----

--pzi5uo6pd3tzhuka--

--===============3800085537232345481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3800085537232345481==--
