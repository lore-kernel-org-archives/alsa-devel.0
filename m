From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA
 where needed
Date: Thu, 1 May 2014 13:54:20 -0700
Message-ID: <20140501205420.GF3245@sirena.org.uk>
References: <6606961.lAGLvkNsEj@wuerfel> <20140429165630.GD16981@sirena.org.uk>
 <8655908.M1OtjG8JKI@wuerfel> <5363504.ttXVrGSYNO@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8441941048255780088=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6D1626545E
 for <alsa-devel@alsa-project.org>; Thu,  1 May 2014 22:55:00 +0200 (CEST)
In-Reply-To: <5363504.ttXVrGSYNO@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Alexander Shiyan <shc_work@mail.ru>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8441941048255780088==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxlY+VokwJUnIklD"
Content-Disposition: inline


--hxlY+VokwJUnIklD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 29, 2014 at 09:36:22PM +0200, Arnd Bergmann wrote:
> Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
> options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
> manually, either as loadable modules or built-in. This unfortunately
> leads to a link error if one or both of them are built-in, while
> the imx-pcm-dma framework is a loadable module:

Applied, thanks.  Please don't send patches in reply to existing threads
(especially with the Re - it makes it look like ongoing discussion, I at
least often leave these discussions among people working on the platform
to grind on).

--hxlY+VokwJUnIklD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYrR4AAoJELSic+t+oim9cyAP/3HXtbHCktSdvlo0T6PJfD0c
iPOzJ9UVgBxX9uxKMbiwcof4TbRCpQJBOt2+9iquKD6mRBpiEaID9B7d3uBEPNpv
jWM9945bIA5YPCzYOfrd8RtbvMfJD5q/aaK5Nt2kW047RT2uNp9SIJbXZBFiSlQK
S+pPkIBsNe80eWmncuj08mIDusiZi0JpdDFEhlo2bHpCIqzbi56qt8pUuLCOsUFC
Kf01CjZQBqg72m5cwHm95VMf1Bd6BeSAzx3V4L/jZq/iBJQur37O+QlGn9sPl35q
RprZJHHXFdHy/p36J6kApHNK1mCHj5SCQbMs5eSp7Yhj6W1MA97OcalYOxxZIK+d
aQbJHdVn7YPone2Ey/6lh6euQkgByELAqZ2coCR1J8iZBXhpww4dqXJgIwJ+C5dC
4hyt62z8+YsQXg8PAx4kt5Uh4zMsSwl8cq0BlfJGhQCtc7M+9WmmcqEboqJrO6Ef
UKFmRkc/xU2haX8XVFWwGTIASdkI2K+zr/9mIdmXyyj2TPbYgh4q3QzQy5qp1FS7
84IAsakx+/YEi55Bn4IQ7HI0s6zV51ukF6FIaWToM/2oQevGJ3J64NLuTEoZu5c6
vhoCG5fu9LY/UGtxxetpsq7ckQVmJf3JBA+QgUihPvPevUUoc3WMRz24+QqsoZVW
KM2zK+3qJ00PiLX7Gvxs
=3d19
-----END PGP SIGNATURE-----

--hxlY+VokwJUnIklD--

--===============8441941048255780088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8441941048255780088==--
