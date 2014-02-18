From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: ssm2602: Split SPI and I2C code
 into different modules
Date: Tue, 18 Feb 2014 10:02:13 +0900
Message-ID: <20140218010213.GM2669@sirena.org.uk>
References: <1392639416-11293-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8581143244384403716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B49D265079
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 02:02:30 +0100 (CET)
In-Reply-To: <1392639416-11293-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8581143244384403716==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GeONROBiaq1zPAtT"
Content-Disposition: inline


--GeONROBiaq1zPAtT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 01:16:53PM +0100, Lars-Peter Clausen wrote:
> There are a few known (minor) problems with having the support code for both I2C
> and SPI in the same module:
>     * We need to be extra careful to make sure to not build the driver into the
>       kernel if one of the subsystems is build as a module (Currently only SPI
>       can be build as a module).

I2C not SPI.

> This patch splits the AD193X driver into 3 modules. One core module that
> implements the device logic, but is independent of the bus method used. And one
> module for SPI and I2C each that registers the drivers and sets up the regmap
> struct for the bus.

No it doesn't, it splits the ssm2602 driver.

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/blackfin/Kconfig     |   3 +-
>  sound/soc/codecs/Kconfig       |  11 ++-
>  sound/soc/codecs/Makefile      |   4 ++
>  sound/soc/codecs/ssm2602-i2c.c |  57 +++++++++++++++
>  sound/soc/codecs/ssm2602-spi.c |  41 +++++++++++
>  sound/soc/codecs/ssm2602.c     | 158 ++++++-----------------------------------
>  sound/soc/codecs/ssm2602.h     |  14 ++++

There also seem to be a bunch of arch/blackfin references to do this -
they should stay OK due to the select but it might be worth updating
them.

I'll apply this with the commit log edited.

--GeONROBiaq1zPAtT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArESAAoJELSic+t+oim9NnUP/RBDphP9CLrzvLGdyqm8Rzoz
CrSuqJD6NaogmF7Zt5dVjT6QW3ILfdqq2gycb3sLdcpY3LSzBmrASflhnF4czGpH
AuNvCiq1GfadqBpUdyHjNuKgoOqeN0HeH0zVCESw5zvTqvKE/gJzWSrPfrGUXg9j
VDik9iAoT9xSAizl/LwLYF1vcTgVD0C+D72zqEqOV1o8/yhPXCFRGGI4Rwkyq47V
qoecQotCP7VnwnqVkbEi7jeOJvvgIXsqWgZ3/5hiFB6ZwGkFg31uVkMqT1YAi7FL
TaGyeCIVPDxeFmwOY8KdV9+Gpr99Yo77mUr4n8utx8n05pJuZwhS31UY56PM3dz+
ojJ7+KN2WKmDv8X0kOsz+jQCScfl3PfFPrPcdalG4aeUE+C4wB9FtFhc5krmBEW9
6Z1tsHfnJscBTwzkdnM37TAFbIvD6mi63YIxVSlxFOX8/ezBJJuJYyZTfPAiaUNn
AAseILL+C+hU9rNiRPZDrZEfCY1rZHB0ai3KsTNzpbxwsqla7YPuF04j3uM6LWwv
MYjegjlrjuPGkOaw74TjuOCE9ysqbkwKqvWQDZriSIrRCsomiGLzQjdtgibIjO6d
xJzQWwTk0/ch6++pQVzyn0yDAVnmmnUWiaLscPN3gTLgX5kBA6lpmMU8mPiV33Lf
DjZ9BDK4FRDPxPU4NgZM
=CL03
-----END PGP SIGNATURE-----

--GeONROBiaq1zPAtT--

--===============8581143244384403716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8581143244384403716==--
