From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Sat, 4 Feb 2012 17:12:40 +0000
Message-ID: <20120204171240.GE8042@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
	<20120203134850.GM3151@opensource.wolfsonmicro.com>
	<4F2BE998.4020903@metafoo.de>
	<20120203141440.GR3151@opensource.wolfsonmicro.com>
	<1328373092.26182.27.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0888239028102592823=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61915243AB
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 18:12:44 +0100 (CET)
In-Reply-To: <1328373092.26182.27.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Ralf Baechle <ralf@linux-mips.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============0888239028102592823==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 04, 2012 at 10:01:32PM +0530, Vinod Koul wrote:
> On Fri, 2012-02-03 at 14:14 +0000, Mark Brown wrote:

> > That doesn't sound insurmountible - you need a callback to allow the
> > individual drivers to set the parameters but hopefully the data flow is
> > more generic?  There will probably be some other setup type stuff that
> > needs doing.

> I had though about this sometime back, and if we add dmaengine support
> into asoc, we wouldn't need to add this kind of support in every driver.

OK, this all sounds good and it seems like Lars-Peter has already been
working on this.  It doesn't seem like it's worth holding Morimoto-san's
patch up for the infrastructure, though so once we work out what's going
on with the bugfix patch I'll go ahead with that and we can convert it
over to use the framework later.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPLWcAAAoJEBus8iNuMP3dvWoP/iBGG5ff7IDyChwqiOAg5Eof
gElMb2Z8Cj+HIHQAsd1x67iVM6dCGO6RA63ihGUG/ip81+u9ITC6zv6yxyOIbP5G
y38DZZnekHDz5thg3PNSL+3W93glPMGTa/TdflaWFG0L8H1dEOwP9v8nuC6sN9PJ
hm2+hTyUbtmb4kNKAOXz/J2MY1Rs3H892DHVE3VXU5m0pEtdUmJRBnJxmrnuqmSw
Q7a8T7GfRXxB6UPBUSyqAF/Dc2XvdN+1iXZF2c2jRwPl0vD7FggdL03EuByt+85O
TwfCpBc75X0ObFzXJ+vm0E/2GsN7NgzxKFwbzs+/lDKJrMIp4xU2GJd7eLVfyYPL
16tPYYG41J05pGb87TpQrbfrhy6rjKTx6mTgDiotifUymGEfAGV2IrxJQ1tWxNRJ
aNRVkS6CsorT1xat4l9xGs11HAtFZ4CGJxswoJeDzDbaz2MPajpMzZbYvSoTuT98
Woj/JFMz6kneoBjRJmi4UwnX9QC4i6yMg8kcvPNkeLS4L6WQiBxoiMSZMb/mxe6P
j8GHPFBmnSNQlqZ4W3S/WtU0vmuOGNcrSTS1Jw3OuhWQw/0v2UKf0rfbIuHqS/ix
y3YlTpsJc5fOxK7qnfDCzEkvPP6+GBsugabDYI/jJovbs7mvqoASY7+dD8SqSQjl
79aMoJKLRR3sZe+AHI4d
=2cQ6
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

--===============0888239028102592823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0888239028102592823==--
