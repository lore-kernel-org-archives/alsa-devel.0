From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 25 Jan 2012 18:05:34 +0000
Message-ID: <20120125180534.GV3687@opensource.wolfsonmicro.com>
References: <007801ccdae0$381fcf40$a85f6dc0$@bossart@linux.intel.com>
	<20120124220036.GA11635@sirena.org.uk>
	<1327511545.11901.41.camel@odin>
	<20120125172051.GS3687@opensource.wolfsonmicro.com>
	<1327513737.11901.47.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5681741339781758650=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B5E7103BCF
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 19:05:37 +0100 (CET)
In-Reply-To: <1327513737.11901.47.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5681741339781758650==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eu12+zRL7gQwOC+E"
Content-Disposition: inline


--eu12+zRL7gQwOC+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2012 at 05:48:57PM +0000, Liam Girdwood wrote:
> On Wed, 2012-01-25 at 17:20 +0000, Mark Brown wrote:

> > Depends how they're allocated - the DSP driver can always do the
> > management on behalf of the DSP firmware if the hardware is structured
> > in a way that makes that make sense (for example, if the CPU never talks
> > to the outside world directly).

> Wouldn't that either mean the DSP driver (re)implements some of the CPU
> DAI driver operations OR the DSP driver calling the CPU DAI driver ops
> directly ?=20

Like I say it depends on how the hardware is structured - the cases I
was thinking about in the example above were those where the CPU needs
to push everything through the DSP (or other in-SoC IP block, some have
other interesting hardware in the way) so the DAI driver the CPU itself
ends up with is different to and probably much simpler than that for the
external interface.

--eu12+zRL7gQwOC+E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIERlAAoJEBus8iNuMP3d1jQP/03dhvkTGl9bE7R2sDa6zt8p
CSjpq+QuGOdbSjsf5ErG22Qs7hwETTm6MPn5pUB/9ZgQnQ0+8LvvRLnB7cxFHue6
6GlHPuwztWzj8iUaGOM4NESuWbfsIo989rm7ofANN9elqLEjyQJuygj6/1Xhkviv
Jm0xNhFaJ7vkjyPu14efJDH0db2Wtc1C1dWb0emsrNVDdE93k2cUTHVO/D8JtXYq
4ngcuPV4k7uTDsNhZffpCyy/hKPi+N4ZHA/32tDZQXv/T7Co+urkjhK7NCLDwqGp
JlMkqC0psOKYTtMCQf8HlMVRPdsRKqxLB1Ah+jbGB7X0XjBRdHBREICccYbATbWN
QLbMXmkwjcA30PP3dkTIF8WCPCJ65spQrEOsS/EVN1RZaPH6Dr9wo9NV+OIANl53
YwPIxrf4seezg2Qn7r71tiIzfkAAGJQEqau3fXw7FZuBEd+YmE9Tzx+w2NUVUdIM
B5GEO5YcT0IWS05B7NQptrurWACm8uMBFiMenw9GRBID9QxvAQ3MJ1E2kp4x3gfz
fBMf2Nue3Iv6xpVHB1YcNLBIfxFcuNHN+zKAVbg2ffeGRRnkozewkJAj7ISANJWw
MsFQLxQnAmywvQZ/Wioo6Kw7crxdoldDacXuU7TofGAvuMV8OMX4DNAPY9+2nKMM
dPOQrrIsXU7PR0yvF29+
=o7yF
-----END PGP SIGNATURE-----

--eu12+zRL7gQwOC+E--

--===============5681741339781758650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5681741339781758650==--
