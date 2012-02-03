From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Fri, 3 Feb 2012 13:48:51 +0000
Message-ID: <20120203134850.GM3151@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2443253644573863295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A78010B87F
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 14:48:53 +0100 (CET)
In-Reply-To: <87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vinod.koul@linux.intel.com>, Ralf Baechle <ralf@linux-mips.org>, Wolfram Sang <w.sang@pengutronix.de>, H Hartley Sweeten <hsweeten@visionengravers.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============2443253644573863295==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Content-Disposition: inline


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 12:59:33AM -0800, Kuninori Morimoto wrote:

> +static void fsi_dma_do_tasklet(unsigned long data)
> +{

So, we're getting more and more drivers converted over to dmaengine
(I've CCed a random selection of people working on relevant drivers and
Vinod).  This means we're getting a bunch of drivers that talk to the
ALSA API on the top and the dmaengine API on the bottom and seem to need
to implement very similar code patterns (like this tasklet to push the
DMA through).  This feels like we need some sort of abstraction to
factor out some code here, either library code or perhaps a framework
driver with callbacks that fill in the platform specifics - if the APIs
are providing useful abstractions then presumably a large part of this
is just translating between them.

If that's not doable then what are the problems?

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK+W6AAoJEBus8iNuMP3dfnAQAJdUy9S05IytnJsMFh7Tj7bn
xJPNN7EYqXf7/ciUKXY8PoKucrT4HXByERkQ0TdoWNB6MmvIWX0CHYWtocptBOiB
0ek4wjFLNoAy2DUL3gBKewbKSIIaKcwpV2kr5h4AIhCRMQqFgYVXZF4oN624mCAb
qx09SiCVOXMbxmPL3E+l9wpinXEbaHy5Ro3XU+KE0prqJZDMtMCdm3/R4Y3ChXkH
0Xs1ikOGstNrNut3LEhIE+dxhBspIem3NpHaVZC9MwlkjmCjbDthAvtfrHsVJChG
IUtTkvVtL03I022WNnJysx3MKVbD1O5ROEntzHedUO9U6k0jlVTiNhHGVF7ylfLg
XFgGZAY3yvBj1CjHi87f1/eMMMWWlZBz0ly86MYOoyr0xmV+LPNFSLBpmbEJHtc1
kwoL5Cr7OozrB0mmnydJVSVNBNujHhQMcTP6TFCfN223vZYqnzolxmRx6/FnhABJ
ZeH4B1GGoCphmLcgCq+1AeMqA1VM2HQofte443Q6ziSk3me+fgAyBg49H2Efb7oM
UdenWvfc5ngUf3QkuQsO+JAmLT5Z3c1V8VByDpyBrt+lHe7Tjp8ZP7HfUy3QgYx6
wX4YGIfrYYc+WRQ5RrOHlWXNCtoET6M2+zE/HJayWbfSxXwBPhwQ3AtypoReaZ5f
EDaqmqOvPUc5fglviYVe
=gVyw
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--

--===============2443253644573863295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2443253644573863295==--
